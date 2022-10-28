


DROP PROCEDURE IF EXISTS consultarDesasignacion;
DELIMITER $$
CREATE PROCEDURE consultarDesasignacion(
	codigo_curso INT,
    ciclo VARCHAR(2),
    anio INT,
    seccion VARCHAR(1)
)
DETERMINISTIC
consultar_des:BEGIN

	DECLARE cod_habilitado INT;
    DECLARE est_cursaron INT;
    DECLARE est_desasignados INT;
	-- Se almacena el codigo del curso habilitado en la variable cod_habilitado con la funcion validarHabiliAsig
	SELECT validarHabiliAsig(codigo_curso,anio,ciclo,seccion) INTO cod_habilitado;
    IF(NOT cod_habilitado) THEN
		SELECT "Error al consultar estudiantes DESASIGNADOS. No se ha encontrado el curso" AS ERROR;
        LEAVE consultar_des;
    END IF;
    
    SELECT COUNT(*) FROM asignacion a WHERE a.id_curso_habilitado = cod_habilitado  INTO est_cursaron;
    SELECT COUNT(*) FROM asignacion a WHERE a.id_curso_habilitado = cod_habilitado AND a.status = 0 INTO est_desasignados;

	SELECT
		acta.codigo_curso AS "Codigo del curso",
        ch.seccion AS "Seccion",
        CASE ch.ciclo WHEN "1S" THEN "PRIMER SEMESTRE"
					  WHEN "2S" THEN "SEGUNDO SEMESTRE"
					  WHEN "VJ" THEN "VACACIONES DE JUNIO"
					  WHEN "VD" THEN "VACACIONES DE DICIEMBRE"
                      END AS "Ciclo",
		ch.anio AS "Año",
        est_cursaron AS "Estudiantes llevaron curso",
        est_desasignados AS "Estidiantes desasignados",
        TRUNCATE(est_desasignados/est_cursaron*100,2) AS "Tasa de desasignados (%)"
	FROM
		curso_habilitado as ch, acta
	WHERE
		acta.id_curso_habilitado = cod_habilitado AND
        ch.id_curso_habilitado = acta.id_curso_habilitado;
        

END $$

