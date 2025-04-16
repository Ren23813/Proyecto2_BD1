# Proyecto2_BD1
## Creación de ambiente de tablas
1. Ejecutar el ddl.sql dentro de pgadmin4. Es importante que la base de datos que se inicialice se llame "Proyecto2". Así como la creación de usuario ejecutarlo únicamente 1 vez. 
2. Ejecutar el data.sql (el trigger únicamente 1 vez, si no, postgres creará un error)
3. Si se quiere volver a ejecutar el código, se recomienda hacer un TRUNCATE antes de volverlo a hacer, para limpiar la BD, así los asientos no están ocupados previamente. Este TRUNCATE:

```sql
DO
$$
DECLARE
    r RECORD;
BEGIN
    EXECUTE 'SET session_replication_role = replica';

    FOR r IN (
        SELECT tablename
        FROM pg_tables
        WHERE schemaname = 'public'
    ) LOOP
        EXECUTE 'TRUNCATE TABLE public.' || quote_ident(r.tablename) || ' RESTART IDENTITY CASCADE';
    END LOOP;

    EXECUTE 'SET session_replication_role = origin';
END;
$$;

## Ejecución del código
1. Ejecutar la función main(), dentro de main.py. En Visual Studio Code, con el botón F5 se corre, ubicándose dentro del archivo de main.py. 