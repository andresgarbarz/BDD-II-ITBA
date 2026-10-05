## a

### Semejanzas

- Los dos muestran el plan que elige el motor para una consulta, antes de mirar el resultado.
- Sirven para ver si recorre toda la tabla o colección, o si usa un índice, y cuánto le cuesta.
  - En MySQL, sale bajo la columna `rows` y el `type`.
  - En Mongo, sale bajo `totalDocsExamined`, `totalKeysExamined` y `executionTimeMillis`.
- En ambos, un recorrido completo (`type` `ALL`, o stage `COLLSCAN`) indica que falta un índice o que el filtro no puede usarlo.

### Diferencias

- **Formato de salida.** En MySQL es una sentencia: `EXPLAIN SELECT ...`, que devuelve una tabla con columnas fijas (`type`, `possible_keys`, `key`, `rows`, `Extra`). En Mongo es un método del cursor: `db.coleccion.find({...}).explain("executionStats")`, que devuelve un documento con etapas (`IXSCAN`, `FETCH`, `COLLSCAN`, `SORT`), no una tabla.
- **Descripción del plan.** MySQL describe un acceso por tabla. Mongo describe un pipeline de stages, sin separar por tablas.
