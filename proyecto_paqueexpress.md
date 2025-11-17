# Proyecto de Estudio

# PRESENTACIÓN - PaqueExpress

**Asignatura**: Bases de Datos I (FaCENA-UNNE)

**Integrantes**:

- Arnica, Saul Agustin (L.U.: 60.457 – DNI: 43.205.368)
- Miño Gomez, Juan Daniel (L.U.: 58.033 – DNI: 38.963.397)
- Morales Lopez, Luana Belen (L.U.: 57.983 – DNI: 46.460.672)
- Navarro Acevedo, Sergio (L.U.: 55.679 – DNI: 43.063.333)

**Año**: 2025

## CAPÍTULO I: INTRODUCCIÓN

### Caso de estudio

El presente trabajo práctico se centra en el diseño e implementación de un sistema de gestión de envíos de paquetería. Este sistema tiene como propósito controlar, registrar y mantener información relativa a paquetes, clientes, rutas, vehículos, conductores y sucursales, facilitando la trazabilidad de cada envío desde su registro hasta su entrega.

El tema se enfoca en la optimización de los procesos de envío y seguimiento dentro de una empresa de transporte de paquetes, garantizando la integridad y consistencia de los datos.

### Definición o planteamiento del problema

En las empresas de transporte de paqueteria, uno de los principales problemas es la falta de un sistema centralizado que permita gestionar de manera eficiente los envios. La informacion sobre paquetes, rutas, vehiculos y conductores a menudo se encuentra dispersa o registrada manualmente, lo que genera errores, retrasos y dificultades para hacer seguimiento de los envios. Este trabajo práctico plantea como problema: ¿Cómo diseñar una base de datos que permita controlar y registrar de manera eficiente toda la información relacionada con los envios de paqueteria, garantizando trazabilidad, integridad de datos y soporte para la toma de decisiones?

### Objetivo del Trabajo Práctico
El objetivo del trabajo práctico es desarrollar una base de datos que permita gestionar de manera eficiente los envíos de paquetes, controlando clientes, paquetes, rutas, vehículos, empleados y sucursales, y facilitando la consulta y generación de reportes sobre los procesos de envío.

### Objetivo Generales

Diseñar e implementar un sistema de base de datos que centralice la información de los envíos de paquetería, garantizando la integridad de los datos y la trazabilidad de cada paquete.

### Objetivos Específicos

- Registrar y mantener información detallada sobre clientes, paquetes, rutas, vehículos, conductores y sucursales.
- Controlar los estados de los paquetes (Pendiente, En tránsito, Entregado, Retrasado) y facilitar el seguimiento de los envíos.
- Permitir consultas y generación de reportes que ayuden a la planificación y gestión de los envíos.

## CAPITULO II: MARCO CONCEPTUAL O REFERENCIAL

- El desarrollo de un sistema de gestión como PaqueExpress requiere considerar diversos aspectos técnicos y conceptuales que garantizan su eficiencia, confiabilidad y capacidad de adaptación a las necesidades operativas de una empresa dedicada al transporte y distribución de paquetes. Este tipo de sistema busca optimizar la administración de los procesos logísticos, desde la recepción de los envíos hasta la entrega final al cliente, manteniendo siempre la integridad y trazabilidad de la información.

- La incorporación de herramientas tecnológicas avanzadas, como los procedimientos almacenados y las funciones definidas por el usuario, la optimización de consultas mediante índices, el manejo de transacciones y transacciones anidadas, así como los mecanismos de backup y restore -*incluyendo la posibilidad de generar copias de seguridad en línea desde el propio motor de base de datos SQL Server*-, permite centralizar la lógica de negocio directamente en el servidor.

- Esto mejora el rendimiento general del sistema, reduce la carga de procesamiento en las aplicaciones cliente y garantiza una mayor seguridad y consistencia en el manejo de la información. Gracias a estos componentes, PaqueExpress logra ejecutar de manera controlada las operaciones de inserción, modificación y eliminación de registros, manteniendo la integridad referencial entre las diferentes entidades del sistema.

- Asimismo, el diseño modular de la base de datos de PaqueExpress posibilita la ampliación futura del sistema sin comprometer su estabilidad. Este enfoque permite incorporar nuevas funcionalidades —como la gestión de tarifas, seguimientos en tiempo real o análisis estadístico de rendimiento— sin alterar la estructura principal del proyecto. De esta forma, el sistema se adapta a la evolución tecnológica y a las necesidades específicas de distintos tipos de empresas del rubro logístico.

