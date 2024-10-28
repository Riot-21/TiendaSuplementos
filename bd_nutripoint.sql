create database bd_nutripoint;

create table usuarios(
id_usuario int primary key auto_increment,
nombres varchar(70),
apellidos varchar(70),
email varchar(50),
contraseña varchar(50),
dni int,
telefono int
);


drop table administrador;
create table administrador(
id_admin int primary key auto_increment,
nombres varchar(70),
apellidos varchar(70),
email varchar(50),
contraseña varchar(50),
dni int,
telefono int
);

create table productos(
id_producto int primary key auto_increment,
nombre varchar(100),
descripcion text,
stock int,
marca varchar(40),
preciounit decimal(10,2),
mod_empleo text,
advert text
);

create table categorias(
id_categoria int primary key auto_increment,
categoria varchar(50),
objetivo text
);

create table prodCategoria(
id_producto int,
id_categoria int,
primary key (id_producto, id_categoria),
foreign key (id_producto) references productos(id_producto)
on delete cascade
on update cascade,
foreign key (id_categoria) references categorias(id_categoria)
on delete cascade
on update cascade
);

create table imgProd(
id_img int primary key auto_increment,
imagen varchar(255),
id_producto int,
foreign key (id_producto) references productos(id_producto)
on delete cascade
on update cascade
);

-- consulta para ver productos con sus imagenes
select p.id_producto, p.nombre, p.preciounit ,i.imagen from productos p 
inner join imgProd i on p.id_producto = i.id_producto ;

-- consulta para ver productos con sus categorias
select p.id_producto, p.nombre, p.descripcion, p.preciounit,
c.categoria, c.id_categoria from productos p 
inner join prodCategoria pc on p.id_producto = pc.id_producto
inner join categorias c on pc.id_categoria = c.id_categoria;

SHOW CREATE DATABASE bd_nutripoint;

SHOW TABLE STATUS WHERE Name = 'usuarios';

SHOW VARIABLES LIKE 'character_set%';
SHOW CREATE DATABASE bd_nutripoint;
SHOW CREATE TABLE usuarios;  


drop table imgProd;
select * from prodcategoria;

select * from imgprod;
select * from categorias;
select * from prodcategoria;
select * from productos;
select * from usuarios;
select * from administrador;
select * from usuarios where email = "user3@gmail.com" and contraseña = "contraseña";
INSERT INTO administrador (nombres, apellidos, email, contraseña, dni, telefono) VALUES ("adm1","apellidadmo","passadmin@gmail.com","contraseñadmin",98654,9764564);
drop database bd_nutripoint;