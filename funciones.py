import psycopg2

host = "localhost"  
dbname = "Proyecto2"  
user = "user_proyecto2"  
password = "proyecto2_2025"  

def funcionPorHilos(lvl_aislamiento, id_thread):
    conn = psycopg2.connect(
        host=host,
        dbname=dbname,
        user=user,
        password=password)
    conn.set_isolation_level(lvl_aislamiento)
    cursor = conn.cursor()

    try:
        cursor.execute("BEGIN;")
        cursor.execute("INSERT INTO TABLA (nombre,algo) VALUES (%s);", (id_thread))     #CAMBIAR POR LOS QUERIES EN SÍ
#        time.sleep(0.5)            Se podría meter si se quisiera que existiera algo de secuencialización, y no solo paralelismo. 
        cursor.execute("UPDATE TABLA SET algo = algo + 1 WHERE id = %s;", (id_thread,))    #CAMBIAR POR LOS QUERIES EN SÍ
        
        cursor.execute("COMMIT;")

    except Exception as e:
        print(f"Hilo {id_thread} falló: {e}")
        cursor.execute("ROLLBACK;")
    
    finally:
        conn.close()
        cursor.close()
