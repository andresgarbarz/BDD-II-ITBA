-- a
SELECT id_distribuidor, id_departamento, nombre_departamento
FROM departamento;

-- b
SELECT apellido, nombre, e_mail
FROM empleado
WHERE e_mail LIKE "%@gmail.com"
	AND sueldo > 1000;

-- c
SELECT DISTINCT id_tarea
FROM empleado;

-- d
SELECT nombre, apellido, telefono
FROM empleado
WHERE id_tarea = "T001"
ORDER BY apellido, nombre ASC;

-- e
-- %e = day of the month (1-31) without leading zero
-- %c = month (1-12) without leading zero
SELECT CONCAT(nombre, ", ", apellido) AS nombre_apellido, DATE_FORMAT(fecha_nacimiento, "%e-%c") AS dia_mes_cumple
FROM empleado
ORDER BY MONTH(fecha_nacimiento), DAY(fecha_nacimiento);

-- f
SELECT CONCAT(apellido, ", ", nombre) as "Apellido y Nombre", e_mail as "Direccion de mail"
FROM empleado
WHERE telefono LIKE "600%";

-- g
SELECT apellido, id_empleado
FROM empleado
WHERE porc_comision = 0;

-- h
SELECT *
FROM distribuidor
WHERE tipo = "I"
	AND telefono IS NULL;

-- i
SELECT idioma, COUNT(*)
FROM pelicula
GROUP BY idioma;

-- j
SELECT id_departamento, id_distribuidor, COUNT(id_empleado) AS cant_empleados
FROM empleado
GROUP BY id_departamento, id_distribuidor;

-- k
SELECT codigo_pelicula, COUNT(nro_entrega) AS cant_entregas
FROM renglon_entrega
GROUP BY codigo_pelicula
HAVING cant_entregas BETWEEN 3 AND 5;
-- HAVING cant_entregas <= 5 AND cant_entregas >= 3;