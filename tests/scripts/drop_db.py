import os
import subprocess
import sys
import shutil
import pythoncom
import win32com.client
import time

# Полностью отключаем кэш COM
win32com.client.gencache.is_readonly = False

def clean_com_cache():
    """Полная очистка COM-кэша"""
    temp_dirs = [
        os.path.expanduser(r"~\AppData\Local\Temp\gen_py"),
        os.path.join(os.environ.get('TEMP', ''), 'gen_py')
    ]
    
    for temp_dir in temp_dirs:
        try:
            if os.path.exists(temp_dir):
                shutil.rmtree(temp_dir, ignore_errors=True)
                print(f"Очищен COM-кэш: {temp_dir}")
        except Exception as e:
            print(f"Ошибка очистки кэша {temp_dir}: {e}")

def delete_folder(folder_path):
    if os.path.exists(folder_path):
        try:
            shutil.rmtree(folder_path, ignore_errors=True)
            print(f"Папка {folder_path} успешно удалена")
        except Exception as e:
            print(f"Не удалось удалить папку {folder_path}: {e}")
    else:
        print(f"Папка {folder_path} не существует")

def clean_1c_cache():
    user = os.getenv('USERNAME')
    cache_paths = [
        f"C:\\Users\\{user}\\AppData\\Local\\1C\\1cv8",
        f"C:\\Users\\{user}\\AppData\\Roaming\\1C\\1cv8",
        f"C:\\Users\\{user}\\AppData\\Roaming\\1C\\1cv82",
        f"C:\\Users\\{user}\\AppData\\Local\\1C\\1cv82"
    ]
    for path in cache_paths:
        if not os.path.exists(path):
            continue
        try:
            for item in os.listdir(path):
                item_path = os.path.join(path, item)
                if item in ('ExtCompT', '1cv8strt.pfl'):
                    continue
                try:
                    if os.path.isdir(item_path):
                        shutil.rmtree(item_path, ignore_errors=True)
                    else:
                        os.remove(item_path)
                except Exception as e:
                    print(f"Не удалось удалить {item_path}: {e}")
        except Exception as e:
            print(f"Не удалось прочитать кэш в {path}: {e}")

def check_1c_service():
    """Проверка статуса службы 1С"""
    try:
        result = subprocess.run(
            ['sc', 'query', '1C:Enterprise 8.3 Server Agent'],
            capture_output=True, text=True, check=False
        )
        if 'RUNNING' in result.stdout:
            print("Служба агента 1С запущена")
            return True
        else:
            print("Служба агента 1С не запущена")
            return False
    except Exception as e:
        print(f"Ошибка проверки службы: {e}")
        return False

def restart_1c_service():
    """Перезапуск службы 1С"""
    try:
        print("Перезапуск службы 1С...")
        subprocess.run(['net', 'stop', '1C:Enterprise 8.3 Server Agent'], 
                      check=False, capture_output=True)
        time.sleep(3)
        subprocess.run(['net', 'start', '1C:Enterprise 8.3 Server Agent'], 
                      check=False, capture_output=True)
        time.sleep(5)  # Даем время для полного запуска
        print("Служба 1С перезапущена")
        return True
    except Exception as e:
        print(f"Ошибка перезапуска службы: {e}")
        return False

def connect_to_agent_with_retry(com_connector, max_retries=3):
    """Подключение к агенту с повторными попытками"""
    for attempt in range(max_retries):
        try:
            print(f"Попытка подключения к агенту {attempt + 1}/{max_retries}...")
            agent = com_connector.ConnectAgent("localhost:1540")
            print("Успешное подключение к агенту")
            return agent
        except Exception as e:
            print(f"Ошибка подключения (попытка {attempt + 1}): {e}")
            if attempt < max_retries - 1:
                if "RPC" in str(e) or "сервер" in str(e).lower():
                    print("Перезапускаем службу 1С...")
                    restart_1c_service()
                time.sleep(3)
                continue
            else:
                raise

def release_com_objects(com_objects):
    """Правильное освобождение COM-объектов"""
    for obj in com_objects:
        if obj is not None:
            try:
                # Для COM объектов лучше явно вызывать Release
                if hasattr(obj, 'Release'):
                    obj.Release()
                del obj
            except Exception as e:
                print(f"Ошибка при освобождении COM-объекта: {e}")

