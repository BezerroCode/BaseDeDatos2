create database Hito4;
use Hito4;

create table users(
id_user int auto_increment primary key not null,
fullname varchar(50) not null,
lastname varchar(50) not null,
age int not null,
email varchar(100) not null
);

insert into users(fullname,lastname,age,email)
values  ('user1','UserLastName1',20,'user1@gmail.com'),
        ('user2','UserLastName2',30,'user2@gmail.com'),
        ('user3','UserLastName3',40,'user3@gmail.com'),
        ('user4','UserLastName4',50,'user4@gmail.com'),
        ('user5','UserLastName5',60,'user5@gmail.com');

insert into users(fullname, lastname, age, email) values ('user6','UserLastName6',70,'user6@gmail.com');
insert into users(fullname, lastname, age, email) values ('user7','UserLastName7',70,'user7@gmail.com');

alter table users add column password varchar(50);

select * from users;

#cuantos son mayores a 40
select count(*)
from users
where age > 40;

#mostrar los usuarios mayores a 40 años
create or replace view user_mayor_40 as
select us.fullname as nombres_persona
     ,us.lastname as apellido_persona
     ,us.age as edad_persona
from users as us
where us.age> 40;

select us.*
from user_mayor_40 as us;

create function fullname()
returns text
begin
    return 'user1';
end;

select fullname();

#trigger
#un trigger se ejecuta de manera automatica
#cuando ocurre los seguientes eventos:
#INSERT, UPDATE, DELETE
#es decir cada vez que inserto o modifico o elimino el registro de una tabla
#ub trigger puede acceder a los datos de la tabla
#y lo hace atravez de los objetos NEW y OLD
#NEW: INSERT        representa los datos que se van a insertar o modificar
#OLD: DELETE        representa los datos que se van a eliminar
#NEW Y OLD =UPDATE

insert into users(fullname, lastname, age, email) values ('william','barra',70,'user8@gmail.com');
select * from users;

create trigger genera_password
before insert on users
for each row                             #before despues
begin
    set new.password = 'pass-123';
end;

create trigger genera_password_concat
before insert on users
for each row                                 #FOR EACH=PARA CADA FILA           before = despues
begin
    #substring de cada dos palabras inciales
    set new.password = concat(substring(new.fullname,1,2),substring(new.lastname,1,2),substring(new.age,1,2));
end;

create table numeros(
numero bigint primary key not null,
cuadrado bigint,
cubo bigint,
raiz_cuadrada real
);

#crear trigger
create or replace trigger calcular
before insert on numeros
for each row
begin
    set new.cuadrado = new.numero * new.numero;
    set new.cubo = pow(new.numero,3);
    set new.raiz_cuadrada = sqrt(new.numero);
end;

insert into numeros(numero) values (4);
select * from numeros;
