SELECT * FROM proyecto2_bases.estudiante;
SELECT * FROM proyecto2_bases.carrera;
SELECT * FROM proyecto2_bases.docente;
SELECT * FROM proyecto2_bases.curso;
SELECT * FROM proyecto2_bases.curso_habilitado;
SELECT * FROM proyecto2_bases.horario;

SELECT validarExisteEstudiante(201901704);

-- registrarEstidante(carnet,nombres,apellidos,fecha_nacimiento,correo,tel,direccion,dpi,id_carrera)
CALL registrarEstudiante(201901705,"JuanMiguel","Asturias Castro",'1999-10-8',"juan@gmail.com",30546878,"Zona 1 mixco",3511485570101,1);
CALL registrarEstudiante(201802214,"JuanMiguel","AsturiasCastro",'1999-10-8',"juan@gmail.com",30546878,"Zona 1 mixco",3511485570101,1);
CALL registrarEstudiante(202011409,"Angel Gabriel","Cifuentes Godinez",'1999-10-8',"juan@gmail.com",30546878,"Zona 1 mixco",3511485570101,1);
CALL registrarEstudiante(200000000,"Eduardo","Garcia",'1999-10-8',"juan@gmail.com",30546878,"Zona 1 mixco",3511485570101,1);
CALL registrarEstudiante(201804741,"Diego Manuel","Garica Juarez",'1998-10-8',"Diego@gmail.com",37881024,"Zona 1 mixco",3525485570101,1);
CALL registrarEstudiante(2019012204,"Juan Carlos","Hernandez",'1999-10-8',"juan@gmail.com",30546878,"Zona 1 mixco",3511485570101,2);
CALL registrarEstudiante(201754445,"Miguel","Estrada",'1998-10-8',"Diego@gmail.com",37881024,"Zona 1 mixco",3115485570101,2);
CALL registrarEstudiante(220000001,"Carlos","Cifuentes Godinez",'1996-10-8',"Carlos@gmail.com",37881424,"Zona 1 mixco",3115481470101,2);
CALL registrarEstudiante(220000002,"Marielos","Lopez Lopez",'1996-10-8',"Marielos@gmail.com",37889924,"Zona 1 mixco",3225481470101,2);
CALL registrarEstudiante(230000001,"Gabriel","Martinoli Martinwz",'1996-10-8',"Mos@gmail.com",37883324,"Zona 1 mixco",3225481470101,3);
CALL registrarEstudiante(240000001,"Mariana","Villagran",'1996-10-8',"Ma@gmail.com",37811324,"Zona 1 mixco",3225881470101,4);

-- crearCarrera(nombre_carrera)
CALL crearCarrera("QUIMICA");
CALL crearCarrera("MECANICA");
CALL crearCarrera("INDUSTRIAL");

-- registrarDocente(nombres,apellidos,fecha_nacimiento,correo,tel,direccion,dpi,registro_siif)
CALL registrarDocente("Fernando","Espino",'1985-10-8',"espino@gmail.com",30546878,"Zona 4, Guatemala",3525415570101,200000000);
CALL registrarDocente("Wosvely","Byron",'1985-10-8',"bayron@gmail.com",30546878,"Zona 4, Guatemala",1654684848,15654954);
CALL registrarDocente("Francisco","De la Rosa",'1985-10-8',"franc@gmail.com",30546878,"Zona 4, Guatemala",3425435570205,20005002);
CALL registrarDocente("Glenda","Estrada",'1985-10-8',"geln@gmail.com",30546878,"Zona 4, Guatemala",3425435570205,20005005);
CALL registrarDocente("Arturo","Samayoa",'1985-10-8',"art@gmail.com",30546878,"Zona 4, Guatemala",3026549840101,20001111);

-- crearCurso(id_curso, nombre, creditos_necesarios,cred_otorta,id_carrera,bool_obligatorio)
CALL crearCurso(112,"Matematica basica 2",15,6,0,1);
CALL crearCurso(116,"Matematica intermedia 1",30,10,0,1);
CALL crearCurso(017,"Social humanistica 1",0,4,0,1);
CALL crearCurso(039,"Deportes 1",0,1,0,0);
CALL crearCurso(040,"Deportes 2",0,1,0,0);
CALL crearCurso(770,"Introducción a la programación y computación 1",33,4,1,0);
CALL crearCurso(774,"Bases de datos 1",160,5,1,1);
CALL crearCurso(960,"Matematica computo 1",33,5,1,1);
CALL crearCurso(281,"Sistemas operativos 1",170,5,1,1);
CALL crearCurso(722,"Teoria de sistemas 1",20,5,1,1);
CALL crearCurso(222,"Fisica 4",15,6,2,1);
CALL crearCurso(170,"Mecanica analitica 1",0,5,2,1);
CALL crearCurso(172,"Mecanica analitica 2",0,5,2,1);
CALL crearCurso(250,"Mecanica fluidos",25,5,2,1);
CALL crearCurso(660,"Mercadotecnia",0,5,3,1);
CALL crearCurso(662,"Legislacion 1",0,5,3,0);
CALL crearCurso(650,"Contabilidad 1",20,5,3,1);
CALL crearCurso(669,"Economia industrial",0,5,3,0);
CALL crearCurso(653,"Microeconomia",20,5,3,1);
CALL crearCurso(354,"Quimica 3",0,5,4,1);
CALL crearCurso(356,"Quimica 4",0,5,4,1);
CALL crearCurso(366,"Analisis instrumental",0,5,4,0);
CALL crearCurso(356,"Quimica organica 1",30,5,4,1);
CALL crearCurso(400,"Bioquimica",30,5,4,0);

-- habilitarCurso(codigo_curso,ciclo,id_docente,cupo_max,seccion)
CALL habilitarCurso(774,"1S",20005005,65,"C");
CALL habilitarCurso(774,"2S",20005005,65,"C");
CALL habilitarCurso(112,"1S",20005005,65,"C");
CALL habilitarCurso(116,"1S",20005002,65,"A");

-- agregarHorario(id_curso,dia,horario)
CALL agregarHorario(1,3,"7:00-10:30");
CALL agregarHorario(2,3,"7:00-10:30");
CALL agregarHorario(3,2,"7:00-8:00");
CALL agregarHorario(3,4,"7:00-8:00");

-- asignarCurso(codigo_curso,ciclo,seccion,carnet)
CALL asignarCurso(774,"2S","C",201901704);
CALL asignarCurso(774,"2S","C",201804741);
CALL asignarCurso(774,"2S","C",200000000);
CALL asignarCurso(112,"1S","C",201804741);
CALL asignarCurso(774,"1S","D",201804741);

select * from estudiante;
-- desasignarCurso(codigo_curso,ciclo,seccion,carnet)
CALL desasignarCurso(774,"2S","C",201901704);
CALL desasignarCurso(774,"1S","D",201804741);
CALL desasignarCurso(774,"1S","D",201901704);


-- ingresarNota(codigo_curso,ciclo,seccion,canet,nota)
CALL ingresarNota(774,"2S","C",201901704,85);
CALL ingresarNota(774,"2S","C",201804741,77);
CALL ingresarNota(774,"2S","C",200000000,54);
CALL ingresarNota(774,"1S","D",201901704,91);
CALL ingresarNota(774,"1S","D",201804741,55);



-- generarActa(codigo_curso,ciclo,seccion)
CALL generarActa(774,"2S","C");
CALL generarActa(774,"1S","C");
CALL generarActa(774,"1S","D");
