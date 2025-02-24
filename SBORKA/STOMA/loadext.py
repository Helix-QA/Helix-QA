import os
import shutil
import subprocess
import sys

# Получение аргументов из командной строки
source_file = sys.argv[1]
designer_path = sys.argv[2]
base_build = sys.argv[3]
build_user = sys.argv[4]  # Имя пользователя на кириллице
template_name = sys.argv[5]

def main():
    # Установка кодировки UTF-8 для вывода в консоль
    sys.stdout.reconfigure(encoding='utf-8')

    # Перекодировка build_user из UTF-8 в cp1251
    build_user_cp1251 = build_user.encode().decode('utf-8').encode('cp1251').decode('cp1251')

    temp_dir = os.path.join(os.environ.get("TEMP", "C:\\Temp"), "template.upd")
    check_template = ""  # Оставлено пустым, как в BAT

    # Проверка исходного файла
    if not os.path.exists(source_file):
        print(f"Исходный файл '{source_file}' не найден!")
        sys.exit(1)

    print(f"Путь к информационной базе: {base_build}")
    print(f"Исходный файл: {source_file}")
    print(f"Целевой шаблон: {template_name}")
    print(f"Пользователь: {build_user}")  # Для отладки

    # Проверка наличия 1C:Enterprise
    if not os.path.exists(designer_path):
        print("1C:Enterprise не найден, невозможно обновить шаблон...")
        sys.exit(1)
    print(f"Найдена 1C:Enterprise: {designer_path}")

    # Управление временной директорией
    if os.path.exists(temp_dir):
        shutil.rmtree(temp_dir, ignore_errors=True)
    os.makedirs(temp_dir, exist_ok=True)

    # Проверка шаблона (если CheckTemplate не пустое)
    if check_template:
        print("Проверка шаблона...")
        dump_cmd = [
            designer_path, "DESIGNER", f"/S{base_build}",
            f"/DumpConfigFiles{temp_dir}", "-Template"
        ]
        result = subprocess.run(dump_cmd, capture_output=True, text=True, encoding='cp1251')
        if result.returncode != 0:
            print(f"Ошибка при выгрузке шаблона: {result.stderr}")
            sys.exit(1)

        template_file = os.path.join(temp_dir, f"ОбщийМакет.{template_name}.Макет.bin")
        if not os.path.exists(template_file):
            print(f"Ошибка: Общий шаблон '{template_name}' не найден в информационной базе '{base_build}'")
            sys.exit(1)

        # Очистка временной директории после проверки
        shutil.rmtree(temp_dir, ignore_errors=True)
        os.makedirs(temp_dir, exist_ok=True)

    # Копирование исходного файла
    target_file = os.path.join(temp_dir, f"ОбщийМакет.{template_name}.Макет.bin")
    shutil.copy2(source_file, target_file)
    print("Загрузка шаблона...")

    # Загрузка шаблона в базу с перекодированным именем пользователя
    load_cmd = [
        designer_path, "DESIGNER", f"/S{base_build}", f"/N{build_user_cp1251}",
        f"/LoadConfigFiles{temp_dir}", "-Template", "/UpdateDBCfg"
    ]
    result = subprocess.run(load_cmd, capture_output=True, text=True, encoding='cp1251')
    if result.returncode != 0:
        print(f"Ошибка при загрузке шаблона: {result.stderr}")
        sys.exit(1)

    # Успешное завершение
    print("Операция выполнена успешно")

    # Очистка временной директории
    if os.path.exists(temp_dir):
        shutil.rmtree(temp_dir, ignore_errors=True)

if __name__ == "__main__":
    try:
        main()
    except Exception as e:
        print(f"Ошибка: {str(e)}")
        sys.exit(1)