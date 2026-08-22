-- a
DROP VIEW IF EXISTS envios500;

CREATE VIEW envios500 AS
SELECT *
FROM envio
WHERE cantidad > 500;

-- Es actualizable, porque conserva todas las columnas de la clave (primaria), no contiene funciones de agregación o información derivada, no incluye la claúsula DISTINCT y no incluye subconsultas en el SELECT.

-- b
DROP VIEW IF EXISTS envios500_999;

CREATE VIEW envios500_999 AS
SELECT *
FROM envios500
WHERE cantidad < 999;

-- Es actualizable, porque se realiza un SELECT a partir de otra vista actualizable y se sigue cumpliendo con las condiciones anteriores.

-- c
DROP VIEW IF EXISTS detalle_envios;

CREATE VIEW detalle_envios AS
SELECT a.descrip, a.peso, p.nombre, e.cantidad
FROM envios500 e
JOIN articulo a ON e.id_articulo = a.id_articulo
	JOIN proveedor p ON e.id_proveedor = p.id_proveedor;