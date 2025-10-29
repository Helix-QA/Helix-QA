import argparse
import json
import logging
import logging.handlers
import os
import shutil
import socket
import subprocess
import sys
import tempfile
import time
from typing import Optional, List

try:
    import pythoncom
    import win32com.client
except Exception as e:
    # We'll log later; keep import error non-fatal so script can at least run parts
    pythoncom = None
    win32com = None

DEFAULT_CONFIG = {
    "pg_server": "localhost",
    "pg_port": 5432,
    "pg_user": "postgres",
    "pg_password": "postgres",
    "agent_host": "127.0.0.1",
    "agent_port": 1540,
    "db_username": "Админ",
    "db_password": "",
    "temp_delete_paths": ["tests/build/results"],
    "cache_relative_paths": [
        "AppData\\Local\\1C\\1cv8",
        "AppData\\Roaming\\1C\\1cv8",
        "AppData\\Roaming\\1C\\1cv82",
        "AppData\\Local\\1C\\1cv82"
    ]
}

LOG_DIR = "logs"
LOG_FILE = os.path.join(LOG_DIR, "drop_1c.log")
if len(sys.argv) == 2 and not sys.argv[1].startswith("--"):
    sys.argv.insert(1, "--db")

def setup_logging(level=logging.INFO):
    os.makedirs(LOG_DIR, exist_ok=True)
    logger = logging.getLogger()
    logger.setLevel(level)

    fmt = logging.Formatter("%(asctime)s %(levelname)-7s %(message)s", "%Y-%m-%d %H:%M:%S")

    sh = logging.StreamHandler(sys.stdout)
    sh.setFormatter(fmt)
    logger.addHandler(sh)

    rh = logging.handlers.RotatingFileHandler(LOG_FILE, maxBytes=5 * 1024 * 1024, backupCount=5, encoding="utf-8")
    rh.setFormatter(fmt)
    logger.addHandler(rh)

    return logger


logger = setup_logging()


def load_config(path: Optional[str]) -> dict:
    cfg = DEFAULT_CONFIG.copy()
    if not path:
        return cfg
    try:
        with open(path, "r", encoding="utf-8") as f:
            user_cfg = json.load(f)
            cfg.update(user_cfg)
            logger.info(f"Loaded config from {path}")
    except FileNotFoundError:
        logger.warning(f"Config file {path} not found, using defaults")
    except Exception as e:
        logger.error(f"Failed to load config {path}: {e}")
    return cfg


def is_port_in_use(host: str, port: int) -> Optional[int]:
    """Return PID occupying the TCP port on Windows by parsing netstat -ano output."""
    try:
        # netstat -ano output encoding on Windows might be cp866 — try decode both
        completed = subprocess.run(["netstat", "-ano"], capture_output=True, text=True, check=False)
        out = completed.stdout + "\n" + completed.stderr
        for line in out.splitlines():
            parts = line.split()
            if len(parts) >= 5 and parts[0].upper().startswith("TCP"):
                local = parts[1]
                pid = parts[-1]
                if ":" in local:
                    hostpart, portpart = local.rsplit(":", 1)
                    try:
                        if int(portpart) == port and (host == "0.0.0.0" or host == hostpart or host == "127.0.0.1" and hostpart in ("127.0.0.1", "0.0.0.0", "[::1]")):
                            return int(pid)
                    except ValueError:
                        continue
    except Exception as e:
        logger.debug(f"is_port_in_use failed: {e}")
    return None


def kill_pid(pid: int, force=False) -> bool:
    try:
        if force:
            subprocess.run(["taskkill", "/PID", str(pid), "/F"], check=False, capture_output=True)
        else:
            subprocess.run(["taskkill", "/PID", str(pid)], check=False, capture_output=True)
        logger.info(f"Requested termination of PID {pid} (force={force})")
        # give it a moment
        time.sleep(1)
        # verify
        try:
            os.kill(pid, 0)
            logger.warning(f"PID {pid} still exists after termination request")
            return False
        except OSError:
            logger.info(f"PID {pid} terminated")
            return True
    except Exception as e:
        logger.error(f"Failed to kill PID {pid}: {e}")
        return False


def safe_rmtree(path: str):
    if not path:
        return
    try:
        if os.path.exists(path):
            shutil.rmtree(path, ignore_errors=True)
            logger.info(f"Removed folder: {path}")
        else:
            logger.debug(f"Folder does not exist: {path}")
    except Exception as e:
        logger.error(f"Failed to remove folder {path}: {e}")


