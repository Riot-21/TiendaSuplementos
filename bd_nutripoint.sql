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
create table administrador(
id_admin int primary key auto_increment,
nombres varchar(70),
apellidos varchar(70),
email varchar(50),
contraseña varchar(50),
dni int,
telefono int
);
INSERT INTO administrador (nombres, apellidos, email, contraseña, dni, telefono) VALUES ("adm1","apellidadmo","admin@gmail.com","123",98654,9764564);


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

create table compra(
id_compra int primary key auto_increment,
fecha date,
total decimal(10,2),
tipo_pago varchar(50),
direccion varchar(100) null,
distrito varchar(50) null,
id_usuario int,
foreign key (id_usuario) references usuarios(id_usuario)
on delete cascade
on update cascade
);

create table detalleCompra(
id_detalle int primary key auto_increment,
item int,
cantidad int,
preciouni decimal(10,2),
subtotal decimal(10,2),
id_producto int,
id_compra int,
foreign key (id_producto) references productos(id_producto)
on delete cascade
on update cascade,
foreign key (id_compra) references compra(id_compra)
on delete cascade
on update cascade
);

create table empresa(
id_empresa int primary key auto_increment,
nombre varchar(50),
ruc_empresa varchar(11),
razonSocial varchar(100)
);

insert into empresa (nombre,ruc_empresa,razonSocial) values ("Nutripoint","11122233344","razon social de la emrpesa");

create table tiendas(
id_tienda int primary key auto_increment,
distrito varchar(50),
direccion varchar(100),
telefono int,
horario varchar (50)
);

insert into tiendas(distrito, direccion, telefono, horario) values("San Isidro","av. kfhsd 432","935426123","9am-10pm");

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

select * from tiendas;
select * from productos;
select * from usuarios;
select * from prodcategoria;
select * from administrador;
select * from imgProd;
select * from categorias;
select * from usuarios where email = "user3@gmail.com" and contraseña = "contraseña";
INSERT INTO usuarios (nombres, apellidos, email, contraseña, dni, telefono) VALUES ("juan","perz","pass3@gmail.com","contraseña",98654,9764564);
drop database bd_nutripoint;