# -*- coding: utf-8 -*-
"""
drop_db.py — надёжное удаление информационной базы 1С 8.3 + PostgreSQL
Работает на Jenkins, TeamCity, под SYSTEM и обычным пользователем.
Версия: 2025-11 (стабильная)
"""

import os
import sys
import shutil
import subprocess
import glob
import pythoncom
import win32com.client
import time


# ----------------------------------------------------------------------
# 1. Принудительная очистка старого COM-кэша (это главное лекарство от IUnknown)
# ----------------------------------------------------------------------
def force_clean_com_cache():
    print("Очистка старого COM-кэша 1С...")
    win32com.client.gencache.is_readonly = False
    win32com.client.gencache.Rebuild(verbose=0)

    patterns = [
        os.path.expanduser(r"~\AppData\Local\Temp\gen_py"),
        os.path.expanduser(r"~\AppData\Local\Temp\TEMP\gen_py"),
        r"C:\Windows\Temp\gen_py",
        r"C:\Windows\Temp\TEMP\gen_py",
    ]
    for p in patterns:
        if "*" in p:
            for path in glob.glob(p):
                try:
                    shutil.rmtree(path, ignore_errors=True)
                except:
                    pass
        else:
            try:
                shutil.rmtree(p, ignore_errors=True)
            except:
                pass


# ----------------------------------------------------------------------
# 2. Очистка кэша 1С пользователя
# ----------------------------------------------------------------------
def clean_1c_cache():
    print("Очистка кэша 1С...")
    user = os.getenv('USERNAME') or "DefaultUser"
    paths = [
        f"C:\\Users\\{user}\\AppData\\Local\\1C\\1cv8",
        f"C:\\Users\\{user}\\AppData\\Roaming\\1C\\1cv8",
        f"C:\\Users\\{user}\\AppData\\Local\\1C\\1cv82",
        f"C:\\Users\\{user}\\AppData\\Roaming\\1C\\1cv82",
    ]
    for base_path in paths:
        if not os.path.exists(base_path):
            continue
        for item in os.listdir(base_path):
            if item in {"ExtCompT", "1cv8strt.pfl"}:
                continue
            full = os.path.join(base_path, item)
            try:
                if os.path.isdir(full):
                    shutil.rmtree(full, ignore_errors=True)
                else:
                    os.remove(full)
            except:
                pass


