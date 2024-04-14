![UGB Logo](https://estudiantes.ugb.edu.sv/img/logos/logo_azul_vertical.png)
# Sistema de Reportes para eCommerce
Actividad correspondiente al Proyecto Final de la asignatura Programacion de Scripts desarrollada por Grupo #7

![Shell Script](https://img.shields.io/badge/shell_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)

## Descripción

Este proyecto consiste en un sistema de reportes desarrollado en `bash` para un eCommerce.
El script genera informes diarios automatizados utilizando un modelo orientado a objetos mediante funciones y estructuras de control.
A continuación, se detallan los requisitos que cumple el sistema de reportes:

### Requisitos
- Automatización con CRON: Se ha configurado un CRON para la generación automática de informes diarios.
- TOP 10 de Productos más Vendidos: El script obtiene y muestra los diez productos más vendidos.
- Total de Ingresos por Categoría: Calcula el total de ingresos generados por cada categoría de productos.
- Total de Ingresos por Mes: Genera el total de ingresos por mes.
- Total de Ingresos por Cliente: Calcula el total de ingresos generados por cada cliente.
- Total de Ingresos por Departamento: Muestra el total de ingresos por departamento.

### Ejecución

Para ejecutar el script manualmente, simplemente se ejecuta el archivo generador_de_reporte.sh en la terminal:

```generador_de_reporte.sh```

## Configuración del CRON

Para configurar el CRON y automatizar la generación de informes diarios, se siguen estos pasos:

- Abrimos la terminal y se ejecuta el comando crontab -e para editar las tareas cron.
- Añadimos la siguiente línea al final del archivo para ejecutar el script todos los días a las 23:59:

bash

```59 23 * * * /ruta/completa/script/generador_de_reporte.sh```

Se reemplaza /ruta/completa/script/ con la ruta absoluta donde se encuentra el script generador_de_reporte.sh.

### Análisis del Contenido

El contenido generado incluye informes detallados que proporcionan percepciones valiosas sobre el rendimiento del eCommerce, permitiendo tomar decisiones informadas para mejorar las ventas y la experiencia del cliente.
