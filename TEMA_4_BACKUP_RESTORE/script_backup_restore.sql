----------------------------- BACKUP -----------------------------

-- Verifica el modelo de recuperación actual de la base de datos activa
SELECT name, recovery_model_desc
FROM sys.databases
WHERE name = DB_NAME();

-- Cambia el modelo de recuperación de la base de datos a FULL
ALTER DATABASE PaqueExpress SET RECOVERY FULL;


-- Realizar un BACKUP FULL de la base de datos
BACKUP DATABASE PaqueExpress
TO DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\PaqueExpress_FULL.bak'
WITH FORMAT,           -- Crea un nuevo conjunto de backup (formatea el archivo)
     INIT,             -- Sobrescribe cualquier backup previo en la ruta especificada
     NAME = N'PaqueExpress Full Backup',  -- Nombre descriptivo del backup
     CHECKSUM,         -- Valida la integridad del backup mientras se realiza
     STATS = 10;       -- Muestra el progreso cada 10%


--------------------- BLOQUE DE INSERCIÓN 1 ---------------------

-- Guarda la hora actual antes de los primeros inserts
DECLARE @Hora_PreInsert1 DATETIME2 = SYSUTCDATETIME();

SET NOCOUNT ON;

-- Inserta 10 registros en las tablas 'paquete' y 'envio'
INSERT INTO paquete (peso, dimensiones, valor_declarado, id_tipo_paquete, id_cliente_origen, id_cliente_destino) VALUES
(12.34, '40x30x20', 45230.50, 3, 10, 25),
(7.80, '25x20x10', 12000.00, 1, 15, 40),
(34.55, '60x50x45', 84500.75, 4, 22, 9),
(0.95, '18x22x3', 3200.00, 1, 5, 13),
(42.30, '90x70x65', 156000.00, 5, 8, 46),
(25.10, '55x40x30', 98500.30, 2, 12, 34),
(4.75, '28x28x25', 18750.00, 3, 17, 19),
(16.89, '45x35x40', 45600.90, 4, 23, 11),
(38.77, '80x70x60', 135800.45, 5, 30, 44),
(2.65, '22x18x10', 6700.00, 2, 7, 33);

INSERT INTO envio (fecha_registro, id_paquete, id_ruta, id_vehiculo, id_empleado_responsable, id_estado_actual) VALUES
('2025-09-12', 51, 10, 8, 21, 1),
('2025-09-18', 52, 5, 22, 37, 2),
('2025-09-25', 53, 14, 19, 28, 3),
('2025-09-30', 54, 9, 27, 15, 4),
('2025-10-02', 55, 7, 33, 42, 2),
('2025-10-05', 56, 3, 18, 17, 3),
('2025-10-10', 57, 4, 41, 25, 1),
('2025-10-11', 58, 11, 35, 13, 2),
('2025-10-14', 59, 13, 9, 40, 3),
('2025-10-15', 60, 8, 46, 22, 4);


-- Muestra la hora en que se inició el bloque de inserción
SELECT @Hora_PreInsert1 AS HoraPreInsert1;


--------------------- BACKUP LOG 1 ---------------------

-- Guarda hora de inicio del primer backup de log (para referencia futura)
DECLARE @Hora_BackupLog1 DATETIME2 = SYSUTCDATETIME();

-- Realiza el primer backup del log de transacciones (copia solo las transacciones desde el último backup)
BACKUP LOG PaqueExpress
TO DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\PaqueExpress_Log1.trn'
WITH INIT,                    
     NAME = N'PaqueExpress Log Backup 1', 
     CHECKSUM,                 
     STATS = 10;               

-- Muestra la hora de creación del log 1
SELECT @Hora_BackupLog1 AS HoraBackupLog1;


--------------------- BLOQUE DE INSERCIÓN 2 ---------------------

-- Inserción de otra tanda de 10 registros en las tablas
SET NOCOUNT ON;
INSERT INTO paquete (peso, dimensiones, valor_declarado, id_tipo_paquete, id_cliente_origen, id_cliente_destino) VALUES
(5.32, '30x25x15', 8900.25, 1, 3, 29),
(9.45, '40x35x25', 23400.80, 3, 48, 2),
(27.90, '65x55x45', 98400.55, 4, 19, 47),
(45.10, '95x80x70', 174500.00, 5, 36, 41),
(1.25, '20x18x10', 3100.00, 1, 9, 24),
(33.66, '75x60x55', 128900.30, 3, 14, 35),
(12.00, '40x25x25', 56000.10, 4, 6, 20),
(18.23, '50x45x30', 74320.45, 2, 28, 31),
(21.50, '60x55x40', 98760.00, 5, 42, 10),
(6.78, '35x28x25', 18900.65, 2, 45, 50);

INSERT INTO envio (fecha_registro, id_paquete, id_ruta, id_vehiculo, id_empleado_responsable, id_estado_actual) VALUES
('2025-10-17', 61, 19, 7, 8, 3),
('2025-10-19', 62, 16, 24, 30, 1),
('2025-10-21', 63, 6, 14, 11, 2),
('2025-10-23', 64, 20, 39, 34, 4),
('2025-10-25', 65, 12, 31, 26, 3),
('2025-10-26', 66, 15, 47, 29, 1),
('2025-10-27', 67, 18, 4, 45, 4),
('2025-10-28', 68, 2, 25, 33, 2),
('2025-10-30', 69, 17, 12, 16, 3),
('2025-11-01', 70, 1, 10, 19, 4);


--------------------- BACKUP LOG 2 ---------------------

-- Guarda hora de inicio del segundo backup de log
DECLARE @Hora_BackupLog2 DATETIME2 = SYSUTCDATETIME();

-- Realiza el segundo backup del log de transacciones
BACKUP LOG PaqueExpress
TO DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\PaqueExpress_Log2.trn'  -- ruta destino del log
WITH INIT,
     NAME = N'PaqueExpress Log Backup 2',
     CHECKSUM,
     STATS = 10;

-- Muestra la hora de creación del log 2
SELECT @Hora_BackupLog2 AS HoraBackupLog2;


--------------------- VERIFICACIÓN ACTUAL ---------------------

-- Cantidad actual de registros antes de realizar la restauración
SELECT COUNT(*) AS Cantidad_Paquetes_Actual FROM paquete;
SELECT COUNT(*) AS Cantidad_Envios_Actual FROM envio;
