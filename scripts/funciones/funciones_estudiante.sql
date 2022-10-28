

DROP PROCEDURE IF EXISTS registrarEstudiante;
DELIMITER $$
CREATE PROCEDURE registrarEstudiante(
	IN carnet BIGINT,
    IN nombres VARCHAR(80),
    IN apellidos VARCHAR(80),
    IN fecha_nacimiento DATE,
    IN correo VARCHAR(80),
    IN telefono INT,
    IN direccion VARCHAR(80),
    IN dpi BIGINT,
    IN carrera INT
)
DETERMINISTIC
agregar_estudiante:BEGIN
	IF(validarExisteEstudiante(carnet)) THEN
		SELECT 'Error al registrar estudiante. El usuario ya existe' AS ERROR;
        LEAVE agregar_estudiante;
	END IF;
    
    IF(NOT validarSoloLetras(nombres)) THEN
		SELECT 'Error al registrar estudiante. El nombre del estudiante contiene caracateres no validos' AS ERROR;
        LEAVE agregar_estudiante;
	END IF;
    
	IF(NOT validarSoloLetras(apellidos)) THEN
		SELECT 'Error al registrar estudiante. El nombre del estudiante contiene caracateres no validos' AS ERROR;
        LEAVE agregar_estudiante;
	END IF;
    
    IF(NOT validarCorreo(correo)) THEN
		SELECT 'ERROR al registrar estudiante. El correo no posee un formato valido' AS ERROR;
        LEAVE agregar_estudiante;
	END IF;
    
    INSERT INTO estudiante(`carnet`,`nombres`,`apellidos`,`fecha_nacimiento`,`correo`,`telefono`,`direccion`,`dpi`,`creditos`,`fecha_creacion`,`id_carrera`)
	VALUES(carnet,nombres,apellidos,fecha_nacimiento,correo,telefono,direccion,dpi,0,SYSDATE(),carrera);
    SELECT 'Estudiante registrado correctamente' AS MENSAJE;
END $$



DROP FUNCTION IF EXISTS validarExisteEstudiante;
DELIMITER $$
CREATE FUNCTION validarExisteEstudiante(
	carnet BIGINT
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
DECLARE existe BOOLEAN;
SELECT exists(SELECT 1 
				FROM estudiante e
				WHERE e.carnet = carnet) INTO existe;
RETURN(existe);
END $$
