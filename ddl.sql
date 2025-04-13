--La BD para la creación de estas tablas se tiene que llamar "Proyecto2"
CREATE TABLE IF NOT EXISTS clientes (id SERIAL PRIMARY KEY, nombre VARCHAR(255) NOT NULL,correo VARCHAR(255));

CREATE TABLE IF NOT EXISTS reserva (id SERIAL PRIMARY KEY, id_cliente int NOT NULL, CONSTRAINT fk_ReservaCliente FOREIGN KEY(id_cliente) REFERENCES clientes(id),estado_reserva INT NOT NULL);

CREATE TABLE IF NOT EXISTS pagos (id SERIAL PRIMARY KEY, id_reserva INT NOT NULL, CONSTRAINT fk_PagosReserva FOREIGN KEY (id_reserva) REFERENCES reserva(id), nit VARCHAR(255) NOT NULL, total INT NOT NULL);

CREATE TABLE IF NOT EXISTS salas (id SERIAL PRIMARY KEY, filas INT NOT NULL, asientos_filas INT NOT NULL, cupo_maximo INT NOT NULL, precio_asiento DECIMAL(10,2) NOT NULL);

CREATE TABLE IF NOT EXISTS peliculas (id SERIAL PRIMARY KEY, nombre VARCHAR(250) NOT NULL, productor VARCHAR(250) NOT NULL, sinopsis TEXT, duracion DECIMAL(10,2) NOT NULL, fecha_estreno TIMESTAMP NOT NULL, fecha_salida TIMESTAMP);

CREATE TABLE IF NOT EXISTS funciones (id SERIAL PRIMARY KEY, id_sala INT NOT NULL, CONSTRAINT fk_FuncionesSala FOREIGN KEY (id_sala) REFERENCES salas(id), id_pelicula INT NOT NULL, CONSTRAINT fk_FuncionesPeliculas FOREIGN KEY (id_pelicula) REFERENCES peliculas(id), horario_inicio TIMESTAMP NOT NULL, horario_salida TIMESTAMP NOT NULL);

CREATE TABLE IF NOT EXISTS asientos (id SERIAL PRIMARY KEY, ubicacion VARCHAR(50) NOT NULL, id_funcion INT NOT NULL, CONSTRAINT fk_AsientosFunciones FOREIGN KEY (id_funcion) REFERENCES funciones(id), estado VARCHAR(50) NOT NULL);

CREATE TABLE IF NOT EXISTS detalles_reserva (id SERIAL PRIMARY KEY, id_reserva INT NOT NULL, CONSTRAINT fk_DetallesreservaReserva FOREIGN KEY (id_reserva) REFERENCES reserva(id), id_asiento INT NOT NULL, CONSTRAINT fk_DetallesreservaAsientos FOREIGN KEY (id_asiento) REFERENCES asientos(id));

ALTER TABLE asientos ALTER COLUMN ubicacion TYPE INT USING ubicacion::integer;

--Esto solo ejecutarlo una única vez:
CREATE USER user_proyecto2 WITH PASSWORD 'proyecto2_2025';
GRANT CONNECT ON DATABASE "Proyecto2" TO user_proyecto2;
GRANT USAGE ON SCHEMA public TO user_proyecto2;
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO user_proyecto2;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO user_proyecto2;
GRANT TRIGGER ON ALL TABLES IN SCHEMA public TO user_proyecto2;
