create database hito3Aula;
use hito3Aula;

set @admin='GUEST';
set @admin='BAR';
#       RETURNS

#    if (condicion)        then          set(condicion)   else (sin condicion)         end if
create or replace function example1()
returns text
begin
declare respuesta text default '';
if @admin = 'GUEST'
    then
    set respuesta='Usuario Admin';
    else
    set respuesta='Usuario invitado';
end if;
return respuesta;
end;

select example1();

# CASE  WHEN (CONDICION 1)    THEN - SET (CONDICION2) /   WHEN    THEN    SET /   ELSE SET    END CASE;
create or replace function example2()
returns text
begin
declare respuesta text default '';
case
    when @admin='GUEST'
        then
    set respuesta ='usuario admin';
    when @admin='BAR'
        then
    set respuesta= 'Usuario invitado';
    else
    set respuesta='Usuario nuevo';
end case ;
    return respuesta;
end;

select example2();

#crear variable global precio(numero)
#si el precio es mayor a 10 y menor igual a 20 retornar el mansaje basico
#si el precio es mayor a 20 y menor igual a 30 retornar el mansaje intermedio
#si el precio es mayor a 30 y menor igual a 50 retornar el mansaje superior
#si el precio es mayor a 50 retornar el mansaje carisimo

set @precio=11;

create function getPrecio()
returns text
begin
    declare respuesta text default '';
    case
        when @precio>10 and @precio<=20
    then set respuesta = 'BASICO';

    when @precio>20 and @precio<=30
        then set respuesta='INTERMEDIO';
    when @precio>30 and @precio <=50
        then set respuesta='SUPERIOR';
    when @precio>50
        then set respuesta='CARISIMO';
        else
        set respuesta = 'caso desconocido';
    end case;
        return respuesta;
end;

select getPrecio();

set @creditNumber=90000;
create or replace function getCredito()
returns text
begin
    declare respuesta text default '';
case
    when @creditNumber>50000
        then set respuesta ='PLATINUM';
    when @creditNumber>=10000 and @creditNumber<=50000
        then set respuesta= 'GOLD';
    when @creditNumber<10000
        then set respuesta='SILVER';
        else
    set respuesta='caso desconocido';
    end case;
    return respuesta;
end;

select getCredito();

#BUCLES LOOP, REPEAT, WHILE.

#WHILE (CONDICION)  DO  SET (CONDICION) SET (CONDICION)     END WHILE;
create or replace function example3(limite int)
returns text
begin
    declare x int default 1;
    declare serie text default '';

    while x<=limite do
        set serie=concat(serie,x,',');
        set x=x+1;
        end while;
    return serie;
end;

select example3(10);

#SERIE EM PARES
create or replace function numerosPares(limite int)
returns text
begin
    declare str text default '';
    declare x int default 2;

    while x<=limite do
        set str=concat(str,x,',');
        set x=x+2;
        end while;
        return str;
end;

select numerosPares(10);

#crear una funcion que maneje while para el seguiente escenario
#recibe un parametro (limite => integer)
#si ese numero es par generar los pares haste ese numero
#si ese numero es impar generar los impares haste ese numero
create or replace function paresImpares(limite int)
returns text
begin
    declare str text default '';
    declare x int default 1;

    if limite%2=0 then
        set x=2;
    end if;
    while x<=limite do
        set str= concat(str,x,',');
        set x=x+2;
        end while;
    return str;
end;

select paresImpares(10);

#decendente
create or replace function paresImpares1(limite int)
returns text
begin
    declare respuesta text default '';
    while limite>0 do
        set respuesta= concat(respuesta,limite,',');
        set limite=limite-2;
end while;
    return respuesta;
end;

select paresImpares1(10);

#repeat set set until (condicion) end repeat
create or replace  function repeatEjemplo1(x int)
returns text
begin
    declare str text default '';
    repeat
        set str= concat(str,x,',');
        set x=x-1;
    until x<=0 end repeat;
return str;
end;

select repeatEjemplo1(10);

create or replace function repeatEjemplo2(x int)
returns text
begin
    declare str text default '';
    repeat
        if x%2=0 then
            set str = concat(str,x,'-BB-');
            else
            set str=concat(str,x,'-AA-');
        end if;
        set x=x-1;
until x<=0 end repeat;
return str;
end;

select repeatEjemplo2(10);

#LOOP
create or replace function loop1(x int)
returns text
begin
    declare str text default '';

    loop_label1: loop
        if x<0 then
            leave loop_label1;
        end if;
        set str= concat(str,x,',');
        set x=x-1;
        iterate loop_label1;
    end loop;
    return str;
end;

select loop1(10);

create or replace function loop1(limite int)
returns text
begin
    declare str text default '';
    declare x int default 1;

    num_nat:loop
        if x> limite then
            leave num_nat;
        end if;
        set str= concat(str,x,',');
        set x=x+1;
        iterate num_nat;
    end loop;
    return str;
end;

select loop1(10);


