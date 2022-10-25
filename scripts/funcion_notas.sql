

DROP PROCEDURE IF EXISTS ingresarNota;
DELIMITER $$
CREATE PROCEDURE ingresarNota(
	codigo_curso INT,
    ciclo VARCHAR(2),
    seccion VARCHAR(1),
    carnet BIGINT,
    nota DECIMAL
)
DETERMINISTIC
ingresar_nota:BEGIN
	DECLARE cod_habilitado INT;
    
    -- Se almacena el codigo del curso habilitado en la variable cod_habilitado con la funcion validarHabiliAsig
	SELECT validarHabiliAsig(codigo_curso,YEAR(SYSDATE()),ciclo,seccion) INTO cod_habilitado;
    IF(NOT cod_habilitado) THEN
		SELECT "Error al ingresar nota. El curso no se encuentra habilitado." AS ERROR;
        LEAVE ingresar_nota;
    END IF;
    
    IF(NOT validarExisteEstudiante(carnet))THEN
		SELECT "Error al ingresar nota. El estudiante no se encuntra registrado." AS ERROR;
        LEAVE ingresar_nota;
	END IF;	

	IF(NOT validarNumeroPositivo(ROUND(nota))) THEN
		SELECT "Error al ingresar nota. La nota debe ser un valor positivo." AS ERROR;
        LEAVE ingresar_nota;
	END IF;	

	IF(NOT validarAsigRepetida(carnet,cod_habilitado,codigo_curso,ciclo)) THEN
		SELECT "Error al ingresar nota. El estudiante no se encuntra asignado al curso." AS ERROR;
        LEAVE ingresar_nota;
	END IF;

	-- Se cambia actualiza la nota del estudiante en la tabla asignacion
    UPDATE asignacion a SET a.nota = nota WHERE a.carnet = carnet AND a.id_curso_habilitado = cod_habilitado;

END $$



