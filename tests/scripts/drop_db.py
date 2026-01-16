import os
import subprocess
import sys
import shutil
import time
import pythoncom
import win32com.client
from contextlib import suppress


# ================== CONFIG ==================
AGENT_ADDR = "localhost:1540"
WP_HOST = "localhost"

DB_USER_1C = "Админ"
DB_PASS_1C = ""

PG_HOST = "localhost"
PG_PORT = "5432"
PG_USER = "postgres"
PG_PASS = "postgres"

PG_RETRIES = 6          # сколько раз пробуем убить сессии
PG_WAIT_BETWEEN = 5    # секунд между попытками
# ============================================


def clean_gen_py():
    gen_py = os.path.expanduser(r"~\AppData\Local\Temp\gen_py")
    shutil.rmtree(gen_py, ignore_errors=True)

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
    user = os.getenv("USERNAME")
    paths = [
        fr"C:\Users\{user}\AppData\Local\1C\1cv8",
        fr"C:\Users\{user}\AppData\Roaming\1C\1cv8",
        fr"C:\Users\{user}\AppData\Local\1C\1cv82",
        fr"C:\Users\{user}\AppData\Roaming\1C\1cv82",
    ]

    for path in paths:
        if not os.path.exists(path):
            continue

        for item in os.listdir(path):
            if item in ("ExtCompT", "1cv8strt.pfl"):
                continue
            full = os.path.join(path, item)
            with suppress(Exception):
                shutil.rmtree(full, ignore_errors=True) if os.path.isdir(full) else os.remove(full)


# ---------- PostgreSQL ----------

def terminate_pg_sessions(db_name: str):
    os.environ["PGPASSWORD"] = PG_PASS

    subprocess.run(
        [
            "psql", "-h", PG_HOST, "-p", PG_PORT,
            "-U", PG_USER, "-d", "postgres",
            "-c",
            f"""
            SELECT pg_terminate_backend(pid)
            FROM pg_stat_activity
            WHERE datname = '{db_name}'
              AND pid <> pg_backend_pid();
            """
        ],
        check=False,
        capture_output=True
    )


def drop_postgres(db_name: str):
    print(f"PostgreSQL: удаление базы {db_name}")
    os.environ["PGPASSWORD"] = PG_PASS

    try:
        for attempt in range(1, PG_RETRIES + 1):
            print(f"Попытка {attempt}: закрываем подключения PostgreSQL")
            terminate_pg_sessions(db_name)

            result = subprocess.run(
                [
                    "psql", "-h", PG_HOST, "-p", PG_PORT,
                    "-U", PG_USER, "-d", "postgres",
                    "-c", f'DROP DATABASE IF EXISTS "{db_name}";'
                ],
                capture_output=True,
                text=True
            )

            if result.returncode == 0:
                print("PostgreSQL: база удалена")
                return

            print("PostgreSQL ещё занята, ждём...")
            time.sleep(PG_WAIT_BETWEEN)

        print("❌ PostgreSQL: не удалось удалить базу после всех попыток")
        print(result.stderr)
        sys.exit(2)

    finally:
        os.environ.pop("PGPASSWORD", None)


# ---------- 1C ----------

def drop_1c_infobase(infobase_name: str) -> bool:
    """
    True — если база найдена (даже если Drop упал)
    False — если базы нет в кластере
    """
    com = agent = None
    pythoncom.CoInitialize()

    try:
        clean_gen_py()

        print("1. Подключение к COMConnector")
        com = win32com.client.gencache.EnsureDispatch("V83.COMConnector")

        print("2. Подключение к агенту 1С")
        agent = com.ConnectAgent(AGENT_ADDR)

        clusters = agent.GetClusters()
        if not clusters:
            print("Кластеры 1С не найдены")
            return False

        cluster = clusters[0]
        agent.Authenticate(cluster, "", "")

        print("3. Поиск базы во всех Working Process")
        for wp_info in agent.GetWorkingProcesses(cluster):
            wp = None
            try:
                wp = com.ConnectWorkingProcess(
                    f"tcp://{WP_HOST}:{wp_info.MainPort}"
                )
                wp.AddAuthentication(DB_USER_1C, DB_PASS_1C)

                for base in wp.GetInfoBases():
                    if base.Name.lower() == infobase_name.lower():
                        print(f"Найдена база {base.Name}")

                        with suppress(Exception):
                            for c in wp.GetInfoBaseConnections(base):
                                wp.TerminateConnection(c)

                        try:
                            wp.DropInfoBase(base, 1)
                            print("База удалена из кластера 1С")
                        except Exception as e:
                            print("⚠ DropInfoBase не удался, продолжаем:", e)

                        return True

            finally:
                with suppress(Exception):
                    del wp

        print("База не найдена в кластере 1С")
        return False

    finally:
        with suppress(Exception):
            del agent
            del com
        pythoncom.CoUninitialize()

# ================== ENTRYPOINT ==================

if __name__ == "__main__":
    print("=== УДАЛЕНИЕ БАЗЫ 1С ===")

    if len(sys.argv) < 2:
        print("Использование: drop_db.py <ИмяИБ>")
        sys.exit(1)

    infobase = sys.argv[1].strip()
    db_name = infobase.lower()

    found_1c = drop_1c_infobase(infobase)

    print("Ожидание освобождения ресурсов...")
    time.sleep(5)
    
    print("9. Удаление временной папки...")
    delete_folder("tests/build/results")

    drop_postgres(db_name)
    clean_1c_cache()

    print("=== УСПЕХ ===")
    sys.exit(0)
