create database defensa_hito4;
use defensa_hito4;

create table departamento(
    id_dep int primary key not null,
    nombre varchar(50)
);

create table provincia(
    id_prov int primary key not null,

    nombre varchar(50),
    id_dep int,
    foreign key (id_dep) references departamento(id_dep)
);

create table proyecto(
    id_proy int primary key,
    nombreProy varchar(100),
    tipoProy varchar(30)
);

create table detalle_proyecto(
    id_dp int primary key not null,

    id_proy int,
    id_per int,
    foreign key (id_proy) references  proyecto (id_proy),
    foreign key (id_per) references  persona (id_per)
);

create table persona(
    id_per int primary key not null,
    nombre varchar(20),
    apellidos varchar(50),
    fecha_nac date,
    edad int,
    email varchar(50),

    id_dep int,
    id_prov int,
    foreign key (id_dep) references departamento (id_dep),
    foreign key (id_prov) references provincia (id_prov),
    sexo char(1)
);

insert into departamento values(1,'Curitiba');
insert into departamento values(2,'Sao paulo');

insert into provincia values(1,'acre',1);
insert into provincia values(2,'alagoas',1);

insert into persona values(1,'jose','perez', '1990-01-01', 30, 'jose@gail.com', 1, 1, 'M');
insert into persona values(2,'maria','perez', '1990-01-01', 30, 'maria', 1, 1, 'F');

insert into proyecto values(1,'proyecto1','tipo1');
insert into proyecto values(2,'proyecto2','tipo2');

insert into detalle_proyecto values(1,1,1);
insert into detalle_proyecto values(2,2,2);

#manejo de triggers
#crear una tabla de auditoria de nombre audit_proyectos
#la tabla audit_proyectos tiene 7 campos
#nombre_proy_anterior varchar(30)
#nombre_proy_posterior varchar(30)
#tipo_proy_anterior varchar(30)
# tipo_proy_posterior varchar(30)
#operation varchar(30)
#userId varchar(30)
#hostname varchar(30)
#crear un trigger para el evento update de la tabla proyecto
#cada vez que se modifique un registro de la tabla proyecto
#se tiene que almacenar en la tabla audit_proyectos los siguientes datos
#anterior= valores antes de la modificacion
#posterior= valores despues de la modificacion
#operation= update

create table audit_proyectos(
    nombre_proy_anterior varchar(30),
    nombre_proy_posterior varchar(30),
    tipo_proy_anterior varchar(30),
    tipo_proy_posterior varchar(30),
    operation varchar(30),
    userId varchar(30),
    hostName varchar(30)
);

create trigger audit_proyectos_update
before update on proyecto
for each row
begin
    insert into audit_proyectos values(old.nombreProy, new.nombreProy, old.tipoProy, new.tipoProy, 'update', user(), @@hostName);
end;

update proyecto set nombreProy='proyecto3' where id_proy=1;

#crear una vista que muestre los siguientes campos
#nombre: Jose
#apellido: perez
#proyecto: proyecto3
#tipoProy: tipo1
#fullName = Jose perez
#desc_proyecto = proyecto3 : tipo1
#departamento: Curitiba
#provincia: acre
#id_dep = 1
#si el nombre de departamento es curitiba el departamento entonces la nueva columa llamado codigo_depp es CUR
#si es nombre de departamento es sao paulo el departamento entonces la nueva columa llamado codigo_depp es SP

create OR REPLACE view vista_proyecto as
select per.nombre, per.apellidos, pr.nombreProy, pr.tipoProy,
       concat(per.nombre, ' ', per.apellidos) as fullName,
       concat(pr.nombreProy, ' : ', pr.tipoProy) as desc_proyecto,
       dep.nombre as departamento,
       dep.id_dep, pr.id_proy,
       case
            when dep.nombre = 'Curitiba' then 'CUR'
            when dep.nombre = 'Sao Paulo' then 'SP'
        end as codigo_dep
from persona per
inner join detalle_proyecto dp on per.id_per = dp.id_per
inner join proyecto pr on dp.id_proy = pr.id_proy
inner join departamento dep on per.id_dep = dep.id_dep
inner join provincia prov on per.id_prov = prov.id_prov;

select * from vista_proyecto;

