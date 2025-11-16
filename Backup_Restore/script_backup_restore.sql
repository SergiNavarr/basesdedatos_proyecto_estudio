USE master;
GO

-- Habilitamos opciones avanzadas para permitir modificar configuraciones especiales
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;

-- Activamos xp_cmdshell, que permite ejecutar comandos del sistema operativo desde SQL Server
EXEC sp_configure 'xp_cmdshell', 1;
RECONFIGURE;

-- Creamos la carpeta C:\Backup si no existe
EXEC xp_cmdshell 'IF NOT EXIST "C:\Backup" mkdir "C:\Backup"';
GO

-- Verificamos el modo de recuperación actual de la base de datos
SELECT name AS NombreBD, recovery_model_desc AS ModoRecuperacion
FROM sys.databases
WHERE name = 'PaqueExpress';
GO

-- Establecemos el modo FULL, necesario para backups de log
ALTER DATABASE PaqueExpress SET RECOVERY FULL WITH NO_WAIT;
GO

-- FULL BACKUP
BACKUP DATABASE PaqueExpress
TO DISK = 'C:\Backup\PaqueExpress_FULL.bak'
WITH NAME = 'PaqueExpress - Backup Completo Inicial',
     CHECKSUM,
     STATS = 10;
GO

-- BLOQUE DE INSERCIÓN #1
USE PaqueExpress;
GO

DECLARE @id_paquete INT;
DECLARE @i INT = 1;

WHILE @i <= 10
BEGIN
    INSERT INTO paquete (peso, dimensiones, valor_declarado, id_tipo_paquete, id_cliente_origen, id_cliente_destino)
    VALUES (ABS(CHECKSUM(NEWID())) % 50 + 1, '40x30x20', (ABS(CHECKSUM(NEWID())) % 100000) + 1000, 1, 5, 8);

    SET @id_paquete = SCOPE_IDENTITY();

    INSERT INTO envio (fecha_registro, id_paquete, id_ruta, id_vehiculo, id_empleado_responsable, id_estado_actual)
    VALUES (GETDATE(), @id_paquete, 2, 3, 4, 1);

    SET @i += 1;
END;
GO

-- BACKUP DEL LOG DE TRANSACCIONES #1
BACKUP LOG PaqueExpress
TO DISK = 'C:\Backup\PaqueExpress_Log1.trn'
WITH NAME = 'PaqueExpress - Backup de Log 1',
     CHECKSUM,
     STATS = 10;
GO

-- Registrar la hora del backup
DECLARE @HoraInicioBackupLog1 DATETIME2 = SYSDATETIME();
SELECT @HoraInicioBackupLog1 AS Hora_BackupLog1;

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
BACKUP LOG PaqueExpress
TO DISK = 'C:\Backup\PaqueExpress_Log2.trn'
WITH NAME = 'PaqueExpress - Backup de Log 2',
     CHECKSUM,
     STATS = 10;
GO

-- Registrar la hora del backup
DECLARE @HoraInicioBackupLog2 DATETIME2 = SYSDATETIME();
SELECT @HoraInicioBackupLog2 AS Hora_BackupLog2;

-- Verificación de registros actuales
SELECT COUNT(*) AS Cantidad_Paquetes_Actual FROM paquete;
SELECT COUNT(*) AS Cantidad_Envios_Actual FROM envio;
GO

-- SIMULACIÓN DE FALLO: pérdida total de datos
ALTER DATABASE PaqueExpress SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

USE master;
GO
DROP DATABASE PaqueExpress;
GO

-- RESTAURACIÓN PARCIAL (FULL + LOG1)
RESTORE DATABASE PaqueExpress
FROM DISK = 'C:\Backup\PaqueExpress_FULL.bak'
WITH NORECOVERY, REPLACE, STATS = 10;

RESTORE LOG PaqueExpress
FROM DISK = 'C:\Backup\PaqueExpress_Log1.trn'
WITH RECOVERY, STATS = 10;
GO

-- Verificación parcial después de LOG1
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

RESTORE DATABASE PaqueExpress
FROM DISK = 'C:\Backup\PaqueExpress_FULL.bak'
WITH NORECOVERY, REPLACE, STATS = 10;

RESTORE LOG PaqueExpress
FROM DISK = 'C:\Backup\PaqueExpress_Log1.trn'
WITH NORECOVERY, STATS = 10;

RESTORE LOG PaqueExpress
FROM DISK = 'C:\Backup\PaqueExpress_Log2.trn'
WITH RECOVERY, STATS = 10;

ALTER DATABASE PaqueExpress SET MULTI_USER;
GO

-- Verificación final
USE PaqueExpress;
GO
SELECT COUNT(*) AS Paquetes_Restaurados_B FROM paquete;
SELECT COUNT(*) AS Envios_Restaurados_B FROM envio;
GO