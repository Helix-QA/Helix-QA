import sys
import requests

def upload_file(upload_url, file_path):
    try:
        # Открываем файл в бинарном режиме
        with open(file_path, 'rb') as file:
            # Отправляем PUT-запрос с бинарным содержимым файла
            response = requests.put(
                upload_url,
                data=file,
                headers={'Content-Type': 'application/octet-stream'}
            )
        
        # Проверяем статус ответа
        if response.status_code in range(200, 300):
            print(f"Upload successful. Status: {response.status_code}")
            if response.text:
                print(f"Response content: {response.text}")
        else:
            print(f"Upload failed. Status: {response.status_code}")
            print(f"Response content: {response.text}")
            sys.exit(1)
    except FileNotFoundError:
        print(f"Error: File not found at {file_path}")
        sys.exit(1)
    except Exception as e:
        print(f"Error during upload: {str(e)}")
        sys.exit(1)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python upload_file.py <upload_url> <file_path>")
        sys.exit(1)
    
    upload_url = sys.argv[1]
    file_path = sys.argv[2]
    print(f"Received upload_url: {upload_url}")  # Добавьте эту строку
    upload_file(upload_url, file_path)