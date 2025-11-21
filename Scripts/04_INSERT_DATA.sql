-- inserts

-- USUARIO
INSERT INTO usuario (mail, nombre, apellido, rol)
VALUES
('lacamiseriaurbana@gmail.com', 'Admin', 'Sistema', 'Admin'),
('ana@gmail.com', 'Ana', 'Lopez', 'Cliente'),
('juan@gmail.com', 'Juan', 'Perez', 'Cliente'),
('sofi@gmail.com', 'Sofia', 'Blanchet', 'Cliente'),
('luca@gmail.com', 'Lucas', 'Gomez', 'Cliente'),
('meli@gmail.com', 'Melina', 'Lopez', 'Cliente'),
('tomi@gmail.com', 'Tomas', 'Rodriguez', 'Cliente'),
('fran@gmail.com', 'Francisco', 'Diaz', 'Cliente'),
('marti@gmail.com', 'Martina', 'Sosa', 'Cliente'),
('vale@gmail.com', 'Valentina', 'Ruiz', 'Cliente'),
('lucho@gmail.com', 'Luciano', 'Fernandez', 'Cliente'),
('agus@gmail.com', 'Agustin', 'Vega', 'Cliente'),
('ema@gmail.com', 'Emanuel', 'Castro', 'Cliente'),
('dani@gmail.com', 'Daniela', 'Muñoz', 'Cliente'),
('pepe@gmail.com', 'José', 'Martinez', 'Cliente');

-- DIRECCION
INSERT INTO direccion (calle, numero, cp)
VALUES
('Belgrano', 123, '1001'),
('Sarmiento', 450, '1002'),
('Mitre', 80, '1003'),
('Rivadavia', 502, '1004'),
('Cordoba', 900, '1005'),
('Urquiza', 300, '1006'),
('San Martin', 700, '1007'),
('Independencia', 250, '1008'),
('Colon', 600, '1009'),
('Italia', 150, '1010'),
('España', 410, '1011'),
('Paraguay', 333, '1012'),
('Brasil', 442, '1013'),
('Mexico', 221, '1014'),
('Peru', 199, '1015');

-- DIRECCION_USUARIO
INSERT INTO direccion_usuario (id_direccion, mail_usuario)
VALUES
(1, 'lacamiseriaurbana@gmail.com'),
(2, 'ana@gmail.com'),
(3, 'juan@gmail.com'),
(4, 'sofi@gmail.com'),
(5, 'luca@gmail.com'),
(6, 'meli@gmail.com'),
(7, 'tomi@gmail.com'),
(8, 'fran@gmail.com'),
(9, 'marti@gmail.com'),
(10, 'vale@gmail.com'),
(11, 'lucho@gmail.com'),
(12, 'agus@gmail.com'),
(13, 'ema@gmail.com'),
(14, 'dani@gmail.com'),
(15, 'pepe@gmail.com');

-- MARCA
INSERT INTO marca (nombre)
VALUES
('Zara'),
('H&M'),
('Nike'),
('Adidas'),
('Kosiuko'),
('Ay Not Dead'),
('47 Street'),
('Levi’s'),
('Wrangler'),
('Uniqlo'),
('Pull&Bear'),
('Bershka'),
('Topshop'),
('Rapsodia'),
('Prüne');

-- PRODUCTO
INSERT INTO producto (nombre, descripcion, material, precio, id_marca)
VALUES
('Camisa Summer', 'Camisa liviana de verano', 'Algodón', 45000, 1),
('Camisa Iron', 'Camisa de algodón premium', 'Algodón', 49000, 2),
('Camisa Oxford Line', 'Camisa Oxford clásica', 'Algodón', 52000, 3),
('Camisa Forest', 'Camisa de tonos tierra', 'Algodón', 47000, 4),
('Camisa Veneto', 'Camisa elegante de manga larga', 'Algodón', 53000, 5),
('Camisa Warm Bloom', 'Camisa suave entallada', 'Algodón', 46000, 6),
('Camisa Sky', 'Camisa celeste relajada', 'Algodón', 45500, 7),
('Camisa Metrio', 'Camisa elegante monocromática', 'Algodón', 51000, 8),
('Camisa Beige Executive', 'Camisa formal beige', 'Algodón', 54000, 9),
('Camisa Nature', 'Camisa estampada con patrones suaves', 'Algodón', 48000, 10),
('Camisa Deep Denim', 'Camisa denim azul oscuro', 'Jean', 58000, 11),
('Camisa Strada Texturata', 'Camisa texturada liviana', 'Algodón', 49000, 12),
('Camisa Mare', 'Camisa estilo marítimo', 'Algodón', 47000, 13),
('Camisa Punto Fino', 'Camisa con tejido fino', 'Algodón', 52000, 14),
('Camisa Cesar', 'Camisa formal clásica', 'Algodón', 50000, 15);

