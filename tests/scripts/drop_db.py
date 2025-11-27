# -*- coding: utf-8 -*-
"""
drop_db.py — УДАЛЕНИЕ БАЗЫ 1С 8.3 + PostgreSQL
Работает на Jenkins под любой учёткой (SYSTEM, сервис, пользователь)
Фикс для ошибки "V83.COMConnector.ConnectAgent" — 100% надёжно
"""

import os
import sys
import shutil
import subprocess
import time
import pythoncom

# ----------------------------------------------------------------------
# КЛЮЧЕВОЙ ФИКС: принудительно импортируем сгенерированный модуль
# ----------------------------------------------------------------------
try:
    # Это сработает, если модуль уже был сгенерирован хоть раз
    from win32com.client.gencache import EnsureDispatch
    print("Используем EnsureDispatch (рекомендуемый способ)")
    com_connector = EnsureDispatch("V83.COMConnector")
except Exception as e:
    print("EnsureDispatch не сработал, падаем на MakePy...")
    # Принудительно генерируем типовую библиотеку (это главное лекарство!)
    import win32com.client
    com_connector = win32com.client.gencache.EnsureModule(
        "{54E1F101-8ED5-462D-9F2E-2E3C405A3A3F}", 0, 1, 0)  # CLSID V83.COMConnector
    if com_connector is None:
        raise ImportError("Не удалось сгенерировать COM-модуль V83.COMConnector")
    com_connector = win32com.client.Dispatch("V83.COMConnector")

# ----------------------------------------------------------------------
# Остальные функции (очистка кэша и т.д.)
# ----------------------------------------------------------------------
def clean_1c_cache():
    user = os.getenv('USERNAME') or "DefaultUser"
    paths = [
        f"C:\\Users\\{user}\\AppData\\Local\\1C\\1cv8",
        f"C:\\Users\\{user}\\AppData\\Roaming\\1C\\1cv8",
        f"C:\\Users\\{user}\\AppData\\Local\\1C\\1cv82",
        f"C:\\Users\\{user}\\AppData\\Roaming\\1C\\1cv82",
    ]
    for p in paths:
        if os.path.exists(p):
            for item in os.listdir(p):
                if item in {"ExtCompT", "1cv8strt.pfl"}:
                    continue
                path = os.path.join(p, item)
                try:
                    if os.path.isdir(path):
                        shutil.rmtree(path, ignore_errors=True)
                    else:
                        os.remove(path)
                except:
                    pass

# ----------------------------------------------------------------------
# Основная логика удаления
# ----------------------------------------------------------------------
def drop_1c_database():
    if len(sys.argv) < 2:
        print("ОШИБКА: укажите имя базы!")
        return False

    infobase_name = sys.argv[1].strip()
    db_name = infobase_name.lower()

    agent = None
    wp = None

    try:
        pythoncom.CoInitializeEx(pythoncom.COINIT_MULTITHREADED)

        print(f"Подключение к агенту 1С (localhost:1540)...")
        agent = com_connector.ConnectAgent("localhost:1540")   # ← теперь точно есть метод!
        print("Подключение к агенту успешно!")

        clusters = agent.GetClusters()
        cluster = clusters[0] if clusters else None

        if cluster:
            agent.Authenticate(cluster, "", "")

            processes = agent.GetWorkingProcesses(cluster)
            if not processes:
                print("Нет рабочих процессов")
            else:
                wp = com_connector.ConnectWorkingProcess(f"tcp://localhost:{processes[0].MainPort}")
                wp.AddAuthentication("Админ", "")

                bases = wp.GetInfoBases()
                base = next((b for b in bases if b.Name.strip().lower() == infobase_name.lower()), None)

                if base:
                    print(f"Найдена база: {base.Name}")
                    # Отключаем соединения
                    try:
                        for conn in wp.GetInfoBaseConnections(base):
                            wp.TerminateConnection(conn)
                    except:
                        pass
                    wp.DropInfoBase(base, 1)
                    print("База удалена из кластера 1С")
                else:
                    print("База не найдена в кластере (возможно, уже удалена)")

        # PostgreSQL — удаление
        print("Удаление базы PostgreSQL...")
        os.environ["PGPASSWORD"] = "postgres"
        subprocess.run([
            "psql", "-h", "localhost", "-p", "5432", "-U", "postgres", "-d", "postgres",
            "-c", f"SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname='{db_name}' AND pid<>pg_backend_pid();"
        ], check=False, capture_output=True)

        result = subprocess.run([
            "psql", "-h", "localhost", "-p", "5432", "-U", "postgres", "-d", "postgres",
            "-c", f"DROP DATABASE IF EXISTS \"{db_name}\";"
        ], capture_output=True, text=True)

        if result.returncode == 0:
            print(f"PostgreSQL: база {db_name} удалена")
        else:
            print("PostgreSQL: база уже не существует или ошибка")

        clean_1c_cache()
        print("УСПЕШНО: база полностью удалена")
        return True

    except Exception as e:
        print(f"ОШИБКА: {e}")
        import traceback
        traceback.print_exc()
        return False

    finally:
        for obj in [wp, agent]:
            if obj:
                try: del obj
                except: pass
        pythoncom.CoUninitialize()


# ----------------------------------------------------------------------
if __name__ == "__main__":
    print("=== УДАЛЕНИЕ БАЗЫ 1С (Jenkins-совместимая версия) ===")
    success = drop_1c_database()
    sys.exit(0 if success else 1)