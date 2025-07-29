import os
import shutil
import fnmatch
import logging
import sys

# Настройка кодировки вывода (опционально, для совместимости)
# sys.stdout.reconfigure(encoding='utf-8')

# Настройка логирования
logger = logging.getLogger()
logger.setLevel(logging.INFO)

# Обработчик для записи логов в файл
file_handler = logging.FileHandler('deletion_log.log', encoding='utf-8')
file_handler.setLevel(logging.INFO)

# Обработчик для вывода логов в консоль
console_handler = logging.StreamHandler()
console_handler.setLevel(logging.INFO)

# Формат для логирования
formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
file_handler.setFormatter(formatter)
console_handler.setFormatter(formatter)

# Добавляем обработчики в логгер
logger.addHandler(file_handler)
logger.addHandler(console_handler)

# Проверка аргументов командной строки
if len(sys.argv) < 4:
    logger.error("Необходимо передать как минимум 3 аргумента: target_path, archive_name, build")
    sys.exit(1)
target_path = sys.argv[1]
archive_name = sys.argv[2]
build = sys.argv[3]

# Папки, которые нужно удалить
folders_to_delete = [
    os.path.join(target_path, r"Комплект поставки обновления\Updsetup"),
    os.path.join(target_path, r"Комплект первичных материалов\Update")
]

# Файлы, которые нужно удалить
files_to_delete = ["1Cv8.dt", "1cv8.efd", "setup.exe", "setup"]

# Удаление папок с их содержимым
for folder in folders_to_delete:
    if os.path.exists(folder):
        try:
            shutil.rmtree(folder)
            logger.info(f"Папка удалена: {folder}")
        except Exception as e:
            logger.error(f"Ошибка при удалении папки {folder}: {str(e)}")
    else:
        logger.warning(f"Папка не найдена: {folder}")

# Удаление файлов в целевом каталоге
try:
    for root, dirs, files in os.walk(target_path):
        for file in files:
            file_path = os.path.join(root, file)
            # Удаление файлов по списку и по маске "Идентификатор_*"
            if file in files_to_delete or fnmatch.fnmatch(file, 'Идентификатор_*'):
                try:
                    os.remove(file_path)
                    logger.info(f"Файл удален: {file_path}")
                except Exception as e:
                    logger.error(f"Ошибка при удалении файла {file_path}: {str(e)}")
            # Удаление файлов с расширением .xls
            if file.endswith('.xls'):
                try:
                    os.remove(file_path)
                    logger.info(f".xls файл удален: {file_path}")
                except Exception as e:
                    logger.error(f"Ошибка при удалении .xls файла {file_path}: {str(e)}")
except Exception as e:
    logger.error(f"Ошибка при обходе директории {target_path}: {str(e)}")

# Удаление папок в archive_name
archive_path = rf"{archive_name}"
if os.path.exists(archive_path):
    for item in os.listdir(archive_path):
        item_path = os.path.join(archive_path, item)
        if os.path.isdir(item_path):
            try:
                shutil.rmtree(item_path)
                logger.info(f"Удалена папка: {item_path}")
            except Exception as e:
                logger.error(f"Ошибка при удалении {item_path}: {str(e)}")
else:
    logger.warning(f"Указанный путь не существует: {archive_path}")

# Удаление папок в build (кроме "Версии библиотек.txt" и "AddDocs")
build_path = rf"{build}"
if os.path.exists(build_path):
    for item in os.listdir(build_path):
        if item == "Версии библиотек.txt" or item == "AddDocs":
            continue
        item_path = os.path.join(build_path, item)
        if os.path.isdir(item_path):
            try:
                shutil.rmtree(item_path)
                logger.info(f"Удалена папка: {item_path}")
            except Exception as e:
                logger.error(f"Ошибка при удалении {item_path}: {str(e)}")
else:
    logger.warning(f"Указанный путь не существует: {build_path}")