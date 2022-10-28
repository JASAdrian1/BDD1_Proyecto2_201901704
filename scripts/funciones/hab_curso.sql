


DROP PROCEDURE IF EXISTS habilitarCurso;
DELIMITER $$
CREATE PROCEDURE habilitarCurso(
	codigo_curso INT,
    ciclo VARCHAR(2),
    id_docente BIGINT,
    cupo_maximo INT,
    seccion VARCHAR(1)
)
DETERMINISTIC
habilitar_curso:BEGIN

	IF(NOT validarCicloValido(ciclo)) THEN 
		SELECT "Error al habilitar curso. El ciclo ingresado no es valido" AS ERROR;
        LEAVE habilitar_curso;
    END IF;

	IF(validarSeccionExiste(ciclo,seccion,codigo_curso)) THEN
		SELECT "Error al habilitar curso. En el ciclo especificado, ya se encuntra la seccion del curso habilitado" AS ERROR;
        LEAVE habilitar_curso;
    END IF;
    
    
    INSERT INTO curso_habilitado(`ciclo`,`cupo_maximo`,`seccion`,`anio`,`cantidad_asignados`,`docente_registro_siif`,`codigo_curso`)
    VALUES(ciclo,cupo_maximo,seccion,YEAR(SYSDATE()),0,id_docente,codigo_curso);
    SELECT "Curso habilitado exitosamente" AS MENSAJE;
END $$


DROP FUNCTION IF EXISTS validarSeccionExiste;
DELIMITER $$
CREATE FUNCTION validarSeccionExiste(
	ciclo VARCHAR(2),
    seccion VARCHAR(1),
    codigo_curso INT
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN 
DECLARE existe BOOLEAN;
SELECT exists(SELECT 1 
				FROM curso_habilitado c
				WHERE c.codigo_curso = codigo_curso AND c.ciclo = ciclo AND c.seccion = seccion) INTO existe;
RETURN(existe);
END $$


DROP FUNCTION IF EXISTS validarCursoHabilitado;
DELIMITER $$
CREATE FUNCTION validarCursoHabilitado(
	id_curso INT
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN 
DECLARE existe BOOLEAN;
SELECT exists(SELECT 1 
				FROM curso_habilitado c
				WHERE c.id_curso_habilitado = id_curso) INTO existe;
RETURN(existe);
END $$
