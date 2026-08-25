DROP TABLE IF EXISTS materia;
DROP TABLE IF EXISTS inscripto;

CREATE TABLE materia(
    codigo INT,
    nombre VARCHAR(40)
);

INSERT INTO materia(codigo, nombre) VALUES
    (10, 'Introduccion a la Computacion'),
    (20, 'Programacion I'),
    (30, 'Estructura de Datos y Algoritmos'),
    (40, 'Base de Datos I'),
    (50, 'Programacion IV'),
    (60, 'Base de Datos II');

CREATE TABLE inscripto (
    legajo INT,
    codigo INT
);

INSERT INTO inscripto VALUES (100, 20);
INSERT INTO inscripto VALUES (200, 10);
INSERT INTO inscripto VALUES (300, 30);
INSERT INTO inscripto VALUES (400, 40);

-- DbVisualizer: en la conexión, Properties → Driver Properties
-- allowLoadLocalInfile = true  (después reconectar)
LOAD DATA LOCAL INFILE '/Users/andresgarbarz/Documents/Github/BDD-II-ITBA/TP5/materia.csv'
INTO TABLE materia
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(codigo, nombre);

LOAD DATA LOCAL INFILE '/Users/andresgarbarz/Documents/Github/BDD-II-ITBA/TP5/inscripto.csv'
INTO TABLE inscripto
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS (legajo, codigo);

-- Consultas sin índices
EXPLAIN ANALYZE
SELECT nombre
FROM materia
WHERE codigo = 12345;

EXPLAIN ANALYZE
SELECT *
FROM inscripto
WHERE codigo = 12345;

EXPLAIN ANALYZE
SELECT *
FROM materia m
JOIN inscripto i ON m.codigo = i.codigo;

-- Agrego PKs (por lo tanto, índices)
ALTER TABLE materia ADD PRIMARY KEY (codigo);
ALTER TABLE inscripto ADD PRIMARY KEY (legajo, codigo);

-- Creo un index separado para probar
CREATE INDEX idx_codigo_inscripto ON inscripto(codigo);