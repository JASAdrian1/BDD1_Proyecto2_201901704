DELIMITER $$
CREATE TRIGGER historial 
AFTER INSERT ON estudiante 
FOR EACH ROW 
BEGIN  
INSERT INTO historial(fecha,descripcion,tipo) VALUES (SYSDATE(),"Se ha registrado un nuevo estudiante","INSERT"); 
END $$

DELIMITER $$
CREATE TRIGGER historial_carrera_insert
AFTER INSERT ON carrera 
FOR EACH ROW 
BEGIN  
INSERT INTO historial(fecha,descripcion,tipo) VALUES (SYSDATE(),"Se ha creado una nueva carrera","INSERT"); 
END $$


DELIMITER $$
CREATE TRIGGER historial_docente_insert
AFTER INSERT ON docente 
FOR EACH ROW 
BEGIN  
INSERT INTO historial(fecha,descripcion,tipo) VALUES (SYSDATE(),"Se ha registrado un nuevo docente","INSERT"); 
END $$


DELIMITER $$
CREATE TRIGGER historial_habilitar_insert
AFTER INSERT ON curso_habilitado 
FOR EACH ROW 
BEGIN  
INSERT INTO historial(fecha,descripcion,tipo) VALUES (SYSDATE(),"Se ha habilitado un nuevo curso","INSERT"); 
END $$


DELIMITER $$
CREATE TRIGGER historial_horario_insert
AFTER INSERT ON horario 
FOR EACH ROW 
BEGIN  
INSERT INTO historial(fecha,descripcion,tipo) VALUES (SYSDATE(),"Se ha agregado un nuevo horario","INSERT"); 
END $$

DELIMITER $$
CREATE TRIGGER historial_asignacion_insert
AFTER INSERT ON asignacion 
FOR EACH ROW 
BEGIN  
INSERT INTO historial(fecha,descripcion,tipo) VALUES (SYSDATE(),"Se ha realizado una asignacion","INSERT"); 
END $$

DROP TRIGGER IF EXISTS historial_asignacion_update;
DELIMITER $$
CREATE TRIGGER historial_asignacion_update
AFTER UPDATE ON asignacion 
FOR EACH ROW 
BEGIN  
	IF NOT(NEW.status <=> OLD.status) THEN
		INSERT INTO historial(fecha,descripcion,tipo) VALUES (SYSDATE(),"Se ha realizado una desagsinacion","UPDATE"); 
	END IF;
    IF NOT(NEW.nota <=> OLD.nota) THEN
		INSERT INTO historial(fecha,descripcion,tipo) VALUES (SYSDATE(),"Se ha cargado una nueva nota","UPDATE"); 
	END IF;
END $$





