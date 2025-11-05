/* Tema: Optimización de consultas a través de índices

Tareas: 

-- Realizar una carga masiva de por lo menos un millón de registro sobre alguna tabla que contenga 
un campo fecha (sin índice). Hacerlo con un script para poder automatizarlo.

-- Realizar una búsqueda por periodo y registrar el plan de ejecución utilizado por el motor 
y los tiempos de respuesta.

-- Definir un índice agrupado sobre la columna fecha y repetir la consulta anterior. 
Registrar el plan de ejecución utilizado por el motor y los tiempos de respuesta.

-- Borrar el índice creado

-- Definir otro índice agrupado sobre la columna fecha pero que además incluya las 
columnas seleccionadas y repetir la consulta anterior. 
Registrar el plan de ejecución utilizado por el motor y los tiempos de respuesta.

-- Expresar las conclusiones en base a las pruebas realizadas.
*/

------------------------------------------------------------------------------------------------------
------------------------------| ELECCION TABLA ENVIO |------------------------------------------------
/* CREATE TABLE envio (
    id_envio INT NOT NULL IDENTITY(1,1),
    fecha_registro DATE NOT NULL,
    id_paquete INT NOT NULL,
    id_ruta INT NOT NULL,
    id_vehiculo INT NOT NULL,
    id_empleado_responsable INT NOT NULL,
    id_estado_actual INT NOT NULL,
    CONSTRAINT pk_envio PRIMARY KEY (id_envio),
    CONSTRAINT fk_envio_paquete FOREIGN KEY (id_paquete) REFERENCES paquete(id_paquete),
    CONSTRAINT fk_envio_ruta FOREIGN KEY (id_ruta) REFERENCES ruta(id_ruta),
    CONSTRAINT fk_envio_vehiculo FOREIGN KEY (id_vehiculo) REFERENCES vehiculo(id_vehiculo),
    CONSTRAINT fk_envio_empleado FOREIGN KEY (id_empleado_responsable) REFERENCES empleado(id_empleado),
    CONSTRAINT fk_envio_estado FOREIGN KEY (id_estado_actual) REFERENCES estado_envio(id_estado),
    CONSTRAINT ck_envio_fecha CHECK (fecha_registro <= GETDATE())
);*/

-- 1) Realizar una carga masiva de por lo menos un millón de registro sobre alguna tabla que contenga un campo fecha (sin índice). Hacerlo con un script para poder automatizarlo.

--Declaramos variables
DECLARE @i INT = 0;
DECLARE @MaxEnvios INT = 1000000; --Numero total de registros a insertar

WHILE @i < @MaxEnvios
BEGIN
    INSERT INTO envio (
        fecha_registro,
        id_paquete,
        id_ruta,
        id_vehiculo,
        id_empleado_responsable,
        id_estado_actual
    )
    VALUES (
        DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 1826, '2020-01-01'), -- fecha aleatoria entre 2020-01 y 2025-01
        (@i % 4) + 1,  -- id_paquete entre 1 y 4
        (@i % 5) + 1,  -- id_ruta entre 1 y 5
        (@i % 4) + 1,  -- id_vehiculo entre 1 y 4
        (@i % 4) + 1,  -- id_empleado entre 1 y 4
        (@i % 4) + 1   -- id_estado entre 1 y 4
    );

    SET @i += 1;  -- Incrementa el contador
END;

-- Crea una nueva tabla "envio_2" como copia de "envio", sin indices
SELECT *
INTO envio_2
FROM envio;

-- 2) Realizar una búsqueda por periodo y registrar el plan de ejecución utilizado por el motor 
--y los tiempos de respuesta.

SET STATISTICS TIME ON;  -- Muestra tiempo de ejecucion (CPU y total)
SET STATISTICS IO ON;   -- Muestra operaciones de lectura/escritura

SELECT *
FROM envio_2
WHERE fecha_registro BETWEEN '2022-01-01' AND '2023-01-01';
--Plan utilizado "Table SCAN"  (escaneo completo de la tabla)

SELECT *
FROM envio
WHERE fecha_registro BETWEEN '2022-01-01' AND '2023-01-01';
--Plan utilizado "Clustered Index Scan" (escaneo del índice agrupado)

--Ahora realizaremos una serie de consultas para verificar los tiempos con el plan "Table Scan" 
-- Consulta 1: rango medio
SELECT *
FROM envio_2
WHERE fecha_registro BETWEEN '2022-01-01' AND '2023-01-01';
--Columnas devueltas: 201.152 // Tiempos (3 intentos): CPU time = 437 ms,  elapsed time = 1494 ms. // CPU time = 532 ms,  elapsed time = 1400 ms. // CPU time = 672 ms,  elapsed time = 1373 ms.
-- Consulta 2: rango estrecho
SELECT *
FROM envio_2
WHERE fecha_registro BETWEEN '2024-01-01' AND '2024-06-01';
--Columnas devueltas: 84.135 // Tiempos (3 intentos):   CPU time = 407 ms,  elapsed time = 833 ms. // CPU time = 375 ms,  elapsed time = 724 ms. // CPU time = 313 ms,  elapsed time = 623 ms.