def clean_1c_cache(cfg: dict):
    user = os.getenv("USERNAME") or os.getenv("USER") or ""
    if not user:
        logger.warning("Не удалось определить имя пользователя, пропускаем очистку кэша 1С")
        return
    for rel in cfg.get("cache_relative_paths", DEFAULT_CONFIG["cache_relative_paths"]):
        path = os.path.join("C:\\Users", user, rel)
        if os.path.exists(path):
            try:
                for item in os.listdir(path):
                    item_path = os.path.join(path, item)
                    if item in ("ExtCompT", "1cv8strt.pfl"):
                        logger.debug(f"Пропускаем {item_path}")
                        continue
                    try:
                        if os.path.isdir(item_path):
                            shutil.rmtree(item_path, ignore_errors=True)
                        else:
                            os.remove(item_path)
                        logger.debug(f"Deleted {item_path}")
                    except Exception as e:
                        logger.warning(f"Не удалось удалить {item_path}: {e}")
            except Exception as e:
                logger.warning(f"Не удалось прочитать кэш в {path}: {e}")
        else:
            logger.debug(f"Кэш путь не найден: {path}")


def delete_temp_paths(cfg: dict):
    for p in cfg.get("temp_delete_paths", DEFAULT_CONFIG["temp_delete_paths"]):
        safe_rmtree(p)


def drop_postgres_db(db_name: str, cfg: dict) -> bool:
    pg_server = cfg.get("pg_server")
    pg_port = str(cfg.get("pg_port"))
    pg_user = cfg.get("pg_user")
    pg_password = cfg.get("pg_password")

    env = os.environ.copy()
    env['PGPASSWORD'] = pg_password or ""

    db_quoted = db_name.replace('"', '""')
    terminate_cmd = [
        'psql', '-h', pg_server, '-p', pg_port, '-U', pg_user, '-d', 'postgres',
        '-c', f"SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = '{db_quoted}' AND pid <> pg_backend_pid();"
    ]

    drop_cmd = [
        'psql', '-h', pg_server, '-p', pg_port, '-U', pg_user, '-d', 'postgres',
        '-c', f"DROP DATABASE IF EXISTS \"{db_quoted}\";"
    ]

    try:
        logger.info(f"Terminating active connections to PostgreSQL DB '{db_name}'...")
        subprocess.run(terminate_cmd, check=False, capture_output=True, env=env, text=True)
        logger.info(f"Dropping PostgreSQL DB '{db_name}'...")
        res = subprocess.run(drop_cmd, check=False, capture_output=True, env=env, text=True)
        if res.returncode == 0:
            logger.info(f"PostgreSQL: база '{db_name}' удалена (или не существовала)")
            return True
        else:
            logger.error(f"PostgreSQL error: {res.stderr.strip()}")
            return False
    except FileNotFoundError:
        logger.error("psql не найден в PATH. Установите PostgreSQL клиент или добавьте psql в PATH.")
        return False
    except Exception as e:
        logger.exception(f"Ошибка при удалении БД PostgreSQL: {e}")
        return False
    finally:
        env.pop('PGPASSWORD', None)


