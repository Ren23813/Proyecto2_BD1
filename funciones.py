import psycopg2

host = "localhost"  
dbname = "Proyecto2"  
user = "user_proyecto2"  
password = "proyecto2_2025"  

try:
    conn = psycopg2.connect(
        host=host,
        dbname=dbname,
        user=user,
        password=password
    )
    cursor = conn.cursor()

    print("Conexión exitosa a la base de datos")
except Exception as e:
    print(f"No se pudo conectar a la base de datos: {e}")





finally:
    conn.close()
    cursor.close()