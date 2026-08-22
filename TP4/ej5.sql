-- Casos: 
-- 1: FK en la tabla principal, PK preservada.
-- 2: FK en tabla intermedia, PK compuesta preservada.
-- 3: No se preserva PK.

-- a.
-- CIUDAD_KP_1: Caso 1
-- ENTREGAS_KP2: Caso 2

-- b.
-- CIUDAD_KP1: PK = id_ciudad (de ciudad)
-- ENTREGAS_KP2: PK = (nro_entrega, codigo_pelicula) (de renglon_entrega)