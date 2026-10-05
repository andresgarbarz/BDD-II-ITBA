## a

### Fortalezas

- Aguanta mucho volumen y muchas consultas, porque escala en horizontal y se puede replicar.
- El esquema es flexible: no hay que declararlo de antemano, y lo que en SQL sería un join se guarda anidado en el documento.
- Los comandos se parecen bastante a SQL, así que el salto desde una base relacional es corto.

### Debilidades

- Al no haber esquema, un typo en el nombre de un campo o de una colección no falla: el dato queda mal cargado y te das cuenta después.
- MongoDB suele usarse guardando los datos desordenados o repetidos (desnormalizados). Si ya tenés tus datos organizados de forma relacional, esta forma de guardar no aporta nada y puede llevar a errores.
- Hay que planear bien el cluster de servidores para escalar en horizontal.

La usaría para aplicaciones con gran volumen de datos y consultas que no tengan muchas entidades relacionadas entre sí.
