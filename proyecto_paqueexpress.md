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

### Diagrama relacional

![diagrama_relacional](https://raw.githubusercontent.com/SergiNavarr/basesdedatos_proyecto_estudio/main/doc/Modelo_Relacional.png)

### Diccionario de datos

Acceso al documento [PDF](doc/DiccionarioDeDatos.pdf) del diccionario de datos.

## CAPÍTULO V: CONCLUSIONES

## BIBLIOGRAFÍA DE CONSULTA
