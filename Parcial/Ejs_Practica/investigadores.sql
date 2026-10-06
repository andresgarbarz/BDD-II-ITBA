-- a
DROP VIEW IF EXISTS inv3bsas;

CREATE VIEW inv3bsas AS
SELECT i.IdInvest, i.nombre, i.fec_nac
FROM Investigador i
JOIN Proyecto p ON i.IdInvest = p.IdInvest
JOIN Instituto u ON p.IdInst = u.IdInst
JOIN Campus c ON u.id_campus = c.id_campus
WHERE c.provincia = 'Buenos Aires'
GROUP BY i.IdInvest, i.nombre, i.fec_nac
HAVING COUNT(DISTINCT u.IdInst) >= 3;

-- b
DROP VIEW IF EXISTS inv3bsas_u30;

CREATE VIEW inv3bsas_u30 AS
SELECT *
FROM inv3bsas
WHERE TIMESTAMPDIFF(YEAR, fec_nac, CURRENT_DATE) < 30;

-- c
DROP VIEW IF EXISTS inv_post15;

CREATE VIEW inv_post15 AS
SELECT i.IdInvest, i.nombre, i.fec_nac, p.fecha_inicio, p.IdInst, p.fecha_fin, p.desempeño
FROM Investigador i
JOIN Proyecto p ON i.IdInvest = p.IdInvest
WHERE p.fecha_inicio > '2015-12-31';