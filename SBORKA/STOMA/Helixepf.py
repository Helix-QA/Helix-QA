import os
import shutil
import sys
# Пути к исходной и целевой папкам

sources = sys.argv[1]

source_dir = rf"{sources}\sources\CommonModules\Helix"
target_dir = rf"{sources}\Helix\Helix"

# Пути к файлу, который нужно переименовать
file_dir = rf"{sources}\Helix\Helix\Ext"
old_file_name = "Module.bsl"
new_file_name = "ObjectModule.bsl"

# Полные пути к файлу до и после переименования
old_file_path = os.path.join(file_dir, old_file_name)
new_file_path = os.path.join(file_dir, new_file_name)

try:
    # Проверяем, существует ли исходная папка
    if not os.ы.exists(source_dir):
        raise FileNotFoundError(f"Исходная папка {source_dir} не существует")

    # Проверяем, существует ли целевая папка
    if os.path.exists(target_dir):
        print(f"Целевая папка {target_dir} уже существует. Удаляем её перед копированием.")
        shutil.rmtree(target_dir)  # Удаляем целевую папку, если она уже существует

    # Копируем папку с содержимым
    shutil.copytree(source_dir, target_dir)
    print(f"Папка успешно скопирована: {source_dir} -> {target_dir}")

    # Проверяем, существует ли файл Module.bsl
    if not os.path.exists(old_file_path):
        raise FileNotFoundError(f"Файл {old_file_path} не существует")

    # Переименовываем файл Module.bsl в ObjectModule.bsl
    os.rename(old_file_path, new_file_path)
    print(f"Файл успешно переименован: {old_file_path} -> {new_file_path}")

except FileNotFoundError as e:
    print(f"Ошибка: {e}")
except PermissionError:
    print(f"Ошибка: Нет прав доступа для выполнения операции. Проверьте права на папки и файлы.")
except Exception as e:
    print(f"Произошла ошибка: {e}")