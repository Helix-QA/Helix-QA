import os
import re
import sys 

smoke = sys.argv[1] 
def replace_commands_in_features(directory, replacements, target_files):
    """
    Открывает указанные .feature-файлы в директории и заменяет указанные команды.

    :param directory: Путь к директории с .feature-файлами.
    :param replacements: Словарь, где ключи — старые команды, а значения — новые команды.
    :param target_files: Список имен файлов, в которых нужно произвести замену.
    """
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file in target_files and file.endswith('.feature'):
                file_path = os.path.join(root, file)
                with open(file_path, 'r', encoding='utf-8') as f:
                    content = f.read()
                for old_command, new_command in replacements.items():
                    pattern = re.escape(old_command)  # Экранируем спецсимволы
                    content = re.sub(pattern, new_command, content)
                with open(file_path, 'w', encoding='utf-8') as f:
                    f.write(content)
                print(f"Обработан файл: {file_path}")
            else:
                print(f"Пропущен файл: {file}")

# Пример использования
if __name__ == "__main__":
    # Укажите путь к директории с .feature-файлами
    directory = rf'{smoke}'  # Замените на актуальный путь

    # Определите словарь замен
    replacements = {
        "И я нажимаю на кнопку с именем 'ФормаЗаписать'": "И я нажимаю на кнопку с именем 'Записать'",
        "И я нажимаю на кнопку с именем 'ФормаПеречитать'": "И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'",
        "И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'": "И я нажимаю на кнопку с именем 'ФормаКнопкаСохранитьИЗакрыть'"
    }

    # Укажите список целевых файлов с расширением .feature
    target_files = [
        '013_Справочники_Запись.feature',
        '014_Справочники_Копирование.feature',
        '023_Документы_Запись.feature',
        '024_Документы_Копирование.feature'
    ]

    # Вызов функции
    replace_commands_in_features(directory, replacements, target_files)