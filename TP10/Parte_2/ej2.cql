-- 2
-- Una tabla por consulta. La categoría va en el producto: pertenece es 1 a n.

CREATE KEYSPACE ecommerce
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': '1'};

USE ecommerce;

-- Usuario por id.
CREATE TABLE usuarios_por_id (
    id uuid PRIMARY KEY,
    nombre text,
    email text,
    password text
);

-- Producto por id, con la categoría a la que pertenece.
CREATE TABLE productos_por_id (
    id uuid PRIMARY KEY,
    titulo text,
    tags set<text>,
    descripcion text,
    categoria text,
    descripcion_categoria text,
    fecha_creacion_categoria timestamp
);

-- Productos publicados por un usuario (nombre), con la fecha de publicación.
CREATE TABLE productos_por_usuario (
    nombre_usuario text,
    fecha timestamp,
    producto_id uuid,
    titulo text,
    tags set<text>,
    descripcion text,
    categoria text,
    PRIMARY KEY (nombre_usuario, fecha, producto_id)
) WITH CLUSTERING ORDER BY (fecha DESC, producto_id ASC);

-- Usuarios que comentaron un producto (título), con el texto y la fecha.
CREATE TABLE comentarios_por_producto (
    titulo_producto text,
    fecha timestamp,
    comentario_id uuid,
    comentario text,
    nombre_usuario text,
    email text,
    PRIMARY KEY (titulo_producto, fecha, comentario_id)
) WITH CLUSTERING ORDER BY (fecha DESC, comentario_id ASC);

-- Productos que calificó un usuario, ordenados por fecha.
CREATE TABLE calificaciones_por_usuario (
    nombre_usuario text,
    fecha timestamp,
    producto_id uuid,
    titulo_producto text,
    PRIMARY KEY (nombre_usuario, fecha, producto_id)
) WITH CLUSTERING ORDER BY (fecha DESC, producto_id ASC);

-- Datos de prueba

INSERT INTO usuarios_por_id (id, nombre, email, password)
VALUES (11111111-1111-4111-8111-111111111111, 'Jorge Drexler', 'jorge@mail.com', 'secreto1');

INSERT INTO usuarios_por_id (id, nombre, email, password)
VALUES (22222222-2222-4222-8222-222222222222, 'María Fernanda', 'maria@mail.com', 'secreto2');

INSERT INTO productos_por_id (id, titulo, tags, descripcion, categoria, descripcion_categoria, fecha_creacion_categoria)
VALUES (
    aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaa1,
    'Guitarra criolla',
    {'cuerdas', 'madera'},
    'Guitarra de concierto',
    'Instrumentos',
    'Instrumentos musicales',
    '2020-01-01 00:00:00+0000'
);

INSERT INTO productos_por_id (id, titulo, tags, descripcion, categoria, descripcion_categoria, fecha_creacion_categoria)
VALUES (
    aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaa2,
    'Vinilo Salvavidas',
    {'vinilo'},
    'Edición de Salvavidas de Hielo',
    'Discos',
    'Álbumes publicados',
    '2019-05-01 00:00:00+0000'
);

INSERT INTO productos_por_id (id, titulo, tags, descripcion, categoria, descripcion_categoria, fecha_creacion_categoria)
VALUES (
    aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaa3,
    'Micrófono',
    {'audio'},
    'Micrófono de estudio',
    'Instrumentos',
    'Instrumentos musicales',
    '2020-01-01 00:00:00+0000'
);

INSERT INTO productos_por_usuario (nombre_usuario, fecha, producto_id, titulo, tags, descripcion, categoria)
VALUES ('Jorge Drexler', '2026-04-02 12:00:00+0000', aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaa2, 'Vinilo Salvavidas', {'vinilo'}, 'Edición de Salvavidas de Hielo', 'Discos');

INSERT INTO productos_por_usuario (nombre_usuario, fecha, producto_id, titulo, tags, descripcion, categoria)
VALUES ('Jorge Drexler', '2026-03-01 10:00:00+0000', aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaa1, 'Guitarra criolla', {'cuerdas', 'madera'}, 'Guitarra de concierto', 'Instrumentos');

INSERT INTO productos_por_usuario (nombre_usuario, fecha, producto_id, titulo, tags, descripcion, categoria)
VALUES ('María Fernanda', '2026-05-10 09:00:00+0000', aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaa3, 'Micrófono', {'audio'}, 'Micrófono de estudio', 'Instrumentos');

INSERT INTO comentarios_por_producto (titulo_producto, fecha, comentario_id, comentario, nombre_usuario, email)
VALUES ('Guitarra criolla', '2026-03-02 15:00:00+0000', bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbb1, 'Muy buena caja', 'María Fernanda', 'maria@mail.com');

INSERT INTO comentarios_por_producto (titulo_producto, fecha, comentario_id, comentario, nombre_usuario, email)
VALUES ('Guitarra criolla', '2026-03-04 11:00:00+0000', bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbb2, 'El mástil está cómodo', 'Jorge Drexler', 'jorge@mail.com');

INSERT INTO comentarios_por_producto (titulo_producto, fecha, comentario_id, comentario, nombre_usuario, email)
VALUES ('Micrófono', '2026-05-11 18:00:00+0000', bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbb3, 'Se escucha claro', 'Jorge Drexler', 'jorge@mail.com');

INSERT INTO calificaciones_por_usuario (nombre_usuario, fecha, producto_id, titulo_producto)
VALUES ('Jorge Drexler', '2026-05-12 20:00:00+0000', aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaa3, 'Micrófono');

INSERT INTO calificaciones_por_usuario (nombre_usuario, fecha, producto_id, titulo_producto)
VALUES ('Jorge Drexler', '2026-03-03 16:00:00+0000', aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaa1, 'Guitarra criolla');

INSERT INTO calificaciones_por_usuario (nombre_usuario, fecha, producto_id, titulo_producto)
VALUES ('María Fernanda', '2026-04-05 13:00:00+0000', aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaa2, 'Vinilo Salvavidas');

-- Consultas

SELECT * FROM usuarios_por_id WHERE id = 11111111-1111-4111-8111-111111111111;

SELECT * FROM productos_por_id WHERE id = aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaa1;

SELECT titulo, fecha, categoria, tags
FROM productos_por_usuario
WHERE nombre_usuario = 'Jorge Drexler';

SELECT nombre_usuario, email, comentario, fecha
FROM comentarios_por_producto
WHERE titulo_producto = 'Guitarra criolla';

SELECT titulo_producto, fecha
FROM calificaciones_por_usuario
WHERE nombre_usuario = 'Jorge Drexler';
