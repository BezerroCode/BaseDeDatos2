create database tareaHito3;
use tareaHito3;

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
#SUBSTRING
CREATE OR REPLACE FUNCTION SUB_STRING (NOMBRE VARCHAR(50),POSICION INTEGER,LONGITUD INTEGER)
RETURNS TEXT
BEGIN
  DECLARE CADENA TEXT DEFAULT '';
  SET CADENA= SUBSTRING(NOMBRE,POSICION,LONGITUD);
  RETURN CADENA;
END;

SELECT SUBSTRING('DANIEL ORIVADO DA SILVA',5,10);

#STRCMP
CREATE or replace FUNCTION CADENA(cadena TEXT,cadena1 text)
RETURNS text

BEGIN
     DECLARE mensaje text default '';
 CASE
      when mensaje=strcmp(cadena,cadena1) then
      if mensaje=0 then
      SET mensaje = ' cadenas iguales';
      end if;
      ELSE SET mensaje = 'cadenas distintas';
      END CASE;
 RETURN mensaje;
END;

SELECT  CADENA('HOLA','CHAU');

#CHAR LENGTH
CREATE OR REPLACE FUNCTION CONTAR_CADENA(TEXTO VARCHAR(20))
RETURNS TEXT
BEGIN
    DECLARE RESPUESTA VARCHAR(20) DEFAULT '';
    SET RESPUESTA=CHAR_LENGTH(TEXTO);
   RETURN RESPUESTA;
END;
SELECT CONTAR_CADENA('HOLA');

#LOCATE
CREATE OR REPLACE FUNCTION LOCATE_CADENA(SUBCADENA VARCHAR(20),CADENA VARCHAR(20))
RETURNS TEXT
BEGIN
    DECLARE RESP INTEGER DEFAULT 0;
    SET RESP=LOCATE(SUBCADENA,CADENA);
   RETURN RESP;
END;
SELECT LOCATE_CADENA('C','SOFT.COM');

#12.Crear una función que genere la serie Fibonacci.
#○ La función recibe un límite(number)
#○ La función debe de retornar una cadena.
#○ Ejemplo para n=7. OUTPUT: 0, 1, 1, 2, 3, 5, 8,
#○ Adjuntar el código SQL generado y una imagen de su correcto funcionamiento.

CREATE OR REPLACE FUNCTION fibonacci(limite INT)
RETURNS TEXT
DETERMINISTIC
BEGIN
    DECLARE fib1 INT DEFAULT 0;
    DECLARE fib2 INT DEFAULT 1;
    DECLARE fib3 INT DEFAULT 0;
    DECLARE str VARCHAR(255) DEFAULT '0,1,';

    IF limite = 1 THEN
        RETURN fib1;
    ELSEIF limite = 2 THEN
        RETURN CONCAT(fib1, fib2);
    ELSE
        WHILE limite > 2 DO
            SET fib3 = fib1 + fib2;
            SET fib1 = fib2;
            SET fib2 = fib3;
            SET limite = limite - 1;
            SET str = CONCAT(str, fib3,',');
        END WHILE;
        RETURN str;
    END IF;
END;

select fibonacci(7);

#13.Crear una variable global a nivel BASE DE DATOS.
#○ Crear una función cualquiera.
#○ La función debe retornar la variable global.
#○ Adjuntar el código SQL generado y una imagen de su correcto funcionamiento.

set @limit=7;
CREATE OR REPLACE FUNCTION fibonacci1()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE fib1 INT DEFAULT 0;
    DECLARE fib2 INT DEFAULT 1;
    DECLARE fib3 INT DEFAULT 0;
    DECLARE str VARCHAR(255) DEFAULT '01';

    IF @limit = 1 THEN
        RETURN fib1;
    ELSEIF @limit = 2 THEN
        RETURN CONCAT(fib1, fib2);
    ELSE
        WHILE @limit > 2 DO
            SET fib3 = fib1 + fib2;
            SET fib1 = fib2;
            SET fib2 = fib3;
            SET @limit = @limit - 1;
            SET str = CONCAT(str, fib3);
        END WHILE;
        RETURN str;
    END IF;