En un entorno cada vez más competitivo, la digitalización y la automatización de los procesos internos se vuelven factores clave para mantener la eficiencia y la rentabilidad. Un sistema como PaqueExpress, respaldado por un diseño sólido de base de datos y por el uso de procedimientos y funciones almacenadas, representa una herramienta estratégica para mejorar la trazabilidad de los envíos, optimizar los tiempos de respuesta y garantizar un flujo de información seguro y confiable entre las distintas áreas de la organización.

## TEMA 1: Procedimientos almacenados y las funciones definidas por el Usuario

## CAPÍTULO III: METODOLOGÍA SEGUIDA

## CAPÍTULO IV: DESARROLLO DEL TEMA / PRESENTACIÓN DE RESULTADOS

## Tema 3: Optimización de Consultas a traves de Índices

## 1. Eleccion de tabla e Insercion de datos

La tabla que vamos a utilizar en esta ocasion es la tabla envio debido a que dentro del sistema de paquetería, es una de las más consultadas y con mayor crecimiento de registros. Sobre ella se realizan búsquedas frecuentes por fecha, estado, ruta y empleado.

```sql
CREATE TABLE envio (
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
);
```

Realizamos una insercion masiva de 1.000.000 de registros en la tabla envio mediante un bucle WHILE.
Las fechas se generaron dentro del rango 2015–2025 y las claves foráneas se asignaron con valores aleatorios dentro del rango válido de registros ya existentes en las tablas relacionadas (paquete, ruta, vehículo, empleado y estado).

```sql
SET NOCOUNT ON;
DECLARE @i INT = 1;
DECLARE @max INT = 1000000;
DECLARE @fecha DATE;
DECLARE @id_paquete INT;
DECLARE @id_ruta INT;
DECLARE @id_vehiculo INT;
DECLARE @id_empleado INT;
DECLARE @id_estado INT;

WHILE @i <= @max
BEGIN
    SET @fecha = DATEADD(DAY, ABS(CHECKSUM(@i * RAND() * 3)) % 3650, '2015-01-01');
    SET @id_paquete  = ((ABS(CHECKSUM(@i*7  + RAND()*100)) % 50) + 1);
    SET @id_ruta     = ((ABS(CHECKSUM(@i*11 + RAND()*200)) % 20) + 1);
    SET @id_vehiculo = ((ABS(CHECKSUM(@i*13 + RAND()*150)) % 10) + 1);
    SET @id_empleado = ((ABS(CHECKSUM(@i*17 + RAND()*90)) % 20) + 1);
    SET @id_estado   = ((ABS(CHECKSUM(@i*19 + RAND()*50)) % 6)  + 1);

    INSERT INTO envio (fecha_registro, id_paquete, id_ruta, id_vehiculo,
                       id_empleado_responsable, id_estado_actual)
    VALUES (@fecha, @id_paquete, @id_ruta, @id_vehiculo, @id_empleado, @id_estado);

    SET @i += 1;
END;
SET NOCOUNT OFF;
```

## 2. Creación de tabla sin índices

Se crea la tabla envio_2 como una copia directa de la tabla envio, sin índices, para disponer de una versión de la tabla que permita medir el rendimiento sin optimizaciones (Table Scan). Evaluamos su plan de ejecucion y tiempo estimado.

```sql
SELECT * INTO envio_2 FROM envio;
```

** Realizo una consulta por periodo en la tabla sin indice (envio_2) y registro sus tiempos de ejecucion**

```sql
--Consulta por periodo tabla sin indice
SELECT *
FROM envio_2
WHERE fecha_registro BETWEEN '2018-01-01' AND '2025-01-01';

--Resultados de la consulta:
--Columnas devueltas: 699.666 // Tiempos (3 intentos):  CPU time = 1079 ms,  elapsed time = 4891 ms. // CPU time = 1063 ms,  elapsed time = 4561 ms. // CPU time = 563 ms,  elapsed time = 4890 ms.
--Lecturas logicas obtenidas: Table 'envio_2'. Scan count 1, logical reads 4465
```

### Plan ejecucion estimado tabla envio_2 sin indices

