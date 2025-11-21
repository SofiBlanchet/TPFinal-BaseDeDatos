
--Función: fn_calcular_total_venta
CREATE OR REPLACE FUNCTION fn_calcular_total_venta(id_venta_param INT)
RETURNS NUMERIC AS $$
DECLARE
total NUMERIC;
BEGIN
SELECT COALESCE(SUM(subtotal),0)
INTO total
FROM detalle_venta
WHERE id_venta = id_venta_param;

RETURN total;
END;
$$ LANGUAGE plpgsql;

--Función: fn_calcular_descuento
CREATE OR REPLACE FUNCTION fn_calcular_descuento(id_variacion_param INT)
RETURNS INT AS $$
DECLARE
descuento_encontrado INT;
BEGIN
SELECT COALESCE(p.descuento, 0)
INTO descuento_encontrado
FROM variaciones v
JOIN producto pr ON pr.id = v.id_producto
JOIN promo_producto pp ON pp.id_producto = pr.id
JOIN promo p ON p.id = pp.id_promo
WHERE v.id = id_variacion_param
AND CURRENT_TIMESTAMP BETWEEN p.fecha_inicio AND p.fecha_fin
LIMIT 1;

RETURN COALESCE(descuento_encontrado, 0);
END;
$$ LANGUAGE plpgsql;

--Función: fn_registrar_venta
CREATE OR REPLACE FUNCTION fn_registrar_venta(mail_usuario_param TEXT, direccion_id_param INT)
RETURNS INT AS $$
DECLARE
    id_venta_creada INT;
    r RECORD;
    descuento_aplicado INT;
    subtotal_calculado NUMERIC(12,2);
    codigo_seguimiento TEXT;
BEGIN
    codigo_seguimiento := 'TRK' || FLOOR(RANDOM() * 100000);

    INSERT INTO venta (usuario_mail, direccion_id, total, nro_seguimiento)
    VALUES (mail_usuario_param, direccion_id_param, 0, codigo_seguimiento)
    RETURNING id INTO id_venta_creada;

    FOR r IN
        SELECT dc.id_variacion, dc.cantidad, dc.precio_unitario
        FROM carrito c
        JOIN detalle_carrito dc ON dc.id_carrito = c.id
        WHERE c.mail_usuario = mail_usuario_param
    LOOP
        descuento_aplicado := fn_calcular_descuento(r.id_variacion);

        subtotal_calculado := (r.precio_unitario * r.cantidad)
                            * (1 - descuento_aplicado / 100.0);

        INSERT INTO detalle_venta (id_venta, id_variacion, cantidad, precio_unitario, descuento, subtotal)
        VALUES (id_venta_creada, r.id_variacion, r.cantidad, r.precio_unitario, descuento_aplicado, subtotal_calculado);
    END LOOP;

    UPDATE venta
    SET total = fn_calcular_total_venta(id_venta_creada)
    WHERE id = id_venta_creada;

    RETURN id_venta_creada;
END;
$$ LANGUAGE plpgsql;



--Función: fn_stock_disponible
CREATE OR REPLACE FUNCTION fn_stock_disponible(id_variacion_param INT)
RETURNS INT AS $$
DECLARE
stock_actual INT;
BEGIN
SELECT stock
INTO stock_actual
FROM variaciones
WHERE id = id_variacion_param;

RETURN stock_actual;
END;
$$ LANGUAGE plpgsql;
