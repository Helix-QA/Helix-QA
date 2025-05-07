import subprocess
import time
import sys
import os

def run_command(command):
    """Выполняет команду и возвращает результат."""
    try:
        # Устанавливаем кодировку cp1251 для декодирования вывода
        result = subprocess.run(command, shell=True, capture_output=True, text=True, encoding='cp1251')
        if result.returncode == 0:
            print(f"Команда '{command}' выполнена успешно: {result.stdout}")
        else:
            print(f"Ошибка при выполнении команды '{command}': {result.stderr}")
        return result.returncode
    except UnicodeDecodeError as ude:
        print(f"Ошибка декодирования вывода команды '{command}': {str(ude)}")
        return 0  # Предполагаем успешное выполнение
    except Exception as e:
        print(f"Исключение при выполнении команды '{command}': {str(e)}")
        return 1

def restart_1c_service():
    """Перезапускает службу 1C:Enterprise 8.3 Server Agent (x86-64)."""
    service_name = "1C:Enterprise 8.3 Server Agent (x86-64)"
    print(f"Остановка службы '{service_name}'...")
    stop_result = run_command(f'net stop "{service_name}"')
    
    if stop_result != 0:
        print(f"Не удалось остановить службу '{service_name}'. Код возврата: {stop_result}")
        sys.exit(1)
    
    # Даем время службе на завершение
    time.sleep(5)
    
    print(f"Запуск службы '{service_name}'...")
    start_result = run_command(f'net start "{service_name}"')
    
    if start_result != 0:
        print(f"Не удалось запустить службу '{service_name}'. Код возврата: {start_result}")
        sys.exit(1)
    
    print(f"Служба '{service_name}' успешно перезапущена.")

if __name__ == "__main__":
    try:
        # Устанавливаем кодировку cp1251 для вывода в консоль
        sys.stdout.reconfigure(encoding='cp1251')
        os.environ['PYTHONIOENCODING'] = 'cp1251'
        restart_1c_service()
    except Exception as e:
        print(f"Критическая ошибка: {str(e)}")
        sys.exit(1)