-- COMPRA_PROVEEDOR
INSERT INTO compra_proveedor (proveedor, total)
VALUES
('Proveedor1', 50000),
('Proveedor2', 32000),
('Proveedor3', 15000),
('Proveedor4', 68000),
('Proveedor5', 45000),
('Proveedor6', 72000),
('Proveedor7', 9000),
('Proveedor8', 88000),
('Proveedor9', 11000),
('Proveedor10', 37000),
('Proveedor11', 22000),
('Proveedor12', 40000),
('Proveedor13', 26000),
('Proveedor14', 15000),
('Proveedor15', 54000);

-- VARIACIONES
INSERT INTO variaciones (talle, color, stock, id_producto, id_compra)
VALUES
('S', 'Negro', 20, 1, 1),
('M', 'Blanco', 30, 2, 2),
('L', 'Azul', 15, 3, 3),
('XL', 'Beige', 12, 4, 4),
('S', 'Rojo', 18, 5, 5),
('M', 'Verde', 10, 6, 6),
('L', 'Amarillo', 25, 7, 7),
('XL', 'Gris', 22, 8, 8),
('S', 'Celeste', 17, 9, 9),
('M', 'Marron', 32, 10, 10),
('L', 'Negro', 14, 11, 11),
('XL', 'Blanco', 19, 12, 12),
('S', 'Azul', 16, 13, 13),
('M', 'Beige', 11, 14, 14),
('L', 'Rojo', 28, 15, 15);

-- PROMO
INSERT INTO promo (nombre, descuento, fecha_inicio, fecha_fin)
VALUES
('Promo Verano', 10, '2025-08-01', '2025-08-06'),
('Promo Otoño', 15, '2025-08-05', '2025-08-15'),
('Promo Invierno', 20, '2025-08-10', '2025-08-25'),
('Promo Primavera', 5, '2025-08-12', '2025-08-20'),
('Cyber Semana', 30, '2025-09-01', '2025-09-05'),
('Hot Sale', 25, '2025-09-10', '2025-09-15'),
('Liquidación 1', 12, '2025-09-18', '2025-09-25'),
('Liquidación 2', 17, '2025-09-20', '2025-09-30'),
('Liquidación 3', 22, '2025-10-01', '2025-10-12'),
('Rebaja A', 8, '2025-10-05', '2025-10-14'),
('Rebaja B', 14, '2025-10-10', '2025-10-22'),
('Rebaja C', 9, '2025-10-15', '2025-10-28'),
('Promo Flash 1', 18, '2025-11-01', '2025-11-03'),
('Promo Flash 2', 28, '2025-11-05', '2025-11-06'),
('Promo Flash 3', 7, '2025-11-08', '2025-11-12');

-- PROMO_PRODUCTO
INSERT INTO promo_producto (activo, id_promo, id_producto)
VALUES
(true, 1, 1),
(true, 2, 2),
(true, 3, 3),
(true, 4, 4),
(true, 5, 5),
(true, 6, 6),
(true, 7, 7),
(true, 8, 8),
(true, 9, 9),
(true, 10, 10),
(true, 11, 11),
(true, 12, 12),
(true, 13, 13),
(true, 14, 14),
(true, 15, 15);

-- CARRITO
INSERT INTO carrito (fecha_creacion, mail_usuario)
VALUES
('2025-08-01', 'ana@gmail.com'),
('2025-08-02', 'juan@gmail.com'),
('2025-08-03', 'sofi@gmail.com'),
('2025-08-04', 'luca@gmail.com'),
('2025-08-05', 'meli@gmail.com'),
('2025-08-06', 'tomi@gmail.com'),
('2025-08-07', 'fran@gmail.com'),
('2025-08-08', 'marti@gmail.com'),
('2025-08-09', 'vale@gmail.com'),
('2025-08-10', 'lucho@gmail.com'),
('2025-08-11', 'agus@gmail.com'),
('2025-08-12', 'ema@gmail.com'),
('2025-08-13', 'dani@gmail.com'),
('2025-08-14', 'pepe@gmail.com'),
('2025-08-15', 'lacamiseriaurbana@gmail.com');

-- DETALLE_CARRITO
INSERT INTO detalle_carrito (cantidad, precio_unitario, id_carrito, id_variacion)
VALUES
(1, 45000, 1, 1),
(2, 49000, 2, 2),
(1, 52000, 3, 3),
(1, 47000, 4, 4),
(3, 53000, 5, 5),
(1, 46000, 6, 6),
(1, 45500, 7, 7),
(2, 51000, 8, 8),
(1, 54000, 9, 9),
(1, 48000, 10, 10),
(2, 58000, 11, 11),
(1, 49000, 12, 12),
(1, 47000, 13, 13),
(1, 52000, 14, 14),
(1, 50000, 15, 15);

