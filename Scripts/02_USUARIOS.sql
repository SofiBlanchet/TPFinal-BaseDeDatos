-- roles

-- Creación de usuarios
CREATE USER admin_bd WITH PASSWORD 'admin123';
CREATE USER cliente_bd WITH PASSWORD 'cliente123';
CREATE USER invitado_bd WITH PASSWORD 'invitado123';

-- Permisos del administrador (control total)
GRANT ALL PRIVILEGES ON DATABASE "TP_final" TO admin_bd;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin_bd;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO admin_bd;

-- Permisos del usuario cliente (permisos limitados)
GRANT CONNECT ON DATABASE "TP_final" TO cliente_bd;
GRANT SELECT ON producto, variaciones, promo, promo_producto TO cliente_bd;
GRANT SELECT, INSERT, UPDATE ON carrito, detalle_carrito, wishlist, resena, venta, detalle_venta TO cliente_bd;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO cliente_bd;

-- Permisos del invitado (solo lectura)
GRANT CONNECT ON DATABASE "TP_final" TO invitado_bd;
GRANT SELECT ON producto, variaciones, promo, promo_producto TO invitado_bd;