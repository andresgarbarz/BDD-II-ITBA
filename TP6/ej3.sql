-- a

-- Rest.| Tabla/s                     | Atrib/s                                   | Tipo Rest.   | Recurso
--------|-----------------------------|-------------------------------------------|--------------|----------
-- A1   | articulo                    | nacionalidad                              | atributo     | CHECK
-- A2   | articulo                    | fecha_pub                                 | atributo     | CHECK
-- A3   | articulo                    | nacionalidad, fecha_pub                   | registro     | CHECK
-- A4   | contiene                    | id_articulo, cod_palabra                  | tabla        | CHECK
-- A5   | articulo, contiene          | nacionalidad, id_articulo, cod_palabra    | global       | ASSERTION
-- B6   | provee                      | cod_producto, nro_prov                    | tabla        | CHECK
-- B7   | sucursal                    | cod_suc                                   | atributo     | CHECK
-- B8   | producto                    | descripcion, presentacion                 | registro     | CHECK
-- B9   | sucursal, provee, proveedor | localidad x2, cod_suc, nro_prov           | global       | ASSERTION

-- b

-- A1
ALTER TABLE articulo
ADD CONSTRAINT art_nac
CHECK (nacionalidad IN ('Argentino', 'Español', 'Inglés', 'Alemán', 'Chileno'));

-- A2
ALTER TABLE articulo
ADD CONSTRAINT art_fecha
CHECK (YEAR(fecha_pub) >= 2010);

-- A3
ALTER TABLE articulo
ADD CONSTRAINT art_fecha_nac
CHECK (YEAR != 2017 OR nacionalidad='Argentino');

-- A4
ALTER TABLE contiene
ADD CONSTRAINT keywords_max_10
CHECK (
	NOT EXISTS (
		SELECT 1
		FROM contiene
		GROUP BY id_articulo
		HAVING COUNT(cod_palabra) > 10
	)
);

-- A5
CREATE ASSERTION keywords_limit_arg
CHECK (
	NOT EXISTS (
		SELECT 1
		FROM articulo a
		JOIN contiene c ON a.id_articulo = c.id_articulo
		WHERE a.nacionalidad = 'Argentino'
		GROUP BY id_articulo
		HAVING COUNT(cod_palabra) NOT BETWEEN 11 AND 15 
	)
);

-- B6
ALTER TABLE contiene
ADD CONSTRAINT productos_max_20
CHECK (
	NOT EXISTS (
		SELECT 1
		FROM provee
		GROUP BY nro_prov
		HAVING COUNT(cod_producto) > 20
	)
);

-- B7
ALTER TABLE sucursal
ADD CONSTRAINT cod_suc_prefix
CHECK (cod_suc LIKE 'S\_%');

-- B8
ALTER TABLE producto
ADD CONSTRAINT not_double_null
CHECK (descripcion IS NOT NULL OR presentacion IS NOT NULL);

-- B9
CREATE ASSERTION misma_localidad
CHECK (
	NOT EXISTS (
		SELECT 1
		FROM provee e
		JOIN proveedor p ON e.nro_prov = p.nro_prov
		JOIN sucursal s ON e.cod_suc = s.cod_suc
		WHERE p.localidad != s.localidad
	)
);

-- c
-- No se pueden en MySQL los ítems A4, A5, B6, B9