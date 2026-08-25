-- a

-- I. Se puede. Se borran las entradas de instalacion con NroC=1
-- II. No se puede, pues no existe tupla con IdServ=S5
-- III. Se puede. Se setea la tupla con Zona="D" como Zona=NULL en referencia
-- IV. No se puede, pues está referenciado en instalacion y referencia, y ambas R2, R3 tienen ON DELETE RESTRICT
-- V. No se puede, pues está referenciado en instalacion y R2 es ON UPDATE RESTRICT

-- b
-- I.
INSERT INTO referencia VALUES ("E", 1, "Anto", C1);
-- No se puede pues no existe PK ("E", 1) en cliente

-- II.
INSERT INTO referencia VALUES ("E", NULL, "Anto", C1);
-- Acepta simple pues tiene un valor de la PK en NULL

-- III.
INSERT INTO referencia VALUES ("A", NULL, "Anto", C1);
-- Acepta simple pues tiene un valor de la PK en NULL
-- Acepta parcial pues su valor no NULL de la PK existe

-- IV.
INSERT INTO referencia VALUES ("A", 1, "Anto", C1);
-- Acepta simple, parcial, full pues la PK ("A", 1) existe en cliente y ninguna es NULL