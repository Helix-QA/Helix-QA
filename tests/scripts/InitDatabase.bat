@echo off
chcp 65001

REM Переходим к нужной функции
if "%1"=="session_kill" call vrunner session kill --db %2 --db-user "Админ" --db-pwd "" --uccode tester
if "%1"=="loadrepo"     call vrunner loadrepo --storage-name %2 --storage-user %3 --ibconnection /Slocalhost/%4 --db-user "Админ" --db-pwd "" --uccode tester
if "%1"=="restore"      call vrunner restore "D:\\Vanessa-Automation\\DT\\%2.dt" --ibconnection /Slocalhost/%3 --uccode tester
if "%1"=="remove"       call vrunner remove --name %2 --drop-database --clear-database --db-user "Админ" --db-pwd "" --uccode tester
if "%1"=="create"       call vrunner create --db-server localhost --name %2 --dbms PostgreSQL --db-admin postgres --db-admin-pwd postgres --uccode tester
if "%1"=="unload"       call vrunner unload "D:\\cf\\1Cv8.cf" --ibconnection /Slocalhost/%2 --db-user "Админ" --db-pwd "" --uccode tester
if "%1"=="load"         call vrunner load --src "D:\\cf\\1Cv8.cf" --ibconnection /Slocalhost/%2 --db-user "Админ" --db-pwd "" --uccode tester
if "%1"=="updatedbRep"  call vrunner updatedb --ibconnection /Slocalhost/%2 --db-user "Админ" --db-pwd "" --uccode tester
if "%1"=="updatedb"     call vrunner updatedb --ibconnection /Slocalhost/%2 --db-user "Админ" --db-pwd "" --uccode tester
if "%1"=="vanessa"      call vrunner vanessa --path "%2%3" --vanessasettings "tools/VAParams.json" --workspace tests --pathvanessa %4 --additional "/DisplayAllFunctions /L ru" --ibconnection /Slocalhost/%5 --db-user "Админ" --db-pwd "" --uccode tester
if "%1"=="update1C"     call vrunner run --command ЗавершитьРаботуСистемы; --ibconnection /Slocalhost/%2 --db-user "Админ" --db-pwd "" --execute "C:\\Program Files\\OneScript\\lib\\vanessa-runner\\epf\\ЗакрытьПредприятие.epf" --uccode tester
if "%1"=="dump"         call vrunner dump "D:\\Vanessa-Automation\\DT\\%2.dt" --ibconnection /Slocalhost/%3 --db-user "Админ" --db-pwd "" --uccode tester
if "%1"=="session_unlock" call vrunner session unlock --db "%2" --db-user "Админ" --db-pwd "" --uccode tester
if "%1"=="run"          call vrunner run --ibconnection /Slocalhost/%2 --db-user "Админ" --db-pwd "" --execute "C:\\Program Files\\OneScript\\lib\\vanessa-runner\\epf\\УбратьОкноПеремещенияИБ.epf" --uccode tester
if "%1"=="smoke"        call vrunner run --command "VAParams=%2\\tests\\tools\\VAParams.json;StartFeaturePlayer;GenerateSmokeTest;QuietInstallVanessaExtAndClose" --execute "%3" --ibconnection /Slocalhost/%4 --db-user "Админ" --db-pwd "" --uccode tester
if "%1"=="extension"    call vrunner loadrepo --storage-name %2 --storage-user МихаилБ --extension %3 --ibconnection /Slocalhost/%4 --db-user "Админ" --db-pwd "" --uccode tester
