

DROP PROCEDURE IF EXISTS desasignarCurso;
DELIMITER $$
CREATE PROCEDURE desasignarCurso(
	codigo_curso INT,
    ciclo VARCHAR(2),
    seccion VARCHAR(1),
    carnet BIGINT
)
DETERMINISTIC
desasignar_curso:BEGIN
	DECLARE cod_habilitado INT;
	DECLARE cantidad_asignados INT;
	-- Se almacena el codigo del curso habilitado en la variable cod_habilitado con la funcion validarHabiliAsig
	SELECT validarHabiliAsig(codigo_curso,YEAR(SYSDATE()),ciclo,seccion) INTO cod_habilitado;
    -- Si la funcion regresa un valor nulo, se reporta que el curso que se busca no se encuentra habilitado
    
	IF(NOT cod_habilitado) THEN
		SELECT "Error al desasignar curso. No se ha encontrado el curso especificado." AS ERROR;
        LEAVE desasignar_curso;
    END IF;
    
    IF(NOT validarExisteEstudiante(carnet))THEN
		SELECT "Error al desasignar curso. El estudiante no se encuntra registrado." AS ERROR;
        LEAVE desasignar_curso;
	END IF;	

	IF(NOT validarAsigRepetida(carnet,cod_habilitado,codigo_curso,ciclo)) THEN
		SELECT "Error al desasignar curso. El estudiante no se encuntra asignado al curso." AS ERROR;
        LEAVE desasignar_curso;
	END IF;
    
    -- Se cambia el status en la tabla asignacion para indicar que el curso ya no se encuentra habilitado
    UPDATE asignacion a SET a.status = 0 WHERE a.carnet = carnet AND a.id_curso_habilitado = cod_habilitado;
    
    -- Se actualiza la cantidad de asignados en la tabla asignacion
    SELECT(SELECT COUNT(*) FROM asignacion a WHERE a.id_curso_habilitado = cod_habilitado
			AND a.status=1) INTO cantidad_asignados;
    UPDATE curso_habilitado c SET c.cantidad_asignados = cantidad_asignados WHERE c.id_curso_habilitado = cod_habilitado;
	
    SELECT "El curso ha sido desasignado correctamente" AS MENSAJE;
    
END $$