\echo 'Завершение подключений к базе :infobase...'

SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = :'infobase' AND pid <> pg_backend_pid();

\echo 'Все подключения к базе :infobase завершены.'