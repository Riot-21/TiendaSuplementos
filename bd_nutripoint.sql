-- =======================================
-- CREACIÓN DE LA BASE DE DATOS Y TABLAS
-- =======================================
-- Crear la base de datos
CREATE DATABASE bd_nutripoint;

-- Seleccionar la base de datos
USE bd_nutripoint;

-- Crear tabla de usuarios
CREATE TABLE usuarios (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nombres VARCHAR(70),
    apellidos VARCHAR(70),
    email VARCHAR(50),
    contraseña VARCHAR(80),
    dni INT,
    telefono INT,
    estado VARCHAR(30)
);

-- Crear tabla de administradores
CREATE TABLE administrador (
    id_admin INT PRIMARY KEY AUTO_INCREMENT,
    nombres VARCHAR(70),
    apellidos VARCHAR(70),
    email VARCHAR(50),
    contraseña VARCHAR(50),
    dni INT,
    telefono INT,
    estado VARCHAR(30)
);

-- Insertar datos de prueba en la tabla administrador
INSERT INTO administrador (nombres, apellidos, email, contraseña, dni, telefono, estado) 
VALUES ("adm1", "apellidadmo", "admin@gmail.com", "123", 98654345, 976456412, 'activo');

-- Crear tabla de productos
CREATE TABLE productos (
    id_producto INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    descripcion TEXT,
    stock INT,
    marca VARCHAR(40),
    preciounit DECIMAL(10,2),
    mod_empleo TEXT,
    advert TEXT,
    fechav DATE,
    estado VARCHAR(30)
);

-- Crear tabla de categorías
CREATE TABLE categorias (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    categoria VARCHAR(50),
    objetivo TEXT
);

-- Crear tabla de relación entre productos y categorías (muchos a muchos)
CREATE TABLE prodCategoria (
    id_producto INT,
    id_categoria INT,
    PRIMARY KEY (id_producto, id_categoria),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- Crear tabla para imágenes de productos
CREATE TABLE imgProd (
    id_img INT PRIMARY KEY AUTO_INCREMENT,
    imagen VARCHAR(255),
    id_producto INT,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- Crear tabla de compras
CREATE TABLE compra (
    id_compra INT PRIMARY KEY AUTO_INCREMENT,
    fecha DATE,
    total DECIMAL(10,2),
    tipo_pago VARCHAR(50),
    direccion VARCHAR(100),
    distrito VARCHAR(50),
    estado VARCHAR(20),
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- Crear tabla de detalle de compras
CREATE TABLE detalleCompra (
    id_detalle INT PRIMARY KEY AUTO_INCREMENT,
    item INT,
    cantidad INT,
    preciouni DECIMAL(10,2),
    subtotal DECIMAL(10,2),
    id_producto INT,
    id_compra INT,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_compra) REFERENCES compra(id_compra)
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- Crear tabla de empresas
CREATE TABLE empresa (
    id_empresa INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50),
    ruc_empresa VARCHAR(11),
    razonSocial VARCHAR(100)
);

-- Insertar datos de prueba en empresa
INSERT INTO empresa (nombre, ruc_empresa, razonSocial) 
VALUES ("Nutripoint", "11122233344", "razon social de la empresa");

-- Crear tabla de tiendas
CREATE TABLE tiendas (
    id_tienda INT PRIMARY KEY AUTO_INCREMENT,
    distrito VARCHAR(50),
    direccion VARCHAR(100),
    telefono INT,
    horario VARCHAR(50),
    foto VARCHAR(255)
);


-- Crear tabla para códigos de verificación
CREATE TABLE codigo_verificacion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    codigo VARCHAR(6) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_expiracion DATETIME,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- =======================================
-- CONSULTAS GENERALES
-- =======================================

-- Seleccionar todas las tablas
SELECT * FROM empresa;
SELECT * FROM tiendas;
SELECT * FROM compra;
SELECT * FROM productos;
SELECT * FROM usuarios;
SELECT * FROM prodCategoria;
SELECT * FROM administrador;
SELECT * FROM imgProd;
SELECT * FROM categorias;
SELECT * FROM codigo_verificacion;

-- Buscar un usuario específico
SELECT * FROM usuarios WHERE email = "user3@gmail.com" AND contraseña = "contraseña";

-- Insertar un nuevo usuario
INSERT INTO usuarios (nombres, apellidos, email, contraseña, dni, telefono) 
VALUES ("juan", "perz", "pass3@gmail.com", "contraseña", 98654, 9764564);

-- =======================================
-- CONSULTAS DE PRODUCTOS
-- =======================================

-- Productos con sus imágenes
SELECT p.id_producto, p.nombre, p.preciounit, i.imagen 
FROM productos p 
INNER JOIN imgProd i ON p.id_producto = i.id_producto;

-- Productos con sus categorías
SELECT p.id_producto, p.nombre, p.descripcion, p.preciounit, c.categoria, c.id_categoria 
FROM productos p 
INNER JOIN prodCategoria pc ON p.id_producto = pc.id_producto
INNER JOIN categorias c ON pc.id_categoria = c.id_categoria;

-- Productos más baratos
SELECT p.id_producto, p.nombre, p.preciounit, p.stock, 
       (SELECT i.imagen 
        FROM imgProd i 
        WHERE i.id_producto = p.id_producto 
        LIMIT 1) AS imagen 
FROM productos p
WHERE p.stock > 0
ORDER BY p.preciounit ASC
LIMIT 3;

-- Productos más vendidos
SELECT p.id_producto, p.nombre, p.preciounit, p.stock, dc.cantidad,
       (SELECT i.imagen 
        FROM imgProd i 
        WHERE i.id_producto = p.id_producto 
        LIMIT 1) AS imagen
FROM productos p
INNER JOIN detalleCompra dc ON p.id_producto = dc.id_producto
WHERE p.stock > 0
GROUP BY p.id_producto, p.nombre, p.preciounit, p.stock
ORDER BY SUM(dc.cantidad) DESC;

-- Productos aleatorios
SELECT p.id_producto, p.nombre, p.preciounit, p.stock, 
       (SELECT i.imagen 
        FROM imgProd i 
        WHERE i.id_producto = p.id_producto 
        LIMIT 1) AS imagen 
FROM productos p
WHERE p.stock > 0
ORDER BY RAND()
LIMIT 3;

-- =======================================
-- CONSULTAS DE USUARIOS
-- =======================================

-- Usuarios más activos
SELECT u.id_usuario AS ID, u.nombres AS Nombres, u.apellidos AS Apellidos, 
       u.dni AS DNI, COUNT(c.id_compra) AS Numero_Compras, 
       IFNULL(SUM(c.total), 0) AS Total_Compras
FROM usuarios u
LEFT JOIN compra c ON u.id_usuario = c.id_usuario
GROUP BY u.id_usuario, u.nombres, u.apellidos, u.dni
ORDER BY Numero_Compras DESC, Total_Compras DESC;

-- Eliminar un usuario
DELETE FROM usuarios WHERE id_usuario = 1;
