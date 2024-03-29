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


DROP FUNCTION IF EXISTS validarCicloValido;
DELIMITER $$
CREATE FUNCTION validarCicloValido(
	ciclo VARCHAR(2)
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
DECLARE nombreValido BOOLEAN;
IF (ciclo ="1S" OR ciclo="2S" OR ciclo="VJ" OR ciclo="VD") THEN
	SELECT TRUE INTO nombreValido;
ELSE
	SELECT FALSE INTO nombreValido;
END IF;
RETURN (nombreValido);
END $$


DROP FUNCTION IF EXISTS validarNumeroSemana;
DELIMITER $$
CREATE FUNCTION validarNumeroSemana(
	numero INT
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
DECLARE numeroValido BOOLEAN;
	SELECT TRUE INTO numeroValido;
	IF(numero<0 OR numero>7) THEN
		SELECT FALSE INTO numeroValido;
	END IF;
RETURN(numeroValido);
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


DROP FUNCTION IF EXISTS validarNotaValida;
DELIMITER $$
CREATE FUNCTION validarNotaValida(
	numero INT
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
DECLARE esPositivo BOOLEAN;
	SELECT TRUE INTO esPositivo;
	IF(numero<0 OR numero>100) THEN
		SELECT FALSE INTO esPositivo;
	END IF;
RETURN(esPositivo);
END $$

