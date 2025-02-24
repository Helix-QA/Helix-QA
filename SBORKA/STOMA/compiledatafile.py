import os
import subprocess
import sys

def main():
    # Установка кодировки UTF-8 (аналог chcp 65001)
    sys.stdout.reconfigure(encoding='utf-8')

    # Константы
    working_dir = sys.argv[1]
    licenceedit_path = os.path.join(working_dir, "licenceedit.exe")
    serie = sys.agrv[2]
    
    datafile = f"{serie}.datafile"
    source_file = "Helix.epf"

    # Проверка наличия licenceedit.exe
    if not os.path.exists(licenceedit_path):
        print(f"Файл 'licenceedit.exe' не найден в '{working_dir}'!")
        sys.exit(1)

    # Смена рабочей директории (аналог cd /d)
    os.chdir(working_dir)

    # Формирование команды
    cmd = [
        licenceedit_path, "c", datafile, source_file, "-y", f"--serie={serie}"
    ]

    # Выполнение команды
    print()  # Пустая строка (аналог echo.)
    result = subprocess.run(cmd, capture_output=True, text=True)

    # Проверка кода завершения
    if result.returncode != 0:
        print()  # Пустая строка
        print(f"Error ({result.returncode}), press any key to quit...")
        print(f"Ошибка: {result.stderr}")
        sys.exit(1)
    else:
        print()  # Пустая строка
        print("Success, press any key to quit...")

    # Ожидание нажатия клавиши (опционально)
    input()  # Аналог "press any key to quit"

if __name__ == "__main__":
    try:
        main()
    except Exception as e:
        print(f"Неожиданная ошибка: {str(e)}")
        sys.exit(1)