import os
import subprocess
import win32com.client
import psycopg2
from psycopg2 import sql

# Название базы 1С и PostgreSQL
infobase = "avtotestqa"

# Параметры подключения
server1c = "localhost"
agent_port = "1540"
pg_server = "localhost"
pg_port = "5432"
pg_user = "postgres"
pg_password = "postgres"  # Пароль PostgreSQL

# Учетные данные для подключения к базе 1С (которую удаляем)
base1c_user = "Админ"  # Пользователь базы 1С
base1c_password = ""           # Пароль базы 1С

base_found = False

try:
    # Подключение к кластеру 1С
    v83_com = win32com.client.Dispatch("V83.ComConnector")
    server_agent = v83_com.ConnectAgent(f"{server1c}:{agent_port}")
    clusters = server_agent.GetClusters()
    cluster = clusters[0]
    server_agent.Authenticate(cluster, "", "")  # Пустые логин/пароль для кластера

    # Подключение к рабочему процессу
    working_processes = server_agent.GetWorkingProcesses(cluster)
    current_working_process = v83_com.ConnectWorkingProcess(
        f"tcp://{server1c}:{working_processes[0].MainPort}"
    )

    # Поиск базы в кластере
    base_info = current_working_process.GetInfoBases()
    for base in base_info:
        if base.Name == infobase:
            base_found = True
            base_obj = base
            break

    if base_found:
        # Блокировка базы с указанием пользователя и пароля
        base_obj.ScheduledJobsDenied = True
        base_obj.SessionsDenied = True
        current_working_process.UpdateInfoBase(base_obj)

        # Завершение соединений с использованием учетных данных базы
        connections = current_working_process.GetInfoBaseConnections(base_obj)
        for conn in connections:
            try:
                print(f"Disconnecting {infobase} connection: {conn.AppID}")
                # Принудительное отключение с указанием пользователя/пароля
                current_working_process.Disconnect(conn, base1c_user, base1c_password)
            except Exception as e:
                print(f"Failed to disconnect {conn.AppID}: {str(e)}")

        # Завершение сессий с указанием пользователя/пароля
        sessions = server_agent.GetSessions(cluster)
        for session in sessions:
            if session.InfoBase.Name == infobase:
                print(f"Terminating session for {infobase}, user: {session.UserName}")
                try:
                    server_agent.TerminateSession(cluster, session, base1c_user, base1c_password)
                except Exception as e:
                    print(f"Failed to terminate session: {str(e)}")

        # Удаление базы из кластера с указанием пользователя/пароля
        print(f"Removing {infobase} from 1C cluster...")
        current_working_process.DropInfoBase(base_obj, 0, base1c_user, base1c_password)

        # Удаление базы из PostgreSQL
        print(f"Removing {infobase} from PostgreSQL...")
        db_name_lower = infobase.lower()

        conn = None
        try:
            # Подключаемся к postgres для выполнения запросов
            conn = psycopg2.connect(
                host=pg_server,
                port=pg_port,
                user=pg_user,
                password=pg_password,
                dbname="postgres"
            )
            conn.autocommit = True
            cursor = conn.cursor()

            # Завершаем все соединения с базой
            terminate_query = sql.SQL("""
                SELECT pg_terminate_backend(pg_stat_activity.pid) 
                FROM pg_stat_activity 
                WHERE pg_stat_activity.datname = %s 
                AND pid <> pg_backend_pid();
            """)
            cursor.execute(terminate_query, [db_name_lower])
            
            # Удаляем базу
            drop_query = sql.SQL("DROP DATABASE IF EXISTS {}").format(
                sql.Identifier(db_name_lower)
            )
            cursor.execute(drop_query)
            
            print(f"PostgreSQL database {db_name_lower} dropped successfully.")
        except psycopg2.Error as e:
            print(f"Error working with PostgreSQL: {str(e)}")
        finally:
            if conn is not None:
                conn.close()

        # Очистка кэша 1С (с исключением папки ExtCompT)
        user = os.getenv('USERNAME')
        cache_paths = [
            f"C:\\Users\\{user}\\AppData\\Local\\1C\\1cv8",
            f"C:\\Users\\{user}\\AppData\\Roaming\\1C\\1cv8",
            f"C:\\Users\\{user}\\AppData\\Roaming\\1C\\1cv82",
            f"C:\\Users\\{user}\\AppData\\Local\\1C\\1cv82"
        ]

        for path in cache_paths:
            if os.path.exists(path):
                for item in os.listdir(path):
                    # Пропускаем папку ExtCompT
                    if item == "ExtCompT":
                        continue
                        
                    # Проверка на GUID-подобное имя
                    if len(item) == 36 and item.count('-') == 4:
                        item_path = os.path.join(path, item)
                        try:
                            if os.path.isdir(item_path):
                                import shutil
                                shutil.rmtree(item_path)
                            else:
                                os.remove(item_path)
                            print(f"Cleared 1C cache at {item_path}")
                        except Exception as e:
                            print(f"Failed to remove {item_path}: {str(e)}")

        print(f"Database {infobase} successfully removed.")
    else:
        print(f"Database {infobase} not found in 1C cluster.")

except Exception as e:
    print(f"Error: {str(e)}")
    exit(1)