import shutil
import os
import sys

archive_name = sys.argv[1]
# Указываем путь
path = rf"{archive_name}\Collected_release"

# Проверяем, существует ли путь
if os.path.exists(path):
    # Получаем список всех элементов в директории
    for item in os.listdir(path):
        item_path = os.path.join(path, item)
        # Проверяем, является ли элемент папкой
        if os.path.isdir(item_path):
            try:
                # Удаляем папку и всё её содержимое
                shutil.rmtree(item_path)
                print(f"Удалена папка: {item_path}")
            except Exception as e:
                print(f"Ошибка при удалении {item_path}: {str(e)}")
else:
    print(f"Указанный путь не существует: {path}")