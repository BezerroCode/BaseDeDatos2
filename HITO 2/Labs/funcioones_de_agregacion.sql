#funcion de agragacion se ejecuta en la clausula selected y retorna un valor
#avg max min
    #count
    #sum devolver la suma de todos los valores d eun campo
CREATE DATABASE function_agregation;

CREATE TABLE estudiantes
(
 id_est INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
 nombres VARCHAR(50),
 apellidos VARCHAR(50),
 edad INTEGER,
 gestion INTEGER,
 fono INTEGER,
 email VARCHAR(100),
 direccion VARCHAR(100),
 genero VARCHAR(10)
);

select est.*
from estudiantes as est;

INSERT INTO estudiantes (nombres, apellidos, edad, fono, email, direccion, genero) VALUES
    ('Miguel' ,'Gonzales Veliz', 20, 2832115, 'miguel@gmail.com', 'Av. 6 de Agosto', 'masculino'),
    ('Sandra' ,'Mavir Uria', 25, 2832116, 'sandra@gmail.com', 'Av. 6 de Agosto', 'femenino'),
    ('Miguel' ,'Gonzales Veliz', 20, 2832115,'miguel@gmail.com', 'Av. 6 de Agosto','masculino'),
     ('Joel' ,'Adubiri Mondar', 30, 2832117, 'joel@gmail.com', 'Av. 6 de Agosto', 'masculino'),
    ('Andrea' ,'Arias Ballesteros', 21, 2832118, 'andrea@gmail.com', 'Av. 6 de Agosto', 'femenino'),
    ('Santos' ,'Montes Valenzuela', 24, 2832119, 'santos@gmail.com', 'Av. 6 de Agosto', 'masculino');

#CREAR la consulta que modifique el campo gestion y que asigne el valor 2022 de la tabla estudiante
UPDATE estudiantes est
SET est.gestion = 2022
WHERE est.id_est >0;

#DELETE FROM estudiantes WHERE id_est != ‘’;


CREATE TABLE materias
(
  id_mat INTEGER AUTO_INCREMENT PRIMARY KEY  NOT NULL,
  nombre_mat VARCHAR(100),
  cod_mat VARCHAR(100)
);


CREATE TABLE inscripcion
(
  id_ins INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
  id_est INT NOT NULL,

  id_mat INT NOT NULL,
  semestre VARCHAR(20),
  gestion INTEGER,
  FOREIGN KEY (id_est) REFERENCES estudiantes (id_est),
  FOREIGN KEY (id_mat) REFERENCES materias (id_mat)
);

INSERT INTO materias (nombre_mat, cod_mat) VALUES
    ('Introduccion a la Arquitectura','ARQ-101'),
    ('Urbanismo y Diseno','ARQ-102'),
    ('Dibujo y Pintura Arquitectonico','ARQ-103'),
    ('Matematica discreta','ARQ-104'),
    ('Fisica Basica','ARQ-105');

INSERT INTO inscripcion (id_est, id_mat, semestre, gestion) VALUES
(1, 1, '1er Semestre', 2015),
(1, 2, '2do Semestre', 2015),
(2, 4, '1er Semestre', 2016),
(2, 3, '2do Semestre', 2016),
(3, 3, '2do Semestre', 2017),
(3, 1, '3er Semestre', 2017),
(4, 4, '4to Semestre', 2017),
(5, 5, '5to Semestre', 2017);

#Mostrar los nombres y apellidos de los estudiantes inscritos en la materia
#ARQ-104, adicionalmente mostrar el nombre el nombre de la materia. //

select est.nombres, mat.cod_mat
from estudiantes as est
inner join materias as mat on est.id_est = mat.id_mat
inner join inscripcion as ins on mat.id_mat = ins.id_est
where mat.cod_mat = 'ARQ-104';

#contar estudiantes
select count(est.id_est) as 'cantidad de estudiantes'
from estudiantes as est;

select avg(est.edad) as 'edad de estudiantes'
from estudiantes as est;

SELECT max(est.edad)
FROM estudiantes AS est;

#determinar la maxima edad de los estudiantes cuyo genero sea masculino y la edad sea mayor a 20
select est.nombres,max (est.edad),est.genero
from estudiantes as est
where est.genero = 'masculino' and est.edad > 20;

