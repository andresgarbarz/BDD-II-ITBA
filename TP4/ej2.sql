DROP VIEW IF EXISTS buenos_proveedores;

CREATE VIEW buenos_proveedores (prov, rub, ciudad) AS
SELECT id_proveedor, rubro, ciudad
FROM proveedor
WHERE rubro IN ("Alimentos", "Agro", "Salud", "Farmacia")
WITH CHECK OPTION;

-- a
INSERT INTO buenos_proveedores (prov, rub, ciudad)
VALUES ('10', 'Farmacia', 'Paris');

-- Falla porque falta proveedor.nombre en la vista y tiene NOT NULL en la tabla ese campo

-- b
ALTER TABLE proveedor
MODIFY nombre VARCHAR(40) NULL;

-- Ahora sí funciona

-- c
UPDATE buenos_proveedores SET rub = 'Educación' WHERE prov = '10';

-- Check option failed, pues ese rubro no está en la lista de permitidos

-- d
INSERT INTO buenos_proveedores (prov, rub, ciudad )
VALUES ('8', 'Deportes', 'Roma');

-- Check option failed, pues ese rubro no está en la lista de permitidos