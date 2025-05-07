import psutil
import time
import sys

def restart_1c_service():
    """Перезапускает службу 1C:Enterprise 8.3 Server Agent (x86-64)."""
    service_name = "1C:Enterprise 8.3 Server Agent (x86-64)"
    service = None
    
    try:
        # Поиск службы
        for svc in psutil.win_service_iter():
            if svc.name() == service_name:
                service = svc
                break
        
        if not service:
            print(f"Служба '{service_name}' не найдена.")
            sys.exit(1)
        
        print(f"Остановка службы '{service_name}'...")
        service_obj = psutil.win_service_get(service_name)
        service_obj.stop()
        
        # Ожидание остановки
        while service_obj.status() != 'stopped':
            time.sleep(1)
        
        print(f"Запуск службы '{service_name}'...")
        service_obj.start()
        
        # Ожидание запуска
        while service_obj.status() != 'running':
            time.sleep(1)
        
        print(f"Служба '{service_name}' успешно перезапущена.")
    
    except Exception as e:
        print(f"Ошибка при перезапуске службы '{service_name}': {str(e)}")
        sys.exit(1)

if __name__ == "__main__":
    try:
        restart_1c_service()
    except Exception as e:
        print(f"Критическая ошибка: {str(e)}")
        sys.exit(1)