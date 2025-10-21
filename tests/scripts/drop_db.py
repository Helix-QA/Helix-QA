import os
import subprocess
import sys
import shutil
import pythoncom
import win32com.client
from colorama import init, Fore, Style

init(autoreset=True)


def delete_folder(folder_path):
    if os.path.exists(folder_path):
        try:
            shutil.rmtree(folder_path, ignore_errors=True)
            print(f"{Fore.GREEN}Папка {folder_path} успешно удалена{Style.RESET_ALL}")
        except Exception as e:
            print(f"{Fore.YELLOW}Не удалось удалить папку {folder_path}: {str(e)}{Style.RESET_ALL}")
    else:
        print(f"{Fore.YELLOW}Папка {folder_path} не существует{Style.RESET_ALL}")


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
                    print(f"{Fore.YELLOW}Не удалось удалить {item_path}: {e}{Style.RESET_ALL}")
        except Exception as e:
            print(f"{Fore.YELLOW}Не удалось прочитать кэш в {path}: {e}{Style.RESET_ALL}")


def drop_1c_database():
    if len(sys.argv) < 2:
        print(f"{Fore.RED}Ошибка: не указано имя базы. Использование: drop_db.py <ИмяБазы>{Style.RESET_ALL}")
        return False

    infobase = sys.argv[1].strip()
    db_username = "Админ"
    db_password = ""
    pg_server = "localhost"
    pg_port = "5432"
    pg_user = "postgres"
    pg_password = "postgres"

    com_connector = None
    agent = None
    wp = None

    try:
        pythoncom.CoInitialize()
        print(f"{Fore.CYAN}1. Подключение к агенту сервера 1С...{Style.RESET_ALL}")
        com_connector = win32com.client.gencache.EnsureDispatch("V83.COMConnector")
        agent = com_connector.ConnectAgent("localhost:1540")

        print(f"{Fore.CYAN}2. Получение кластеров...{Style.RESET_ALL}")
        clusters = agent.GetClusters()
        if not clusters:
            print(f"{Fore.YELLOW}Кластеры не найдены. Пропускаем 1С.{Style.RESET_ALL}")
            return True

        cluster = clusters[0]
        print(f"{Fore.CYAN}3. Аутентификация в кластере...{Style.RESET_ALL}")
        agent.Authenticate(cluster, "", "")

        # === Рабочий процесс ===
        print(f"{Fore.CYAN}4. Получение рабочих процессов...{Style.RESET_ALL}")
        processes = agent.GetWorkingProcesses(cluster)
        if not processes:
            print(f"{Fore.YELLOW}Рабочие процессы не найдены.{Style.RESET_ALL}")
            return True

        wp = com_connector.ConnectWorkingProcess(f"tcp://localhost:{processes[0].MainPort}")
        wp.AddAuthentication(db_username, db_password)

        # === Поиск базы ===
        print(f"{Fore.CYAN}5. Поиск базы '{infobase}'...{Style.RESET_ALL}")
        bases = wp.GetInfoBases()
        base_obj = next((b for b in bases if b.Name.lower() == infobase.lower()), None)
        if not base_obj:
            print(f"{Fore.YELLOW}База не найдена в кластере. Пропускаем 1С.{Style.RESET_ALL}")
        else:
            # === ОТКЛЮЧЕНИЕ СОЕДИНЕНИЙ ЧЕРЕЗ КЛАСТЕР (а не через wp!) ===
            print(f"{Fore.CYAN}6. Проверка и отключение соединений...{Style.RESET_ALL}")
            try:
                # Получаем соединения через агент и кластер
                connections = agent.GetConnections(cluster)
                active_conn = [c for c in connections if c.InfoBase.Name.lower() == infobase.lower()]
                if active_conn:
                    print(f"{Fore.YELLOW}Найдено {len(active_conn)} активных соединений. Отключаем...{Style.RESET_ALL}")
                    for conn in active_conn:
                        try:
                            agent.TerminateSession(cluster, conn)
                            print(f"{Fore.GREEN}  → Соединение {conn.ConnectionID} ({conn.Application}) отключено{Style.RESET_ALL}")
                        except Exception as e:
                            print(f"{Fore.RED}  → Не удалось отключить {conn.ConnectionID}: {e}{Style.RESET_ALL}")
                else:
                    print(f"{Fore.GREEN}Активных соединений нет.{Style.RESET_ALL}")
            except Exception as e:
                print(f"{Fore.YELLOW}Не удалось получить соединения (возможно, старая версия): {e}{Style.RESET_ALL}")

            # === УДАЛЕНИЕ БАЗЫ ===
            print(f"{Fore.CYAN}7. Удаление базы из кластера (принудительно)...{Style.RESET_ALL}")
            try:
                wp.DropInfoBase(base_obj, 1)  # 1 = принудительно
                print(f"{Fore.GREEN}База успешно удалена из кластера 1С{Style.RESET_ALL}")
            except Exception as e:
                print(f"{Fore.RED}Ошибка при удалении из кластера: {e}{Style.RESET_ALL}")

        # === PostgreSQL ===
        print(f"{Fore.CYAN}8. Удаление из PostgreSQL...{Style.RESET_ALL}")
        db_name = infobase.lower()
        try:
            os.environ['PGPASSWORD'] = pg_password

            # Закрываем чужие сессии
            subprocess.run([
                'psql', '-h', pg_server, '-p', pg_port, '-U', pg_user, '-d', 'postgres',
                '-c', f"SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = '{db_name}' AND pid <> pg_backend_pid();"
            ], check=False, capture_output=True)

            # Удаляем БД
            result = subprocess.run([
                'psql', '-h', pg_server, '-p', pg_port, '-U', pg_user, '-d', 'postgres',
                '-c', f"DROP DATABASE IF EXISTS \"{db_name}\";"
            ], check=False, capture_output=True, text=True)

            if result.returncode == 0:
                print(f"{Fore.GREEN}База '{db_name}' удалена из PostgreSQL{Style.RESET_ALL}")
            else:
                if "does not exist" in result.stderr:
                    print(f"{Fore.YELLOW}База '{db_name}' не существует в PostgreSQL{Style.RESET_ALL}")
                else:
                    print(f"{Fore.YELLOW}PostgreSQL: {result.stderr.strip()}{Style.RESET_ALL}")
        except Exception as e:
            print(f"{Fore.YELLOW}Ошибка PostgreSQL: {e}{Style.RESET_ALL}")
        finally:
            os.environ.pop('PGPASSWORD', None)

        # === Папка и кэш ===
        print(f"{Fore.CYAN}9. Удаление папки...{Style.RESET_ALL}")
        delete_folder("tests/build/results")

        print(f"{Fore.CYAN}10. Очистка кэша 1С...{Style.RESET_ALL}")
        clean_1c_cache()
        print(f"{Fore.GREEN}Кэш 1С очищен{Style.RESET_ALL}")

        print(f"{Fore.GREEN}Скрипт завершён успешно{Style.RESET_ALL}")
        return True

    except Exception as e:
        print(f"{Fore.RED}Критическая ошибка: {e}{Style.RESET_ALL}")
        return False

    finally:
        # === ОСВОБОЖДЕНИЕ COM-ОБЪЕКТОВ БЕЗ ОШИБОК ===
        for obj in [wp, agent, com_connector]:
            if obj is not None:
                try:
                    # Явно обнуляем ссылки
                    obj = None
                except:
                    pass
        try:
            pythoncom.CoUninitialize()
        except:
            pass


if __name__ == "__main__":
    print(f"{Fore.BLUE}=== УДАЛЕНИЕ БАЗЫ 1С + PostgreSQL ==={Style.RESET_ALL}")
    success = drop_1c_database()
    print(f"{Fore.BLUE}=== {'УСПЕХ' if success else 'ОШИБКА'} ==={Style.RESET_ALL}")
    sys.exit(0 if success else 1)