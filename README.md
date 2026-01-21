<h1>Покрытие тестов</h1>

<details>
<summary><h3>1С: Фитнес-клуб</h3></summary>
<table style="border-collapse: separate; border-spacing: 40px 20px; width: 100%;">
  <tr>
    <!-- Договоры (фиолетовый блок, занимает 3 строки по высоте) -->
    <td rowspan="3" style="background:#bb86fc; padding:30px 50px; border-radius:30px; text-align:center; vertical-align:middle; white-space:nowrap; font-size:18px; color:black;">
      Договоры
    </td>

    <!-- Пустая ячейка для отступа/стрелки -->
    <td rowspan="3" style="text-align:center; vertical-align:middle; font-size:30px;">
      →
    </td>

    <!-- Создание и проверка справочников (синий, занимает 2 строки) -->
    <td rowspan="2" style="background:#81d4fa; padding:30px 50px; border-radius:30px; text-align:center; vertical-align:middle; font-size:18px; color:black;">
      Создание и проверка<br>справочников
    </td>

    <!-- Пустая ячейка для отступа/ветвления стрелок -->
    <td rowspan="3" style="text-align:center; vertical-align:middle; font-size:24px;">
      ↱<br><br>↳
    </td>

    <!-- Заполнение организации (зелёный) -->
    <td style="background:#a7ffeb; padding:30px 50px; border-radius:30px; text-align:center; vertical-align:middle; font-size:18px; color:black;">
      Заполнение<br>организации
    </td>
  </tr>

  <tr>
    <!-- Заполнение структурной единицы (зелёный) -->
    <td style="background:#a7ffeb; padding:30px 50px; border-radius:30px; text-align:center; vertical-align:middle; font-size:18px; color:black;">
      Заполнение<br>структурной единицы
    </td>
  </tr>

  <tr>
    <!-- Создание и проверка документов (синий) -->
    <td colspan="3" style="background:#81d4fa; padding:30px 50px; border-radius:30px; text-align:center; vertical-align:middle; font-size:18px; color:black;">
      Создание и проверка<br>документов
    </td>
  </tr>
</table>
</details>

<details>
<summary><h3>1С: Стоматологическая клиника</h3></summary>

</details>

<details>
<summary><h3>1С: Салон красоты</h3></summary>

</details>


<details>
<summary><h1>Автоматическое тестирование </h1></summary>

Автоматическое тестирование продукта перед выпуском релиза для обеспечения качества.

## Файлы

Файлы хранятся в папке `tests`:

| Папка/Файл                        | Описание                                                                 |
|-----------------------------------|--------------------------------------------------------------------------|
| `Jenkinsfile`                     | Основной файл запуска Jenkins, адаптированный для трёх продуктов: «Фитнес-клуб», «Салон красоты», «Стоматология». |
| `tools/VAParams.json`             | Настройки для Vanessa Automation.                                        |
| `scripts/AgentRestart.py`         | Перезапускает службу агента сервера 1С.                                 |
| `scripts/drop_db.py`              | Удаляет базу данных из кластера 1С и PostgreSQL.                         |
| `scripts/InitDatabase.bat`        | Запускает функции `vrunner` для инициализации базы.                      |
| `notifications/allure-notifications-4.8.0.jar` | Формирует отчёт Allure и отправляет его в Telegram.                     |
| `notifications/config.json`        | Настройки отчёта Allure и отправки сообщений в Telegram.                 |
| `notifications/logo.png`           | Логотип продукта в отчёте Allure.                                       |
| `features/`                       | Наборы тестов для Vanessa Automation.                                   |
| `epf/`                            | Обработки для тестирования.                                             |
| `cfe/`                            | Расширения конфигурации.                                                |
| `build/`                          | Результаты отчётов Allure.                                              |

## Запуск

Процесс полностью автоматизирован. Запуск выполняется через **Jenkins** для продуктов:

- **fitness** (Фитнес-клуб)
- **salon** (Салон красоты)
- **stoma** (Стоматология)

Агент выполнения (`OneS`) находится на сервере 71.

### Настройка расписания

Тестирование выполняется автоматически в **20:00** по МСК. Для активации периодического запуска в настройках Pipeline продукта включите опцию «Запускать периодически» и укажите расписание: `H 20 * * *`.

![Настройка расписания](docs/trigger.jpg)

## Принцип работы

### 1. Подготовка базы данных

1. Удаление существующей базы данных (при её наличии).
2. Создание новой пустой базы.
3. Загрузка файла `.dt` в новую базу.
4. Обновление конфигурации базы данных.
5. Загрузка данных из релизного хранилища.
6. Повторное обновление конфигурации.

В случае ошибки на любом этапе процесс повторяется до двух раз. При повторной ошибке перезапускается агент сервера 1С, после чего подготовка базы повторяется ещё два раза.

Если база успешно создана и заполнена, проверяется версия релиза:

- Если версия совпадает с текущей в файле `D:\Vanessa-Automation\version`, продолжается выполнение Pipeline.
- Если версия релиза выше, запускаются обработчики обновления, а эталонная база выгружается и заменяется новой версией.

![Процесс подготовки базы](docs/pipeline.jpg)

### 2. Сценарное тестирование

1. Отключение пользователей от базы данных.
2. Выполнение тестов с использованием Vanessa Automation.

### 3. Формирование и отправка отчёта Allure

- Проверяется стабильность результатов тестирования.
- Если результат стабилен или нестабилен, отчёт Allure отправляется в Telegram.
- В противном случае отчёт не отправляется.

![Пример отчёта Allure](docs/allure.jpg)

### 4. Дымовые тесты

#### - **Планируемые этапы**

- **Syntax-check**: Автоматическая проверка синтаксиса кода.
- **SonarQube**: Анализ качества кода с использованием платформы SonarQube.

## Рабочие каталоги

На сервере 71 в папке `D:\Vanessa-Automation` хранятся файлы эталонных баз и информация о версиях.

![Этапы выполнения](docs/build.jpg)

</details>