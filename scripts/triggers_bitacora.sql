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

