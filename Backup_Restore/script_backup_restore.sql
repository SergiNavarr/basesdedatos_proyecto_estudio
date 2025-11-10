USE master;
GO

-- Verificamos el modo de recuperación actual de la base de datos.

SELECT name AS NombreBD, recovery_model_desc AS ModoRecuperacion
FROM sys.databases
WHERE name = 'PaqueExpress';
GO

-- Cambiamos el modelo de recuperación a FULL.
ALTER DATABASE PaqueExpress SET RECOVERY FULL WITH NO_WAIT;
GO


-- FULL BACKUP
BACKUP DATABASE PaqueExpress
TO DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\PaqueExpress_FULL.bak'
WITH FORMAT,          -- Crea un nuevo conjunto de backups (descarta anteriores)
     INIT,            -- Sobrescribe cualquier archivo previo en esa ruta
     NAME = N'PaqueExpress - Backup Completo Inicial',
     CHECKSUM,        -- Verifica la integridad del backup mientras se crea
     STATS = 10;      -- Muestra progreso cada 10%
GO


-- BLOQUE DE INSERCIÓN #1
USE PaqueExpress;
GO

DECLARE @HoraInicioBloque1 DATETIME2 = SYSDATETIME();
PRINT '==> Inicio de operaciones del Bloque 1:';
SELECT @HoraInicioBloque1 AS Hora_Bloque1;

-- Variable para capturar el último ID generado por el INSERT en “paquete”.
DECLARE @id_paquete INT;

DECLARE @i INT = 1;
WHILE @i <= 10
BEGIN
    INSERT INTO paquete (peso, dimensiones, valor_declarado, id_tipo_paquete, id_cliente_origen, id_cliente_destino)
    VALUES (ABS(CHECKSUM(NEWID())) % 50 + 1, '40x30x20', (ABS(CHECKSUM(NEWID())) % 100000) + 1000, 1, 5, 8);

    SET @id_paquete = SCOPE_IDENTITY(); -- Guarda el último ID insertado

    INSERT INTO envio (fecha_registro, id_paquete, id_ruta, id_vehiculo, id_empleado_responsable, id_estado_actual)
    VALUES (GETDATE(), @id_paquete, 2, 3, 4, 1);

    SET @i += 1;
END;
GO


-- BACKUP DEL LOG DE TRANSACCIONES #1
-- Guardamos los cambios ocurridos desde el último backup

BACKUP LOG PaqueExpress
TO DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\PaqueExpress_Log1.trn'
WITH INIT,
     NAME = N'PaqueExpress - Backup de Log 1',
     CHECKSUM,
     STATS = 10;
GO


-- BLOQUE DE INSERCIÓN #2
DECLARE @id_paquete2 INT;
DECLARE @j INT = 1;

WHILE @j <= 10
BEGIN
    INSERT INTO paquete (peso, dimensiones, valor_declarado, id_tipo_paquete, id_cliente_origen, id_cliente_destino)
    VALUES (ABS(CHECKSUM(NEWID())) % 60 + 1, '50x40x30', (ABS(CHECKSUM(NEWID())) % 150000) + 500, 2, 9, 10);

    SET @id_paquete2 = SCOPE_IDENTITY();

    INSERT INTO envio (fecha_registro, id_paquete, id_ruta, id_vehiculo, id_empleado_responsable, id_estado_actual)
    VALUES (GETDATE(), @id_paquete2, 3, 4, 5, 2);

    SET @j += 1;
END;
GO


-- BACKUP DEL LOG DE TRANSACCIONES #2

-- Guardamos transacciones realizadas después del LOG1
DECLARE @HoraBackupLog2 DATETIME2 = SYSDATETIME();

BACKUP LOG PaqueExpress
TO DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\PaqueExpress_Log2.trn'
WITH INIT,
     NAME = N'PaqueExpress - Backup de Log 2',
     CHECKSUM,
     STATS = 10;
GO


-- VERIFICACIÓN ACTUAL DE REGISTROS

SELECT COUNT(*) AS Cantidad_Paquetes_Actual FROM paquete;
SELECT COUNT(*) AS Cantidad_Envios_Actual FROM envio;
GO



-- SIMULACIÓN DE FALLO

-- SINGLE_USER fuerza la desconexión de cualquier usuario conectado
ALTER DATABASE PaqueExpress SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

USE master;
GO


DROP DATABASE PaqueExpress;
GO


-- RESTAURACIÓN PARCIAL (FULL + LOG1)

-- Se restaura el backup completo (FULL), pero con la opción NORECOVERY:
-- esto deja la base en estado “restaurada” pero no operativa,
-- esperando que se apliquen los backups de log.
RESTORE DATABASE PaqueExpress
FROM DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\PaqueExpress_FULL.bak'
WITH NORECOVERY,  -- Mantiene la base pendiente de restauración
     REPLACE,     -- Sobrescribe si existiera una base con el mismo nombre
     STATS = 10;

-- Se aplica el primer log y se finaliza con RECOVERY:
-- RECOVERY deja la base lista para uso normal.
RESTORE LOG PaqueExpress
FROM DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\PaqueExpress_Log1.trn'
WITH RECOVERY,
     STATS = 10;
GO


-- Verificamos cuántos registros existen luego de restaurar hasta LOG1.
USE PaqueExpress;
GO
SELECT COUNT(*) AS Paquetes_Restaurados_A FROM paquete;
SELECT COUNT(*) AS Envios_Restaurados_A FROM envio;
GO



-- RESTAURACIÓN COMPLETA (FULL + LOG1 + LOG2)


USE master;
GO


ALTER DATABASE PaqueExpress SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

-- FULL
RESTORE DATABASE PaqueExpress
FROM DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\PaqueExpress_FULL.bak'
WITH NORECOVERY, REPLACE, STATS = 10;

-- LOG1
RESTORE LOG PaqueExpress
FROM DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\PaqueExpress_Log1.trn'
WITH NORECOVERY, STATS = 10;

-- LOG2 - RECOVERY
RESTORE LOG PaqueExpress
FROM DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\PaqueExpress_Log2.trn'
WITH RECOVERY, STATS = 10;

-- Devuelve la base a MULTI_USER para acceso normal.
ALTER DATABASE PaqueExpress SET MULTI_USER;
GO

USE PaqueExpress;
GO

SELECT COUNT(*) AS Paquetes_Restaurados_B FROM paquete;
SELECT COUNT(*) AS Envios_Restaurados_B FROM envio;
GO