# ----------------------------------------------------------------------
# 3. Основная функция удаления базы
# ----------------------------------------------------------------------
def drop_1c_database():
    if len(sys.argv) < 2:
        print("ОШИБКА: укажите имя базы!")
        print("Использование: drop_db.py <ИмяБазы>")
        return False

    infobase_name = sys.argv[1].strip()
    db_name = infobase_name.lower()

    # Настройки подключения
    AGENT_ADDRESS = "localhost:1540"      # можно просто "localhost"
    PG_HOST = "localhost"
    PG_PORT = "5432"
    PG_USER = "postgres"
    PG_PASS = "postgres"
    ADMIN_1C = "Админ"
    ADMIN_PASS = ""

    com = agent = wp = None

    try:
        print("=== УДАЛЕНИЕ БАЗЫ 1С + PostgreSQL ===")
        print(f"Имя базы в 1С: {infobase_name}")
        print(f"Имя БД в PostgreSQL: {db_name}")

        # Важно для запуска под службами/Jenkins
        pythoncom.CoInitializeEx(pythoncom.COINIT_MULTITHREADED)

        print("1. Создание COM-объекта V83.COMConnector...")
        com = win32com.client.dynamic.Dispatch("V83.COMConnector")

        print(f"2. Подключение к агенту 1С ({AGENT_ADDRESS})...")
        agent = com.ConnectAgent(AGENT_ADDRESS)
        print("Подключение к агенту успешно")

        clusters = agent.GetClusters()
        if not clusters:
            print("Кластеры не найдены — база, скорее всего, уже удалена.")
        else:
            cluster = clusters[0]
            print(f"Кластер: {cluster.Name} ({cluster.HostName})")

            print("3. Аутентификация в кластере...")
            agent.Authenticate(cluster, "", "")

            print("4. Поиск рабочих процессов...")
            processes = agent.GetWorkingProcesses(cluster)
            if not processes:
                print("Рабочие процессы не найдены.")
            else:
                wp = com.ConnectWorkingProcess(f"tcp://localhost:{processes[0].MainPort}")
                wp.AddAuthentication(ADMIN_1C, ADMIN_PASS)

                print(f"5. Поиск инфобазы '{infobase_name}'...")
                bases = wp.GetInfoBases()
                base_obj = next((b for b in bases if b.Name.strip().lower() == infobase_name.lower()), None)

                if base_obj:
                    print(f"Инфобаза найдена: {base_obj.Name}")

                    # Отключаем все соединения
                    try:
                        connections = wp.GetInfoBaseConnections(base_obj)
                        if connections:
                            print(f"Найдено {len(connections)} активных соединений — отключаем...")
                            for c in connections:
                                try:
                                    wp.TerminateConnection(c)
                                    print(f"   Соединение {c.ConnID} ({c.Application}) отключено")
                                except:
                                    pass
                        else:
                            print("Активных соединений нет.")
                    except Exception as e:
                        print(f"Не удалось получить/отключить соединения: {e}")

                    # Удаляем базу из списка кластера
                    print("6. Удаление инфобазы из кластера...")
                    wp.DropInfoBase(base_obj, 1)  # 1 = удалить физически
                    print("Инфобаза успешно удалена из кластера 1С")
                else:
                    print(f"Инфобаза '{infobase_name}' не найдена в кластере (возможно, уже удалена)")

        # =============================================
        # 7. Удаление базы из PostgreSQL
        # =============================================
        print("7. Удаление базы из PostgreSQL...")
        os.environ["PGPASSWORD"] = PG_PASS

        # Завершаем все соединения
        subprocess.run([
            "psql", "-h", PG_HOST, "-p", PG_PORT, "-U", PG_USER, "-d", "postgres",
            "-c", f"SELECT pg_terminate_backend(pg_stat_activity.pid) "
                  f"FROM pg_stat_activity WHERE datname = '{db_name}' AND pid <> pg_backend_pid();"
        ], check=False, capture_output=True)

        # Удаляем саму БД
        result = subprocess.run([
            "psql", "-h", PG_HOST, "-p", PG_PORT, "-U", PG_USER, "-d", "postgres",
            "-c", f"DROP DATABASE IF EXISTS \"{db_name}\";"
        ], capture_output=True, text=True)

        if result.returncode == 0:
            print(f"База PostgreSQL '{db_name}' успешно удалена")
        else:
            if "does not exist" in result.stderr.lower():
                print(f"База PostgreSQL '{db_name}' уже не существует")
            else:
                print(f"Ошибка PostgreSQL: {result.stderr.strip()}")

        # =============================================
        # 8. Финальная очистка
        # =============================================
        print("8. Очистка временных папок проекта...")
        for folder in ["tests/build/results", "build", "out"]:
            if os.path.exists(folder):
                shutil.rmtree(folder, ignore_errors=True)

        print("9. Очистка кэша 1С...")
        clean_1c_cache()

        print("=== УСПЕШНО ЗАВЕРШЕНО ===")
        return True

    except pythoncom.com_error as e:
        print(f"COM-ОШИБКА: HRESULT=0x{e.hresult:X}")
        print(f"Описание: {e.strerror}")
        if e.hresult in (-2146959355, -2147220991):
            print("Агент 1С не запущен, порт закрыт или COM не зарегистрирован под текущим пользователем.")
        return False

    except Exception as e:
        print(f"НЕОЖИДАННАЯ ОШИБКА: {e}")
        import traceback
        traceback.print_exc()
        return False

    finally:
        # Правильное освобождение COM-объектов
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
        try:
            os.environ.pop("PGPASSWORD", None)
        except:
            pass


# ----------------------------------------------------------------------
# Запуск
# ----------------------------------------------------------------------
if __name__ == "__main__":
    force_clean_com_cache()
    success = drop_1c_database()
    print(f"\n=== {'УСПЕХ' if success else 'ОШИБКА'} ===")
    sys.exit(0 if success else 1)