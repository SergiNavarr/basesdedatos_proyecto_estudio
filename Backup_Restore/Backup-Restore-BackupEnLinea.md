### **Introducción**

Los **backups** son fundamentales para garantizar la **disponibilidad**, **integridad** y **seguridad** de los datos. Dado que las bases de datos constituyen un componente crítico en la mayoría de las aplicaciones empresariales, es imprescindible contar con estrategias efectivas que las protejan frente a **pérdida de información**, **corrupciones**, **fallos de hardware** o **errores humanos**.  

En este contexto, los mecanismos de **backup en línea** y los procedimientos de **restore** (restauración) resultan esenciales para asegurar que una base de datos pueda recuperarse sin interrumpir el servicio.  

En **SQL Server**, las tareas de **backup y restore** son pilares clave para preservar la **disponibilidad** y **recuperación** de los datos. Existen distintos tipos de respaldo —**full**, **differential**, **transaction log** y **file/filegroup**—, junto con diversos **modelos de recuperación**, que determinan qué tipo de respaldo realizar y cómo llevar a cabo la restauración de la base de datos.

---

### **1. Backup**

Un **backup** es una copia de seguridad de los datos tomada en un punto específico del tiempo. Su propósito es permitir la restauración de la base de datos ante fallos o pérdidas de información.

#### **Tipos de Backup**

- **Backup Completo (Full Backup)**  
  Realiza una copia de todos los datos y objetos de la base de datos, sin importar si han cambiado o no desde el último respaldo.  
  En SQL Server, el *full backup* sirve como base para los respaldos diferenciales y de log posteriores, y representa el estado completo de la base en un momento determinado.

- **Backup Diferencial (Differential Backup)**  
  Incluye únicamente los datos que han cambiado desde el último *full backup*. Es más rápido que un respaldo completo, aunque depende del último *full backup* para su restauración.

- **Backup de Log (Transaction Log Backup)**  
  Crea una copia del archivo de log de transacciones, que registra todas las operaciones ejecutadas en la base de datos. Este tipo de respaldo permite la **recuperación punto en el tiempo**, restaurando el estado exacto antes de un error o evento no deseado.

- **Backup en Línea (Online Backup)**  
  Se ejecuta mientras la base de datos sigue en funcionamiento, permitiendo que las operaciones continúen sin interrupción.

- **Backup de Archivos o Grupos de Archivos (File / Filegroup Backup)**  
  Permite realizar respaldos parciales de archivos o grupos de archivos específicos dentro de la base de datos. Esta modalidad posibilita **restauraciones parciales o en línea** sin necesidad de dejar toda la base de datos fuera de servicio.

---

#### **Modelos de Recuperación**

El modelo de recuperación determina cómo SQL Server gestiona el log de transacciones y qué opciones de respaldo y restauración están disponibles.

- **Simple**  
  No permite *transaction log backups* ni recuperación a punto en el tiempo. El log se trunca automáticamente. Es adecuado cuando no se requiere recuperación granular o cuando la pérdida de datos reciente es aceptable.

- **Full**  
  Conserva todo el historial del log, lo que posibilita respaldos de log y recuperación exacta a un momento específico. Es el modelo más flexible y el más utilizado en entornos de producción.

- **Bulk-Logged**  
  Similar al modelo *Full*, pero reduce el registro de transacciones en operaciones masivas (*bulk operations*), mejorando el rendimiento. No permite recuperación punto en el tiempo si una operación masiva ocurre entre respaldos de log.

---

### **2. Restore**

El **restore** o restauración es el proceso de recuperación de una base de datos a partir de los respaldos almacenados. La secuencia de restauración depende del tipo de respaldo y del modelo de recuperación configurado.

#### **Tipos de Restauración**

- **Restauración Completa (Full Restore)**  
  Restaura toda la base de datos a partir de un *full backup*.

- **Restauración Diferencial (Differential Restore)**  
  Requiere aplicar primero el *full backup* y luego el *differential backup* más reciente para reconstruir el estado actual.

- **Restauración del Log (Log Restore)**  
  Se aplica después del *full* o *differential backup* para reproducir todas las transacciones registradas y recuperar la base hasta un punto específico en el tiempo.

#### **Online Restore**
El **online restore** permite restaurar archivos, páginas o grupos de archivos mientras la base de datos permanece operativa.  
Esta característica, disponible en ediciones **Enterprise** o superiores de SQL Server, resulta especialmente útil en entornos con bases de datos grandes donde se necesita minimizar el tiempo de inactividad.

**Ejemplo de restauración básica en SQL Server:**
```sql
RESTORE DATABASE MiBase
FROM DISK = 'C:\Backups\MiBase_FULL.bak'
WITH NORECOVERY;

RESTORE LOG MiBase
FROM DISK = 'C:\Backups\MiBase_LOG.trn'
WITH RECOVERY;
```
---

### **3. Backup en Línea**

El **backup en línea** resulta crítico en sistemas que requieren **alta disponibilidad** y **operación continua**.  
Permite realizar respaldos mientras los usuarios siguen ejecutando consultas o modificando datos, sin detener el servicio.

SQL Server maneja internamente los **bloqueos** y las **transacciones activas** para garantizar que el respaldo sea **consistente** y **confiable**. Esta funcionalidad es esencial en entornos de producción donde los **periodos de mantenimiento** deben reducirse al mínimo.

En SQL Server, el **online restore** o **piecemeal restore** permite restaurar partes específicas de la base de datos (como archivos o *filegroups*) mientras el resto del sistema permanece disponible.  
Esta característica es especialmente valiosa en bases de datos de **gran tamaño**, donde un restore completo implicaría **tiempos de inactividad prolongados**.

---