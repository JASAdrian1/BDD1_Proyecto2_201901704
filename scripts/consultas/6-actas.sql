


DROP PROCEDURE IF EXISTS consultarActas;
DELIMITER $$
CREATE PROCEDURE consultarActas(
	codigo_curso INT
)
DETERMINISTIC
consultar_actas:BEGIN
	-- IF(a.nota>60,"APROBADO","DESAPROBADO") AS "Resultado"
    SELECT 
		acta.codigo_curso AS "Codigo de curso",
		ch.seccion AS "Sección",
        CASE ch.ciclo WHEN "1S" THEN "PRIMER SEMESTRE"
					  WHEN "2S" THEN "SEGUNDO SEMESTRE"
					  WHEN "VJ" THEN "VACACIONES DE JUNIO"
					  WHEN "VD" THEN "VACACIONES DE DICIEMBRE"
                      END AS "Ciclo",
		ch.anio AS "Año",
        ch.cantidad_asignados AS "Cantidad estudiantes",
        acta.fecha_creacion AS "Fecha generada"
	FROM
		acta, curso_habilitado as ch
	WHERE acta.id_curso_habilitado = ch.id_curso_habilitado
		  AND acta.codigo_curso = codigo_curso;

END $$


