import zipfile
import os
import sys

fbrb = sys.argv[1]
target_path = sys.argv[2] 
serie = sys.argv[3]

def zip_selected_files(file_paths, archive_name):
    """
    Архивирует выбранные файлы в указанный архив.
    """
    # Получаем директорию архива и создаем её, если она не существует
    archive_dir = os.path.dirname(archive_name)
    if not os.path.exists(archive_dir):
        os.makedirs(archive_dir)
        print(f"Создана директория: {archive_dir}")

    # Создаем архив
    with zipfile.ZipFile(archive_name, 'w') as archive:
        for file_path in file_paths:
            if os.path.exists(file_path):
                archive.write(file_path, os.path.basename(file_path))
                print(f"Файл {file_path} добавлен в архив {archive_name}.")
            else:
                print(f"Файл {file_path} не найден и не был добавлен.")

# Формируем пути
directory_path = fbrb
selected_files = [
    os.path.join(directory_path, f"{serie}.datafile"),
    os.path.join(directory_path, f"{serie}.paramfile")
]
archive_name = os.path.join(target_path, "Комплект первичных материалов", "KeyDB", f"{serie}.zip")

# Запускаем архивацию
zip_selected_files(selected_files, archive_name)