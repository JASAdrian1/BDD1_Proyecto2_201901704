
DROP PROCEDURE IF EXISTS registrarDocente;
DELIMITER $$
CREATE PROCEDURE registrarDocente(
	nombres VARCHAR(80),
    apellidos VARCHAR(80),
    fecha_nacimiento DATE,
    correo VARCHAR(80),
    telefono INT,
    direccion VARCHAR(80),
    dpi BIGINT,
	registro_siif INT
)
DETERMINISTIC
agregar_docente:BEGIN
	IF(validarDocenteExiste(registro_siif)) THEN
		SELECT CONCAT('Error al registrar docente. El docente ya existe ',validarDocenteExiste(registro_siif)," ",registro_siif) AS ERROR;
        LEAVE agregar_docente;
	END IF;
    
    IF(NOT validarSoloLetras(nombres)) THEN
		SELECT 'Error al registrar docente. El nombre del docente contiene caracateres no validos' AS ERROR;
        LEAVE agregar_docente;
	END IF;
    
	IF(NOT validarSoloLetras(apellidos)) THEN
		SELECT 'Error al registrar docente. El nombre del docente contiene caracateres no validos' AS ERROR;
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
	registro_siif INT
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
DECLARE existe BOOLEAN;
SELECT exists(SELECT 1 
				FROM docente d
				WHERE d.registro_siif = registro_siif) INTO existe;
RETURN(existe);
END $$
