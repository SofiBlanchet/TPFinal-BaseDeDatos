-- triggers

--Trigger: check_estado_venta_trigger
CREATE OR REPLACE FUNCTION check_estado_venta_fn()
RETURNS TRIGGER AS $$
BEGIN
IF NEW.estado = 'Entregado' AND OLD.estado = 'En proceso' THEN
RAISE EXCEPTION 'No se puede pasar de En proceso a Entregado directamente. Debe pasar por Enviado.';
ELSIF OLD.estado = 'Enviado' AND NEW.estado = 'En proceso' THEN
RAISE EXCEPTION 'No se puede volver de Enviado a En proceso.';
ELSIF OLD.estado = 'Entregado' AND NEW.estado <> 'Entregado' THEN
RAISE EXCEPTION 'No se puede cambiar el estado de Entregado a ningún otro estado.';
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_estado_venta_trigger
BEFORE UPDATE ON venta
FOR EACH ROW
EXECUTE FUNCTION check_estado_venta_fn();

--Trigger: update_total_venta_trigger
CREATE OR REPLACE FUNCTION update_total_venta_fn()
RETURNS TRIGGER AS $$
BEGIN
UPDATE venta
SET total = fn_calcular_total_venta(NEW.id_venta)
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_total_venta_trigger
AFTER INSERT OR UPDATE OR DELETE ON detalle_venta
FOR EACH ROW
EXECUTE FUNCTION update_total_venta_fn();

--Trigger: update_stock_variacion_trigger
CREATE OR REPLACE FUNCTION update_stock_variacion_fn()
RETURNS TRIGGER AS $$
BEGIN
IF TG_OP = 'INSERT' THEN
UPDATE variaciones
SET stock = stock - NEW.cantidad
WHERE id = NEW.id_variacion;
ELSIF TG_OP = 'DELETE' THEN
UPDATE variaciones
SET stock = stock + OLD.cantidad
WHERE id = OLD.id_variacion;
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_stock_variacion_trigger
AFTER INSERT OR DELETE ON detalle_venta
FOR EACH ROW
EXECUTE FUNCTION update_stock_variacion_fn();

--Trigger: check_stock_carrito_trigger
CREATE OR REPLACE FUNCTION check_stock_carrito_fn()
RETURNS TRIGGER AS $$
DECLARE
stock_actual INT;
BEGIN
stock_actual := fn_stock_disponible(NEW.id_variacion);

IF NEW.cantidad > stock_actual THEN
RAISE EXCEPTION 'No hay stock suficiente para agregar al carrito.';
END IF;

RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_stock_carrito_trigger
BEFORE INSERT OR UPDATE ON detalle_carrito
FOR EACH ROW
EXECUTE FUNCTION check_stock_carrito_fn();

--Trigger: check_fecha_promo_trigger
CREATE OR REPLACE FUNCTION check_fecha_promo_fn()
RETURNS TRIGGER AS $$
BEGIN
IF NEW.fecha_fin <= NEW.fecha_inicio THEN
RAISE EXCEPTION 'La fecha de fin debe ser mayor que la fecha de inicio.';
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_fecha_promo_trigger
BEFORE INSERT OR UPDATE ON promo
FOR EACH ROW
EXECUTE FUNCTION check_fecha_promo_fn();

--Trigger: promo_descuento_trigger
CREATE OR REPLACE FUNCTION promo_descuento_fn()
RETURNS TRIGGER AS $$
DECLARE
descuento_aplicado INT;
BEGIN
descuento_aplicado := fn_calcular_descuento(NEW.id_variacion);
NEW.descuento := descuento_aplicado;
NEW.subtotal := NEW.precio_unitario * NEW.cantidad * (1 - NEW.descuento / 100.0);
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER promo_descuento_trigger
BEFORE INSERT OR UPDATE ON detalle_venta
FOR EACH ROW
EXECUTE FUNCTION promo_descuento_fn();

--Trigger: check_compra_resena_trigger
CREATE OR REPLACE FUNCTION check_compra_resena_fn()
RETURNS TRIGGER AS $$
DECLARE
existe INT;
BEGIN
SELECT COUNT(*) INTO existe
FROM venta v
JOIN detalle_venta dv ON dv.id_venta = v.id
WHERE v.usuario_mail = NEW.mail_usuario
AND dv.id_variacion IN (SELECT id FROM variaciones WHERE id_producto = NEW.id_producto);

IF existe = 0 THEN
RAISE EXCEPTION 'El usuario no puede reseñar un producto que no compró.';
END IF;

RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_compra_resena_trigger
BEFORE INSERT ON resena
FOR EACH ROW
EXECUTE FUNCTION check_compra_resena_fn();

--Trigger: check_wishlist_duplicate_trigger
CREATE OR REPLACE FUNCTION check_wishlist_duplicate_fn()
RETURNS TRIGGER AS $$
DECLARE
existe INT;
BEGIN
SELECT COUNT(*) INTO existe
FROM wishlist
WHERE mail_usuario = NEW.mail_usuario
AND id_producto = NEW.id_producto;

IF existe > 0 THEN
RAISE EXCEPTION 'El producto ya está en la wishlist de este usuario.';
END IF;

RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_wishlist_duplicate_trigger
BEFORE INSERT ON wishlist
FOR EACH ROW
EXECUTE FUNCTION check_wishlist_duplicate_fn();

--Trigger: prevent_delete_user_trigger
CREATE OR REPLACE FUNCTION prevent_delete_user_fn()
RETURNS TRIGGER AS $$
DECLARE
existe INT;
BEGIN
SELECT COUNT(*) INTO existe
FROM venta
WHERE mail_usuario = OLD.mail;

IF existe > 0 THEN
RAISE EXCEPTION 'No se puede eliminar un usuario con ventas registradas.';
END IF;

RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_delete_user_trigger
BEFORE DELETE ON usuario
FOR EACH ROW
EXECUTE FUNCTION prevent_delete_user_fn();

