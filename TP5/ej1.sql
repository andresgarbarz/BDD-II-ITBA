DROP TABLE IF EXISTS materia;

CREATE TABLE materia(
    codigo INT PRIMARY KEY,
    nombre VARCHAR(40)
);

INSERT INTO materia(codigo, nombre) VALUES
	(10, 'Introduccion a la Computacion'),
    (20, 'Programacion I'),
    (30, 'Estructura de Datos y Algoritmos'),
    (40, 'Base de Datos I'),
    (50, 'Programacion IV'),
    (60, 'Base de Datos II');

SELECT * FROM materia;

SET @@explain_format=TREE;
EXPLAIN SELECT * FROM materia;
EXPLAIN ANALYZE SELECT * FROM materia;

/* Análisis de Resultados:

Consulta sin WHERE: el optimizador elegirá un table scan.

EXPLAIN SELECT: -> Table scan on materia  (cost=0.85 rows=6)
Devuelve cost y rows estimados, no ejecuta query

EXPLAIN ANALYZE SELECT: -> Table scan on materia  (cost=0.85 rows=6) (actual time=0.0138..0.0161 rows=6 loops=1)
Devuelve los estimados y datos reales, pues ejecuta query */