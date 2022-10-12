create database hito3_lenguaje_procedural;

#creando variable local
set @admin='ADMIN';
select @admin;

set @admin ='GUEST';
set @admin ='william';

create or replace function example1()
returns varchar(20)
begin
    declare respuesta varchar(20) default '';
    if @admin = 'ADMIN'
    then
        set respuesta = 'Usuario Admin';
        else
        set respuesta='Usuarios Invitado';
    end if;
    return respuesta;
end;

select example1();

create or replace function example2()
returns varchar(20)
begin
    declare respuesta varchar(20) default '';
    case
        when @admin='ADMIN' then set respuesta = 'Usuario ADMIN';
        when @admin='GUEST' then set respuesta = 'Usuario Invitado';
        else set respuesta='Usuario nuevo';
    end case;
    return respuesta;
end;

select example2();

#crear variable global precio(numero)
#si el precio es mayor a 10 y menor igual a 20 retornar el mansaje basico
#si el precio es mayor a 20 y menor igual a 30 retornar el mansaje intermedio
#si el precio es mayor a 30 y menor igual a 50 retornar el mansaje superior
#si el precio es mayor a 50 retornar el mansaje desconocido
set @precio = 100;
create or replace function example3()
returns varchar(20)
begin
    declare respuesta varchar(20) default '';
    case
        when @precio>10 and @precio <=20 then set respuesta = 'basico';
        when @precio>20 and @precio <=30 then set respuesta = 'intermedio';
        when @precio>30 and @precio <=50 then set respuesta = 'superior';
        when @precio>50  then set respuesta = 'carisimo';
        else set respuesta='caso desconocido';
    end case;
    return respuesta;
end;

select example3();

set @creditNumber=50000;
create or replace function example4()
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
select example4();

CREATE OR REPLACE FUNCTION ejercicio3(LIMITWHILE INTEGER)
RETURNS text
BEGIN
    DECLARE  X  int DEFAULT 1;
    declare  str text default ' ';
    WHILE X <= LIMITWHILE DO
        SET str = concat (str , x,',');
        set x = x +1 ;
        end while;
    return str ;
end;

select ejercicio3(10);

#BUCLES LOOP, REPEAT, WHILE.
create or replace function numeroNaturales(limite integer)
returns TEXT
begin
    declare response TEXT default '';
    declare x integer default 1;

    while x <= limite do
        set response= concat(response,x,',');
        set x=x+1;
        end while;
    return response;
end;

select numeroNaturales(10);

create or replace function numeroNaturalesPares(limite integer)
returns TEXT
begin
    declare response TEXT default '';
    declare x integer default 2;

    while x <= limite do
        set response= concat(response,x,',');
        set x=x+2;
        end while;
    return response;
end;
select numeroNaturalesPares(10);

#crear una funcion que maneje while para el seguiente escenario
#recibe un parametro (limite => integer)
#si ese numero es par generar los pares haste ese numero
#si ese numero es impar generar los impares haste ese numero

create or replace function pares_Impares(limite integer)
returns TEXT
begin
    declare respuesta text default '';
    declare x int;
   if limite %2=0
       then
       set x=2;
       while x<=limite do
           set respuesta= concat(respuesta,x,',');
           set x=x+2;
       end while;
   else
       set x=1;
       while x<= limite do
            set respuesta =concat(respuesta,x,' ,  ');
            set x =x+2;
        end while;
   end if;
    return respuesta;
end;

select pares_Impares(10);

#crear una funcion que maneje UN SOLO while para el seguiente escenario
#recibe un parametro (limite => integer)
#si ese numero es par generar los pares haste ese numero
#si ese numero es impar generar los impares haste ese numero

create or replace function pares_Impares1(limite integer)
returns TEXT
begin
    declare respuesta text default '';
    declare x int default 1;
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

select pares_Impares1(9);

#decendente
create or replace function pares_Impares2(limite integer)
returns TEXT
begin
    declare respuesta text default '';
    declare x int default 1;
   if limite %2=0
       then
       set x=2;
    end if;
    while x<=limite do
           set respuesta= concat(x,',',respuesta);
           set x=x+2;
       end while;
    return respuesta;
   end;

select pares_Impares2(11);

#descendente en el limite
create or replace function pares_Impares_decendente(limite integer)
returns TEXT
begin
    declare respuesta text default '';

    while limite>0 do
           set respuesta= concat(respuesta,limite,',');
           set limite=limite-2;
       end while;
    return respuesta;
   end;

select pares_Impares_decendente(10);

CREATE OR REPLACE FUNCTION repeat_ejemplo(x INTEGER)
RETURNS text
BEGIN
    declare  str text default ' ';
    repeat
        SET str = concat (str , x,',');
        set x = x -1 ;
        until x<=0 end repeat;
    return str;
end;

select repeat_ejemplo(10);

CREATE OR REPLACE FUNCTION repeat_ejemplo1(x INTEGER)
RETURNS text
BEGIN
    declare  str text default ' ';
    repeat
        IF X %2=0
        THEN
        SET str = CONCAT (str , x,'-BB-');
        set x = x -1 ;
        ELSE
           SET str = CONCAT (str , x,'-AA-');
        set x = x -1 ;
           END IF;
        until x<=0 end repeat;
    return str;
end;
select repeat_ejemplo1(9)

