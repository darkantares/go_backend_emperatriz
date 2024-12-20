DO $$ DECLARE
    tbl RECORD;
BEGIN
    -- Itera sobre todas las tablas en el esquema 'public'
    FOR tbl IN
        SELECT tablename
        FROM pg_tables
        WHERE schemaname = 'public'
    LOOP
        -- Elimina cada tabla y sus dependencias
        EXECUTE format('DROP TABLE IF EXISTS %I CASCADE', tbl.tablename);
    END LOOP;
END $$;
