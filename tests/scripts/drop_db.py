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
pg_password = "postgres"  # ← Укажи здесь пароль PostgreSQL

base_found = False

try:
    # Подключение к кластеру 1С
    v83_com = win32com.client.Dispatch("V83.ComConnector")
    server_agent = v83_com.ConnectAgent(f"{server1c}:{agent_port}")
    clusters = server_agent.GetClusters()
    cluster = clusters[0]
    server_agent.Authenticate(cluster, "", "")

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
        # Блокировка базы
        base_obj.ScheduledJobsDenied = True
        base_obj.SessionsDenied = True
        current_working_process.UpdateInfoBase(base_obj)

        # Завершение соединений
        connections = current_working_process.GetInfoBaseConnections(base_obj)
        for conn in connections:
            try:
                print(f"Disconnecting {infobase} connection: {conn.AppID}")
                current_working_process.Disconnect(conn)
            except Exception as e:
                print(f"Failed to disconnect {conn.AppID}: {str(e)}")

        # Завершение сессий
        sessions = server_agent.GetSessions(cluster)
        for session in sessions:
            if session.InfoBase.Name == infobase:
                print(f"Terminating session for {infobase}, user: {session.UserName}")
                try:
                    server_agent.TerminateSession(cluster, session)
                except Exception as e:
                    print(f"Failed to terminate session: {str(e)}")

        # Удаление базы из кластера
        print(f"Removing {infobase} from 1C cluster...")
        current_working_process.DropInfoBase(base_obj, 0)

        # Удаление базы из PostgreSQL
        print(f"Removing {infobase} from PostgreSQL...")
        db_name_lower = infobase.lower()

        terminate_query = f"""
        SELECT pg_terminate_backend(pg_stat_activity.pid) 
        FROM pg_stat_activity 
        WHERE pg_stat_activity.datname = '{db_name_lower}' 
        AND pid <> pg_backend_pid();
        """
        
        drop_query = f"DROP DATABASE IF EXISTS {db_name_lower};"

        # Установка переменной окружения PGPASSWORD
        os.environ['PGPASSWORD'] = pg_password

        try:
            # Выполнение SQL-запросов через psql
            subprocess.run([
                'psql', 
                '-h', pg_server, 
                '-p', pg_port, 
                '-U', pg_user, 
                '-d', 'postgres', 
                '-c', terminate_query
            ], check=True)
            
            subprocess.run([
                'psql', 
                '-h', pg_server, 
                '-p', pg_port, 
                '-U', pg_user, 
                '-d', 'postgres', 
                '-c', drop_query
            ], check=True)
        except subprocess.CalledProcessError as e:
            print(f"Error executing PostgreSQL command: {str(e)}")
        finally:
            # Удаление переменной окружения PGPASSWORD
            del os.environ['PGPASSWORD']

        # Очистка кэша 1С
        user = os.getenv('USERNAME')
        paths = [
            f"C:\\Users\\{user}\\AppData\\Local\\1C\\1cv8",
            f"C:\\Users\\{user}\\AppData\\Roaming\\1C\\1cv8",
            f"C:\\Users\\{user}\\AppData\\Roaming\\1C\\1cv82",
            f"C:\\Users\\{user}\\AppData\\Local\\1C\\1cv82"
        ]

        for path in paths:
            if os.path.exists(path):
                for item in os.listdir(path):
                    # Проверка на GUID-подобное имя (упрощенная версия)
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