![Plan envio_2 sin indices](Optimizacion%20con%20indices/Assets-Indices/IndicesPlanEjecucion-1.png)

**Explicacion del resultado del plan de ejecucion estimado**
En este caso, el motor de SQL Server utiliza Table Scan debido a que la tabla envio_2 no posee ningún índice. Esto significa que la consulta requiere recorrer todas las filas de la tabla, hasta encontrar los registros que con fechas entre 2018 y 2015. Esta operación es muy poco eficiente para la cantidad de regitros que posee dicha tabla por lo que es conveniente crear un indice agrupado.

**Realizo consulta una consulta por periodo en la tabla con indice (Envio)**

```sql
--Consulta por periodo tabla con indice
SELECT *
FROM envio
WHERE fecha_registro BETWEEN '2018-01-01' AND '2025-01-01';
--Resultados de la consulta:
--Columnas devueltas: 699.666 // Tiempos (3 intentos): CPU time = 953 ms,  elapsed time = 4633 ms. //  CPU time = 906 ms,  elapsed time = 4548 ms. //   CPU time = 875 ms,  elapsed time = 4667 ms.
--Lecturas logicas obtenidas: Table 'envio'. Scan count 1, logical reads 4483
```

### Plan ejecucion estimado tabla envio con indice
![Plan envio con indices](Optimizacion%20con%20indices/Assets-Indices/IndicesPlanEjecucion-2.png)

**Explicacion del resultado del plan de ejecucion estimado**
En este caso, el plan de ejecución estimado que eligió el motor fue "Clustered Index Scan" porque, si bien la tabla envio tiene un índice agrupado, dicho índice está creado sobre id_envio (PRIMARY KEY) y no sobre fecha_registro, que es la columna utilizada en el filtro.
Debido a esto, el índice no alcanza para localizar rápidamente un subconjunto de filas dentro del rango de fechas solicitado, por lo que SQL Server debe recorrer todo el índice agrupado, evaluando fila por fila.

Al tratarse de un índice agrupado, este contiene toda la información completa de cada registro, lo cual hace que el escaneo sea algo más eficiente que un Table Scan.
Sin embargo, sigue siendo una operación costosa para una tabla con tantos registros, ya que el motor debe leer gran parte de las páginas del índice para encontrar todas las filas entre 2018-01-01 y 2025-01-01. Esto evidencia la necesidad de crear un índice sobre fecha_registro.

### AMBAS CONSULTAS Y SUS COSTOS DE EJECUCION

![Costos_ambas consultas1](Optimizacion%20con%20indices/Assets-Indices/IndicesComparacionCostos-1.png)

## 3. Creacion de indice agrupado para la tabla envio_2, evaluacion del plan de ejecucion y tiempo estimado

**Creamos un indice agrupado sobre la columna fecha de la tabla envio_2**

```sql
--Tardo 00:00:05 en crear el indice
--Aplicamos indice acumulado en la columna fecha_registro
CREATE CLUSTERED INDEX IX_fecha_registro
ON envio_2 (fecha_registro);
```

**Realizamos una consulta sobre la tabla envio_2, registramos sus tiempos de ejecucion y evaluamos su plan de ejecucion**

```sql
SELECT *
FROM envio_2
WHERE fecha_registro BETWEEN '2018-01-01' AND '2025-01-01';
--Resultados de la consulta:
--Columnas devueltas: 699.666 // Tiempos (3 intentos): CPU time = 844 ms,  elapsed time = 5289 ms. /   CPU time = 843 ms,  elapsed time = 4530 ms. /  CPU time = 719 ms,  elapsed time = 4537 ms.
--Lecturas logicas obtenidas: Table 'envio_2'. Scan count 1, logical reads 3815
```

### Plan ejecucion estimado tabla envio_2 con indice agrupado

![Plan envio_2 indiceAgrupado](Optimizacion%20con%20indices/Assets-Indices/IndicesPlanEjecucion-3.png)

**Explicacion del resultado del plan de ejecucion estimado**
En este caso, el motor utiliza Clustered Index Seek. Esto ocurre porque ahora la tabla envio_2 tiene un índice agrupado creado directamente sobre fecha_registro, que es justamente la columna utilizada en el filtro de la consulta, con esto, SQL Server puede moverse directamente hasta la primera fecha que cumple la condición (2018-01-01) y luego recorrer únicamente las paginas necesarias hasta llegar al final del rango (2025-01-01), sin tener que leer el resto de la tabla.
Esto evita escaneos completos y reduce significativamente los tiempos, el consumo de CPU y la cantidad de lecturas lógicas.