def drop_1c_database():
    if len(sys.argv) < 2:
        print("Ошибка: укажите имя базы. Использование: drop_db.py <ИмяБазы>")
        return False

    infobase = sys.argv[1].strip()
    db_username = "Админ"
    db_password = ""
    pg_server = "localhost"
    pg_port = "5432"
    pg_user = "postgres"
    pg_password = "postgres"

    com = agent = wp = None

    try:
        # Очищаем COM-кэш перед началом
        clean_com_cache()
        
        print("Инициализация COM...")
        pythoncom.CoInitialize()
        
        print("1. Проверка службы 1С...")
        if not check_1c_service():
            print("Пытаемся перезапустить службу...")
            restart_1c_service()

        print("2. Создание COM-коннектора...")
        com = win32com.client.dynamic.Dispatch("V83.COMConnector")
        if not com:
            raise Exception("Не удалось создать COMConnector")

        print("3. Подключение к агенту 1С...")
        agent = connect_to_agent_with_retry(com)
        if not agent:
            raise Exception("Не удалось подключиться к агенту")

        print("4. Получение кластеров...")
        clusters = agent.GetClusters()
        if not clusters:
            print("Кластеры не найдены. Пропускаем удаление из 1С.")
        else:
            cluster = clusters[0]
            print(f"Найден кластер: {cluster}")
            
            print("5. Аутентификация в кластере...")
            agent.Authenticate(cluster, "", "")

            print("6. Получение рабочих процессов...")
            processes = agent.GetWorkingProcesses(cluster)
            if not processes:
                print("Рабочие процессы не найдены.")
            else:
                wp_info = processes[0]
                print(f"Подключение к рабочему процессу на порту {wp_info.MainPort}...")
                
                wp = com.ConnectWorkingProcess(f"tcp://{wp_info.HostName}:{wp_info.MainPort}")
                wp.AddAuthentication(db_username, db_password)

                print(f"7. Поиск базы '{infobase}'...")
                bases = wp.GetInfoBases()
                base_obj = next((b for b in bases if b.Name.lower() == infobase.lower()), None)

                if base_obj:
                    print("8. Попытка отключить соединения...")
                    try:
                        connections = wp.GetInfoBaseConnections(base_obj)
                        if connections:
                            print(f"Найдено {len(connections)} соединений. Отключаем...")
                            for conn in connections:
                                try:
                                    wp.TerminateConnection(conn)
                                    print(f"  → соединение ID={conn.ConnectionID} отключено")
                                except Exception as e:
                                    print(f"  → Ошибка отключения: {e}")
                        else:
                            print("Активных соединений нет.")
                    except Exception as e:
                        print(f"Не удалось получить соединения: {e}")

                    print("9. Удаление базы из кластера...")
                    try:
                        wp.DropInfoBase(base_obj, 1)
                        print("База удалена из кластера 1С")
                    except Exception as e:
                        print(f"Ошибка удаления из 1С: {e}")
                else:
                    print(f"База '{infobase}' не найдена в кластере 1С.")

        # === PostgreSQL ===
        print("10. Удаление из PostgreSQL...")
        db_name = infobase.lower()
        try:
            os.environ['PGPASSWORD'] = pg_password
            # Завершаем активные соединения
            subprocess.run([
                'psql', '-h', pg_server, '-p', pg_port, '-U', pg_user, '-d', 'postgres',
                '-c', f"SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = '{db_name}' AND pid <> pg_backend_pid();"
            ], check=False, capture_output=True)

            # Удаляем базу данных
            result = subprocess.run([
                'psql', '-h', pg_server, '-p', pg_port, '-U', pg_user, '-d', 'postgres',
                '-c', f"DROP DATABASE IF EXISTS \"{db_name}\";"
            ], check=False, capture_output=True, text=True)

            if result.returncode == 0:
                print(f"База '{db_name}' удалена из PostgreSQL")
            else:
                if "does not exist" in result.stderr:
                    print(f"База '{db_name}' не существует в PostgreSQL")
                else:
                    print(f"PostgreSQL ошибка: {result.stderr.strip()}")
        except Exception as e:
            print(f"Ошибка PostgreSQL: {e}")
        finally:
            os.environ.pop('PGPASSWORD', None)

        print("11. Удаление временной папки...")
        delete_folder("tests/build/results")

        print("12. Очистка кэша 1С...")
        clean_1c_cache()
        print("Кэш 1С очищен")

        print("Скрипт успешно завершён")
        return True

    except Exception as e:
        print(f"Критическая ошибка: {type(e).__name__}: {e}")
        import traceback
        traceback.print_exc()
        return False

    finally:
        # Улучшенное освобождение ресурсов
        release_com_objects([wp, agent, com])
        try:
            pythoncom.CoUninitialize()
        except:
            pass

def main_with_retry(max_attempts=5):
    """Основная функция с повторными попытками"""
    for attempt in range(1, max_attempts + 1):
        print(f"\n=== ПОПЫТКА {attempt} ИЗ {max_attempts} ===")
        success = drop_1c_database()
        
        if success:
            print(f"=== УСПЕХ НА ПОПЫТКЕ {attempt} ===")
            return True
        else:
            print(f"Ошибка на попытке {attempt}: script returned exit code 1")
            
            if attempt < max_attempts:
                if attempt >= 2:  # После 2 неудачных попыток перезапускаем службу
                    print("Перезагрузка службы агента сервера 1С после 2 неудачных попыток")
                    restart_1c_service()
                print(f"Попытка {attempt + 1} из {max_attempts}")
                time.sleep(5)  # Пауза перед следующей попыткой
    
    print("=== ВСЕ ПОПЫТКИ ИСЧЕРПАНЫ ===")
    return False

if __name__ == "__main__":
    print("=== УДАЛЕНИЕ БАЗЫ 1С (8.3.27) ===")
    success = main_with_retry()
    print(f"=== {'УСПЕХ' if success else 'ОШИБКА'} ===")
    sys.exit(0 if success else 1)