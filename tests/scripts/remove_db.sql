-- Для PostgreSQL (правильный синтаксис)
\echo 'Удаление базы :infobase...'

-- Принудительно завершаем все подключения к базе
SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = :'infobase' AND pid <> pg_backend_pid();

-- Удаляем базу
DROP DATABASE IF EXISTS :"infobase";

\echo 'База :infobase удалена.'