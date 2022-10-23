DROP FUNCTION validarSoloLetras;
DELIMITER $$
CREATE FUNCTION validarSoloLetras(
	cadena VARCHAR(100)
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
DECLARE soloLetras BOOLEAN;
IF (SELECT REGEXP_INSTR(cadena,'[^a-zA-Z ]')) THEN
	SELECT FALSE INTO soloLetras;
ELSE
	SELECT TRUE INTO soloLetras;
END IF;
RETURN (soloLetras);
END $$



DROP FUNCTION IF EXISTS validarCorreo;
DELIMITER $$
CREATE FUNCTION validarCorreo(
	correo VARCHAR(100)
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
DECLARE correoValido BOOLEAN;
IF (SELECT REGEXP_INSTR(correo,'^[a-zA-Z0-9][a-zA-Z0-9._-]*[a-zA-Z0-9._-]@[a-zA-Z0-9][a-zA-Z0-9._-]*[a-zA-Z0-9]\\.[a-zA-Z]{2,63}$')) THEN
	SELECT TRUE INTO correoValido;
ELSE
	SELECT FALSE INTO correoValido;
END IF;
RETURN (correoValido);
END $$



DROP FUNCTION IF EXISTS validarNumeroPositivo;
DELIMITER $$
CREATE FUNCTION validarNumeroPositivo(
	numero INT
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
DECLARE esPositivo BOOLEAN;
	SELECT TRUE INTO esPositivo;
	IF(numero<0) THEN
		SELECT FALSE INTO esPositivo;
	END IF;
RETURN(esPositivo);
END $$


