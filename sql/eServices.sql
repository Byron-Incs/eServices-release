Drop database if exists eservices;
create database eservices;
use eservices;



CREATE TABLE `Roles` (
  `id_rol` INT AUTO_INCREMENT,
  `rol` VARCHAR(21) ,
  PRIMARY KEY (`id_rol`));
  
  
  CREATE TABLE `Usuario` (
  `id_usuario` INT AUTO_INCREMENT,
  `email` VARCHAR(45) ,
  `nombre` VARCHAR(45) ,
  `apellido_p` VARCHAR(45),
  `apellido_m` VARCHAR(45) ,
  `contrasena` VARCHAR(45) ,
  `foto` VARBINARY(50) ,
  `curp` VARCHAR(45) ,
  `celular` VARCHAR(45) ,
	`colonia` VARCHAR(20) ,
  `calle` VARCHAR(4) ,
  `num_ext` VARCHAR(7) ,
  `num_int` VARCHAR(5) ,
  `codigo_postal` VARCHAR(33) ,
  PRIMARY KEY (`id_usuario`));
  
  
  CREATE TABLE `Compra` (
  `id_compra` INT AUTO_INCREMENT,
  `estado` VARCHAR(45) ,

  PRIMARY KEY (`id_compra`));
  
  
  CREATE TABLE `Servicio` (
  `id_servicio` INT AUTO_INCREMENT,
  `nombreS` VARCHAR(45) ,
  `descripcionS` VARCHAR(1000) ,
  `precio` VARCHAR(4) ,
  `categoria` VARCHAR(100) ,
  
  `fotoS` VARBINARY(50) ,
  PRIMARY KEY (`id_servicio`));
  
  
  CREATE TABLE `Categoria` (
  `id_categoria` INT AUTO_INCREMENT,
  `categoria` VARCHAR(45) ,
  PRIMARY KEY (`id_categoria`));
  
  
  

  CREATE TABLE `Tarjeta` (
  `num_tarjeta` INT AUTO_INCREMENT,
  `ano` varchar(3) ,
  `mes` varchar(3) ,
  `cvv` varchar(3) ,
  `nombre_tar` VARCHAR(45) ,
  PRIMARY KEY (`num_tarjeta`));
  
  
  CREATE TABLE `Review` (
  `id_Review` INT AUTO_INCREMENT,
  `calif_rev` INT(5) ,
  `comentario` VARCHAR(700) ,
  PRIMARY KEY (`id_Review`));
  
  

  
  CREATE TABLE `roles_usuario` (
  `id_rol` INT ,
  `id_usuario` INT ,
  foreign key (id_rol) references Roles (id_rol) on update cascade on delete cascade,
  foreign key (id_usuario) references Usuario (id_usuario) on update cascade on delete cascade);



  
  
   CREATE TABLE `servicio_usuario` (
  `id_usuario` INT ,
  `id_servicio` INT ,
  
  foreign key (id_servicio) references Servicio (id_servicio) on update cascade on delete cascade,
  foreign key (id_usuario) references Usuario (id_usuario) on update cascade on delete cascade);

  
  CREATE TABLE `compra_servicio` (
  `id_compra` INT ,
  `id_servicio` INT ,
  
  foreign key (id_compra) references Compra (id_compra) on update cascade on delete cascade,
  foreign key (id_servicio) references Servicio (id_servicio) on update cascade on delete cascade);
  
  CREATE TABLE `servicio_categoria` (
  `id_servicio` INT ,
  `id_categoria` INT ,
  
  foreign key (id_categoria) references Categoria (id_categoria) on update cascade on delete cascade,
  foreign key (id_servicio) references Servicio (id_servicio) on update cascade on delete cascade);




    
	CREATE TABLE `usuario_tarjeta` (
  `id_usuario` INT ,
  `num_tarjeta` INT ,
  
  foreign key (num_tarjeta) references Tarjeta (num_tarjeta) on update cascade on delete cascade,
  foreign key (id_usuario) references Usuario (id_usuario) on update cascade on delete cascade);

  
  CREATE TABLE `usuario_review` (
  `id_Review` INT ,
  `id_usuario` INT ,
  
  foreign key (id_Review) references Review (id_Review) on update cascade on delete cascade,
  foreign key (id_usuario) references Usuario (id_usuario) on update cascade on delete cascade);

  
  CREATE TABLE `review_servicio` (
  `id_Review` INT ,
  `id_servicio` INT ,
  
  foreign key (id_Review) references Review (id_Review) on update cascade on delete cascade,
  foreign key (id_servicio) references Servicio (id_servicio) on update cascade on delete cascade);


INSERT INTO Roles (rol) VALUES 
("vendedor");

INSERT INTO Roles (rol) VALUES 
("comprador");
