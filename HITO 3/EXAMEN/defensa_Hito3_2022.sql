create database defensa_hito3_2022;
use defensa_hito3_2022;

set @str='aleluya';

create or replace function vowel_count()
returns text
begin
    return  concat(
       concat (' a: ', (LENGTH(@str) - LENGTH(REPLACE(@str, 'a', '')))/LENGTH('a')) ,
       concat (' e: ', (LENGTH(@str) - LENGTH(REPLACE(@str, 'e', '')))/LENGTH('e')) ,
       concat (' i: ', (LENGTH(@str) - LENGTH(REPLACE(@str, 'i', '')))/LENGTH('i')) ,
       concat (' o: ', (LENGTH(@str) - LENGTH(REPLACE(@str, 'o', '')))/LENGTH('o')) ,
       concat (' u: ', (LENGTH(@str) - LENGTH(REPLACE(@str, 'u', '')))/LENGTH('u'))
     );
end;

select vowel_count();

select strcmp('dba i', 'dba i');

#verifica si una cadena leila al reves  es la misma cadena
CREATE or replace FUNCTION CADENACAPICUA(cadena TEXT,cadena1 text)
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

select CADENACAPICUA('dba i', 'dba ii');


create table clientes(
    id_client varchar (20) primary key auto_increment,
    fullname varchar(20),
    lastnname varchar(20),
    age integer,
    genero char
);

insert into clientes values (1,'daniel','orivaldo',19,'M');
insert into clientes values (2,'gustavo','silva',20,'F');
insert into clientes values (3,'roberto','carlos',22,'M');
insert into clientes values (4,'roberto','carlos',23,'M');

create or replace function edadMaxima ()
returns text
begin
declare respuesta text default '';
declare limite int;
declare x int;
select max(cli.age) into limite
from clientes as cli;
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

select edadMaxima();


CREATE OR REPLACE FUNCTION fibonacci(limite INT)
RETURNS text
DETERMINISTIC
BEGIN
    DECLARE fib1 INT DEFAULT 0;
    DECLARE fib2 INT DEFAULT 1;
    DECLARE fib3 INT DEFAULT 0;
    DECLARE str VARCHAR(255) DEFAULT '0, 1 ,';

    IF limite = 1 THEN
        RETURN fib1;
    ELSEIF limite = 2 THEN
        RETURN CONCAT(fib1, fib2,', ');
    ELSE
        WHILE limite > 2 DO
            SET fib3 = fib1 + fib2;
            SET fib1 = fib2;
            SET fib2 = fib3;
            SET limite = limite - 1;
            SET str = CONCAT(str, fib3,', ');
        END WHILE;
        RETURN str;
    END IF;
END;

select fibonacci(1);

CREATE or replace FUNCTION CADENA(cadena TEXT)
RETURNS text

BEGIN
     DECLARE mensaje text default '';
      set mensaje=reverse(cadena);
 RETURN mensaje;
END;

select CADENA('palindrome');















