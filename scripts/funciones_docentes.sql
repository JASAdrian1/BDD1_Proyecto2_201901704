
DROP PROCEDURE IF EXISTS registrarDocente;
DELIMITER $$
CREATE PROCEDURE registrarDocente(
    IN nombres VARCHAR(80),
    IN apellidos VARCHAR(80),
    IN fecha_nacimiento DATE,
    IN correo VARCHAR(80),
    IN telefono INT,
    IN direccion VARCHAR(80),
    IN dpi BIGINT,
	IN registro_siif BIGINT
)
DETERMINISTIC
agregar_docente:BEGIN
	IF(validarDocenteExiste(registro_siif)) THEN
		SELECT 'Error al registrar docente. El docente ya existe' AS ERROR;
        LEAVE agregar_docente;
	END IF;
    
    IF(NOT validarSoloLetras(nombres)) THEN
		SELECT 'Error al registrar docente. El nombre del estudiante contiene caracateres no validos' AS ERROR;
        LEAVE agregar_docente;
	END IF;
    
	IF(NOT validarSoloLetras(apellidos)) THEN
		SELECT 'Error al registrar docente. El nombre del estudiante contiene caracateres no validos' AS ERROR;
        LEAVE agregar_docente;
	END IF;
    
    IF(NOT validarCorreo(correo)) THEN
		SELECT 'ERROR al registrar docente. El correo no posee un formato valido' AS ERROR;
        LEAVE agregar_docente;
	END IF;
    
    INSERT INTO docente(`nombres`,`apellidos`,`fecha_nacimiento`,`correo`,`telefono`,`direccion`,`dpi`,`fecha_creacion`,`registro_siif`)
	VALUES(nombres,apellidos,fecha_nacimiento,correo,telefono,direccion,dpi,SYSDATE(),registro_siif);
    SELECT 'Docente registrado correctamente' AS MENSAJE;
END $$




DROP FUNCTION IF EXISTS validarDocenteExiste;
DELIMITER $$
CREATE FUNCTION validarDocenteExiste(
	resgistro_siif BIGINT
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
DECLARE existe BOOLEAN;
SELECT exists(SELECT 1 
				FROM docente d
				WHERE d.registro_siif = registro_siif) INTO existe;
RETURN(existe);
END 
$$