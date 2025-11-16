## TEMA 3: Optimización de Consultas a través de Índices

La optimización de consultas mediante índices constituye una técnica esencial para mejorar el
rendimiento de los sistemas de gestión de bases de datos, especialmente en entornos donde
se manejan grandes volúmenes de información y se requiere alta disponibilidad.

### ¿Qué son los Índices?

Un índice es una estructura de disco asociada con una tabla que acelera la recuperación de
filas de la misma. Contiene claves generadas a partir de una o varias columnas de la tabla.
Dichas claves están almacenadas en una estructura (árbol b) que permite que SQL Server
busque de forma rápida y eficiente la fila o filas asociadas a los valores de cada clave,
reduciendo el tiempo de respuesta al acceder y manipular datos.

### Tipos de Índices

Los índices se construyen sobre una o varias columnas de una tabla y pueden clasificarse en
agrupados (clustered) y no agrupados (non-clustered).

**Índice Agrupado:** Un índice agrupado organiza los datos de una tabla de manera física, es
decir, los datos se almacenan en el disco en el mismo orden en que están organizados por el
índice. Solo puede haber un índice clúster por cada tabla, porque las filas de datos solo pueden
estar almacenadas físicamente de una forma. Cuando una tabla tiene un índice clúster, la tabla
se denomina tabla agrupada.

**Sintaxis de Creación de un Índice Agrupado:**

```sql
CREATE CLUSTERED INDEX IX_NombreIndice
ON NombreTabla (Columna1 [ASC|DESC], Columna2 [ASC|DESC]);
```

**Índice no Agrupado:** Los índices no agrupados mantienen una estructura separada que
contiene las claves del índice y punteros a las ubicaciones físicas de los datos. Al no alterar el
orden físico de la tabla, una tabla puede contener múltiples índices no agrupados.

**Sintaxis de Creación de un Índice No Agrupado:**

```sql
CREATE NONCLUSTERED INDEX IX_NombreIndice
ON NombreTabla (Columna1 [ASC|DESC])
INCLUDE (Columna2, Columna3);
```

### ¿Qué es una Página de Datos?

Una página de datos es la unidad donde se almacenan físicamente las filas y columnas reales
de una tabla. El almacén de filas (rowstore) hace referencia a una tabla cuyo formato de
almacenamiento de datos subyacente es un montón (heap) o un árbol B + (índice agrupado).

### Arquitectura de los Índices

Desde el punto de vista estructural, la mayoría de los índices de almacén de filas (agrupados y
no agrupados) se organizan como árboles B +.

### Niveles del Árbol B+

- **Nodo Raíz:** El nivel superior del índice.
- **Nodos Intermedios:** Los niveles entre la raíz y las hojas.
- **Nodos Hoja (Páginas Hoja):** El nivel inferior del índice.

  - **Agrupados:** Las páginas hoja contienen las páginas de datos reales de la
    tabla.

  - **No Agrupados:** Las páginas hoja contienen las columnas clave del índice más
    los localizadores de filas (punteros a los datos). Por eso, los índices no
    agrupados son menos eficientes cuando hay que acceder directamente a los
    datos, ya que necesitan una segunda búsqueda para localizar los datos en la
    tabla subyacente.

### Columnas Incluidas

En los índices no agrupados, se pueden especificar columnas sin clave almacenadas en el
nivel hoja, conocidas como “columnas incluidas”, mediante la cláusula INCLUDE en SQL
Server. Esto permite que el índice cubra la consulta (es decir, que contenga todas las
columnas utilizadas en la consulta) sin tener que acceder a la tabla base, reduciendo la E/S de
disco.

### ¿Qué es el Plan de Ejecución Estimado?

El plan de ejecución estimado es una herramienta utilizada para comprender cómo el
optimizador de consultas del motor de la base de datos planea ejecutar una consulta SQL. El
optimizador de consultas tiene la tarea de seleccionar el índice, o una combinación de índices,
más eficaz para ejecutar una consulta, o determinar si es mejor evitar la recuperación
indexada.

### Importancia y Ventajas de los Índices

El uso de índices es beneficioso en consultas que involucran cláusulas WHERE, JOIN, ORDER
BY o GROUP BY, ya que permite al optimizador de consultas seleccionar planes de ejecución
más eficientes.

Sin embargo, la implementación de índice implica un costo de mantenimiento, ya que las
operaciones de escritura (INSERT, UPDATE, DELETE) deben actualizar también las
estructuras de índice asociadas. Esto puede generar fragmentación interna, afectando el
rendimiento de lectura si no se gestiona adecuadamente.
