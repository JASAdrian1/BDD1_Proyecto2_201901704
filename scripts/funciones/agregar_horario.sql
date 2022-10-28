

DROP PROCEDURE IF EXISTS agregarHorario;
DELIMITER $$
CREATE PROCEDURE agregarHorario(
	id_curso INT,
    dia INT,
    horario VARCHAR(15)
)
DETERMINISTIC
agregar_horario:BEGIN
	IF(NOT validarCursoHabilitado(id_curso)) THEN
		SELECT "Error al agregar horario. El curso no se encuentra habilitado" AS ERROR;
        LEAVE agregar_horario;
	END IF;
    
    IF(NOT validarNumeroSemana(dia)) THEN
		SELECT "Error al agregar horario. El dia no se encuentra en el rango [1-7]" AS ERROR;
        LEAVE agregar_horario;
	END IF;
    
    INSERT INTO horario(`dia`,`horario`,`id_curso_habilitado`)
    VALUES(dia,horario,id_curso);
    SELECT "Horario agregado exitosamente" AS MENSAJE;
END $$

