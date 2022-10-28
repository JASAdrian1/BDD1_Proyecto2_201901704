
DROP PROCEDURE IF EXISTS crearCarrera;
DELIMITER $$
CREATE PROCEDURE crearCarrera(
	IN nombre VARCHAR(80)
)
DETERMINISTIC
crear_carrera:BEGIN
	IF(NOT validarSoloLetras(nombre)) THEN
		SELECT "Error al crear carrera. El nombre incluye un caracter invalido" AS ERROR;
		LEAVE crear_carrera;
	END IF;
    
    INSERT INTO carrera(nombre)VALUES(nombre);
	SELECT "Se ha creado la carrera exitosamente";
END $$


DROP FUNCTION IF EXISTS validarCarreraExiste;
DELIMITER $$
CREATE FUNCTION validarCarreraExiste(
	id_carrera INT
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
	DECLARE carreraExiste BOOLEAN;
	SELECT EXISTS(SELECT 1 FROM carrera c WHERE c.id_carrera = id_carrera) INTO carreraExiste;
	RETURN(carreraExiste);
END $$