--Consulta 3: rango amplio
SELECT *
FROM envio_2
WHERE fecha_registro BETWEEN '2020-01-01' AND '2024-01-01';
--Columnas devueltas: 800.608/ // Tiempos (3 intentos): CPU time = 1328 ms,  elapsed time = 7414 ms.// CPU time = 1407 ms,  elapsed time = 6639 ms.// CPU time = 1063 ms,  elapsed time = 7544 ms.

SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;

-- 3) Definir un índice agrupado sobre la columna fecha y repetir la consulta anterior. Registrar el plan de ejecución utilizado por el motor y los tiempos de respuesta.

--Tardo 00:00:04 en crear el indice 
--Aplicamos indice acumulado en la columna fecha_registro
CREATE CLUSTERED INDEX IX_fecha_registro
ON envio_2 (fecha_registro);

--Ahora realizaremos las mismas consultas para verificar los tiempos pero con el plan ("CLUSTERED INDEX SEEK").
SELECT *
FROM envio_2
WHERE fecha_registro BETWEEN '2022-01-01' AND '2023-01-01';
--Columnas devueltas: 201.152 // Tiempos (3 intentos):  CPU time = 250 ms,  elapsed time = 1400 ms. //   CPU time = 375 ms,  elapsed time = 1456 ms. //  CPU time = 203 ms,  elapsed time = 1467 ms.

SELECT *
FROM envio_2
WHERE fecha_registro BETWEEN '2024-01-01' AND '2024-06-01';
--Columnas devueltas: 84.135 // Tiempos (3 intentos):  CPU time = 62 ms,  elapsed time = 655 ms. //    CPU time = 78 ms,  elapsed time = 736 ms. //    CPU time = 78 ms,  elapsed time = 609 ms.

SELECT *
FROM envio_2
WHERE fecha_registro BETWEEN '2020-01-01' AND '2024-01-01';
--Columnas devueltas: 800.608//  Tiempos (3 intentos): CPU time = 1172 ms,  elapsed time = 5935 ms. // CPU time = 875 ms,  elapsed time = 5638 ms. //    CPU time = 797 ms,  elapsed time = 5416 ms.

-- 4) Borrar el índice creado

DROP INDEX IX_fecha_registro
ON envio_2;

-- 5) Definir otro índice agrupado sobre la columna fecha pero que además incluya las 
-- columnas seleccionadas y repetir la consulta anterior. 
-- Registrar el plan de ejecución utilizado por el motor y los tiempos de respuesta.

-- OPCION 1: Indice agrupado con las columnas definidas.
CREATE CLUSTERED INDEX I_fecha_registro
ON envio_2 (fecha_registro, id_paquete, id_ruta);

SET STATISTICS TIME ON;
SET STATISTICS IO ON;

--Plan "Clustered Index Seek"
-- Consulta 1: rango amplio
SELECT fecha_registro, id_paquete, id_ruta
FROM envio_2
WHERE fecha_registro BETWEEN '2020-01-01' AND '2024-01-01';
--Columnas devueltas: 800.608 / Tiempos (3 intentos):  CPU time = 578 ms,  elapsed time = 5374 ms.//     CPU time = 594 ms,  elapsed time = 5987 ms. //    CPU time = 640 ms,  elapsed time = 5087 ms.

-- Consulta 2: rango medio
SELECT fecha_registro, id_paquete, id_ruta
FROM envio_2
WHERE fecha_registro BETWEEN '2022-01-01' AND '2023-01-01';
-- Columnas devueltas: 201.152 // Tiempos (3 intentos):  CPU time = 172 ms,  elapsed time = 1191 ms. //    CPU time = 281 ms,  elapsed time = 1202 ms. //  CPU time = 157 ms,  elapsed time = 1185 ms.

-- Consulta 3: rango estrecho
SELECT fecha_registro, id_paquete, id_ruta
FROM envio_2
WHERE fecha_registro BETWEEN '2024-01-01' AND '2024-06-01';
--Columnas devueltas: 84.135 // Tiempos (3 intentos):    CPU time = 62 ms,  elapsed time = 490 ms. //    CPU time = 78 ms,  elapsed time = 539 ms. //   CPU time = 47 ms,  elapsed time = 508 ms.

