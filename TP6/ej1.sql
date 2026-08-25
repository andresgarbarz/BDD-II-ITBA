-- a

-- R1
ALTER TABLE trabaja_en
ADD CONSTRAINT fk_trabaja_empleado
FOREIGN KEY (TipoE, NroE)
REFERENCES empleado(TipoE, NroE)
ON DELETE CASCADE
ON UPDATE RESTRICT;

-- R2
ALTER TABLE trabaja_en
ADD CONSTRAINT fk_trabaja_proyecto
FOREIGN KEY (IdProy)
REFERENCES pryecto(IdProy)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- R3
ALTER TABLE auspicio
ADD CONSTRAINT fk_auspicio_proyecto
FOREIGN KEY (IdProy)
REFERENCES pryecto(IdProy)
ON DELETE RESTRICT
ON UPDATE RESTRICT;

-- R4
ALTER TABLE auspicio
ADD CONSTRAINT fk_auspicio_empleado
FOREIGN KEY (TipoE, NroE)
REFERENCES empleado(TipoE, NroE)
ON DELETE SET NULL
ON UPDATE RESTRICT;

-- b

-- I. Se puede. Se borra en proyecto la tupla con idProy = 3
-- II. Se puede. Se actualiza la tupla de idProy=3 a idProy=7
-- III. No se puede, pues es referenciada por trabaja_en y R2 es ON DELETE RESTRICT
-- IV. Se puede. Se vuelve NULL la referencia en auspicio y se elimina (CASCADE) la referencia en trabaja_en
-- V. Se puede. Se modificaría la referencia, pasando a apuntar a la tupla de proyecto con idProy=3 (que existe)
-- VI. No se puede, pues es referenciada por auspicio y R3 es ON UPDATE RESTRICT

-- c

--        | Simple | Parcial | Full
-- -------|--------|---------|------
--  I     |   Sí   |   Sí    |  No
--  II    |   Sí   |   Sí    |  Sí
--  III   |   No   |   Sí    |  Sí
--  IV    |   Sí   |   No    |  Sí