**Reutilizamos la consulta sobre la tabla Envio (sin indice)**

```sql
--Consulta por periodo tabla con indice
SELECT *
FROM envio
WHERE fecha_registro BETWEEN '2018-01-01' AND '2025-01-01';
```

### AMBAS CONSULTAS Y SUS COSTOS DE EJECUCION

![Costos ambas consultas2](Optimizacion%20con%20indices/Assets-Indices/IndicesComparacionCostos-2.png)

### Conclusion sobre el resultado del costo y el plan de ejecucion de ambas consultas

En este caso, el motor utiliza Clustered Index Seek para la tabla envio_2 porque el índice agrupado está creado directamente sobre fecha_registro. Esto le permite buscar únicamente el rango de fechas solicitado, sin recorrer toda la tabla.

En cambio, en la tabla envio el índice agrupado está sobre la clave primaria (id_envio), por lo que el motor debe usar Clustered Index Scan, ya que esa estructura no le sirve para localizar el rango de fechas de forma directa.

Por esto, el costo es menor en envio_2, el índice coincide con el filtro y permite un acceso mas preciso, mientras que la otra tabla necesita revisar mas registros para obtener el mismo resultado.

## 4. Eliminacion del indice agrupado de la tabla envio_2

```sql
DROP INDEX IX_fecha_registro
ON envio_2;
```

## 5. Creacion de indice agrupado sobre la columna fecha con columnas definidas

**Creamos un indice agrupado sobre la tabla envio_2 con columnas definidas**

```sql
-- OPCION 1: Indice agrupado con las columnas definidas.
CREATE CLUSTERED INDEX IX_envio_fecha_estado_ruta
ON envio_2 ( fecha_registro, id_estado_actual, id_ruta);
```

**Realizamos consultas con distintos niveles de complejidad sobre la tabla envio_2 con indice agrupado**

```sql
--Consulta 1
SELECT fecha_registro, id_estado_actual, id_ruta
FROM envio_2
WHERE fecha_registro BETWEEN '2023-01-01' AND '2025-01-01';
--Resultados de la consulta:
--Columnas devueltas: 200.040 // Tiempos (3 intentos): CPU time = 171 ms,  elapsed time = 1418 ms. /  CPU time = 188 ms,  elapsed time = 1371 ms. /  CPU time = 203 ms,  elapsed time = 1153 ms.
--Lecturas logicas obtenidas: Table 'envio_2'. Scan count 1, logical reads 1019

--Consulta 2
SELECT fecha_registro, id_ruta, id_estado_actual
FROM envio_2
WHERE fecha_registro BETWEEN '2024-01-01' AND '2024-12-31' AND id_ruta = 7;

--Resultados de la consulta:
--Columnas devueltas: 4.993 // Tiempos (3 intentos):  CPU time = 16 ms,  elapsed time = 105 ms. /   CPU time = 31 ms,  elapsed time = 82 ms. /  CPU time = 15 ms,  elapsed time = 86 ms.
--Lecturas logicas obtenidas:Table 'envio_2'. Scan count 1, logical reads 510

--Consulta 3
SELECT e.fecha_registro, es.nombre_estado, e.id_ruta
FROM envio_2 AS e
INNER JOIN estado_envio AS es ON e.id_estado_actual = es.id_estado
WHERE e.fecha_registro BETWEEN '2023-01-01' AND '2024-12-31' AND e.id_estado_actual IN (5, 6) AND id_ruta = 7 ;
--Resultados de la consulta:
--Consultas devueltas: 3329 // Tiempos (3 intentos): CPU time = 47 ms,  elapsed time = 136 ms. / CPU time = 31 ms,  elapsed time = 132 ms. / CPU time = 62 ms,  elapsed time = 142 ms.
--Lecturas logicas obtenidas: Table 'envio_2'. Scan count 1, logical reads 1019
```

### Plan ejecucion estimado tabla envio_2 con indice agrupado con columnas definidas

![Plan envio_2_indicesAgrupado_columnas](Optimizacion%20con%20indices/Assets-Indices/IndicesPlanEjecucion-4.png)

