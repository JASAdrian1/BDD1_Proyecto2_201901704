

DROP PROCEDURE IF EXISTS consultarPensum;
DELIMITER $$
CREATE PROCEDURE consultarPensum(
	codigo_carrera INT
)
DETERMINISTIC
consultar_pensum:BEGIN

	IF(NOT(SELECT EXISTS(SELECT 1 FROM carrera c WHERE c.id_carrera = codigo_carrera))) THEN
		SELECT "Error al realizar la consulta. No existe una carreara con el id especificado." AS ERROR;
        LEAVE consultar_pensum;
	END IF;


	SELECT 
		cu.codigo_curso AS "Codigo del curso",
        cu.nombre AS "Nombre",
        IF(cu.obligatorio=0,"Opcional","Obligatorio") AS "Es obligatorio",
		cu.creditos_necesarios AS "Creditos necesarios"
    FROM 
		curso as cu
    WHERE cu.id_carrera = codigo_carrera OR cu.id_carrera = 0;

END $$











