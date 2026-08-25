-- a
-- I.
EXPLAIN ANALYZE SELECT nombre
FROM materia
WHERE codigo = 10;

-- MySQL usará un index lookup con la PK (codigo), accediendo directamente a la fila con codigo = 10.

-- II.
ALTER TABLE materia DROP PRIMARY KEY;
ALTER TABLE materia ADD PRIMARY KEY (codigo, nombre);

-- MySQL seguirá usando un index lookup, pero ahora utilizará con la PK (codigo, nombre). Como la consulta filtra solo por codigo, usará la 1era columna del índice para buscar, accediendo directo a la(s) fila(s) con codigo = 10.

-- III.
ALTER TABLE materia DROP PRIMARY KEY;
CREATE UNIQUE INDEX uq_codigo ON materia(codigo);

-- No hay cambios en el plan, MySQL también indexa por unique.

ALTER TABLE materia DROP PRIMARY KEY;
CREATE UNIQUE INDEX uq_codigo_nombre ON materia(codigo, nombre);

-- No hay cambios en el plan, MySQL también indexa por unique.

-- b
EXPLAIN ANALYZE SELECT nombre
FROM materia
WHERE codigo = 60 and nombre = 'Base de Datos II';

-- I.
ALTER TABLE materia DROP INDEX uq_codigo;
ALTER TABLE materia DROP INDEX uq_codigo_nombre;

-- MySQL sigue haciendo un index lookup, porque indexa la PK

-- II.
ALTER TABLE materia DROP PRIMARY KEY;
ALTER TABLE materia ADD CONSTRAINT PRIMARY KEY(codigo, nombre);

-- MySQL sigue haciendo un index lookup, porque indexa la PK

-- III.
ALTER TABLE materia DROP PRIMARY KEY;
CREATE UNIQUE INDEX uq_codigo ON materia(codigo);
CREATE UNIQUE INDEX uq_nombre ON materia(nombre);

-- MySQL sigue haciendo un index lookup.
-- Puede usar solo el índice uq_codigo para la búsqueda por codigo. Si la consulta usa ambos, puede hacer index merge o elegir el más óptimo.

-- c
EXPLAIN ANALYZE SELECT *
FROM materia
ORDER BY codigo;

-- I.
ALTER TABLE materia DROP INDEX uq_codigo;
ALTER TABLE materia DROP INDEX uq_nombre;

-- MySQL hace table scan + filesort para ORDER BY codigo porque no hay índice.

-- II.
ALTER TABLE materia ADD CONSTRAINT PRIMARY KEY (codigo);

-- MySQL usa index scan ordenado con la PK.

-- d
CREATE TABLE inscripto (
    legajo INT,
    codigo INT
);

-- e
INSERT INTO inscripto VALUES (100, 20);
INSERT INTO inscripto VALUES (200, 10);
INSERT INTO inscripto VALUES (300, 30);
INSERT INTO inscripto VALUES (400, 40);

-- f
EXPLAIN ANALYZE SELECT *
FROM materia INNER JOIN inscripto
ON materia.codigo = inscripto.codigo;

-- I.
ALTER TABLE materia DROP PRIMARY KEY;

-- -> Inner hash join (materia.codigo = inscripto.codigo)  (cost=3.3 rows=4) (actual time=0.0145..0.0161 rows=4 loops=1)
-- -> Table scan on materia  (cost=0.0875 rows=6) (actual time=0.00167..0.00267 rows=6 loops=1)
-- -> Hash
-- -> Table scan on inscripto  (cost=0.65 rows=4) (actual time=0.00629..0.00796 rows=4 loops=1)

-- Escanea toda la tabla inscripto y arma una hash table en memoria. Luego, escanea la tabla materia y, por cada fila, se busca en esa hash table si hay coincidencias según la condición del join.
-- El árbol se lee de abajo hacia arriba porque así ocurren las operaciones: primero los escaneos, luego el join.

-- II.
ALTER TABLE materia ADD CONSTRAINT PRIMARY KEY (codigo);

-- -> Nested loop inner join  (cost=2.05 rows=4) (actual time=0.012..0.0149 rows=4 loops=1)
-- -> Filter: (inscripto.codigo is not null)  (cost=0.65 rows=4) (actual time=0.00654..0.00775 rows=4 loops=1)
-- -> Table scan on inscripto  (cost=0.65 rows=4) (actual time=0.00563..0.00667 rows=4 loops=1)
-- -> Single-row index lookup on materia using PRIMARY (codigo = inscripto.codigo)  (cost=0.275 rows=1) (actual time=0.00134..0.00135 rows=1 loops=4)

-- Recorre inscripto con table scan, y por cada fila hace un index lookup en materia usando el índice de la PK materia.codigo

-- III.
ALTER TABLE inscripto ADD CONSTRAINT PRIMARY KEY (codigo);

-- -> Nested loop inner join  (cost=2.05 rows=4) (actual time=0.0112..0.0137 rows=4 loops=1)
-- -> Table scan on inscripto  (cost=0.65 rows=4) (actual time=0.00613..0.00696 rows=4 loops=1)
-- -> Single-row index lookup on materia using PRIMARY (codigo = inscripto.codigo)  (cost=0.275 rows=1) (actual time=0.00122..0.00123 rows=1 loops=4)

-- El plan no cambia respecto al paso II. MySQL ya estaba optimizando usando el índice de la PK en materia, y la PK en inscripto no aporta ventaja extra en este join.

-- g
EXPLAIN ANALYZE SELECT *
FROM inscripto
WHERE legajo = 100 OR codigo = 10;

-- I.
ALTER TABLE materia DROP PRIMARY KEY;
ALTER TABLE inscripto DROP PRIMARY KEY;

-- Como no hay índices, recorre toda la tabla y usa un filter

-- II.
ALTER TABLE inscripto ADD PRIMARY KEY (legajo, codigo);

-- No cambia el plan, pues en la PK compuesta solo aprovecha el índice si el filtro utiliza el primer campo de ella para filtrar. En este caso el OR acepta casos que no la involucran, entonces debe hacer full scan.