#manejo de funciones

create function get_max_edad()
returns integer
BEGIN
    return 10;
end;
select get_max_edad();


create function get_name()
returns varchar(20)
BEGIN
    return 'name';
end;

select get_name();

#Crear una función que devuelve el máximo valor del campo edad en la tabla estudiantes.
CREATE FUNCTION get_max_est()
    RETURNS INTEGER
    BEGIN
        RETURN (
            SELECT MAX(est.edad)
            FROM estudiantes AS est
        );
    END;

SELECT get_max_est() AS MaxEdad

CREATE FUNCTION get_min_est()
    RETURNS INTEGER
    BEGIN
        RETURN (
            SELECT min(est.edad)
            FROM estudiantes AS est
        );
    END;

SELECT get_min_est() AS minEdad

CREATE FUNCTION get_avg_est()
    RETURNS INTEGER
    BEGIN
        RETURN (
            SELECT avg(est.edad)
            FROM estudiantes AS est
        );
    END;

SELECT get_avg_est() AS avgEdad;

CREATE FUNCTION get_est()
    RETURNS INTEGER
    BEGIN
        RETURN (
            SELECT MAX(est.edad)
            FROM estudiantes AS est
            where est.genero='masculino' or  est.genero ='femenino'
        );
    END;

SELECT get_est();


CREATE FUNCTION suma_edades_femenino() RETURNS INTEGER
    BEGIN
        RETURN (
            SELECT SUM(est.edad)
            FROM estudiantes AS est
            WHERE est.genero = 'femenino'
        );
    END;

SELECT suma_edades_femenino();

#funcion parametrizada segun genero

CREATE FUNCTION suma_edades_v1(generoValor varchar(10))
RETURNS INTEGER
    BEGIN
        RETURN (
            SELECT SUM(est.edad)
            FROM estudiantes AS est
            WHERE est.genero = generoValor
        );
    END;

select suma_edades_v1('masculino');

#select con numeros pares de la anterior funcion
select est.nombres,est.apellidos
from estudiantes as est
where suma_edades_v1('femenino') % 2 = 0;

create function suma_edad_v2(genero varchar(10))
    returns integer
    begin
        declare sumaEdad integer default 0;

         SELECT SUM(est.edad) INTO sumaEdad
            FROM estudiantes AS est
            WHERE est.genero = genero;

        return sumaEdad;
    end;

select est.nombres,est.apellidos
from estudiantes as est
where suma_edad_v2('femenino') % 2 = 0;

CREATE FUNCTION get_avg_est_v1(genero varchar(10))
    RETURNS INTEGER
    BEGIN
            declare avgEdad real default 0;

            SELECT avg(est.edad) into avgEdad
            FROM estudiantes AS est
            where est.genero=genero;

        return avgEdad;
    END;

select est.nombres,est.apellidos
from estudiantes as est
where get_avg_est_v1('masculino') % 2 = 0;

select Concat('dba',' ','s')
select CONCAT_WS('-','dba','s','FG')
select TRIM('       DBA II    ');
#concatenar
select CONCAT(est.nombres, ' ', est.apellidos) as Persona
from estudiantes as est;

#funcion
create function getNombreCompleto(nombre varchar(50),apellidos varchar(50))
returns varchar(50)
begin
   declare nombreCompleto varchar(50);
   set nombreCompleto = CONCAT(nombre, ' ', apellidos);
   return nombreCompleto;
end;

select getNombreCompleto(est.nombres,est.apellidos)
from estudiantes as est;

#concatenar metodo 2

create function getnombre1(par1 varchar(25),par2 varchar(25))
    returns varchar(50)
    begin
        declare nombreCompleto varchar (50) default '';
        set nombreCompleto = CONCAT(par1,' ',par2);
        return  nombreCompleto;
    end;
select getNombreCompleto('a','b');

select getnombre1(est.nombres,est.apellidos) as fullName
from estudiantes as est;

#Mostrar los registros de la tabla estudiantes (nombres y apellidos concatenados) y la edad en otra columna si la cantidad de estudiantes femeninos sea PAR.
#Utilice las funciones previamente creados.
#La función parametrizable para sumar edades en función al sexo( masculinos o femeninos).
#La función que concatena nombres y apellidos.

