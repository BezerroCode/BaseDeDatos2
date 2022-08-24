create database diagnostico;
use diagnostico;
create table estudent
(
    id_estudiante int primary key not null,
    nombre        varchar(20),
    apellidos     varchar(20),
    edad          int
);

insert into estudent (id_estudiante, nombre, apellidos, edad)
values (1, 'Mario', 'Castellon', 21);
insert into estudent (id_estudiante, nombre, apellidos, edad)
values (2, 'Daniel', 'Orivaldo', 21);

select *
from (estudent);

