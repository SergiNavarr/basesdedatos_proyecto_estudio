
SET NOCOUNT ON;

--Declaramos variables
DECLARE @i INT = 1;
DECLARE @max INT = 1000000; --Numero total de registros a insertar

-- Variables para los campos del INSERT
DECLARE @fecha DATE;
DECLARE @id_paquete INT;
DECLARE @id_ruta INT;
DECLARE @id_vehiculo INT;
DECLARE @id_empleado INT;
DECLARE @id_estado INT;

WHILE @i <= @max
BEGIN
   -- Genera una fecha aleatoria entre 2015 y 2025
    SET @fecha = DATEADD(
                    DAY, 
                    ABS(CHECKSUM(@i * RAND() * 3)) % 3650,
                    '2015-01-01'
                );
    -- Valores pseudoaleatorios para claves foraneas
    SET @id_paquete    = ((ABS(CHECKSUM(@i * 7     + RAND()*100)) % 50) + 1); -- 1-50
    SET @id_ruta       = ((ABS(CHECKSUM(@i * 11    + RAND()*200)) % 20) + 1); -- 1-20
    SET @id_vehiculo   = ((ABS(CHECKSUM(@i * 13    + RAND()*150)) % 10) + 1); -- 1-10
    SET @id_empleado   = ((ABS(CHECKSUM(@i * 17    + RAND()*90 )) % 20) + 1); -- 1-20
    SET @id_estado     = ((ABS(CHECKSUM(@i * 19    + RAND()*50 )) % 6 ) + 1); -- 1-6

    -- Insercion final
    INSERT INTO envio (fecha_registro, id_paquete, id_ruta, id_vehiculo, id_empleado_responsable, id_estado_actual)
    VALUES (@fecha, @id_paquete, @id_ruta, @id_vehiculo, @id_empleado, @id_estado);

    -- Incremento del contador
    SET @i = @i + 1;
END;
SET NOCOUNT OFF;