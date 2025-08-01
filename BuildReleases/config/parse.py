import re
import os

def modify_xml_in_place(file_path, replacements):
    """
    Изменяет указанные значения прямо в исходном XML-файле
    
    :param file_path: Путь к XML-файлу, который нужно изменить
    :param replacements: Словарь замен в формате {'шаблон': 'новое_значение'}
    :return: Строка с отчетом об изменениях
    """
    # Проверяем существование файла
    if not os.path.exists(file_path):
        return f"❌ Ошибка: Файл не найден: {file_path}"

    # Читаем содержимое файла
    try:
        with open(file_path, 'r', encoding='utf-8') as file:
            content = file.read()
    except Exception as e:
        return f"❌ Ошибка при чтении файла: {e}"

    updated_content = content
    changes = {}

    # Применяем все замены
    for pattern, new_value in replacements.items():
        updated_content, count = re.subn(
            pattern,
            fr'\g<1>{new_value}\g<2>',
            updated_content,
            flags=re.IGNORECASE
        )
        changes[new_value] = count > 0

    # Если есть изменения - перезаписываем файл
    if updated_content != content:
        try:
            # Создаем временный файл
            temp_file = file_path + '.tmp'
            with open(temp_file, 'w', encoding='utf-8') as file:
                file.write(updated_content)
            
            # Заменяем оригинальный файл
            os.replace(temp_file, file_path)
            
            # Формируем отчет
            report = []
            for value, changed in changes.items():
                status = "✅" if changed else "⚠️"
                report.append(f"{status} {value}")
            
            return "Изменения применены:\n" + "\n".join(report)
        except Exception as e:
            return f"❌ Ошибка при сохранении изменений: {e}"
    else:
        return "⚠️ Файл не изменен (совпадения не найдены)"

# Пример использования
xml_file = r'C:\Users\Алексей\Desktop\XML\Configuration.xml'

# Словарь замен (регулярные выражения)
replacements = {
    r'(<Name>\s*)СалонКрасоты_SPA(\s*<\/Name>)': 'SPAСалон',
  #  r'(<Version>\s*)3\.0\.42\.1(\s*<\/Version>)': '4.0.0.1',
    r'(<v8:content>\s*)1С:Салон красоты, редакция 3\.0(\s*<\/v8:content>)': '1С:SPA-Салон, редакция 3.0',
    r'(<DefaultStyle>\s*)Style\.Дополнительный(\s*<\/DefaultStyle>)': 'Style.Основной'
}

# Применяем изменения
result = modify_xml_in_place(xml_file, replacements)
print(result)