def connect_and_drop_1c(infobase: str, cfg: dict) -> bool:
    if pythoncom is None or win32com is None:
        logger.warning("win32com или pythoncom не доступны — пропускаем операцию с кластером 1С")
        return False

    com = agent = wp = None
    try:
        pythoncom.CoInitialize()
        logger.info("Инициализация COM...")

        com = win32com.client.dynamic.Dispatch("V83.COMConnector")
        agent_addr = f"tcp://{cfg.get('agent_host')}:{cfg.get('agent_port')}"
        logger.info(f"Подключение к агенту 1С: {agent_addr} ...")
        agent = com.ConnectAgent(agent_addr)

        clusters = agent.GetClusters()
        if not clusters:
            logger.info("Кластеры не найдены. Пропускаем удаление из кластера 1С.")
            return False

        cluster = clusters[0]
        logger.debug("Аутентификация в кластере...")
        try:
            agent.Authenticate(cluster, "", "")
        except Exception:
            logger.debug("Аутентификация не удалась или не требуется")

        processes = agent.GetWorkingProcesses(cluster)
        if not processes:
            logger.info("Рабочие процессы не найдены в кластере")
            return False

        main_port = processes[0].MainPort
        wp = com.ConnectWorkingProcess(f"tcp://127.0.0.1:{main_port}")
        wp.AddAuthentication(cfg.get('db_username'), cfg.get('db_password'))

        logger.info(f"Поиск базы '{infobase}' в списке...")
        bases = wp.GetInfoBases()
        base_obj = next((b for b in bases if b.Name.lower() == infobase.lower()), None)
        if not base_obj:
            logger.info(f"База '{infobase}' не найдена в кластере 1С")
            return False

        # try to disable connections
        try:
            logger.info("Пробуем отключить активные соединения...")
            connections = wp.GetInfoBaseConnections(base_obj)
            if connections:
                logger.info(f"Найдено {len(connections)} соединений, отключаем...")
                for conn in connections:
                    try:
                        wp.TerminateConnection(conn)
                        logger.debug(f"Отключено соединение ID={conn.ConnectionID}")
                    except Exception as e:
                        logger.warning(f"Не удалось отключить соединение: {e}")
            else:
                logger.debug("Активных соединений не найдено")
        except Exception as e:
            logger.warning(f"Ошибка при работе с соединениями: {e}")

        # drop
        try:
            logger.info("Удаляем базу из кластера 1С...")
            wp.DropInfoBase(base_obj, 1)
            logger.info("База удалена из кластера 1С")
            return True
        except Exception as e:
            logger.exception(f"Ошибка удаления базы из кластера: {e}")
            return False

    except Exception as e:
        logger.exception(f"Критическая ошибка при работе с агентом 1С: {e}")
        return False
    finally:
        for obj in (wp, agent, com):
            try:
                if obj is not None:
                    del obj
            except Exception:
                pass
        try:
            pythoncom.CoUninitialize()
        except Exception:
            pass


def main():
    parser = argparse.ArgumentParser(description="Удаление базы 1С + очистка PostgreSQL и кэша")
    parser.add_argument("--db", "-d", required=True, help="avtotestqa")
    parser.add_argument("--config", "-c", help="Путь к config.json")
    parser.add_argument("--force-stop", action="store_true", help="Если порт занят — пробовать завершать процесс")
    parser.add_argument("--verbose", "-v", action="store_true", help="Более подробный вывод логов")

    args = parser.parse_args()

    if args.verbose:
        logger.setLevel(logging.DEBUG)
        logger.debug("Включен подробный лог (DEBUG)")

    cfg = load_config(args.config)

    agent_port = int(cfg.get("agent_port", 1540))
    agent_host = cfg.get("agent_host", "127.0.0.1")

    logger.info("=== УДАЛЕНИЕ БАЗЫ 1С (v2) ===")
    logger.info(f"Целевая база: {args.db}")

    pid = is_port_in_use(agent_host, agent_port)
    if pid:
        logger.warning(f"Порт агента {agent_port} занят PID {pid}")
        if args.force_stop:
            ok = kill_pid(pid, force=True)
            if not ok:
                logger.error(f"Не удалось завершить процесс PID {pid}. Прекращаю выполнение.")
                sys.exit(2)
            else:
                # small wait to let agent free port
                time.sleep(1)
        else:
            logger.error("Порт агента занят. Запустите скрипт с --force-stop чтобы попытаться завершить процесс или освободите порт вручную.")
            # proceed but operations with COM likely will fail

    # 1) delete from 1C cluster
    try:
        res_1c = connect_and_drop_1c(args.db, cfg)
    except Exception as e:
        logger.exception(f"Ошибка при удалении базы из 1С: {e}")
        res_1c = False

    # 2) delete from PostgreSQL
    dbname = args.db.lower()
    res_pg = drop_postgres_db(dbname, cfg)

    # 3) delete temp folders
    delete_temp_paths(cfg)

    # 4) clean 1C caches
    clean_1c_cache(cfg)

    if res_1c or res_pg:
        logger.info("Операция завершена (частично или полностью). Смотрите логи для деталей.")
        sys.exit(0)
    else:
        logger.error("Не удалось удалить базу ни из кластера 1С, ни из PostgreSQL. Проверьте логи.")
        sys.exit(3)

if __name__ == '__main__':
    main()


# ======= Пример config.json =======
# {
#   "pg_server": "localhost",
#   "pg_port": 5432,
#   "pg_user": "postgres",
#   "pg_password": "postgres",
#   "agent_host": "127.0.0.1",
#   "agent_port": 1540,
#   "db_username": "Админ",
#   "db_password": "",
#   "temp_delete_paths": ["tests/build/results"],
#   "cache_relative_paths": [
#       "AppData\\Local\\1C\\1cv8",
#       "AppData\\Roaming\\1C\\1cv8"
#   ]
# }