END;

select fibonacci1();

#/////////////////////////////////////////////////////////////////////

CREATE OR REPLACE FUNCTION FIBONANCI_1(NUMBER INTEGER)
RETURNS TEXT
BEGIN
    DECLARE A INTEGER DEFAULT 0;
    DECLARE B INTEGER DEFAULT 1;
    DECLARE AUX INTEGER DEFAULT 0;
    DECLARE CONTADOR INTEGER DEFAULT 0;
    DECLARE CADENA TEXT DEFAULT '';
    SET CADENA =CONCAT(A,',',B);

IF NUMBER=1 THEN SET CADENA='0';
ELSEIF NUMBER=2 THEN SET CADENA='0,1';
ELSEIF NUMBER<=0 THEN SET CADENA=' ingresar numero mayor a cero';
ELSE
    REPEAT

    SET AUX=A+B;
    SET CADENA = CONCAT(CADENA,',',AUX);
    SET A=B;
    SET B=AUX;
    SET CONTADOR=CONTADOR+1;
    UNTIL CONTADOR = NUMBER-2 END REPEAT;
END IF;
    RETURN CADENA;
END;

SELECT FIBONANCI_1(7);


#14.Crear una función no recibe parámetros (Utilizar WHILE, REPEAT o LOOP).
#○ Previamente deberá de crear una función que obtenga la edad mínima de los estudiantes
#La función no recibe ningún parámetro.
#La función debe de retornar un número.(LA EDAD MÍNIMA)
create or replace function edadMinima ()
returns int
begin
declare respuesta int default 0;

select min(est.edad) into respuesta
from estudiantes as est;

return  respuesta;
end;

select edadMinima();

#Si la edad mínima es PAR mostrar todos los pares empezando desde 0 a este
#ese valor de la edad mínima.
# Si la edad mínima es IMPAR mostrar descendentemente todos los impares
#hasta el valor 0.

create or replace function edadMinima1 ()
returns text
begin
declare respuesta text default '';
declare limite int;
declare x int;
select min(est.edad) into limite
from estudiantes as est;
if limite%2=0
then
    set x=2;
    while x<= limite do
    set respuesta = concat(respuesta,x,',');
    set x=x+2;
    end while;
else
set x=1;
while x<= limite do
    set respuesta = concat(respuesta,x,',');
    set x=x+2;
    end while;
end if;
return  respuesta;
end;

select edadMinima1();

#un solo while
create or replace function edadMinima2()
returns TEXT
begin
    declare respuesta text default '';
    declare limite int;
    declare x int default 1;
    select min(est.edad) into limite
    from estudiantes as est;

   if limite %2=0
       then
       set x=2;
    end if;
    while x<=limite do
           set respuesta= concat(respuesta,x,',');
           set x=x+2;
       end while;
    return respuesta;
   end;

select edadMinima2();

#15.Crear una función que determina cuantas veces se repite las vocales.
# La función recibe una cadena y retorna un TEXT.
# Retornar todas las vocales ordenadas e indicando la cantidad de veces que
#se repite en la cadena.

#consulta sin funcion

#V1
SELECT est.apellidos, (LENGTH(est.apellidos) - LENGTH(REPLACE(est.apellidos, 'a', '')))/LENGTH('a') AS Count
FROM estudiantes as est;

#V2
select sum(
    if (est.nombres LIKE  '%a%', 1, 0)
    + if( est.nombres LIKE '%e%', 1, 0)
    + if( est.nombres LIKE '%i%', 1, 0)
    + if( est.nombres LIKE '%o%', 1, 0)
    + if( est.nombres LIKE '%u%', 1, 0)
) as vowel_count
from estudiantes as est;

