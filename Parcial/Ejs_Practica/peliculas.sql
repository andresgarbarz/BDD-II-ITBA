-- La siguiente consulta sobre el esquema de Películas debería “listar los datos completos de las películas con género Drama entregadas por un distribuidor nacional que no tenga distribuidor mayorista”

-- SELECT * FROM unc_esq_peliculas.pelicula p
-- JOIN unc_esq_peliculas.renglon_entrega re ON (p.codigo_pelicula = re.codigo_pelicula)
-- JOIN unc_esq_peliculas.entrega e ON (re.nro_entrega = e.nro_entrega)
-- JOIN unc_esq_peliculas.distribuidor d ON (e.id_distribuidor = d.id_distribuidor)
-- JOIN unc_esq_peliculas.nacional n ON (e.id_distribuidor = n.id_distribuidor)
-- WHERE p.genero LIKE 'Drama%' AND n.id_distrib_mayorista IS NULL;

-- Revisar las tablas en el PDF

-- a) ¿La consulta responde a lo solicitado? Justifique brevemente
-- No.
-- El camino pelicula -> renglon_entrega -> entrega -> nacional, y el id_distrib_mayorista IS NULL están bien, pero el SELECT * devuelve todos los campos de todas las tablas en el camino, y el filtro de 'Drama%' devuelve todos los géneros que empiecen con "Drama", no exactamente el género "Drama".

-- b) ¿Se le ocurre otra forma de resolverlo? Si su respuesta es SÍ, escriba la nueva consulta.
-- Sí, con EXISTS.

SELECT p.*
FROM unc_esq_peliculas.pelicula p
WHERE p.genero = 'Drama'
	AND EXISTS (
		SELECT 1
		FROM unc_esq_peliculas.renglon_entrega re
		JOIN unc_esq_peliculas.entrega e ON re.nro_entrega = e.nro_entrega
		JOIN unc_esq_peliculas.nacional n ON e.id_distribuidor = n.id_distribuidor
		WHERE re.codigo_pelicula = p.codigo_pelicula AND n.id_distrib_mayorista IS NULL
	);