create function getNombreCompleto_v1(nombres varchar(50),apellidos varchar(50),genero varchar(10))
returns varchar(50)
begin
   declare nombreCompleto  varchar (50);
      set nombreCompleto = CONCAT(nombres, ' ', apellidos);
            SELECT sum(est.edad) into nombreCompleto
            FROM estudiantes AS est
            where est.genero=genero;

   return nombreCompleto;
end;

select getNombreCompleto_v1(est.nombres,est.apellidos,'masculino')
from estudiantes as est;


create function getNombreCompleto_v2(genero varchar(10))
returns varchar(50)
begin
    return(
            SELECT sum(est.edad)
            FROM estudiantes AS est
            where est.genero=genero
    );

end;

select est.nombres,est.apellidos,est.edad
from estudiantes as est
where concat(nombres, ' ', apellidos, '',edad) and getNombreCompleto_v2('masculino') % 2 = 2;

#GENERAR EL SEGUIENTE FORMATO DE SALIDA
create or replace function getLista(par1 varchar(25),par2 varchar(25))
    returns varchar(50)
    begin
        declare nombreCompleto varchar (50) default '';
        set nombreCompleto = concat_ws(':','nombres','apellidos') or CONCAT_WS(',',par1,par2);
        return  nombreCompleto;
    end;

create or replace function getLista1(par3 varchar(25),par4 varchar(25))
    returns varchar(50)
    begin
        declare nombreCompleto varchar (50) default '';
        set nombreCompleto = concat_ws(':','gestion','edad') or CONCAT_WS('-',par3,par4);
        return  nombreCompleto;
    end;


select getLista('William', 'Barra'), getLista1('20','2022')

#generar el seguientre formato de salida
#concatenar nombres y apellidos de la seiguiente forma: Nombres: William, Apellidos: Barrra
#concatenar gestion y edad de la seiguiente forma: Gestion:2022 -  edad: 10

CREATE function output_fullname(nombres VARCHAR(20), apellidos varchar(20))
    RETURNS VARCHAR(100)
begin
    declare resultado VARCHAR(100) DEFAULT '';
    set resultado = concat('Nombres: ', nombres, ', Apellidos: ', apellidos);
    return resultado;
end;

SELECT output_fullname('William', 'Barra');
SELECT output_fullname(est.nombres, est.apellidos) as fullname
from estudiantes as est;

CREATE or replace function output_age(gestion integer, edad integer)
    RETURNS integer
begin
    declare resultado varchar(100) default '';
    set resultado = concat('Gestion: ', gestion, '- edad(',edad,')');
    return resultado;
end;

select output_fullname('William','Barra'), output_age(20,2022) from estudiantes as est

select output_fullname(est.nombres,est.apellidos),
       output_age(est.gestion,est.edad)
from estudiantes as est

CREATE function output_datos(nombres VARCHAR(20), apellidos varchar(20),gestion integer, edad integer)
    RETURNS VARCHAR(100)
begin
    declare resultado VARCHAR(100) DEFAULT '';
    set resultado = concat('Nombres: ', nombres, ', Apellidos: ', apellidos,'Gestion: ', gestion, '- edad(',edad,')');
    return resultado;
end;

select output_datos(est.nombres,est.apellidos,est.gestion,est.edad)
from estudiantes as est;


#nombres y apelludos que estn inscritos en la gestion 2015 Y ARQ-101 y inscritos en 5to semestres ademas de la gesion 2016 y 2017
select est.nombres, est.apellidos,ins.gestion
from estudiantes as est
inner join inscripcion as ins on est.id_est = ins.id_est
where ins.gestion=2016 or ins.gestion=2017;

select est.nombres, est.apellidos,ins.gestion
from estudiantes as est
inner join materias as mat on est.id_est = mat.id_mat
inner join inscripcion as ins on mat.id_mat = ins.id_est
where ins.gestion = 2015 and mat.cod_mat='ARQ-101' and ins.semestre='5to Semestre' or ins.gestion=2016 or ins.gestion=2017;