-- WISHLIST
INSERT INTO wishlist (fecha_creacion, mail_usuario, id_producto)
VALUES
('2025-08-01', 'ana@gmail.com', 1),
('2025-08-04', 'juan@gmail.com', 2),
('2025-08-08', 'sofi@gmail.com', 3),
('2025-08-12', 'luca@gmail.com', 4),
('2025-08-15', 'meli@gmail.com', 5),
('2025-08-19', 'tomi@gmail.com', 6),
('2025-08-22', 'fran@gmail.com', 7),
('2025-08-27', 'marti@gmail.com', 8),
('2025-09-02', 'vale@gmail.com', 9),
('2025-09-06', 'lucho@gmail.com', 10),
('2025-09-11', 'agus@gmail.com', 11),
('2025-09-15', 'ema@gmail.com', 12),
('2025-09-20', 'dani@gmail.com', 13),
('2025-10-01', 'pepe@gmail.com', 14),
('2025-10-05', 'lacamiseriaurbana@gmail.com', 15);

-- VENTA
INSERT INTO venta (fecha, estado, total, nro_seguimiento, usuario_mail, direccion_id)
VALUES
('2025-08-03 14:22', 'En proceso', 40500, 'TRK1001', 'ana@gmail.com', 1),
('2025-08-05 18:40', 'Enviado', 83300, 'TRK1002', 'juan@gmail.com', 2),
('2025-08-09 11:10', 'Entregado', 41600, 'TRK1003', 'sofi@gmail.com', 3),
('2025-08-12 09:55', 'En proceso', 44650, 'TRK1004', 'luca@gmail.com', 4),
('2025-08-15 16:30', 'Entregado', 111300, 'TRK1005', 'meli@gmail.com', 5),
('2025-08-18 20:12', 'Enviado', 34500, 'TRK1006', 'tomi@gmail.com', 6),
('2025-08-21 10:45', 'En proceso', 40040, 'TRK1007', 'fran@gmail.com', 7),
('2025-08-25 13:05', 'Entregado', 84660, 'TRK1008', 'marti@gmail.com', 8),
('2025-09-01 17:50', 'En proceso', 42120, 'TRK1009', 'vale@gmail.com', 9),
('2025-09-05 15:33', 'Enviado', 44160, 'TRK1010', 'lucho@gmail.com', 10),
('2025-09-10 19:20', 'Entregado', 49920, 'TRK1011', 'agus@gmail.com', 11),
('2025-09-14 08:45', 'En proceso', 44590, 'TRK1012', 'ema@gmail.com', 12),
('2025-09-19 12:15', 'Enviado', 38540, 'TRK1013', 'dani@gmail.com', 13),
('2025-09-23 17:05', 'Entregado', 37440, 'TRK1014', 'pepe@gmail.com', 14),
('2025-10-01 11:55', 'En proceso', 46500, 'TRK1015', 'lacamiseriaurbana@gmail.com', 15);

-- DETALLE_VENTA
INSERT INTO detalle_venta (cantidad, precio_unitario, descuento, subtotal, id_venta, id_variacion)
VALUES
(1, 45000, 10, 40500, 1, 1),
(2, 49000, 15, 83300, 2, 2),
(1, 52000, 20, 41600, 3, 3),
(1, 47000, 5, 44650, 4, 4),
(3, 53000, 30, 111300, 5, 5),
(1, 46000, 25, 34500, 6, 6),
(1, 45500, 12, 40040, 7, 7),
(2, 51000, 17, 84660, 8, 8),
(1, 54000, 22, 42120, 9, 9),
(1, 48000, 8, 44160, 10, 10),
(2, 58000, 14, 49920, 11, 11),
(1, 49000, 9, 44590, 12, 12),
(1, 47000, 18, 38540, 13, 13),
(1, 52000, 28, 37440, 14, 14),
(1, 50000, 7, 46500, 15, 15);

-- RESENA
INSERT INTO resena (comentario, valoracion, fecha, id_producto, mail_usuario)
VALUES
('Excelente calidad', 5, '2025-08-10', 1, 'ana@gmail.com'),
('Muy buena compra', 4, '2025-08-12', 2, 'juan@gmail.com'),
('Me encantó', 5, '2025-08-15', 3, 'sofi@gmail.com'),
('Correcta', 3, '2025-08-18', 4, 'luca@gmail.com'),
('Hermosa tela', 5, '2025-08-22', 5, 'meli@gmail.com'),
('Normal', 3, '2025-08-25', 6, 'tomi@gmail.com'),
('Muy cómodo', 4, '2025-08-30', 7, 'fran@gmail.com'),
('Muy lindo diseño', 4, '2025-09-03', 8, 'marti@gmail.com'),
('Perfecto para diario', 5, '2025-09-08', 9, 'vale@gmail.com'),
('Recomendado', 5, '2025-09-12', 10, 'lucho@gmail.com'),
('Buena calidad', 4, '2025-09-17', 11, 'agus@gmail.com'),
('Muy buena relación precio-calidad', 5, '2025-09-21', 12, 'ema@gmail.com'),
('Me gustó mucho', 5, '2025-09-26', 13, 'dani@gmail.com'),
('Está bien', 3, '2025-10-01', 14, 'pepe@gmail.com'),
('Muy elegante', 5, '2025-10-05', 15, 'lacamiseriaurbana@gmail.com');