**Como Opcion 2, creamos un indice no agrupado sobre la tabla envio con columnas incluidas**

```sql
--OPCION 2: Indice no agrupado con INCLUDE para las columnas
CREATE NONCLUSTERED INDEX IX_fecha_registro_estado_ruta
ON envio (fecha_registro)
INCLUDE (id_estado_actual, id_ruta);
```

**Realizamos las mismas consultas sobre la tabla envio con indice no agrupado**

```sql
--Consulta 1:
SELECT fecha_registro, id_estado_actual, id_ruta
FROM envio
WHERE fecha_registro BETWEEN '2023-01-01' AND '2025-01-01';

--Resultados de la consulta:
--Columnas devueltas: 200040 / Tiempos (3 intentos):  CPU time = 47 ms,  elapsed time = 1206 ms. /   CPU time = 203 ms,  elapsed time = 1073 ms. / CPU time = 0 ms,  elapsed time = 1257 ms.
--Lecturas logicas obtenidas: Table 'envio'. Scan count 1, logical reads 525

--Consulta 2
SELECT fecha_registro, id_ruta, id_estado_actual
FROM envio
WHERE fecha_registro BETWEEN '2024-01-01' AND '2024-12-31' AND id_ruta = 7;

--Resultados de la consulta:
--Columnas devueltas: 4.993 // Tiempos (3 intentos): CPU time = 0 ms,  elapsed time = 72 ms./ CPU time = 15 ms,  elapsed time = 79 ms./  CPU time = 0 ms,  elapsed time = 82 ms.
--Lecturas logicas obtenidas: Table 'envio'. Scan count 1, logical reads 264

--Consulta 3
SELECT e.fecha_registro, es.nombre_estado, e.id_ruta
FROM envio AS e
INNER JOIN estado_envio AS es ON e.id_estado_actual = es.id_estado
WHERE e.fecha_registro BETWEEN '2023-01-01' AND '2024-12-31' AND e.id_estado_actual IN (5, 6) AND id_ruta = 7 ;

--Resultados de la consulta:
--Columnas devueltas: 3329 // Tiempos (3 intentos): CPU time = 63 ms,  elapsed time = 118 ms. /   CPU time = 32 ms,  elapsed time = 139 ms. /   CPU time = 47 ms,  elapsed time = 139 ms.
--Lecturas logicas obtenidas: Table 'envio'. Scan count 1, logical reads 525
```

### Plan ejecucion estimado tabla envio con indice no agrupado con columnas definidas



## 6. Conclusiones

Plan sin indices ("TABLE SCAN"): Al ejecutar las consultas sin ningún índice sobre la tabla envio_2, todas las búsquedas requerían un recorrido completo de la tabla. Esto produjo tiempos altos, mayor carga de CPU y gran cantidad de lecturas lógicas, ya que el motor debía analizar toda la tabla para encontrar los registros dentro del rango de fechas solicitado.

Uso del índice en fecha_registro (IX_fecha_registro): Al aplicar un índice agrupado sobre fecha_registro, las consultas basadas únicamente en el rango de fechas mejoraron considerablemente. El motor pudo utilizar Index Seek, leyendo solo las páginas de datos necesarias. Si bien en consultas más complejas la mejora no fue tan marcada, igualmente evitó el escaneo completo y redujo significativamente el costo respecto al Table Scan.

Uso de índice agrupado compuesto e índice no agrupado con INCLUDE: Ambos indices, al incluir todas las columnas claves de las consultas (fecha, estado y ruta), mejoraron los tiempos de ejecución de forma significativa, especialmente en las consultas más complejas. Es decir las que involucran la totalidad de las columnas ya que justamente estos índices estan "preparados" para consultas que involucran estas columnas. Ademas, el indice no agrupado con include al tener una estructura más "liviana" y cubrir todas las columnas, resulto más eficiente en consultas mas específicas, logrando una mayor reduccion de lecturas logicas.

### Diagrama relacional

![diagrama_relacional](https://raw.githubusercontent.com/SergiNavarr/basesdedatos_proyecto_estudio/main/doc/Modelo_Relacional.png)

### Diccionario de datos

Acceso al documento [PDF](doc/DiccionarioDeDatos.pdf) del diccionario de datos.

## CAPÍTULO V: CONCLUSIONES

## BIBLIOGRAFÍA DE CONSULTA
