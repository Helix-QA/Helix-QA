\echo 'Проверка и создание базы :restoreddb...'

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT FROM pg_database WHERE datname = :'restoreddb'
    ) THEN
        EXECUTE 'CREATE DATABASE "' || :'restoreddb' || '"';
        RAISE NOTICE 'База данных % создана.', :'restoreddb';
    ELSE
        RAISE NOTICE 'База данных % уже существует.', :'restoreddb';
    END IF;
END $$;

\echo 'Операция с базой :restoreddb завершена.'