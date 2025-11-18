# Universidad Nacional del Nordeste
## Facultad de Ciencias Exactas Naturales y Agrimensura
### Cátedra: Bases de Datos I
#### Informe: Procedimientos y Funciones Almacenadas — *Proyecto PaqueExpress*
**Autor:** Saul Agustín Arníca  
**Fecha:** Noviembre 2025
---

## 1. Introducción / Objetivos

- Este informe tiene como proposito el explicar qué son y cuándo usar procedimientos almacenados (stored procedures) y funciones almacenadas (user-defined functions), muestra ejemplos implementados sobre la estructura del proyecto PaqueExpress y cumple con las tareas pedidas:
- Objetivos de Aprendizaje:
  - Comprender la diferencia entre procedimientos y funciones almacenadas.
  - Aplicar procedimientos y funciones en la implementación de operaciones CRUD.
- Criterios de Evaluación:
  - Correcta implementación y funcionamiento de los procedimientos y funciones.
  - Documentación clara y precisa de cada paso y concepto.
  - Efectividad en la manipulación de datos usando las funciones y procedimientos.
  
- Implementar al menos 3 procedimientos (insert/update/delete).

- Insertar un lote de datos por INSERT directo y otro lote usando los procedimientos.

- Ejecutar UPDATE y DELETE mediante procedimientos.

- Implementar 3 funciones de ejemplo (cálculo de antigüedad/edad, cálculo del peso volumetrico del paquete, clasificación de riesgo).

- Comparar eficiencia y buenas prácticas.

## 2. Conceptos clave

- *Procedimiento almacenado (Stored Procedure):* Es un bloque de T-SQL(Transact-SQL) compilado que puede ejecutar operaciones (SELECT/INSERT/UPDATE/DELETE), recibir parámetros (IN/OUT), y realizar lógica de negocio compleja. Mejora el rendimiento (plan cached), reduce el tráfico de red y centraliza la lógica. 

- *Función (User-Defined Function, UDF):* devuelve un valor (escalares) o una tabla (table-valued). Ideal para cálculos reutilizables (p. ej. edad, conversiones). Las UDFs no deben tener efectos secundarios (no deben modificar datos) en SQL Server.

- *Diferencias claves:* los procedimientos pueden modificar datos y usar transacciones; las funciones se usan para cálculos y su uso dentro de SELECT/WHERE es más natural. También hay restricciones de determinismo y funciones no deterministas (ej. GETDATE()) que afectan optimizaciones.

## 3. Buenas prácticas 

  - Usar SET NOCOUNT ON al inicio del SP (reduce mensajes de filas afectadas). 

  - Especificar el esquema (ej. dbo.) para invocaciones/creación. 

  - Validar parámetros de entrada (no confiar solo en constraints). 

  - Preferir operaciones set-based (no cursores) cuando sea posible. 

  - Para evitar UDFs(User-Defined Functions) con lógica pesada por fila, se considera usar funciones en línea table-valued si se necesita rendimiento. 

## 4. Procedimientos almacenados (implementación para PaqueExpress)

A continuación 3 procedimientos básicos (insert / update / delete) — elegí la entidad cliente para cubrir CRUD, y otros dos para paquete y envio. Los procedimientos incluyen manejo básico de errores y SET NOCOUNT ON.

