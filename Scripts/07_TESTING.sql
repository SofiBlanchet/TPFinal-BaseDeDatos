-- testing

-- PRUEBA 1: STOCK INSUFICIENTE
INSERT INTO detalle_carrito (cantidad, precio_unitario, id_carrito, id_variacion)
VALUES (50, 45000, 1, 1);

-- PRUEBA 2: ESTADO DE VENTA INCORRECTO
UPDATE venta SET estado = 'Entregado' WHERE id = 1;

-- PRUEBA 3A: DETALLE VENTA SIN PROMO
INSERT INTO detalle_venta (cantidad, precio_unitario, descuento, subtotal, id_venta, id_variacion)
VALUES (1, 45000, 0, 45000, 1, 1);

-- PRUEBA 3B: DETALLE VENTA CON PROMO
-- NUEVA PROMO ACTIVA
INSERT INTO promo (nombre, descuento, fecha_inicio, fecha_fin)
VALUES ('Promo Test Activa', 20, CURRENT_DATE - 1, CURRENT_DATE + 7);
-- ASOCIAR PROMO CON PRODUCTO 7
INSERT INTO promo_producto (activo, id_promo, id_producto)
VALUES (true, 16, 7);
-- DETALLE VENTA CON PROMO ACTIVA
INSERT INTO detalle_venta (cantidad, precio_unitario, descuento, subtotal, id_venta, id_variacion)
VALUES (1, 49000, 0, 49000, 2, 7)
RETURNING id;

SELECT * FROM detalle_venta WHERE id = 17;

-- PRUEBA 4: RESEÑA SIN COMPRA
INSERT INTO resena (comentario, valoracion, fecha, id_producto, mail_usuario)
VALUES ('Fake', 5, '2025-08-10', 15, 'ana@gmail.com');

-- PRUEBA 5: PROMO CON FECHAS INVÁLIDAS
INSERT INTO promo (nombre, descuento, fecha_inicio, fecha_fin)
VALUES ('Promo Mala', 10, '2025-09-10', '2025-09-01');

-- PRUEBA 6: TOTAL VENTA
INSERT INTO detalle_venta (cantidad, precio_unitario, descuento, subtotal, id_venta, id_variacion)
VALUES (1, 54000, 0, 54000, 1, 9);
SELECT * FROM venta WHERE id = 1;
SELECT * FROM detalle_venta WHERE id_venta = 1;

-- PRUEBA 7: VALORACIÓN FUERA DE RANGO
INSERT INTO resena (comentario, valoracion, fecha, id_producto, mail_usuario)
VALUES ('Inválida', 7, '2025-08-10', 1, 'ana@gmail.com');

-- PRUEBA 8: DUPLICADO EN WISHLIST
INSERT INTO wishlist (fecha_creacion, mail_usuario, id_producto)
VALUES ('2025-09-10', 'ana@gmail.com', 1);

-- PRUEBAS DE FUNCIONES
SELECT fn_calcular_total_venta(1);
SELECT fn_calcular_descuento(7);
SELECT fn_stock_disponible(1);

SELECT fn_registrar_venta('ana@gmail.com',1);
SELECT * FROM venta WHERE id = 16;

-- PRUEBAS DE VISTAS
SELECT * FROM vista_mejores_clientes;
SELECT * FROM vista_articulos_mas_comprados;
SELECT * FROM vista_descuentos_activos;
SELECT * FROM vista_ventas_cliente;

-- PRUEBA DE PERMISOS
SET ROLE cliente_bd;
DELETE FROM producto WHERE id = 1;
RESET ROLE;
