import os
import sys
from datetime import datetime

sys.stdout.reconfigure(encoding='utf-8')

# Аргументы версии
oldversion_1 = sys.argv[1]
newversion_1 = sys.argv[2]
sampleEdf = sys.argv[3]
fbrb = sys.argv[4]


# Формирование дополнительных переменных для версии
def create_version_variables(version):
    parts = version.split('.')
    version_2 = '.'.join(parts[:3])
    version_3 = '_'.join(parts)
    return version_2, version_3

oldversion_2, oldversion_3 = create_version_variables(oldversion_1)
newversion_2, newversion_3 = create_version_variables(newversion_1)

# Словарь замен
replacements = {
    "oldversion_1": oldversion_1,
    "newversion_1": newversion_1,
    "oldversion_2": oldversion_2,
    "newversion_2": newversion_2,
    "oldversion_3": oldversion_3,
    "newversion_3": newversion_3,
}

# Функция для замены текста в файле
def replace_text_in_file(source, target, replacements):
    # Открываем исходный файл и читаем его содержимое
    with open(source, 'r', encoding='utf-8') as file:
        file_content = file.read()

    # Выполняем замену текста
    for key, value in replacements.items():
        file_content = file_content.replace(key, value)

    # Сохраняем изменения в целевом файле
    os.makedirs(os.path.dirname(target), exist_ok=True)
    with open(target, 'w', encoding='utf-8') as file:
        file.write(file_content)

# Обрабатываем все файлы в исходной директории
for filename in os.listdir(sampleEdf):
    if filename.endswith(".edf"):
        source_file = os.path.join(sampleEdf, filename)
        target_file = os.path.join(fbrb, filename)
        replace_text_in_file(source_file, target_file, replacements)
        print(f"Файл успешно скопирован и обработан: {target_file}")

print("Все файлы успешно обработаны.")
