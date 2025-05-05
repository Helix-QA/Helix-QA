import argparse
import os
import subprocess
import win32com.client
import re
import sys
from pathlib import Path

def parse_arguments():
    """Парсинг аргументов командной строки."""
    parser = argparse.ArgumentParser(description="Удаление базы 1С из кластера и PostgreSQL")
    parser.add_argument("--server1c", default="localhost", help="Адрес сервера 1С")
    parser.add_argument("--agentPort", default="1550", help="Порт агента 1С")
    parser.add_argument("--serverPg", default="localhost", help="Адрес PostgreSQL-сервера")
    parser.add_argument("--pgPort", default="5432", help="Порт PostgreSQL-сервера")
    parser.add_argument("--infobase", default="avtotestqa", help="Имя информационной базы")
    parser.add_argument("--user", default="", help="Имя администратора 1С")
    parser.add_argument("--passw", default="", help="Пароль администратора 1С")
    parser.add_argument("--pgUser", default="postgres", help="Имя пользователя PostgreSQL")
    parser.add_argument("--pgPwd", default="", help="Пароль PostgreSQL")
    parser.add_argument("--fulldrop", action="store_true", help="Полное удаление, включая базу PostgreSQL")
    return parser.parse_args()

def run_psql(pg_server, pg_port, pg_user, pg_pwd, script, infobase, dbname="postgres"):
    """Выполнение SQL-команды с помощью psql."""
    env = os.environ.copy()
    if pg_pwd:
        env["PGPASSWORD"] = pg_pwd
    cmd = [
        "psql",
        "-h", pg_server,
        "-p", pg_port,
        "-U", pg_user,
        "-d", dbname,
        "-v", f"infobase={infobase}",
        "-f", script
    ]
    try:
        result = subprocess.run(cmd, env=env, check=True, capture_output=True, text=True)
        print(result.stdout)
    except subprocess.CalledProcessError as e:
        print(f"Ошибка выполнения psql: {e.stderr}")
        raise

def terminate_pg_connections(pg_server, pg_port, pg_user, pg_pwd, infobase):
    """Завершение активных подключений к базе PostgreSQL."""
    env = os.environ.copy()
    if pg_pwd:
        env["PGPASSWORD"] = pg_pwd
    query = f"""
    SELECT pg_terminate_backend(pg_stat_activity.pid)
    FROM pg_stat_activity
    WHERE pg_stat_activity.datname = '{infobase}' AND pid <> pg_backend_pid();
    """
    cmd = [
        "psql",
        "-h", pg_server,
        "-p", pg_port,
        "-U", pg_user,
        "-d", "postgres",
        "-c", query
    ]
    try:
        result = subprocess.run(cmd, env=env, check=True, capture_output=True, text=True)
        print(result.stdout)
    except subprocess.CalledProcessError as e:
        print(f"Ошибка завершения подключений: {e.stderr}")
        raise

def clear_1c_cache():
    """Очистка кэша 1С для текущего пользователя."""
    users = [os.environ.get("USERNAME")]
    for user in users:
        user_path = f"C:\\Users\\{user}"
        paths = [
            f"{user_path}\\AppData\\Local\\1C\\1cv8",
            f"{user_path}\\AppData\\Roaming\\1C\\1cv8",
            f"{user_path}\\AppData\\Roaming\\1C\\1cv82",
            f"{user_path}\\AppData\\Local\\1C\\1cv82",
        ]
        for path in paths:
            if os.path.exists(path):
                print(f"Очистка кэша 1С в {path}")
                for item in os.listdir(path):
                    if re.match(r"[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}", item):
                        item_path = os.path.join(path, item)
                        try:
                            subprocess.run(f'rmdir /S /Q "{item_path}"', shell=True, check=True)
                        except subprocess.CalledProcessError as e:
                            print(f"Ошибка удаления {item_path}: {e}")

def main():
    """Основная логика удаления базы 1С."""
    args = parse_arguments()
    
    # Подключение к серверу 1С
    try:
        com_connector = win32com.client.Dispatch("V83.COMConnector")
        server_agent = com_connector.ConnectAgent(f"{args.server1c}:{args.agentPort}")
    except Exception as e:
        print(f"Ошибка подключения к агенту 1С: {e}")
        sys.exit(1)

    # Получение кластера
    clusters = server_agent.GetClusters()
    if not clusters:
        print("Кластеры не найдены")
        sys.exit(1)
    
    cluster = clusters[0]
    server_agent.Authenticate(cluster, "", "")

    # Подключение к рабочему процессу
    working_processes = server_agent.GetWorkingProcesses(cluster)
    if not working_processes:
        print("Рабочие процессы не найдены")
        sys.exit(1)

    working_process = com_connector.ConnectWorkingProcess(f"tcp://{args.server1c}:{working_processes[0].MainPort}")
    if args.user:
        working_process.AddAuthentication(args.user, args.passw)

    # Поиск информационной базы
    base_found = False
    base = None
    for info_base in working_process.GetInfoBases():
        if info_base.Name == args.infobase:
            base_found = True
            base = info_base
            break

    if not base_found:
        print(f"Информационная база {args.infobase} не найдена в кластере 1С")
        sys.exit(0)

    # Блокировка заданий и сессий
    base.ScheduledJobsDenied = True
    base.SessionsDenied = True
    working_process.UpdateInfoBase(base)

    # Разрыв соединений
    connections = working_process.GetInfoBaseConnections(base)
    for conn in connections:
        try:
            print(f"Разрыв соединения {conn.AppID} для базы {args.infobase}")
            working_process.Disconnect(conn)
        except Exception as e:
            print(f"Ошибка разрыва соединения: {e}")

    # Разрыв сессий
    for curr_cluster in clusters:
        sessions = server_agent.GetSessions(curr_cluster)
        for session in sessions:
            if session.InfoBase and session.InfoBase.Name == args.infobase:
                print(f"Разрыв сессии {session.AppID} для пользователя {session.UserName}")
                try:
                    server_agent.TerminateSession(cluster, session)
                except Exception as e:
                    print(f"Ошибка разрыва сессии: {e}")

    # Удаление базы из кластера
    print("Удаление базы из кластера...")
    try:
        script_dir = os.path.dirname(os.path.abspath(__file__))
        
        # Завершение активных подключений к базе PostgreSQL
        terminate_pg_connections(args.serverPg, args.pgPort, args.pgUser, args.pgPwd, args.infobase)
        
        # Удаление базы из кластера 1С
        working_process.DropInfoBase(base, 0)
        
        if args.fulldrop:
            # Полное удаление базы PostgreSQL
            run_psql(args.serverPg, args.pgPort, args.pgUser, args.pgPwd, f"{script_dir}\\remove_db.sql", args.infobase)
        
        clear_1c_cache()
        print("База успешно удалена")
    except Exception as e:
        print(f"Ошибка удаления базы: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()