### 4.1. sp_InsertCliente — insertar cliente (devuelve id creado)
```sql
CREATE OR ALTER PROCEDURE dbo.sp_InsertCliente
    @Nombre VARCHAR(100),
    @Apellido VARCHAR(100),
    @DNI VARCHAR(20),
    @Email VARCHAR(100) = NULL,
    @IdDireccion INT,
    @NewId INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO cliente (nombre, apellido, dni, email, id_direccion)
        VALUES (@Nombre, @Apellido, @DNI, @Email, @IdDireccion);

        SET @NewId = SCOPE_IDENTITY();
    END TRY
    BEGIN CATCH
        SET @NewId = -1;
        THROW;
    END CATCH
END
GO
```
### 4.2. sp_UpdateCliente — modificar datos de cliente
```sql
CREATE OR ALTER PROCEDURE dbo.sp_UpdateCliente
    @IdCliente INT,
    @Nombre VARCHAR(100) = NULL,
    @Apellido VARCHAR(100) = NULL,
    @DNI VARCHAR(20) = NULL,
    @Email VARCHAR(100) = NULL,
    @IdDireccion INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        UPDATE cliente
        SET nombre = COALESCE(@Nombre, nombre),
            apellido = COALESCE(@Apellido, apellido),
            dni = COALESCE(@DNI, dni),
            email = COALESCE(@Email, email),
            id_direccion = COALESCE(@IdDireccion, id_direccion)
        WHERE id_cliente = @IdCliente;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO
```
### 4.3 SP para eliminar logicamente y eliminar fisicamente(no recomendable)
-***Nota: agrego esto que es para modificar la tabla cliente y añadirle una columna que sea si esta activo o no, ya que nuestro modelo no tiene eso(porque se nos paso)***
### 4.3.0 Script para agregar columna 'activo' a Cliente.
```sql
ALTER TABLE cliente
ADD activo BIT NOT NULL DEFAULT 1;
GO
```
### 4.3.1 sp_EliminarClienteLogico

```sql
CREATE OR ALTER PROCEDURE dbo.sp_EliminarClienteLogico
    @IdCliente INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE cliente
    SET activo = 0
    WHERE id_cliente = @IdCliente;
END
GO
```
### 4.3.2 sp_EliminarClienteFisico

```sql
CREATE OR ALTER PROCEDURE dbo.sp_EliminarClienteFisico
    @IdCliente INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM cliente
    WHERE id_cliente = @IdCliente;
END
GO
```
### 4.3. SP para paquete (insert)

```sql
CREATE OR ALTER PROCEDURE dbo.sp_InsertPaquete
    @Peso DECIMAL(10,2),
    @Dimensiones VARCHAR(50) = NULL,
    @ValorDeclarado DECIMAL(10,2) = 0,
    @IdTipoPaquete INT,
    @IdClienteOrigen INT,
    @IdClienteDestino INT,
    @NewId INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO paquete
            (peso, dimensiones, valor_declarado, id_tipo_paquete, id_cliente_origen, id_cliente_destino)
        VALUES
            (@Peso, @Dimensiones, @ValorDeclarado, @IdTipoPaquete, @IdClienteOrigen, @IdClienteDestino);

        SET @NewId = SCOPE_IDENTITY();
    END TRY
    BEGIN CATCH
        SET @NewId = -1;
        THROW;
    END CATCH
END
GO
```
### 4.4. SP para envio (insert con transacción simple)
```sql
CREATE OR ALTER PROCEDURE dbo.sp_InsertEnvio
    @IdPaquete INT,
    @IdRuta INT,
    @IdVehiculo INT,
    @IdEmpleadoResponsable INT,
    @IdEstadoActual INT,
    @FechaRegistro DATE = NULL,
    @NewId INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        IF @FechaRegistro IS NULL SET @FechaRegistro = GETDATE();

        BEGIN TRANSACTION;

        INSERT INTO envio (fecha_registro, id_paquete, id_ruta, id_vehiculo, id_empleado_responsable, id_estado_actual)
        VALUES (@FechaRegistro, @IdPaquete, @IdRuta, @IdVehiculo, @IdEmpleadoResponsable, @IdEstadoActual);

        SET @NewId = SCOPE_IDENTITY();

        INSERT INTO historial_envio (id_envio, fecha_hora, id_estado, observaciones)
        VALUES (@NewId, GETDATE(), @IdEstadoActual, 'Registro inicial');

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        SET @NewId = -1;
        THROW;
    END CATCH
END
GO
```
## 5. Funciones almacenadas

- Propongo 3 funciones útiles para el proyecto. Son UDFs escalares y una en línea (table-valued) para rendimiento cuando convenga.

