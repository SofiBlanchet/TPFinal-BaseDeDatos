-- creación de tipos

CREATE TYPE rol_usuario AS ENUM ('Admin', 'Cliente');
CREATE TYPE estado_venta AS ENUM ('En proceso', 'Enviado','Entregado');
CREATE TYPE talle AS ENUM ('XS','S','M','L','XL','XXL','XXXL','4XL');
CREATE TYPE materiales AS ENUM ('Jean','Algodón','Lino');
CREATE TYPE colores AS ENUM ('Blanco','Negro','Gris','Beige','Marron','Azul','Celeste','Verde','Amarillo','Rosa','Rojo');

CREATE TABLE direccion (
id SERIAL PRIMARY KEY,
calle VARCHAR (50) NOT NULL,
numero VARCHAR (20) NOT NULL,
cp VARCHAR (10) NOT NULL
);

CREATE TABLE usuario (
mail VARCHAR (50) PRIMARY KEY,
nombre VARCHAR (30) NOT NULL,
apellido VARCHAR (30) NOT NULL,
rol rol_usuario NOT NULL
);

CREATE TABLE marca (
ID SERIAL PRIMARY KEY,
nombre VARCHAR (50) NOT NULL
);

CREATE TABLE compra_proveedor (
id SERIAL PRIMARY KEY,
proveedor VARCHAR (50) NOT NULL,
total NUMERIC (12,2) NOT NULL CHECK (total > 0)
);

CREATE TABLE promo (
id SERIAL PRIMARY KEY,
nombre VARCHAR (30) NOT NULL,
descuento INT NOT NULL CHECK (descuento >= 0 AND descuento <= 100),
fecha_inicio TIMESTAMPTZ,
fecha_fin TIMESTAMPTZ CHECK (fecha_fin>fecha_inicio)
);

CREATE TABLE producto (
id SERIAL PRIMARY KEY,
nombre VARCHAR(30) NOT NULL,
descripcion TEXT NOT NULL,
material materiales NOT NULL,
precio NUMERIC(12,2) NOT NULL CHECK (precio >= 0),
id_marca INT NOT NULL,

CONSTRAINT fk_producto_marca
FOREIGN KEY (id_marca)
REFERENCES marca(id)
);

CREATE TABLE variaciones (
id SERIAL PRIMARY KEY,
talle talle NOT NULL,
color colores NOT NULL,
stock INT NOT NULL CHECK (stock >= 0),
id_producto INT NOT NULL,
id_compra INT NOT NULL,

CONSTRAINT fk_variaciones_producto
FOREIGN KEY (id_producto)
REFERENCES producto(id),

CONSTRAINT fk_variaciones_compra
FOREIGN KEY (id_compra)
REFERENCES compra_proveedor(id)
);

CREATE TABLE promo_producto (
id SERIAL PRIMARY KEY,
activo BOOLEAN NOT NULL,
id_promo INT NOT NULL,
id_producto INT NOT NULL,

CONSTRAINT fk_promoproducto_promo
FOREIGN KEY (id_promo)
REFERENCES promo (id),

CONSTRAINT fk_promoproducto_producto
FOREIGN KEY (id_producto)
REFERENCES producto(id)
);


CREATE TABLE direccion_usuario (
id SERIAL PRIMARY KEY,
id_direccion INT NOT NULL,
mail_usuario VARCHAR(50) NOT NULL,

CONSTRAINT fk_du_direccion
FOREIGN KEY (id_direccion)
REFERENCES direccion(id),

CONSTRAINT fk_du_usuario
FOREIGN KEY (mail_usuario)
REFERENCES usuario(mail)
);

CREATE TABLE carrito (
id SERIAL PRIMARY KEY,
fecha_creacion TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
mail_usuario VARCHAR(50) NOT NULL,

CONSTRAINT fk_carrito_usuario
FOREIGN KEY (mail_usuario)
REFERENCES usuario(mail)
);

CREATE TABLE detalle_carrito (
id SERIAL PRIMARY KEY,
cantidad INT NOT NULL CHECK (cantidad > 0),
precio_unitario NUMERIC(12,2) NOT NULL CHECK (precio_unitario > 0),
id_carrito INT NOT NULL,
id_variacion INT NOT NULL,

CONSTRAINT fk_detallecarrito_carrito
FOREIGN KEY (id_carrito)
REFERENCES carrito(id),

CONSTRAINT fk_detallecarrito_variaciones
FOREIGN KEY (id_variacion)
REFERENCES variaciones(id)
);


CREATE TABLE venta (
id SERIAL PRIMARY KEY,
fecha TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
estado estado_venta NOT NULL DEFAULT 'En proceso',
total NUMERIC(12,2) NOT NULL CHECK (total >= 0),
nro_seguimiento VARCHAR(50) NOT NULL,
usuario_mail VARCHAR(50) NOT NULL,
direccion_id INT NOT NULL,

CONSTRAINT fk_venta_usuario
FOREIGN KEY (usuario_mail)
REFERENCES usuario(mail),

CONSTRAINT fk_venta_direccion
FOREIGN KEY (direccion_id)
REFERENCES direccion(id)
);


CREATE TABLE detalle_venta (
id SERIAL PRIMARY KEY,
cantidad INT NOT NULL CHECK (cantidad > 0),
precio_unitario NUMERIC(12,2) NOT NULL CHECK (precio_unitario > 0),
descuento INT NOT NULL CHECK (descuento >= 0 AND descuento <= 100),
subtotal NUMERIC(12,2) NOT NULL CHECK (subtotal >= 0),
id_venta INT NOT NULL,
id_variacion INT NOT NULL,

CONSTRAINT fk_detalleventa_venta
FOREIGN KEY (id_venta)
REFERENCES venta(id),

CONSTRAINT fk_detalleventa_variacion
FOREIGN KEY (id_variacion)
REFERENCES variaciones(id)
);

CREATE TABLE wishlist (
id SERIAL PRIMARY KEY,
fecha_creacion TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
mail_usuario VARCHAR(50) NOT NULL,
id_producto INT NOT NULL,

CONSTRAINT fk_wishlist_usuario
FOREIGN KEY (mail_usuario)
REFERENCES usuario(mail),

CONSTRAINT fk_wishlist_producto
FOREIGN KEY (id_producto)
REFERENCES producto(id)
);

CREATE TABLE resena (
id SERIAL PRIMARY KEY,
comentario TEXT NOT NULL,
valoracion INT NOT NULL CHECK (valoracion >= 1 AND valoracion <= 5),
fecha TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
id_producto INT NOT NULL,
mail_usuario VARCHAR(50) NOT NULL,

CONSTRAINT fk_resena_producto
FOREIGN KEY (id_producto)
REFERENCES producto(id),

CONSTRAINT fk_resena_usuario
FOREIGN KEY (mail_usuario)
REFERENCES usuario(mail)
);




