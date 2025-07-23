import os
import re
import sys 

smoke = sys.argv[1]
product = sys.argv[2] 
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
    directory = rf'{product}'  # Путь из аргумента командной строки

    # Определение словаря замен и целевых файлов в зависимости от product
    if product == 'fitness':
        replacements = {
            "Если элемент формы с именем 'ФормаЗаписать' присутствует на форме Тогда": "Если элемент формы с именем 'ЗаписатьФитнес' присутствует на форме Тогда",
            "Если элемент формы с именем 'ФормаПеречитать' присутствует на форме Тогда": "Если элемент формы с именем 'СохранитьФитнес' присутствует на форме Тогда",
            "Если элемент формы с именем 'ФормаЗаписатьИЗакрыть' присутствует на форме Тогда": "Если элемент формы с именем 'СохранитьИЗакрытьФитнес' присутствует на форме Тогда",
            "И я нажимаю на кнопку с именем 'ФормаЗаписать'": "И я нажимаю на кнопку с именем 'ЗаписатьФитнес'",
            "И я нажимаю на кнопку с именем 'ФормаПеречитать'": "И я нажимаю на кнопку с именем 'СохранитьФитнес'",
            "И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'": "И я нажимаю на кнопку с именем 'СохранитьИЗакрытьФитнес'",
            "И Я закрываю текущее окно": "И Я закрываю все окна клиентского приложения"
        }
        target_files = [
            '013_Фитнес_Справочники_Запись.feature',
            '014_Фитнес_Справочники_Копирование.feature',
            '023_Фитнес_Документы_Запись.feature',
            '024_Фитнес_Документы_Копирование.feature',
            '082_Фитнес_Обработки_ФормаОбъекта.feature'
        ]
    elif product == 'salon':
        replacements = {
           
        }
        target_files = [
           
        ]
    elif product == 'stoma':
        replacements = {
            
        }
        target_files = [
           
        ]
    else:
        print(f"Неизвестный продукт: {product}. Поддерживаемые продукты: fitness, salon, stoma.")
        sys.exit(1)

    # Вызов функции
    replace_commands_in_features(directory, replacements, target_files)