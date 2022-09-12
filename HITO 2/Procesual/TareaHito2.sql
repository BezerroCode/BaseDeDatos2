create database tareaHito2;
use tareaHito2;

create table estudiantes
(
    id_est    int auto_increment primary key not null,
    nombres   varchar(50),
    apellidos varchar(50),
    edad      int(11),
    gestion   int(11),
    fono      int(11),
    email     varchar(100),
    direccion varchar(100),
    sexo      varchar(10)
);
create table materias
(
    id_mat     int auto_increment primary key not null,
    nombre_mat varchar(100),
    cod_mat    varchar(100)
);

create table inscripcion
(
    id_ins   int auto_increment primary key not null,
    semestre varchar(20),
    gestion  int(11),

    id_est   int                            not null,
    id_mat   int                            not null,

    foreign key (id_est) references estudiantes (id_est),
    foreign key (id_mat) references materias (id_mat)
);

INSERT INTO estudiantes (nombres, apellidos, edad, fono, email, direccion, sexo)
VALUES ('Miguel', 'Gonzales Veliz', 20, 2832115, 'miguel@gmail.com', 'Av. 6 de Agosto', 'masculino'),
       ('Sandra', 'Mavir Uria', 25, 2832116, 'sandra@gmail.com', 'Av. 6 de Agosto', 'femenino'),
       ('Joel', 'Adubiri Mondar', 30, 2832117, 'joel@gmail.com', 'Av. 6 de Agosto', 'masculino'),
       ('Andrea', 'Arias Ballesteros', 21, 2832118, 'andrea@gmail.com', 'Av. 6 de Agosto', 'femenino'),
       ('Santos', 'Montes Valenzuela', 24, 2832119, 'santos@gmail.com', 'Av. 6 de Agosto', 'masculino');

INSERT INTO materias (nombre_mat, cod_mat)
VALUES ('Introduccion a la Arquitectura', 'ARQ-101'),
       ('Urbanismo y Diseno', 'ARQ-102'),
       ('Dibujo y Pintura Arquitectonico', 'ARQ-103'),
       ('Matematica discreta', 'ARQ-104'),
       ('Fisica Basica', 'ARQ-105');

INSERT INTO inscripcion (semestre, gestion, id_est, id_mat)
values ('1er Semestre', 2018, 1, 1),
       ('2do Semestre', 2018, 1, 2),
       ('1er Semestre', 2019, 2, 4),
       ('2do Semestre', 2019, 2, 3),
       ('2do Semestre', 2020, 3, 3),
       ('3er Semestre', 2020, 3, 1),
       ('4to Semestre', 2021, 4, 4),
       ('5to Semestre', 2021, 5, 5);

#Mostrar los nombres y apellidos de los estudiantes inscritos en la
#materia ARQ-105, adicionalmente mostrar el nombre de la materia
select est.nombres, est.apellidos, mat.cod_mat, mat.nombre_mat
from estudiantes as est
         inner join inscripcion as ins on est.id_est = ins.id_est
         inner join materias as mat on ins.id_mat = mat.id_mat
where mat.cod_mat = 'ARQ-105';


#Deberá de crear una función que reciba dos parámetros y esta
#función deberá ser utilizada en la cláusula WHERE.
create function compara_materias(cod_mat varchar(20), nombre_mat varchar(20))
    returns boolean
begin
    declare respuesta boolean;
    if cod_mat = nombre_mat
    then
        set respuesta=1;
    end if;
    return respuesta;
end;

#clausula where en la consulta
select est.nombres, est.apellidos, mat.cod_mat, mat.nombre_mat
from estudiantes as est
         inner join inscripcion as ins on est.id_est = ins.id_est
         inner join materias as mat on ins.id_mat = mat.id_mat
where compara_materias(mat.cod_mat,'ARQ-105');


#Crear una función que permita obtener el promedio de las edades del género
#masculino o femenino de los estudiantes inscritos en la asignatura ARQ-104.
# La función recibe como parámetro el género y el código de materia.

#sin funcion
SELECT avg(est.edad)
FROM estudiantes AS est
         inner join inscripcion ins on est.id_est = ins.id_est
         inner join materias mat on ins.id_mat = mat.id_mat
where est.sexo = 'femenino' and mat.cod_mat = 'ARQ-104';


CREATE OR REPLACE FUNCTION get_avg_est(genero varchar(10), codMateria varchar(10))
    RETURNS INTEGER
BEGIN
    declare avgEdad int default 0;
    SELECT avg(est.edad) into avgEdad
    FROM estudiantes AS est
             inner join inscripcion ins on est.id_est = ins.id_est
             inner join materias mat on ins.id_mat = mat.id_mat
    where est.sexo = genero and mat.cod_mat = codMateria;
    return avgEdad;
END;


select get_avg_est('femenino', 'ARQ-104') as promedio;

#Crear una función que permita concatenar 3 cadenas.
#○ La función recibe 3 parámetros.
#○ Si las cadenas fuesen:
#■ Pepito
#■ Pep
#■ 50
#○ La salida debería ser: (Pepito), (Pep), (50)
#○ La función creada utilizarlo en una consulta SQL.
create function getParametros(par1 varchar(20), par2 varchar(20), par3 varchar(20))
    returns varchar(60)
begin
    declare resultado varchar(60);
    set resultado = CONCAT(par1, ' ', par2, ' ', par3);
    return resultado;
end;

select getParametros('pepito', 'pep', '50');


#Crear una función de acuerdo a lo siguiente:
#○ Mostrar el nombre, apellidos, edad y el semestre de todos los estudiantes
#que estén inscritos.
#○ Siempre y cuando la suma de las edades del sexo femenino(tambien puede
#ser masculino) sea par y mayores a cierta edad.
#○ Debe de crear una función que sume las edades (recibir como parámetro el
#sexo, y la edad).
#■ Ejemplo: sexo=’Masculino’ y edad=22
#■ Note que la función recibe 2 parámetros.
#○ La función creada anteriormente debe utilizarse en la consulta SQL.
#(Cláusula WHERE).


create or replace function get_genero_edad(genero varchar(10), edad int)
    returns boolean
begin
    declare resultado int default 0;
    declare ifRes boolean;

    select sum(est.edad) into resultado
    from estudiantes as est
    where est.sexo=genero;

    if resultado%2=0 and resultado>edad
    then
        set ifRes=1;
    end if;
    return ifRes;
end;

select est.nombres, est.apellidos, i.semestre
from estudiantes as est
inner join inscripcion i on est.id_est = i.id_est
where get_genero_edad('masculino', 22);


#Crear una función sobre la tabla estudiantes que compara un nombre y
#apellidos. (si existe este nombre y apellido mostrar todos los datos del
#estudiante).
#La función devuelve un boolean.
#La función debe recibir 4 parámetros, nombres y apellidos.
#Similar al siguiente ejemplo.

create or replace function comparaNombre(nombre varchar(50),apellido varchar(50),nombreEst varchar(50), apellidoEst varchar(50))
    returns boolean
begin
    declare resultado boolean;
    if nombre=nombreEst and apellido=apellidoEst
    then
    set resultado=1;
end if;
    return resultado;
end;

select est.*
from estudiantes as est
where comparaNombre(est.nombres,est.apellidos,'Joel','Adubiri Mondar')








