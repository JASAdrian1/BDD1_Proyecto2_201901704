

DROP PROCEDURE IF EXISTS consultarEstudiante;
DELIMITER $$
CREATE PROCEDURE consultarEstudiante(
	carnet_in BIGINT
)
DETERMINISTIC
consultar_estudiante:BEGIN

	IF(NOT validarExisteEstudiante(carnet_in)) THEN
		SELECT "Error en la consulta. El estudiante especificado no se encuntra registrado." AS ERROR;
        LEAVE consultar_estudiante;
	END IF;

	SELECT 
		carnet AS "Carnet",
        CONCAT(nombres," ",apellidos) AS "Nombre",
        fecha_nacimiento AS "Fecha de nacimiento",
        correo AS "Correo",
        telefono AS "Teléfono",
        direccion AS "Dirección",
        dpi AS "Número de DPI",
        c.nombre AS "Carrera",
        creditos AS "Creditos"
	FROM
		estudiante e, carrera c
	WHERE c.id_carrera = e.id_carrera AND
		carnet=carnet_in;
END $$