### 5.1. fn_TiempoContratacion — años desde fecha_contratacion (antigüedad en la empresa)
```sql
CREATE OR ALTER FUNCTION dbo.fn_TiempoContratacion(@IdEmpleado INT)
RETURNS INT
AS
BEGIN
    DECLARE @Fecha DATE;
    SELECT @Fecha = fecha_contratacion FROM empleado WHERE id_empleado=@IdEmpleado;

    IF @Fecha IS NULL RETURN NULL;

    RETURN DATEDIFF(YEAR,@Fecha,GETDATE()) -
           CASE WHEN DATEADD(YEAR,DATEDIFF(YEAR,@Fecha,GETDATE()),@Fecha) > GETDATE()
                THEN 1 ELSE 0 END;
END
GO
```

Las referencias y el método de cálculo recomendado es (DATEDIFF+DATEADD) para edad/antigüedad. 

### 5.2. fn_PesoVolumetrico

  Parámetros:  
      @AltoCM-> Alto del paquete en centímetros  
      @AnchoCM-> Ancho del paquete en centímetros  
      @LargoCM-> Largo del paquete en centímetros  
  Retorna:
      DECIMAL(10,2) -> Peso volumétrico en kilogramos
     
  Fórmula:
      PesoVolumétrico = (Alto * Ancho * Largo) / 5000

```sql
CREATE OR ALTER FUNCTION dbo.fn_PesoVolumetrico
(
    @AltoCM DECIMAL(10,2),
    @AnchoCM DECIMAL(10,2),
    @LargoCM DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    IF @AltoCM IS NULL OR @AnchoCM IS NULL OR @LargoCM IS NULL
        RETURN NULL;

    RETURN ROUND((@AltoCM * @AnchoCM * @LargoCM) / 5000,2);
END
GO
```

Calcula el peso volumétrico (en kg) de un paquete segun la formula estandar utilizada por servicios de correo y logística en Argentina, donde el divisor habitual es de 5000 para cm³.

### 5.3. fn_PaqueteEsAltoRiesgo — determina riesgo por valor_declarado

```sql
CREATE OR ALTER FUNCTION dbo.fn_PaqueteEsAltoRiesgo(@ValorDeclarado DECIMAL(10,2))
RETURNS VARCHAR(2)
AS
BEGIN
    IF @ValorDeclarado IS NULL RETURN 0;
    RETURN CASE WHEN @ValorDeclarado >= 100000 THEN 'Si' ELSE 'NO' END;
END
GO
```

- ***Nota: en caso de necesitar funciones que devuelvan conjuntos (ej. listado de envíos con último estado) conviene usar inline table-valued functions por rendimiento frente a UDF escalares con loops.***

## 6. Scripts de carga (lote) — ejemplos
### 6.1. Lote de INSERTs directos (pequeño ejemplo)
-- Provincias / ciudades / direcciones

```sql

INSERT INTO dbo.provincia (nombre) VALUES ('Buenos Aires'), ('Cordoba');
INSERT INTO dbo.ciudad (nombre, id_provincia) VALUES ('Cordoba', 2), ('La Plata', 1);

INSERT INTO dbo.direccion (calle, numero, piso_depto, codigo_postal, id_ciudad)
VALUES ('Av. Siempre Viva', '123', NULL, '5000', 2),
       ('Calle Falsa', '742', '1A', '1900', 1);
```

-- Roles y sucursales

```sql
INSERT INTO dbo.rol (nombre_rol) VALUES ('Repartidor'), ('Admin');
INSERT INTO dbo.sucursal (nombre, id_direccion) VALUES ('Sucursal Centro', 1), ('Sucursal Norte', 2);

-- Clientes
INSERT INTO dbo.cliente (nombre, apellido, dni, email, id_direccion)
VALUES ('Juan', 'Perez', '12345678', 'juan.perez@example.com', 1),
       ('Ana', 'Gomez', '87654321', NULL, 2);

-- Tipos y estados
INSERT INTO dbo.tipo_paquete (descripcion) VALUES ('Sobre'), ('Caja');
INSERT INTO dbo.estado_envio (nombre_estado) VALUES ('Registrado'), ('En tránsito'), ('Entregado');
```

