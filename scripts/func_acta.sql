


DROP PROCEDURE IF EXISTS generarActa;
DELIMITER $$
CREATE PROCEDURE generarActa(
	codigo_curso INT,
    ciclo VARCHAR(2),
    seccion VARCHAR(1)
)
DETERMINISTIC
generar_acta:BEGIN
	DECLARE cod_habilitado INT;
    
     -- Se almacena el codigo del curso habilitado en la variable cod_habilitado con la funcion validarHabiliAsig
	SELECT validarHabiliAsig(codigo_curso,YEAR(SYSDATE()),ciclo,seccion) INTO cod_habilitado;
    IF(NOT cod_habilitado) THEN
		SELECT "Error al generar el acta. El curso no se encuentra habilitado." AS ERROR;
        LEAVE generar_acta;
	END IF;
	
    IF(SELECT EXISTS(SELECT 1 FROM asignacion a WHERE a.id_curso_habilitado = cod_habilitado 
														AND a.nota = -1 AND a.status = 1)) THEN
		SELECT "Error al generar el acta. No se ha ingresado la nota de todos los estudiantes asignados" AS ERROR;
        LEAVE generar_acta;
	END IF;
	
    INSERT INTO acta(`codigo_curso`,`fecha_creacion`,`id_curso_habilitado`)
    VALUES(codigo_curso,SYSDATE(),cod_habilitado);
	SELECT "Se ha generado el acta exitosamente." AS MENSAJE;
END $$