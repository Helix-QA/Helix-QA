import os
import subprocess
import win32com.client
import pythoncom
import sys
import shutil
from colorama import init, Fore, Style


# Инициализация colorama для цветного вывода
init(autoreset=True)

def delete_folder(folder_path):
    """Удаляет указанную папку и её содержимое."""
    if os.path.exists(folder_path):
        try:
            shutil.rmtree(folder_path, ignore_errors=True)
            print(f"{Fore.GREEN}Папка {folder_path} успешно удалена{Style.RESET_ALL}")
        except Exception as e:
            print(f"{Fore.YELLOW}Не удалось удалить папку {folder_path}: {str(e)}{Style.RESET_ALL}")
    else:
        print(f"{Fore.YELLOW}Папка {folder_path} не существует{Style.RESET_ALL}")

def drop_1c_database():
    # Настройки
    infobase = sys.argv[1] # Имя базы 1С
    db_username = "Админ"  # Логин от базы 1С
    db_password = ""       # Пароль от базы 1С (пустой)
    
    # Настройки PostgreSQL
    pg_server = "localhost"
    pg_port = "5432"
    pg_user = "postgres"
    pg_password = "postgres"  # Пароль PostgreSQL

    try:
        # Инициализация COM
        pythoncom.CoInitialize()
        
        print(f"{Fore.CYAN}1. Подключение к агенту сервера 1С...{Style.RESET_ALL}")
        v83_com = win32com.client.gencache.EnsureDispatch("V83.ComConnector")
        agent = v83_com.ConnectAgent("localhost:1540")
        
        print(f"{Fore.CYAN}2. Получаем кластер...{Style.RESET_ALL}")
        clusters = agent.GetClusters()
        if not clusters:
            print(f"{Fore.YELLOW}Не найден ни один кластер 1С, пропускаем удаление из кластера...{Style.RESET_ALL}")
            base_obj = None
        else:
            cluster = clusters[0]
            
            print(f"{Fore.CYAN}3. Аутентификация в кластере...{Style.RESET_ALL}")
            agent.Authenticate(cluster, "", "")  # Пустые данные для кластера
            
            print(f"{Fore.CYAN}4. Получаем рабочие процессы...{Style.RESET_ALL}")
            processes = agent.GetWorkingProcesses(cluster)
            if not processes:
                print(f"{Fore.YELLOW}Не найдено рабочих процессов, пропускаем удаление из кластера...{Style.RESET_ALL}")
                base_obj = None
            else:
                print(f"{Fore.CYAN}5. Подключение к рабочему процессу...{Style.RESET_ALL}")
                wp = v83_com.ConnectWorkingProcess(f"tcp://localhost:{processes[0].MainPort}")
                
                print(f"{Fore.CYAN}6. Добавляем аутентификацию для базы (логин: {db_username})...{Style.RESET_ALL}")
                wp.AddAuthentication(db_username, db_password)
                
                print(f"{Fore.CYAN}7. Поиск базы в кластере...{Style.RESET_ALL}")
                bases = wp.GetInfoBases()
                base_obj = None
                
                for base in bases:
                    if base.Name.lower() == infobase.lower():
                        base_obj = base
                        break
                
                if not base_obj:
                    print(f"{Fore.YELLOW}База '{infobase}' не найдена в кластере 1С, пропускаем удаление из кластера...{Style.RESET_ALL}")
                else:
                    print(f"{Fore.CYAN}8. Удаляем базу '{infobase}'...{Style.RESET_ALL}")
                    try:
                        wp.DropInfoBase(base_obj, 0)
                        print(f"{Fore.GREEN}База успешно удалена из кластера 1С{Style.RESET_ALL}")
                    except Exception as e:
                        print(f"{Fore.RED}Ошибка при удалении базы из кластера: {str(e)}{Style.RESET_ALL}")
        
        # Удаление из PostgreSQL
        print(f"{Fore.CYAN}9. Удаление из PostgreSQL...{Style.RESET_ALL}")
        try:
            os.environ['PGPASSWORD'] = pg_password
            db_name = infobase.lower()
            
            commands = [
                f"SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = '{db_name}' AND pid <> pg_backend_pid();",
                f"DROP DATABASE IF EXISTS {db_name};"
            ]
            
            for cmd in commands:
                result = subprocess.run([
                    'psql',
                    '-h', pg_server,
                    '-p', pg_port,
                    '-U', pg_user,
                    '-d', 'postgres',
                    '-c', cmd
                ], check=True, capture_output=True, text=True)
                
                # Проверяем, если база не существует
                if cmd.startswith("DROP DATABASE") and "does not exist" in result.stderr:
                    print(f"{Fore.YELLOW}База '{db_name}' не найдена в PostgreSQL, пропускаем удаление...{Style.RESET_ALL}")
                elif cmd.startswith("DROP DATABASE"):
                    print(f"{Fore.GREEN}База успешно удалена из PostgreSQL{Style.RESET_ALL}")
                    
        except subprocess.CalledProcessError as e:
            print(f"{Fore.YELLOW}Ошибка при удалении из PostgreSQL (возможно, база уже отсутствует): {str(e)}{Style.RESET_ALL}")
        finally:
            if 'PGPASSWORD' in os.environ:
                del os.environ['PGPASSWORD']
        
        # Удаление папки
        print(f"{Fore.CYAN}10. Удаление папки...{Style.RESET_ALL}")
        folder_to_delete = "tests/build/results"  # Укажите путь к папке здесь
        delete_folder(folder_to_delete)
        
        # Очистка кэша
        print(f"{Fore.CYAN}11. Очистка кэша 1С...{Style.RESET_ALL}")
        clean_1c_cache()
        
        print(f"{Fore.GREEN}Кэш 1С успешно очищен{Style.RESET_ALL}")
        print(f"{Fore.GREEN}Скрипт успешно завершен{Style.RESET_ALL}")
        return True
        
    except Exception as e:
        print(f"{Fore.RED}Критическая ошибка: {str(e)}{Style.RESET_ALL}")
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
                # Пропускаем папку ExtCompT
                if item == 'ExtCompT':
                    continue
                # Пропускаем файл 1cv8strt.pfl
                if item == '1cv8strt.pfl':
                    continue
                try:
                    if os.path.isdir(item_path):
                        shutil.rmtree(item_path, ignore_errors=True)
                    else:
                        os.remove(item_path)
                except Exception as e:
                    print(f"{Fore.YELLOW}Не удалось удалить {item_path}: {str(e)}{Style.RESET_ALL}")
        except Exception as e:
            print(f"{Fore.YELLOW}Не удалось очистить кэш в {path}: {str(e)}{Style.RESET_ALL}")

if __name__ == "__main__":
    print(f"{Fore.BLUE}=== Начало удаления базы ==={Style.RESET_ALL}")
    success = drop_1c_database()
    
    if success:
        print(f"{Fore.BLUE}=== Удаление завершено успешно ==={Style.RESET_ALL}")
        sys.exit(0)
    else:
        print(f"{Fore.RED}=== Удаление завершено с ошибками ==={Style.RESET_ALL}")
        sys.exit(1)