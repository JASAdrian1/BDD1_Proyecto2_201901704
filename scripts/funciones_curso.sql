


DROP PROCEDURE IF EXISTS crearCurso;
DELIMITER $$
CREATE PROCEDURE crearCurso(
	IN codigo_curso INT,
    IN nombre VARCHAR(80),
    IN creditos_necesarios INT,
    IN creditos_valor INT,
    IN id_carrera INT,
    IN obligatorio BOOLEAN
)
DETERMINISTIC
crear_curso:BEGIN
	IF(validarCursoExiste(codigo_curso)) THEN
		SELECT 'Error al crear curso. Ya existe un curso registrado con el codigo utilizado' AS ERROR;
		LEAVE crear_curso;
	END IF;
    
    IF(NOT validarNumeroPositivo(creditos_necesarios)) THEN
		SELECT 'Error al crear curso. El numero de creditos necesarios debe ser positivo' AS ERROR;
        LEAVE crear_curso;
    END IF;
    
    IF(NOT validarNumeroPositivo(creditos_valor)) THEN
		SELECT 'Error al crear curso. El numero de creditos que otorga debe ser positivo' AS ERROR;
        LEAVE crear_curso;
    END IF;
    
    
    IF(NOT validarCarreraExiste(id_carrera)) THEN
		SELECT 'Error al crear curso. La carrera a la que pertenece el curso no existe' AS  ERROR;
        LEAVE crear_curso;
    END IF;
    
    INSERT INTO curso(`codigo_curso`,`nombre`,`creditos_necesarios`,`creditos_valor`,`obligatorio`,`id_carrera`)
    VALUES(codigo_curso,nombre,creditos_necesarios,creditos_valor,obligatorio,id_carrera);
    SELECT 'Curso creado exitosamente' AS MENSAJE;
END $$



DROP FUNCTION IF EXISTS validarCursoExiste;
DELIMITER $$
CREATE FUNCTION validarCursoExiste(
	codigo_curso INT
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
	DECLARE cursoExiste BOOLEAN;
	SELECT EXISTS(SELECT 1 FROM curso c WHERE c.codigo_curso = codigo_curso) INTO cursoExiste;
	RETURN(cursoExiste);
END $$