--Consulta 4: 
SELECT fecha_registro, id_paquete, id_ruta
FROM envio
WHERE fecha_registro BETWEEN '2024-01-01' AND '2024-06-01'
  AND id_paquete = 3;
--Columnas devueltas; 21.202 // Tiempos (3 intentos):  CPU time = 250 ms,  elapsed time = 354 ms. // CPU time = 250 ms,  elapsed time = 332 ms.

--Consulta 5:
SELECT fecha_registro, id_paquete, id_ruta
FROM envio
WHERE fecha_registro BETWEEN '2024-01-01' AND '2024-06-01'
  AND id_paquete = 3
  AND id_ruta = 3;
--Columnas devueltas: 4.303 // Tiempos (3 intentos): CPU time = 266 ms,  elapsed time = 343 ms. // CPU time = 218 ms,  elapsed time = 292 ms.

SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;

--DROP INDEX I_fecha_registro ON envio_2;

--OPCION 2: Indice no agrupado con INCLUDE para las columnas
CREATE NONCLUSTERED INDEX IX_fecha_registro
ON envio (fecha_registro)
INCLUDE (id_paquete, id_ruta);

--Primero realizamos una consulta para verificar que no exista ningun indice no acumulado creado.
SELECT fecha_registro, id_paquete, id_ruta
FROM envio
WHERE fecha_registro BETWEEN '2020-01-01' AND '2024-01-01';
-- Plan Clustered Index Scan, por lo visto está utilizando el indice acumulado generado de forma automatica "PK_envio" pero este no es eficiente
--ya que realiza un escaneo completo de la tabla para encontrar el resultado deseado.

--Plan "Index Seek (NonClustered)"

-- Consulta 1: rango amplio
SELECT fecha_registro, id_paquete, id_ruta
FROM envio_2
WHERE fecha_registro BETWEEN '2020-01-01' AND '2024-01-01';
--Columnas devueltas: 800.608 // Tiempos (3 intentos): CPU time = 672 ms,  elapsed time = 4730 ms. //    CPU time = 781 ms,  elapsed time = 4795 ms. //  CPU time = 500 ms,  elapsed time = 4351 ms.

-- Consulta 2: rango medio
SELECT fecha_registro, id_paquete, id_ruta
FROM envio_2
WHERE fecha_registro BETWEEN '2022-01-01' AND '2023-01-01';
--Columnas devueltas: 201.152 // Tiempos (3 intentos):  CPU time = 281 ms,  elapsed time = 1172 ms. //  CPU time = 156 ms,  elapsed time = 1172 ms. //  CPU time = 296 ms,  elapsed time = 1102 ms.

-- Consulta 3: rango estrecho
SELECT fecha_registro, id_paquete, id_ruta
FROM envio_2
WHERE fecha_registro BETWEEN '2024-01-01' AND '2024-06-01';
--Columnas devueltas: 84.135 // Tiempos (3 intentos):  CPU time = 62 ms,  elapsed time = 515 ms. //  CPU time = 31 ms,  elapsed time = 518 ms. // CPU time = 63 ms,  elapsed time = 492 ms.

--Consulta 4
SELECT fecha_registro, id_paquete, id_ruta
FROM envio
WHERE fecha_registro BETWEEN '2024-01-01' AND '2024-06-01'
  AND id_paquete = 3;
--Columnas devueltas: 21.202 // Tiempos (3 intentos):    CPU time = 16 ms,  elapsed time = 243 ms. //  CPU time = 31 ms,  elapsed time = 194 ms. // CPU time = 63 ms,  elapsed time = 243 ms.

--Consulta 5
SELECT fecha_registro, id_paquete, id_ruta
FROM envio
WHERE fecha_registro BETWEEN '2024-01-01' AND '2024-06-01'
  AND id_paquete = 3
  AND id_ruta = 3;
--Columnas devueltas: 4.303 // Tiempos (3 intentos):  CPU time = 47 ms,  elapsed time = 119 ms. //  CPU time = 31 ms,  elapsed time = 115 ms. //  CPU time = 47 ms,  elapsed time = 110 ms.

 --En caso de querer eliminar el indice (NO acumulado), ejecutamos el siguiente codigo.
-- DROP INDEX IX_fecha_registro ON envio;

--Nota: Estas pruebas de índices acumulados e índices NO acumulados fueron basicas, sin embargo los resultados muestran que el uso de
--los mismos mejora notablemente el rendimiento de las consultas. Los índices agrupados optimizan busquedas por rangos amplios, mientras que los no agrupados con columnas incluidas son mas eficientes en consultas especificas.
--En ambos casos, se reducen los tiempos de respuesta y el uso de recursos al evitar escaneos completos de la tabla.
