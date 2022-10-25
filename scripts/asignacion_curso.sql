

DROP PROCEDURE IF EXISTS asignarCurso;
DELIMITER $$
CREATE PROCEDURE asignarCurso(
	codigo_curso INT,
    ciclo VARCHAR(2),
    seccion VARCHAR(1),
    carnet BIGINT
)
DETERMINISTIC
asignar_curso:BEGIN

DECLARE cod_habilitado INT;
DECLARE cantidad_asignados INT;
	-- Se almacena el codigo del curso habilitado en la variable cod_habilitado con la funcion validarHabiliAsig
	SELECT validarHabiliAsig(codigo_curso,YEAR(SYSDATE()),ciclo,seccion) INTO cod_habilitado;
    -- Si la funcion regresa un valor nulo, se reporta que el curso que se busca no se encuentra habilitado
    
	IF(NOT cod_habilitado) THEN
		SELECT "Error al asignar curso. El curso no se encuentra habilitado." AS ERROR;
        LEAVE asignar_curso;
    END IF;
    
    IF(NOT validarExisteEstudiante(carnet))THEN
		SELECT "Error al asignar curso. El estudiante no se encuntra registrado." AS ERROR;
        LEAVE asignar_curso;
	END IF;	
    
    IF(NOT validarCredNecesarios(codigo_curso,carnet)) THEN
		SELECT "Error al asgnar curso. El estudiante no cuenta con los creditos necesarios." AS ERROR;
        LEAVE asignar_curso;
	END IF;
    
    IF(NOT validarCarreraCursoEst(codigo_curso,carnet)) THEN
		SELECT "Error al asignar curso. El estudiante no puede asignarse cursos de otra carrera." AS ERROR;
        LEAVE asignar_curso;
	END IF;
    
    IF(validarAsigRepetida(carnet,cod_habilitado,codigo_curso,ciclo)) THEN
		-- Si se encuntra el registro de la asignacion en la tabla asignacion pero con el estatus 0, unicamente se actualiza el status
		IF((SELECT a.status FROM asignacion a WHERE a.carnet = carnet AND a.id_curso_habilitado = cod_habilitado) = 0) THEN
			UPDATE asignacion a SET a.status = 1 WHERE a.carnet = carnet AND a.id_curso_habilitado = cod_habilitado;
            SELECT "La asignacion ha sido exitosa" AS MENSAJE;
            LEAVE asignar_curso;
        END IF;
		SELECT "Error al asignarse. El estudiante ya se encuentra asignado en alguna de las secciones del curso";
        LEAVE asignar_curso;
    END IF;
    
    INSERT INTO asignacion(`carnet`,`status`,`id_curso_habilitado`,`nota`)
    VALUES(carnet,1,cod_habilitado,0);
    -- Se actualiza la cantidad de asignados en la tabla curso_habilitado
    SELECT(SELECT COUNT(*) FROM asignacion a WHERE a.id_curso_habilitado = cod_habilitado
			AND a.status=1) INTO cantidad_asignados;
    UPDATE curso_habilitado c SET c.cantidad_asignados = cantidad_asignados WHERE c.id_curso_habilitado = cod_habilitado;
		
	SELECT "La asignacion ha sido exitosa" AS MENSAJE;
END $$



DROP FUNCTION IF EXISTS validarHabiliAsig;
DELIMITER $$
CREATE FUNCTION validarHabiliAsig(
	codigo_curso INT,
    anio INT,
    ciclo VARCHAR(2),
    seccion VARCHAR(1)
)
RETURNS INT
DETERMINISTIC
BEGIN
DECLARE habilitado INT;
	IF(validarCursoExiste(codigo_curso)) THEN
		SELECT(SELECT c.id_curso_habilitado FROM curso_habilitado c 
							   WHERE c.ciclo = ciclo AND c.anio = anio AND c.seccion = seccion and c.codigo_curso = codigo_curso) 
		INTO habilitado;
    ELSE 
		SELECT FALSE INTO habilitado;
    END IF;
RETURN(habilitado);
END $$

SELECT validarHabiliAsig(116,2023,"1S","A");
SELECT * FROM proyecto2_bases.curso_habilitado;

-- -------------------------------------------------------------------

DROP FUNCTION IF EXISTS validarCredNecesarios;
DELIMITER $$
CREATE FUNCTION validarCredNecesarios(
	codigo_curso INT,
    carnet INT
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
DECLARE valido INT;
	SELECT FALSE INTO valido;
	IF((SELECT c.creditos_necesarios FROM curso c WHERE c.codigo_curso = codigo_curso) <= 
		(SELECT e.creditos FROM estudiante e WHERE e.carnet = carnet)) THEN
		SELECT TRUE INTO valido;
	END IF;
RETURN(valido);
END $$

SELECT validarCredNecesarios(774,201802214);


-- ------------------------------------------------------------------
DROP FUNCTION IF EXISTS validarCarreraCursoEst;
DELIMITER $$
CREATE FUNCTION validarCarreraCursoEst(
	codigo_curso INT,
    carnet INT
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
	DECLARE valido BOOLEAN;
	SELECT FALSE INTO valido;
	IF(((SELECT c.id_carrera FROM curso c WHERE c.codigo_curso = codigo_curso) = 
		(SELECT e.id_carrera FROM estudiante e WHERE e.carnet = carnet)) 
        OR
        ((SELECT c.id_carrera FROM curso c WHERE c.codigo_curso = codigo_curso) = 0)) THEN
			SELECT TRUE INTO valido;
	END IF;
RETURN(valido);
END $$

SELECT validarCarreraCursoEst(222,201901704);


-- --------------------------------------------------------------
DROP FUNCTION IF EXISTS validarAsigRepetida;
DELIMITER $$
CREATE FUNCTION validarAsigRepetida(
	carnet INT,
    id_curso_habilitado INT,
    codigo_curso INT,
    ciclo VARCHAR(2)
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
	DECLARE repetido BOOLEAN;
	SELECT EXISTS(SELECT 1 FROM asignacion AS a, curso_habilitado AS ch 
					WHERE a.carnet = carnet 
                    AND ch.id_curso_habilitado = a.id_curso_habilitado
					AND ch.ciclo = ciclo AND ch.codigo_curso = codigo_curso) INTO repetido;
RETURN(repetido);
END $$


SELECT validarAsigRepetida(201901704,1,774,"1S");



DROP FUNCTION IF EXISTS validarEstudianteEstaAsignado;
DELIMITER $$
CREATE FUNCTION validarEstudianteEstaAsignado(
	carnet INT,
    id_curso_habilitado INT,
    codigo_curso INT,
    ciclo VARCHAR(2)
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
	DECLARE repetido BOOLEAN;
	SELECT EXISTS(SELECT 1 FROM asignacion AS a, curso_habilitado AS ch 
					WHERE a.carnet = carnet 
                    AND ch.id_curso_habilitado = a.id_curso_habilitado
					AND ch.ciclo = ciclo AND ch.codigo_curso = codigo_curso AND a.status = 1) INTO repetido;
RETURN(repetido);
END $$


