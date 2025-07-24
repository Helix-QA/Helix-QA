import os
import re
import sys

def replace_commands_in_features(directory, replacements, target_files):
    """
    Открывает указанные .feature-файлы в директории и заменяет указанные команды.

    :param directory: Путь к директории с .feature-файлами.
    :param replacements: Словарь, где ключи — старые команды, а значения — новые команды.
    :param target_files: Список имен файлов, в которых нужно произвести замену.
    """
    if not os.path.isdir(directory):
        print(f"Ошибка: Директория {directory} не существует.")
        sys.exit(1)

    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith('.feature'):
                if file in target_files:
                    file_path = os.path.join(root, file)
                    try:
                        with open(file_path, 'r', encoding='utf-8') as f:
                            content = f.read()
                        modified = False
                        for old_command, new_command in replacements.items():
                            pattern = re.escape(old_command)
                            new_content, count = re.subn(pattern, new_command, content)
                            if count > 0:
                                modified = True
                                content = new_content
                        if modified:
                            with open(file_path, 'w', encoding='utf-8') as f:
                                f.write(content)
                            print(f"Обработан файл: {file_path} (замен произведено: {count})")
                        else:
                            print(f"Обработан файл: {file_path} (замен не произведено)")
                    except UnicodeDecodeError:
                        print(f"Ошибка: Не удалось прочитать файл {file_path} (проблема с кодировкой)")
                    except Exception as e:
                        print(f"Ошибка при обработке файла {file_path}: {str(e)}")
                else:
                    print(f"Пропущен файл: {file} (не в списке целевых файлов)")
            # Не выводим сообщение для файлов, не являющихся .feature

if __name__ == "__main__":
    # Проверка аргументов командной строки
    if len(sys.argv) < 3:
        print("Ошибка: Необходимо указать два аргумента: smoke и prod.")
        print("Пример: python script.py smoke_value fitness")
        sys.exit(1)

    smoke = sys.argv[1]  
    prod = sys.argv[2]

    # Определение словаря замен и целевых файлов
    if prod == 'fitness':
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
    elif prod == 'salon':
        replacements = {}
        target_files = []
    elif prod == 'stoma':
        replacements = {}
        target_files = []
    else:
        print(f"Неизвестный продукт: {prod}. Поддерживаемые продукты: fitness, salon, stoma.")
        sys.exit(1)

    # Проверка, есть ли целевые файлы для обработки
    if not target_files:
        print(f"Предупреждение: Список целевых файлов пуст для продукта {prod}. Никакие файлы не будут обработаны.")
        sys.exit(0)

    # Вызов функции
    replace_commands_in_features(prod, replacements, target_files)