#funcion que cuenta vocales
create function vowel_count1(str varchar(1024))
returns text
begin
    return (
      char_length(str) -
      char_length(replace(replace(replace(replace(replace(
            lower(str), 'a', ''), 'e', ''), 'i', ''), 'o', ''), 'u', '')));
end;

select vowel_count1('VIVA');


#15.Crear una función que determina cuantas veces se repite las vocales.
# La función recibe una cadena y retorna un TEXT.
# Retornar todas las vocales ordenadas e indicando la cantidad de veces que
#se repite en la cadena.

#LA CONSULTA CON FUNCION
create or replace function vowel_count(str varchar(1024))
returns text
begin
    return  concat(
       concat (' a: ', (LENGTH(str) - LENGTH(REPLACE(str, 'a', '')))/LENGTH('a')) ,
       concat (' e: ', (LENGTH(str) - LENGTH(REPLACE(str, 'e', '')))/LENGTH('e')) ,
       concat (' i: ', (LENGTH(str) - LENGTH(REPLACE(str, 'i', '')))/LENGTH('i')) ,
       concat (' o: ', (LENGTH(str) - LENGTH(REPLACE(str, 'o', '')))/LENGTH('o')) ,
       concat (' u: ', (LENGTH(str) - LENGTH(REPLACE(str, 'u', '')))/LENGTH('u'))
     );
end;

select vowel_count('aleluya');


select est.nombres,vowel_count(est.nombres)
    from estudiantes as est;

#16.Crear una función que recibe un parámetro INTEGER.
# La función debe de retornar un texto(TEXT) como respuesta.
# El parámetro es un valor numérico credit_number.
# Si es mayor a 50000 es PLATINIUM.
#Si es mayor igual a 10000 y menor igual a 50000 es GOLD.
#○ Si es menor a 10000 es SILVER
#○ La función debe retornar indicando si ese cliente es PLATINUM, GOLD o
#SILVER en base al valor del credit_number.

create or replace function function_credit1(creditNumber int)
returns text
begin
    declare respuesta text default '';
    case
        when creditNumber>50000 then set respuesta = 'PLATINIUM';
        when creditNumber<=50000 and @creditNumber >=10000 then set respuesta = 'GOLD';
        when creditNumber<10000  then set respuesta = 'SILVER';
        else set respuesta='caso desconocido';
    end case;
    return respuesta;
end;


select function_credit1(50001);

#con variable local
set @creditNumber=50000;

create or replace function function_credit()
returns varchar(20)
begin
    declare respuesta varchar(20) default '';
    case
        when @creditNumber>50000 then set respuesta = 'PLATINIUM';
        when @creditNumber<=50000 and @creditNumber >=10000 then set respuesta = 'GOLD';
        when @creditNumber<10000  then set respuesta = 'SILVER';
        else set respuesta='caso desconocido';
    end case;
    return respuesta;
end;


select function_credit();

#17. Crear una función que reciba un parámetro TEXT
# En donde este parámetro deberá de recibir una cadena cualquiera y retorna
#un TEXT de respuesta.
# Concatenar N veces la misma cadena reduciendo en uno en cada iteraciónr
#hasta llegar a una sola letra.
# Utilizar REPEAT y retornar la nueva cadena concatenada.
CREATE OR REPLACE  FUNCTION  REDUCIR_CADENA (PALABRA TEXT)
RETURNS TEXT
BEGIN
    DECLARE RESPUESTA TEXT DEFAULT '';
    DECLARE CONTADOR INTEGER DEFAULT CHAR_LENGTH(PALABRA);
    DECLARE AUX INTEGER DEFAULT 1;
    DECLARE AUX2 INTEGER DEFAULT CHAR_LENGTH(PALABRA);

    REPEAT
        SET RESPUESTA= CONCAT(RESPUESTA,',',SUBSTRING(PALABRA,AUX,AUX2));
        SET CONTADOR=CONTADOR-1;
        SET AUX=AUX+1;

    until CONTADOR <=0 end repeat;
    RETURN RESPUESTA;
end;

SELECT REDUCIR_CADENA('ABRAHAM');


