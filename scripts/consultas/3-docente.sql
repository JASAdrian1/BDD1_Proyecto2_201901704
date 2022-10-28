


DROP PROCEDURE IF EXISTS consultarDocente;
DELIMITER $$
CREATE PROCEDURE consultarDocente(
	registro_siif_in BIGINT
)
DETERMINISTIC
consultar_docente:BEGIN

	IF(NOT validarDocenteExiste(registro_siif_in)) THEN
		SELECT "Error en la consulta. El docente especificado no se encuntra registrado." AS ERROR;
        LEAVE consultar_docente;
	END IF;
    
    SELECT registro_siif AS "Registro SIIF",
        CONCAT(nombres," ",apellidos) AS "Nombre",
        fecha_nacimiento AS "Fecha de nacimiento",
        correo AS "Correo",
        telefono AS "Teléfono",
        direccion AS "Dirección",
        dpi AS "Número de DPI"
	FROM
		docente
	WHERE
		registro_siif = registro_siif_in ;

END $$
