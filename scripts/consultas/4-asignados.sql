


DROP PROCEDURE IF EXISTS consultarAsignados;
DELIMITER $$
CREATE PROCEDURE consultarAsignados(
	codigo_curso INT,
    ciclo VARCHAR(2),
    anio INT,
    seccion VARCHAR(1)
)
DETERMINISTIC
consultar_asignados:BEGIN
	DECLARE cod_habilitado INT;
    
    -- Se almacena el codigo del curso habilitado en la variable cod_habilitado con la funcion validarHabiliAsig
	SELECT validarHabiliAsig(codigo_curso,anio,ciclo,seccion) INTO cod_habilitado;
    IF(NOT cod_habilitado) THEN
		SELECT "Error al consultar estudiantes asignados. No se ha encontrado el curso" AS ERROR;
        LEAVE consultar_asignados;
    END IF;


	SELECT
		e.carnet AS "Carnet", CONCAT(e.nombres," ",e.apellidos) AS "Nombre", e.creditos AS "Creditos"
	FROM
		asignacion as a, estudiante as e
	WHERE a.id_curso_habilitado = cod_habilitado AND a.status = 1 AND
		  a.carnet = e.carnet;
END $$