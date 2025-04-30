import os
import subprocess
import win32com.client
import pythoncom
import sys

def drop_1c_database():
    # Настройки
    infobase = "avtotestqa"
    db_username = "Админ"  # Логин от базы 1С
    db_password = ""               # Пароль от базы 1С (пустой)
    
    # Настройки PostgreSQL
    pg_server = "localhost"
    pg_port = "5432"
    pg_user = "postgres"
    pg_password = "postgres"  # Пароль PostgreSQL

    try:
        # Инициализация COM
        pythoncom.CoInitialize()
        
        print("1. Подключение к агенту сервера 1С...")
        v83_com = win32com.client.Dispatch("V83.ComConnector")
        agent = v83_com.ConnectAgent("localhost:1540")
        
        print("2. Получаем кластер...")
        clusters = agent.GetClusters()
        if not clusters:
            raise Exception("Не найден ни один кластер 1С")
        cluster = clusters[0]
        
        print("3. Аутентификация в кластере...")
        agent.Authenticate(cluster, "", "")  # Пустые данные для кластера
        
        print("4. Получаем рабочие процессы...")
        processes = agent.GetWorkingProcesses(cluster)
        if not processes:
            raise Exception("Не найдено рабочих процессов")
        
        print("5. Подключение к рабочему процессу...")
        wp = v83_com.ConnectWorkingProcess(f"tcp://localhost:{processes[0].MainPort}")
        
        # Ключевой момент: добавляем аутентификацию для базы данных
        print(f"6. Добавляем аутентификацию для базы (логин: {db_username})...")
        wp.AddAuthentication(db_username, db_password)
        
        print("7. Поиск базы в кластере...")
        bases = wp.GetInfoBases()
        base_obj = None
        
        for base in bases:
            if base.Name == infobase:
                base_obj = base
                break
        
        if not base_obj:
            print(f"База {infobase} не найдена в кластере")
            return False
        
        print(f"8. Удаляем базу {infobase}...")
        try:
            # Параметр 0 = обычное удаление, 1 = удаление с очисткой данных
            wp.DropInfoBase(base_obj, 0)
            print("База успешно удалена из кластера 1С")
        except Exception as e:
            print(f"Ошибка при удалении базы: {str(e)}")
            return False
        
        # Удаление из PostgreSQL
        print("9. Удаление из PostgreSQL...")
        try:
            os.environ['PGPASSWORD'] = pg_password
            db_name = infobase.lower()
            
            commands = [
                f"SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = '{db_name}' AND pid <> pg_backend_pid();",
                f"DROP DATABASE IF EXISTS {db_name};"
            ]
            
            for cmd in commands:
                subprocess.run([
                    'psql',
                    '-h', pg_server,
                    '-p', pg_port,
                    '-U', pg_user,
                    '-d', 'postgres',
                    '-c', cmd
                ], check=True)
            
            print("База успешно удалена из PostgreSQL")
        except subprocess.CalledProcessError as e:
            print(f"Ошибка при удалении из PostgreSQL: {str(e)}")
            return False
        finally:
            if 'PGPASSWORD' in os.environ:
                del os.environ['PGPASSWORD']
        
        # Очистка кэша
        print("10. Очистка кэша 1С...")
        clean_1c_cache()
        
        return True
        
    except Exception as e:
        print(f"Критическая ошибка: {str(e)}")
        return False
    finally:
        pythoncom.CoUninitialize()

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
                try:
                    if os.path.isdir(item_path):
                        import shutil
                        shutil.rmtree(item_path, ignore_errors=True)
                    else:
                        os.remove(item_path)
                except Exception as e:
                    print(f"Не удалось удалить {item_path}: {str(e)}")
        except Exception as e:
            print(f"Не удалось очистить кэш в {path}: {str(e)}")

if __name__ == "__main__":
    print("=== Начало удаления базы ===")
    success = drop_1c_database()
    
    if success:
        print("=== Удаление завершено успешно ===")
        sys.exit(0)
    else:
        print("=== Удаление завершено с ошибками ===")
        sys.exit(1)