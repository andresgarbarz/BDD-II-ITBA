-- a
-- Uso LEFT JOIN porque "a lo sumo 3" incluye el caso de 0, en el cual no hay relación
SELECT m.tipo_mensaje, m.cod_mensaje, m.asunto, m.texto, m.fecha_envio
FROM mensaje m
LEFT JOIN contiene c ON m.tipo_mensaje = c.tipo_mensaje AND m.cod_mensaje = c.cod_mensaje
LEFT JOIN adjunto a ON c.id_adjunto = a.id_adjunto AND YEAR(a.anio_creacion) = YEAR(CURRENT_DATE) AND a.tamanio < 50
GROUP BY m.tipo_mensaje, m.cod_mensaje, m.asunto, m.texto, m.fecha_envio
HAVING COUNT(a.id_adjunto) <= 3;

-- b
-- Uso COALESCE para obtener el que no es NULL (según si el adjunto es imagen o audio)
SELECT a.*, COALESCE(au.duracion, im.resolucion) AS duracion_o_resolucion
FROM adjunto a
LEFT JOIN audio au ON a.id_adjunto = au.id_adjunto
LEFT JOIN imagen im ON a.id_adjunto = im.id_adjunto;