@echo off
chcp 65001

REM Проверяем, передан ли параметр (имя функции)
if "%1"=="" (
    echo Ошибка: Укажите имя функции [kill_sessions или load_and_update]
    exit /b 1
)

REM Переходим к нужной функции
if "%1"=="kill_sessions" goto :kill_sessions
if "%1"=="loadrepo" goto :loadrepo
if "%1"=="remove" goto :remove
if "%1"=="create" goto :create
if "%1"=="run" goto :run
if "%1"=="unload" goto :unload
if "%1"=="load" goto :load
if "%1"=="updatedb" goto :updatedb

REM Если функция не найдена
echo Ошибка: Функция %1 не найдена
exit /b 1

REM Функция 1: Завершение сессий
:kill_sessions
    REM %2 - это dbName
    call vrunner session kill --db %2 --cluster-admin Admin --cluster-pwd admin --cluster-name "Локальный кластер"
    exit /b 0

REM Функция 2: Загрузка из хранилища и обновление базы
:loadrepo
    REM %2 - это repository, %3 - это user, %4 - это dbName
    call vrunner loadrepo --storage-name %2 --storage-user %3 --ibconnection /Slocalhost/%4 --db-user Админ
    call vrunner updatedb --ibconnection /Slocalhost/%4 --db-user Админ
    exit /b 0

REM Функция 3: Удаление базы
:remove
    REM %2 - это dbName
    call vrunner remove --name %2 --drop-database --clear-database --db-user Админ
    exit /b 0

REM Функция 3: Удаление базы
:create
    REM %2 - это dbName
    call vrunner create --db-server localhost --name %2 --dbms PostgreSQL --db-admin postgres --db-admin-pwd postgres
    exit /b 0


REM Функция 3: Удаление базы
:run
    REM %2 - это dbName
    call vrunner run --command "Путь=%2\\tests\\cfe\\%3.cfe;ЗавершитьРаботуСистемы" --ibconnection /Slocalhost/%4 --execute "%2\\tests\\epf\\ЗагрузитьРасширениеВРежимеПредприятия.epf"
    exit /b 0

REM Функция 3: Удаление базы
:unload
    REM %2 - это dbName
    call vrunner unload "D:\\cf\\1Cv8.cf" --ibconnection /Slocalhost/%2 --db-user Админ
    exit /b 0


REM Функция 3: Удаление базы
:load
    REM %2 - это dbName
    call vrunner load --src "D:\\cf\\1Cv8.cf" --ibconnection /Slocalhost/%2
    exit /b 0

REM Функция 3: Удаление базы
:updatedb
    REM %2 - это dbName
    call vrunner updatedb --ibconnection /Slocalhost/%2
    exit /b 0