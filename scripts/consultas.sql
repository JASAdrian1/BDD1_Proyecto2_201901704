
-- consultarPensum(codigo_carrera)
CALL consultarPensum(1);

-- consultarEstudiante(carnet)
CALL consultarEstudiante(201901704);

-- consultarDocente(registro_siif)
CALL consultarDocente(200000000);

-- consultarAsignados(codigo_curso,ciclo,anio,seccion)
CALL consultarAsignados(774,"1S",2022,"D");

-- consultarAprobacion(codigo_curso,ciclo,anio,seccion)
CALL consultarAprobacion(774,"2S",2022,"C");

-- consultarActas(codigo_curso)
CALL consultarActas(774);

-- consultarDesasignacion(codigo_curso,ciclo,año,seccion)
CALL consultarDesasignacion(774,"2S",2022,"C");
CALL consultarDesasignacion(774,"1S",2022,"D");