### 6.2. Lote usando procedimientos (ejemplo de uso)
- Ejemplo de insercion utilizando los procedimientos almacenados desarrollados
```sql

DECLARE @NewId INT;
```

-- Insert cliente via sp
```sql

EXEC dbo.sp_InsertCliente @Nombre='Luis', @Apellido='Martinez', @DNI='33445566', @Email='luis.m@example.com', @IdDireccion=1, @NewId=@NewId OUTPUT;
SELECT 'Cliente creado' AS Info, @NewId AS IdNuevo;
```

-- Insert paquete via sp

```sql
EXEC dbo.sp_InsertPaquete @Peso=2.5, @Dimensiones='30x20x10', @ValorDeclarado=15000, @IdTipoPaquete=2, @IdClienteOrigen=1, @IdClienteDestino=2, @NewId=@NewId OUTPUT;
SELECT 'Paquete creado' AS Info, @NewId AS IdNuevo;
```

### 6.3. Update/delete invocando a los SPs
-- Actualizar email de cliente

```sql
EXEC dbo.sp_UpdateCliente
  @IdCliente=1,
  @Email='nuevo.email@example.com';
```

-- Borrar cliente logicamente
```sql
EXEC dbo.sp_EliminarClienteLogico @IdCliente=10;
```

-- Borrar cliente fisicamente
```sql
EXEC dbo.sp_EliminarClienteFisico @IdCliente=10;
```

### 6.4 Calcular el peso facturable del paquete
```sql
SELECT 
    peso_real_kg,                                             -- Peso real del paquete registrado en la BD
    dbo.fn_PesoVolumetrico(alto_cm, ancho_cm, largo_cm) 
        AS peso_vol,                                          -- Peso volumétrico calculado
    CASE 
        WHEN peso_real_kg > dbo.fn_PesoVolumetrico(alto_cm, ancho_cm, largo_cm)
             THEN peso_real_kg                                -- Si el peso real es mayor, se factura ese
             ELSE dbo.fn_PesoVolumetrico(alto_cm, ancho_cm, largo_cm)
    END AS peso_facturable                                    -- Peso final que se utiliza para cobrar
FROM paquete;
```

## 7. Comparación: Procedimientos almacenados (SP) vs Funciones almacenadas (UDF)

En este trabajo no se busca medir tiempos de ejecución ni comparar rendimiento en milisegundos.  
El objetivo es analizar **diferencias conceptuales**, **seguridad**, y **cuándo corresponde usar cada uno** dentro del proyecto PaqueExpress.

---

### 7.1 Diferencias principales orientadas a seguridad y control

| Característica                                   | Procedimientos almacenados (SP) | Funciones almacenadas (UDF)       |
|--------------------------------------------------|----------------------------------|------------------------------------|
| ¿Modifican datos (INSERT/UPDATE/DELETE)?         | Sí                               | No (prohibido)                     |
| ¿Devuelven valores?                              | Opcional                         | Sí (valor o tabla)                 |
| ¿Permiten transacciones?                         | Sí                               | No                                 |
| ¿Manejo TRY/CATCH?                               | Sí                               | No                                 |
| ¿Control de permisos granular?                   | Muy alto                         | Limitado                           |
| ¿Lógica compleja?                                | Ideal                            | Solo lógica sin efectos            |
| ¿Se ejecutan con EXEC?                           | Sí                               | No (se usan en SELECT)             |

**Conclusión de seguridad:**  
Los SP permiten aislar y proteger el acceso a las tablas.  
Un usuario puede tener permiso para ejecutar un SP sin tener acceso directo a las tablas internas.  
Las funciones no ofrecen este “blindaje”, porque solo calculan valores y se ejecutan dentro de consultas.

---

### 7.2 ¿Cuándo conviene usar procedimientos almacenados?

Los SP deben usarse cuando:

