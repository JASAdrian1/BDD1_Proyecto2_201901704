SELECT * FROM proyecto2_bases.estudiante;
SELECT * FROM proyecto2_bases.carrera;
SELECT * FROM proyecto2_bases.docente;
SELECT * FROM proyecto2_bases.curso;

SELECT validarExisteEstudiante(201901704);

CALL registrarEstudiante(201901705,"JuanMiguel","Asturias Castro",'1999-10-8',"juan@gmail.com",30546878,"Zona 1 mixco",3511485570101,1);
CALL registrarEstudiante(201802214,"JuanMiguel","AsturiasCastro",'1999-10-8',"juan@gmail.com",30546878,"Zona 1 mixco",3511485570101,1);
CALL registrarEstudiante(202011409,"Angel Gabriel","Cifuentes Godinez",'1999-10-8',"juan@gmail.com",30546878,"Zona 1 mixco",3511485570101,1);
CALL registrarEstudiante(200000000,"Eduardo","Garcia",'1999-10-8',"juangmail.com",30546878,"Zona 1 mixco",3511485570101,1);

CALL crearCarrera("QUIMICA");
CALL crearCarrera("MECANICA");
CALL crearCarrera("INDUSTRIAL");

CALL registrarDocente("Fernando","Espino",'1985-10-8',"espino@gmail.com",30546878,"Zona 4, Guatemala",3525415570101,200000000);

CALL crearCurso(774,"Bases de datos 1",160,5,1,1);


