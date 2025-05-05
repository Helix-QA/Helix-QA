\echo 'Проверка существования базы :restoreddb...'

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT FROM pg_database WHERE datname = :'restoreddb'
    ) THEN
        RAISE EXCEPTION 'Ошибка: база данных % не существует', :'restoreddb';
    END IF;
END $$;

\echo 'База :restoreddb существует.'