import os
import sys
import time
import json
import argparse
import subprocess
import pythoncom
import win32com.client
import locale
from typing import Optional

# ==========================
# CONFIG
# ==========================

CONFIG_PATH_DEFAULT = "tests/scripts/config.json"

# ==========================
# LOGGING SETUP
# ==========================

import logging
logger = logging.getLogger("drop_db_v2")
logger.setLevel(logging.INFO)
formatter = logging.Formatter("%(asctime)s %(levelname)-7s %(message)s")

console = logging.StreamHandler(sys.stdout)
console.setFormatter(formatter)
logger.addHandler(console)

# ==========================
# ARGUMENT PARSER
# ==========================

# --- Автоматическая подстановка --db ---
if len(sys.argv) == 2 and not sys.argv[1].startswith("--"):
    sys.argv.insert(1, "--db")

parser = argparse.ArgumentParser(description="Drop 1C + PostgreSQL database safely (v2)")
parser.add_argument("--db", "-d", required=True, help="Database name (1C cluster + PostgreSQL)")
parser.add_argument("--config", "-c", default=CONFIG_PATH_DEFAULT, help="Path to config JSON")
parser.add_argument("--force-stop", action="store_true", help="Force terminate all connections")
parser.add_argument("--verbose", "-v", action="store_true", help="Verbose output")
args = parser.parse_args()

if args.verbose:
    logger.setLevel(logging.DEBUG)

# ==========================
# UTILS
# ==========================

def is_port_in_use(host: str, port: int) -> Optional[int]:
    """Return PID occupying the TCP port on Windows by parsing netstat -ano output."""
    try:
        system_encoding = locale.getpreferredencoding(False)
        completed = subprocess.run(
            ["netstat", "-ano"],
            capture_output=True,
            text=True,
            check=False,
            encoding=system_encoding,
            errors="ignore"
        )
        out = completed.stdout + "\n" + completed.stderr
        for line in out.splitlines():
            parts = line.split()
            if len(parts) >= 5 and parts[0].upper().startswith("TCP"):
                local = parts[1]
                pid = parts[-1]
                if ":" in local:
                    hostpart, portpart = local.rsplit(":", 1)
                    try:
                        if int(portpart) == port and (
                            host == "0.0.0.0" or host == hostpart or
                            (host == "127.0.0.1" and hostpart in ("127.0.0.1", "0.0.0.0", "[::1]"))
                        ):
                            return int(pid)
                    except ValueError:
                        continue
    except Exception as e:
        logger.debug(f"is_port_in_use failed: {e}")
    return None


def kill_pid(pid: int, force=False) -> bool:
    system_encoding = locale.getpreferredencoding(False)
    try:
        cmd = ["taskkill", "/PID", str(pid)]
        if force:
            cmd.append("/F")

        subprocess.run(cmd, check=False, capture_output=True,
                       text=True, encoding=system_encoding, errors="ignore")

        logger.info(f"Requested termination of PID {pid} (force={force})")
        time.sleep(1)
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


def drop_postgres_db(db_name: str, cfg: dict) -> bool:
    system_encoding = locale.getpreferredencoding(False)

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
        subprocess.run(terminate_cmd, check=False, capture_output=True, env=env,
                       text=True, encoding=system_encoding, errors="ignore")

        logger.info(f"Dropping PostgreSQL DB '{db_name}'...")
        res = subprocess.run(drop_cmd, check=False, capture_output=True, env=env,
                             text=True, encoding=system_encoding, errors="ignore")

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


def load_config(path: str) -> dict:
    if not os.path.exists(path):
        logger.error(f"Config file '{path}' not found!")
        return {}
    try:
        with open(path, "r", encoding="utf-8") as f:
            return json.load(f)
    except Exception as e:
        logger.error(f"Failed to read config file '{path}': {e}")
        return {}

# ==========================
# MAIN LOGIC
# ==========================

def main():
    logger.info("=== УДАЛЕНИЕ БАЗЫ 1С (v2) ===")
    db_name = args.db
    logger.info(f"Целевая база: {db_name}")

    cfg = load_config(args.config)

    pythoncom.CoInitialize()
    try:
        logger.info("Инициализация COM...")
        agent = win32com.client.Dispatch("V83.COMConnector").ConnectAgent("tcp://127.0.0.1:1540")
        logger.info("Подключение к агенту 1С: tcp://127.0.0.1:1540 ...")

        clusters = agent.GetClusters()
        if not clusters:
            logger.error("Не найдено ни одного кластера 1С.")
            return

        cluster = clusters[0]
        agent.Authenticate(cluster, "", "")
        logger.info(f"Поиск базы '{db_name}' в списке...")

        infobases = agent.GetInfoBases(cluster)
        target_ib = next((ib for ib in infobases if ib.Name == db_name), None)
        if not target_ib:
            logger.warning(f"База '{db_name}' не найдена в кластере 1С.")
        else:
            logger.info("Пробуем отключить активные соединения...")
            try:
                sessions = agent.GetSessions(cluster)
                connections = [s for s in sessions if s.InfoBase.Name == db_name]
                if connections:
                    logger.info(f"Найдено {len(connections)} соединений, отключаем...")
                    for s in connections:
                        try:
                            agent.TerminateSession(cluster, s)
                        except Exception as e:
                            logger.warning(f"Не удалось отключить соединение: {e}")
                else:
                    logger.info("Активных соединений не найдено.")
            except Exception as e:
                logger.warning(f"Ошибка при попытке отключения: {e}")

            logger.info("Удаляем базу из кластера 1С...")
            try:
                agent.DropInfoBase(cluster, target_ib)
                logger.info("База удалена из кластера 1С")
            except Exception as e:
                logger.error(f"Не удалось удалить базу из кластера 1С: {e}")

    finally:
        pythoncom.CoUninitialize()

    # PostgreSQL
    if cfg:
        drop_postgres_db(db_name, cfg)

    logger.info("Операция завершена (частично или полностью). Смотрите логи для деталей.")

# ==========================
# ENTRY POINT
# ==========================

if __name__ == "__main__":
    main()