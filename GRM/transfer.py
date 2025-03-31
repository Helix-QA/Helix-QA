import shutil
import os

# Исходная папка и имя файла
source_folder = r"D:\Release_build\FITNESSCORP\Collected_release"
file_name = "example.txt"  # Укажите имя файла, который нужно скопировать

# Целевая папка
destination_folder = r"D:\Release_build\New_folder"

try:
    # Формируем полный путь к исходному файлу
    source_path = os.path.join(source_folder, file_name)
    
    # Формируем полный путь к целевому файлу
    destination_path = os.path.join(destination_folder, file_name)
    
    # Проверяем существование исходной папки и файла
    if not os.path.exists(source_folder):
        print(f"Исходная папка не существует: {source_folder}")
    elif not os.path.exists(source_path):
        print(f"Файл не найден: {source_path}")
    else:
        # Создаем целевую папку, если она не существует
        os.makedirs(destination_folder, exist_ok=True)
        
        # Копируем файл
        shutil.copy2(source_path, destination_path)
        print(f"Файл успешно скопирован из {source_path} в {destination_path}")

except Exception as e:
    print(f"Произошла ошибка: {str(e)}")