-- a
CREATE VIEW empleado_dist_20 AS
SELECT id_empleado, nombre, apellido, sueldo, fecha_nacimiento
FROM empleado
WHERE id_distribuidor = 20;

-- b
CREATE VIEW empleado_dist_20_80 AS
SELECT * FROM empleado_dist_20
WHERE YEAR(fecha_nacimiento) BETWEEN 1980 AND 1989;

-- c
-- LOCAL: sólo chequea el WHERE de la vista donde se declara el CHECK OPTION.
-- CASCADE: chequea ese WHERE y los de todas las vistas subyacentes.

-- En empleado_dist_20 da igual (no depende de otra vista)
-- En empleado_dist_20_80 con LOCAL sólo controla el rango de años, con CASCADE también exige id_distribuidor=20.

-- d
CREATE VIEW peliculas_entregadas AS
SELECT codigo_pelicula, SUM(cantidad)
FROM renglon_entrega
GROUP BY codigo_pelicula;

-- e
CREATE VIEW distribuidoras_nacionales AS
SELECT d.id_distribuidor, d.nombre, d.direccion, d.telefono, d.tipo, n.nro_inscripcion, n.encargado, n.id_distrib_mayorista
FROM nacional n
JOIN distribuidor d ON n.id_distribuidor = d.id_distribuidor;