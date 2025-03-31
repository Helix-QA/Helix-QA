# ГРМ

**ГРМ** — сервис 1С, в который необходимо отправить файл `.dt`, полученный из пустой базы актуальной версии релиза.

- Отправка происходит после того, как 1С опубликовали релиз на портале.

## Файлы

Все файлы хранятся в папке `GRM`:

- **`Jenkinsfile`** — основной файл запуска всего процесса отправки в Jenkins.
- **`cleaning.py`** — удаляет содержимое папок `D:\dt` и `D:\cf`.
- **`transfer.py`** — копирует файл `.cf` из папки сборки релизов (`Old_versions_cf`).
- **`upload_file.py`** — выполняет PUT-запрос для отправки файла в ГРМ.

## Принцип работы

1. Удаляется содержимое папок `D:\dt` и `D:\cf`.
2. Получается предподписанная ссылка.
3. Файл `.cf` переносится из `Old_versions_cf` в `D:\cf`, загружается в пустую базу, обновляется конфигурация, затем выгружается `.dt` в папку `D:\dt`.
4. Файл `.dt` загружается в объектное хранилище.
5. Устанавливается версия по умолчанию.

## Запуск

Агент выполнения (`OneS`) находится на 71 сервере.  
Запуск производится через **Jenkins**:  
**Сборки релизов → GRM → Собрать с параметрами**.

### Заполняем параметры:

- **`nameProduct`** — указывается в зависимости от продукта, который отправляем (`finessCorp`, `SpaSalon3`, `salon30`).
- **`version`** — устанавливаем версию в формате `x.x.xx.x`.
- **`jenkinsAgent`** — имя агента устанавливается по умолчанию (изменять не нужно).

# Сборка релиза