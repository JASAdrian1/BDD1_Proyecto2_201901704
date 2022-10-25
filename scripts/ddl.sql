CREATE DATABASE IF NOT EXISTS proyecto2_bases;
USE proyecto2_bases;


CREATE TABLE `proyecto2_bases`.`carrera` (
  `id_carrera` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_carrera`));
    
  CREATE TABLE `proyecto2_bases`.`curso` (
  `codigo_curso` INT NOT NULL,
  `nombre` VARCHAR(80) NULL,
  `creditos_necesarios` INT NULL,
  `creditos_valor` INT NULL,
  `obligatorio` TINYINT NULL,
  `id_carrera` INT NULL,
  PRIMARY KEY (`codigo_curso`));
  
  
  CREATE TABLE `proyecto2_bases`.`estudiante` (
  `carnet` INT NOT NULL,
  `nombres` VARCHAR(80) NULL,
  `apellidos` VARCHAR(80) NULL,
  `fecha_nacimiento` DATE NULL,
  `correo` VARCHAR(80) NULL,
  `telefono` INT NULL,
  `direccion` INT NULL,
  `dpi` BIGINT NULL,
  `creditos` INT NULL,
  `fecha_creacion` DATE NULL,
  `id_carrera` INT NULL,
  PRIMARY KEY (`carnet`));
  
  
  CREATE TABLE `proyecto2_bases`.`asignacion` (
  `id_asignacion` INT NOT NULL AUTO_INCREMENT,
  `ciclo` VARCHAR(2) NULL,
  `seccion` VARCHAR(1) NULL,
  `anio` DATE NULL,
  `status` TINYINT NULL,
  `carnet` INT NULL,
  `id_curso_habilitado` INT NULL,
  `nota` INT NULL,
  PRIMARY KEY (`id_asignacion`));


CREATE TABLE `proyecto2_bases`.`nota` (
  `id_nota` INT NOT NULL AUTO_INCREMENT,
  `nota` INT NULL,
  `id_asignacion` INT NULL,
  PRIMARY KEY (`id_nota`));


CREATE TABLE `proyecto2_bases`.`curso_habilitado` (
  `id_curso_habilitado` INT NOT NULL AUTO_INCREMENT,
  `ciclo` VARCHAR(2) NULL,
  `cupo_maximo` INT NULL,
  `seccion` VARCHAR(1) NULL,
  `anio` DATE NULL,
  `cantidad_asignados` INT NULL,
  `docente_registro_siif` INT NULL,
  `codigo_curso` INT NULL,
  PRIMARY KEY (`id_curso_habilitado`));
  
  
  CREATE TABLE `proyecto2_bases`.`horario` (
  `id_horario` INT NOT NULL AUTO_INCREMENT,
  `dia` INT NULL,
  `horario` VARCHAR(30) NULL,
  `id_curso_habilitado` INT NULL,
  PRIMARY KEY (`id_horario`));
  
  
  CREATE TABLE `proyecto2_bases`.`docente` (
  `registro_siif` INT NOT NULL,
  `nombres` VARCHAR(80) NULL,
  `apellidos` VARCHAR(80) NULL,
  `fecha_nacimiento` DATE NULL,
  `correo` VARCHAR(80) NULL,
  `telefono` INT NULL,
  `direccion` VARCHAR(80) NULL,
  `dpi` BIGINT(14) NULL,
  `fecha_creacion` DATE NULL,
  PRIMARY KEY (`registro_siif`));
  
  
  CREATE TABLE `proyecto2_bases`.`acta` (
  `id_acta` INT NOT NULL AUTO_INCREMENT,
  `codigo_curso` INT NULL,
  `ciclo` VARCHAR(2) NULL,
  `seccion` VARCHAR(1) NULL,
  `anio` DATE NULL,
  `fecha_creacion` DATETIME NULL,
  `id_curso_habilitado` INT NULL,
  PRIMARY KEY (`id_acta`));
  
  
  CREATE TABLE `proyecto2_bases`.`historial` (
  `id_historial` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME NULL,
  `descripcion` TEXT NULL,
  `tipo` VARCHAR(40) NULL,
  PRIMARY KEY (`id_historial`));
  
  -- ------------------------------------------------------------------------
  
ALTER TABLE `proyecto2_bases`.`nota` 
ADD INDEX `nota_asignacion_idx` (`id_asignacion` ASC) VISIBLE;
;
ALTER TABLE `proyecto2_bases`.`nota` 
ADD CONSTRAINT `nota_asignacion`
  FOREIGN KEY (`id_asignacion`)
  REFERENCES `proyecto2_bases`.`asignacion` (`id_asignacion`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  

ALTER TABLE `proyecto2_bases`.`curso` 
ADD INDEX `curso_carrera_idx` (`id_carrera` ASC) VISIBLE;
;
ALTER TABLE `proyecto2_bases`.`curso` 
ADD CONSTRAINT `curso_carrera`
  FOREIGN KEY (`id_carrera`)
  REFERENCES `proyecto2_bases`.`carrera` (`id_carrera`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  

ALTER TABLE `proyecto2_bases`.`estudiante` 
ADD INDEX `estudiante_carrera_idx` (`id_carrera` ASC) VISIBLE;
;
ALTER TABLE `proyecto2_bases`.`estudiante` 
ADD CONSTRAINT `estudiante_carrera`
  FOREIGN KEY (`id_carrera`)
  REFERENCES `proyecto2_bases`.`carrera` (`id_carrera`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  

ALTER TABLE `proyecto2_bases`.`asignacion` 
ADD INDEX `asignacion_curso_habilitado_idx` (`id_curso_habilitado` ASC) VISIBLE;
;
ALTER TABLE `proyecto2_bases`.`asignacion` 
ADD CONSTRAINT `asignacion_curso_habilitado`
  FOREIGN KEY (`id_curso_habilitado`)
  REFERENCES `proyecto2_bases`.`curso_habilitado` (`id_curso_habilitado`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `proyecto2_bases`.`asignacion` 
ADD INDEX `asignacion_estudiante_idx` (`carnet` ASC) VISIBLE;
;
ALTER TABLE `proyecto2_bases`.`asignacion` 
ADD CONSTRAINT `asignacion_estudiante`
  FOREIGN KEY (`carnet`)
  REFERENCES `proyecto2_bases`.`estudiante` (`carnet`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  

ALTER TABLE `proyecto2_bases`.`curso_habilitado` 
ADD INDEX `curso_habilitado_docente_idx` (`docente_registro_siif` ASC) VISIBLE,
ADD INDEX `curso_habilitado_curso_idx` (`codigo_curso` ASC) VISIBLE;
;
ALTER TABLE `proyecto2_bases`.`curso_habilitado` 
ADD CONSTRAINT `curso_habilitado_docente`
  FOREIGN KEY (`docente_registro_siif`)
  REFERENCES `proyecto2_bases`.`docente` (`registro_siif`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `curso_habilitado_curso`
  FOREIGN KEY (`codigo_curso`)
  REFERENCES `proyecto2_bases`.`curso` (`codigo_curso`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  
ALTER TABLE `proyecto2_bases`.`horario` 
ADD INDEX `horario_curso_habilitado_idx` (`id_curso_habilitado` ASC) VISIBLE;
;
ALTER TABLE `proyecto2_bases`.`horario` 
ADD CONSTRAINT `horario_curso_habilitado`
  FOREIGN KEY (`id_curso_habilitado`)
  REFERENCES `proyecto2_bases`.`curso_habilitado` (`id_curso_habilitado`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


ALTER TABLE `proyecto2_bases`.`acta` 
ADD INDEX `acta_curso_habilitado_idx` (`id_curso_habilitado` ASC) VISIBLE;
;
ALTER TABLE `proyecto2_bases`.`acta` 
ADD CONSTRAINT `acta_curso_habilitado`
  FOREIGN KEY (`id_curso_habilitado`)
  REFERENCES `proyecto2_bases`.`curso_habilitado` (`id_curso_habilitado`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  
  