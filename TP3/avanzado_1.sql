-- a
SELECT DISTINCT v.razon_social
FROM video v
JOIN entrega e ON v.id_video = e.id_video
	JOIN renglon_entrega r ON e.nro_entrega = r.nro_entrega
	JOIN pelicula p ON r.codigo_pelicula = p.codigo_pelicula
WHERE idioma = "English"
	AND YEAR(e.fecha_entrega) = 2022
ORDER BY razon_social ASC;

-- b
SELECT d.id_departamento, d.id_distribuidor, d.nombre_departamento
FROM departamento d
WHERE NOT EXISTS (
    SELECT 1
    FROM empleado e JOIN tarea t ON e.id_tarea = t.id_tarea
    WHERE e.id_departamento = d.id_departamento
		AND (t.sueldo_maximo - t.sueldo_minimo) > 0.5 * (SELECT MAX(sueldo) FROM empleado)
);

-- c
SELECT SUM(r.cantidad) AS total_peliculas
FROM renglon_entrega r
JOIN entrega e ON r.nro_entrega = e.nro_entrega
	JOIN nacional n ON e.id_distribuidor = n.id_distribuidor
WHERE YEAR(fecha_entrega) = 2022;

-- d
SELECT p.titulo
FROM pelicula p
WHERE p.codigo_pelicula NOT IN (
	SELECT r.codigo_pelicula
	FROM renglon_entrega r
		JOIN entrega e ON r.nro_entrega = e.nro_entrega
		JOIN nacional n ON e.id_distribuidor = n.id_distribuidor
);

-- e
SELECT DISTINCT j.nombre, j.apellido
FROM empleado j
JOIN departamento d ON j.id_departamento = d.id_departamento
WHERE EXISTS (
    SELECT 1
    FROM empleado e
    WHERE e.id_jefe = j.id_empleado
);

-- f
SELECT genero, SUM(r.cantidad) AS cantidad_total
FROM renglon_entrega r
JOIN pelicula p ON r.codigo_pelicula = p.codigo_pelicula
	JOIN entrega e ON r.nro_entrega = e.nro_entrega
WHERE YEAR(e.fecha_entrega) >= (YEAR(CURRENT_DATE) - 5)
GROUP BY p.genero
ORDER BY cantidad_total DESC;

-- g
SELECT e.fecha_entrega, v.razon_social, COUNT(r.cantidad) AS cantidad_total
FROM entrega e
JOIN video v ON e.id_video = v.id_video
	JOIN renglon_entrega r ON e.nro_entrega = r.nro_entrega
GROUP BY e.fecha_entrega, v.razon_social;

-- h
SELECT c.nombre_ciudad, p.id_pais, SUM(e.id_empleado) AS total_empleados
FROM ciudad c
JOIN pais p ON c.id_pais = p.id_pais
	JOIN departamento d ON c.id_ciudad = d.id_ciudad
	JOIN empleado e ON d.id_departamento = e.id_departamento
WHERE (CURRENT_DATE >= DATE_ADD(e.fecha_nacimiento, INTERVAL 18 YEAR))
GROUP BY c.nombre_ciudad, p.id_pais
HAVING total_empleados >= 30;