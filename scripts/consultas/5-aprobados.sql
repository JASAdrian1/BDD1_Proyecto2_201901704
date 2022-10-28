


DROP PROCEDURE IF EXISTS consultarAprobacion;
DELIMITER $$
CREATE PROCEDURE consultarAprobacion(
	codigo_curso INT,
    ciclo VARCHAR(2),
    anio INT,
    seccion VARCHAR(1)
)
DETERMINISTIC
consultar_aprobacion:BEGIN
	DECLARE cod_habilitado INT;
    
    -- Se almacena el codigo del curso habilitado en la variable cod_habilitado con la funcion validarHabiliAsig
	SELECT validarHabiliAsig(codigo_curso,anio,ciclo,seccion) INTO cod_habilitado;
    IF(NOT cod_habilitado) THEN
		SELECT "Error al consultar estudiantes APROBADOS. No se ha encontrado el curso" AS ERROR;
        LEAVE consultar_aprobacion;
    END IF;

	-- IF(cu.obligatorio=0,"Opcional","Obligatorio") AS "Es obligatorio",
	SELECT
		ch.codigo_curso AS "Codigo curso",
		e.carnet AS "Carnet",
        CONCAT(e.nombres," ",e.apellidos) AS "Nombre", 
        IF(a.nota>60,"APROBADO","DESAPROBADO") AS "Resultado"
	FROM
		asignacion as a, estudiante as e, curso_habilitado as ch
	WHERE 
		a.id_curso_habilitado = cod_habilitado 
        AND a.status = 1 
        AND a.carnet = e.carnet
        AND a.id_curso_habilitado = ch.id_curso_habilitado;
END $$