- **Se modifican datos (CRUD):** insertar, actualizar, eliminar registros.  
- **Se necesita seguridad:** evitar accesos directos a las tablas.  
- **Es necesaria una transacción:** operaciones que afectan múltiples tablas.  
- **Existe lógica de negocio compleja:** validaciones, reglas, auditorías.  
- **Se desea centralizar reglas en el servidor:** evitar duplicación en la aplicación.

**Ejemplos prácticos en PaqueExpress:**
- Insertar cliente, paquete o envío.  
- Registrar el historial de movimientos de un envío.  
- Actualizar direcciones o datos del cliente.  
- Eliminar lógicamente registros.

---

### 7.3 ¿Cuándo conviene usar funciones almacenadas?

Las funciones se usan para **cálculos puros**, retornos de valores y lógica reutilizable sin modificar datos.

Usos ideales:

- ✔ **Cálculos matemáticos o lógicos:**  
  - `fn_PesoVolumetrico`  
  - `fn_TiempoContratacion`  
  - `fn_PaqueteEsAltoRiesgo`

- ✔ **Funciones que se usan dentro de SELECT o informes.**

- ✔ **Reglas repetidas que deben ser consistentes en todo el sistema.**

- ✔ **Funciones que devuelven tablas (TVF) para consultas reutilizables.**

Ejemplo típico en PaqueExpress:
```sql
SELECT 
    p.id_paquete,
    dbo.fn_PesoVolumetrico(alto_cm, ancho_cm, largo_cm) AS peso_volumetrico
FROM paquete p;

## 7. Comparación: operaciones directas vs uso de procedimientos/funciones

### 7.1. Ventajas de usar procedimientos y funciones

- Rendimiento: los SPs tienen planes en caché y reducen tráfico cliente-servidor al ejecutar múltiples statements en una sola llamada. Esto mejora latencia para operaciones repetidas. 

- Seguridad: con SPs puedes otorgar permisos de ejecución y limitar acceso directo a tablas; facilita validación centralizada. 

- Mantenimiento: la lógica centralizada evita duplicación en la aplicación. 

### 7.2. Consideraciones y limitaciones

- Complejidad del despliegue: cambios en SPs requieren despliegue en BD.

- Rendimiento en UDFs: funciones escalares (particularmente las definidas por usuario que no son inline table-valued) pueden ser evaluadas por fila y penalizar rendimiento; para operaciones masivas conviene funciones en línea o SPs set-based. 

### 7.3. Recomendación práctica para PaqueExpress

- Operaciones CRUD habituales: implementarlas con SPs set-based (por ejemplo, insertar lote de paquetes mediante un SP que acepte tabla tipo parameter).

- Cálculos reutilizables sin efectos secundarios: funciones (por ejemplo fn_ConvertKgToLb, fn_TiempoContratacion).

- Para reportes y consultas complejas: views o TVFs (table-valued functions) en vez de UDF escalares pesadas.
## 8. Conclusiones

- El uso de procedimientos y funciones almacenadas en SQL Server permite encapsular la lógica de negocio y optimizar la manipulación de datos en sistemas complejos como PaqueExpress.
  A través de estos objetos, se logra una mejor separación de responsabilidades entre la aplicación y la base de datos, un mayor rendimiento en operaciones repetitivas, y una gestión más segura y consistente de la información.
  La experiencia adquirida durante la implementación permitió comprender las ventajas prácticas del enfoque set-based, así como la importancia de aplicar buenas prácticas de diseño en cada nivel del sistema.

## 9. Bibliografía y lecturas recomendadas

Microsoft Docs — Stored procedures (Database Engine). 

Microsoft Docs — CREATE PROCEDURE (Transact-SQL). 

Oracle Docs — Advantages of Stored Procedures (teórica universal). 
docs.oracle.com

WiseOwl (tutorial) — Calculating age in SQL Server (DATEDIFF + DATEADD recommended approach). 
wiseowl.co.uk

SQLServerCentral / StackOverflow — buenas prácticas y debates sobre SPs/UDFs y rendimiento. 

