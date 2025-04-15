@echo off
chcp 65001

REM Проверяем, передан ли параметр (имя функции)
if "%1"=="" (
    echo Ошибка: Укажите имя функции [kill_sessions или load_and_update]
    exit /b 1
)

REM Переходим к нужной функции
if "%1"=="kill_sessions" goto :kill_sessions
if "%1"=="load_and_update" goto :load_and_update

REM Если функция не найдена
echo Ошибка: Функция %1 не найдена
exit /b 1

REM Функция 1: Завершение сессий
:kill_sessions
    REM %2 - это dbName
    call vrunner session kill --with-nolock --db %2 --db-user Админ
    exit /b 0

REM Функция 2: Загрузка из хранилища и обновление базы
:load_and_update
    REM %2 - это repository, %3 - это user, %4 - это dbName
    call vrunner loadrepo --storage-name %2 --storage-user %3 --ibconnection /Slocalhost/%4 --db-user Админ
    call vrunner updatedb --ibconnection /Slocalhost/%4 --db-user Админ
    exit /b 0

REM Функция 3: Удаление базы
:remove
    REM %2 - это dbName
    call vrunner remove --name %2 --drop-database --clear-database --db-user Админ
    exit /b 0