import comtypes.client
import psycopg2
from psycopg2 import sql
import sys
import time

def connect_to_1c_cluster(server_address, agent_port):
    """Подключение к кластеру 1С."""
    try:
        v83 = comtypes.client.CreateObject("V83.COMConnector")
        connection_string = f"Srvr=\"{server_address}:{agent_port}\";Ref=\"\";"
        connection = v83.Connect(connection_string)
        return connection
    except Exception as e:
        print(f"Ошибка подключения к кластеру 1С: {e}")
        sys.exit(1)

def terminate_1c_sessions(connection, db_name):
    """Завершение всех сессий и соединений базы в кластере 1С."""
    try:
        cluster = connection.GetCluster()
        for db in cluster.GetInfoBases():
            if db.Name.lower() == db_name.lower():
                # Получаем соединения
                connections = cluster.GetInfoBaseConnections(db)
                for conn in connections:
                    cluster.Disconnect(conn)
                    print(f"Соединение {conn.ConnectionID} отключено")
                
                # Получаем сессии
                sessions = cluster.GetInfoBaseSessions(db)
                for session in sessions:
                    cluster.TerminateSession(db, session)
                    print(f"Сессия {session.SessionID} завершена")
                
                time.sleep(2)  # Ждем завершения операций
        print("Все сессии и соединения завершены")
    except Exception as e:
        print(f"Ошибка при завершении сессий 1С: {e}")
        sys.exit(1)

def drop_1c_database(connection, db_name):
    """Удаление базы данных из кластера 1С."""
    try:
        cluster = connection.GetCluster()
        for db in cluster.GetInfoBases():
            if db.Name.lower() == db_name.lower():
                cluster.DropInfoBase(db)
                print(f"База {db_name} удалена из кластера 1С")
                return
        print(f"База {db_name} не найдена в кластере 1С")
    except Exception as e:
        print(f"Ошибка при удалении базы из кластера 1С: {e}")
        sys.exit(1)

def connect_to_postgres(pg_server, pg_port, pg_user, pg_password):
    """Подключение к PostgreSQL."""
    try:
        conn = psycopg2.connect(
            host=pg_server,
            port=pg_port,
            user=pg_user,
            password=pg_password,
            database="postgres"  # Подключаемся к системной базе
        )
        conn.autocommit = True
        return conn
    except Exception as e:
        print(f"Ошибка подключения к PostgreSQL: {e}")
        sys.exit(1)

def drop_postgres_database(pg_conn, db_name):
    """Удаление базы данных в PostgreSQL."""
    try:
        cursor = pg_conn.cursor()
        # Завершаем все соединения с базой
        cursor.execute(sql.SQL("""
            SELECT pg_terminate_backend(pg_stat_activity.pid)
            FROM pg_stat_activity
            WHERE pg_stat_activity.datname = %s AND pid <> pg_backend_pid();
        """), [db_name])
        
        # Удаляем базу
        cursor.execute(sql.SQL("DROP DATABASE IF EXISTS {}").format(sql.Identifier(db_name)))
        print(f"База {db_name} удалена из PostgreSQL")
        cursor.close()
    except Exception as e:
        print(f"Ошибка при удалении базы из PostgreSQL: {e}")
        sys.exit(1)

def main(
    server_address, agent_port, pg_server, pg_port, db_name,
    db_user, db_password, pg_user, pg_password
):
    """Основная функция удаления базы."""
    print(f"Начало удаления базы {db_name}")
    
    # Подключение к кластеру 1С
    connection = connect_to_1c_cluster(server_address, agent_port)
    
    # Завершение сессий и соединений в 1С
    terminate_1c_sessions(connection, db_name)
    
    # Удаление базы из кластера 1С
    drop_1c_database(connection, db_name)
    
    # Подключение к PostgreSQL
    pg_conn = connect_to_postgres(pg_server, pg_port, pg_user, pg_password)
    
    # Удаление базы из PostgreSQL
    drop_postgres_database(pg_conn, db_name)
    
    # Закрытие соединений
    pg_conn.close()
    print("Удаление завершено успешно")

if __name__ == "__main__":
    # Укажите ваши данные здесь
    server_address = "localhost"  # Адрес сервера 1С
    agent_port = "1540"           # Порт агента 1С
    pg_server = "localhost"       # Адрес сервера PostgreSQL
    pg_port = "5432"              # Порт PostgreSQL
    db_name = "avtotestqa"        # Имя базы данных
    db_user = "Админ"             # Пользователь базы 1С
    db_password = ""              # Пароль базы 1С
    pg_user = "postgres"          # Пользователь PostgreSQL
    pg_password = "pgpass"        # Пароль PostgreSQL
    
    main(
        server_address, agent_port, pg_server, pg_port, db_name,
        db_user, db_password, pg_user, pg_password
    )