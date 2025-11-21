-- VISTA: vista_mejores_clientes
-- Muestra los clientes que más compraron, sumando el total gastado.
CREATE OR REPLACE VIEW vista_mejores_clientes AS
SELECT
    u.nombre || ' ' || u.apellido AS cliente,
    u.mail,
    SUM(v.total) AS monto_total_comprado
FROM venta v
JOIN usuario u ON u.mail = v.usuario_mail
GROUP BY u.nombre, u.apellido, u.mail
ORDER BY monto_total_comprado DESC;


-- VISTA: vista_articulos_mas_comprados
-- Lista los productos más vendidos, unidades totales y facturación generada.
CREATE OR REPLACE VIEW vista_articulos_mas_comprados AS
SELECT
    p.id AS id_producto,
    p.nombre AS producto,
    SUM(dv.cantidad) AS unidades_vendidas,
    SUM(dv.subtotal) AS ingresos_generados
FROM detalle_venta dv
JOIN variaciones va ON va.id = dv.id_variacion
JOIN producto p ON p.id = va.id_producto
GROUP BY p.id, p.nombre
ORDER BY unidades_vendidas DESC;


-- VISTA: vista_descuentos_activos
-- Muestra todas las promociones vigentes según fecha actual.
CREATE OR REPLACE VIEW vista_descuentos_activos AS
SELECT
    pr.id,
    pr.nombre,
    pr.descuento,
    pr.fecha_inicio,
    pr.fecha_fin
FROM promo pr
WHERE CURRENT_DATE BETWEEN pr.fecha_inicio AND pr.fecha_fin
ORDER BY pr.fecha_inicio;


-- VISTA: vista_ventas_cliente
-- Muestra el historial de compras por cliente.
CREATE OR REPLACE VIEW vista_ventas_cliente AS
SELECT
    v.id AS id_venta,
    v.fecha,
    v.total,
    u.nombre || ' ' || u.apellido AS cliente,
    u.mail
FROM venta v
JOIN usuario u ON u.mail = v.usuario_mail
ORDER BY v.fecha DESC;


SELECT * FROM vista_mejores_clientes;

