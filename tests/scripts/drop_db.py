import os
import subprocess
import sys
import shutil
import pythoncom
import win32com.client

# Полностью отключаем кэш COM
win32com.client.gencache.is_readonly = False
try:
    shutil.rmtree(os.path.expanduser(r"~\AppData\Local\Temp\gen_py"), ignore_errors=True)
except:
    pass


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
        pythoncom.CoInitialize()
        print("1. Подключение к агенту 1С...")

        com = win32com.client.dynamic.Dispatch("V83.COMConnector")
        agent = com.ConnectAgent("tcp://127.0.0.1:1540")

        print("2. Получение кластеров...")
        clusters = agent.GetClusters()
        if not clusters:
            print("Кластеры не найдены. Пропускаем 1С.")
        else:
            cluster = clusters[0]
            print("3. Аутентификация в кластере...")
            agent.Authenticate(cluster, "", "")

            print("4. Получение рабочих процессов...")
            processes = agent.GetWorkingProcesses(cluster)
            if not processes:
                print("Рабочие процессы не найдены.")
            else:
                wp = com.ConnectWorkingProcess(f"tcp://127.0.0.1:{processes[0].MainPort}")
                wp.AddAuthentication(db_username, db_password)

                print(f"5. Поиск базы '{infobase}'...")
                bases = wp.GetInfoBases()
                base_obj = next((b for b in bases if b.Name.lower() == infobase.lower()), None)

                if base_obj:
                    print("6. Попытка отключить соединения...")
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

                    print("7. Удаление базы из кластера...")
                    try:
                        wp.DropInfoBase(base_obj, 1)
                        print("База удалена из кластера 1С")
                    except Exception as e:
                        print(f"Ошибка удаления: {e}")
                else:
                    print(f"База '{infobase}' не найдена в кластере.")

        # === PostgreSQL ===
        print("8. Удаление из PostgreSQL...")
        db_name = infobase.lower()
        try:
            os.environ['PGPASSWORD'] = pg_password
            subprocess.run([
                'psql', '-h', pg_server, '-p', pg_port, '-U', pg_user, '-d', 'postgres',
                '-c', f"SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = '{db_name}' AND pid <> pg_backend_pid();"
            ], check=False, capture_output=True)

            result = subprocess.run([
                'psql', '-h', pg_server, '-p', pg_port, '-U', pg_user, '-d', 'postgres',
                '-c', f"DROP DATABASE IF EXISTS \"{db_name}\";"
            ], check=False, capture_output=True, text=True)

            if result.returncode == 0:
                print(f"База '{db_name}' удалена из PostgreSQL")
            else:
                if "does not exist" in result.stderr:
                    print(f"База '{db_name}' не существует")
                else:
                    print(f"PostgreSQL ошибка: {result.stderr.strip()}")
        except Exception as e:
            print(f"Ошибка PostgreSQL: {e}")
        finally:
            os.environ.pop('PGPASSWORD', None)

        print("9. Удаление временной папки...")
        delete_folder("tests/build/results")

        print("10. Очистка кэша 1С...")
        clean_1c_cache()
        print("Кэш 1С очищен")

        print("Скрипт успешно завершён")
        return True

    except Exception as e:
        print(f"Критическая ошибка: {e}")
        return False

    finally:
        # Правильный порядок освобождения COM
        for obj in [wp, agent, com]:
            if obj is not None:
                try:
                    del obj
                except:
                    pass
        try:
            pythoncom.CoUninitialize()
        except:
            pass


if __name__ == "__main__":
    print("=== УДАЛЕНИЕ БАЗЫ 1С (8.3.27) ===")
    success = drop_1c_database()
    print(f"=== {'УСПЕХ' if success else 'ОШИБКА'} ===")
    sys.exit(0 if success else 1)
