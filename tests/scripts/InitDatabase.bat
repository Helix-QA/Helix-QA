@echo off
chcp 65001

REM Переходим к нужной функции
if "%1"=="session_kill" call vrunner session kill --db %2 --db-user Админ
if "%1"=="session_lock" call vrunner session lock --db %2 --db-user Админ
if "%1"=="session_unlock" call vrunner session unlock --db %2 --db-user Админ
if "%1"=="loadrepo" call vrunner loadrepo --storage-name %2 --storage-user %3 --ibconnection /Slocalhost/%4 --db-user Админ
if "%1"=="remove" call vrunner remove --name %2 --drop-database --clear-database --db-user Админ
if "%1"=="create" call vrunner create --db-server localhost --name %2 --dbms PostgreSQL --db-admin postgres --db-admin-pwd postgres
if "%1"=="run" call vrunner run --command "Путь=%2\\tests\\cfe\\%3.cfe;ЗавершитьРаботуСистемы" --ibconnection /Slocalhost/%4 --execute "%2\\tests\\epf\\ЗагрузитьРасширениеВРежимеПредприятия.epf"
if "%1"=="unload" call vrunner unload "D:\\cf\\1Cv8.cf" --ibconnection /Slocalhost/%2 --db-user Админ
if "%1"=="load" call vrunner load --src "D:\\cf\\1Cv8.cf" --ibconnection /Slocalhost/%2
if "%1"=="updatedb" call vrunner updatedb --ibconnection /Slocalhost/%2
if "%1"=="vanessa" call vrunner updatedb --ibconnection /Slocalhost/%2