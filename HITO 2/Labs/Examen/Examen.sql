create database hito2
use hito2

CREATE TABLE autor

(

    id_autor    INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,

    name        VARCHAR(100),

    nacionality VARCHAR(50)

);


CREATE TABLE book

(

    id_book   INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,

    codigo    VARCHAR(25)                        NOT NULL,

    isbn      VARCHAR(50),

    title     VARCHAR(100),

    editorial VARCHAR(50),

    pages     INTEGER,

    id_autor  INTEGER,

    FOREIGN KEY (id_autor) REFERENCES autor (id_autor)

);


CREATE TABLE category

(

    id_cat  INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,

    type    VARCHAR(50),

    id_book INTEGER,

    FOREIGN KEY (id_book) REFERENCES book (id_book)

);


CREATE TABLE users

(

    id_user  INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,

    ci       VARCHAR(15)                        NOT NULL,

    fullname VARCHAR(100),

    lastname VARCHAR(100),

    address  VARCHAR(150),

    phone    INTEGER

);


CREATE TABLE prestamos

(

    id_prestamo    INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,

    id_book        INTEGER,

    id_user        INTEGER,

    fec_prestamo   DATE,

    fec_devolucion DATE,

    FOREIGN KEY (id_book) REFERENCES book (id_book),

    FOREIGN KEY (id_user) REFERENCES users (id_user)

);


INSERT INTO autor (name, nacionality)

VALUES ('autor_name_1', 'Bolivia'),

       ('autor_name_2', 'Argentina'),

       ('autor_name_3', 'Mexico'),

       ('autor_name_4', 'Paraguay');


INSERT INTO book (codigo, isbn, title, editorial, pages, id_autor)

VALUES ('codigo_book_1', 'isbn_1', 'title_book_1', 'NOVA', 30, 1),

       ('codigo_book_2', 'isbn_2', 'title_book_2', 'NOVA II', 25, 1),

       ('codigo_book_3', 'isbn_3', 'title_book_3', 'NUEVA SENDA', 55, 2),

       ('codigo_book_4', 'isbn_4', 'title_book_4', 'IBRANI', 100, 3),

       ('codigo_book_5', 'isbn_5', 'title_book_5', 'IBRANI', 200, 4),

       ('codigo_book_6', 'isbn_6', 'title_book_6', 'IBRANI', 85, 4);


INSERT INTO category (type, id_book)

VALUES ('HISTORIA', 1),

       ('HISTORIA', 2),

       ('COMEDIA', 3),

       ('MANGA', 4),

       ('MANGA', 5),

       ('MANGA', 6);


INSERT INTO users (ci, fullname, lastname, address, phone)

VALUES ('111 cbba', 'user_1', 'lastanme_1', 'address_1', 111),

       ('222 cbba', 'user_2', 'lastanme_2', 'address_2', 222),

       ('333 cbba', 'user_3', 'lastanme_3', 'address_3', 333),

       ('444 lp', 'user_4', 'lastanme_4', 'address_4', 444),

       ('555 lp', 'user_5', 'lastanme_5', 'address_5', 555),

       ('666 sc', 'user_6', 'lastanme_6', 'address_6', 666),

       ('777 sc', 'user_7', 'lastanme_7', 'address_7', 777),

       ('888 or', 'user_8', 'lastanme_8', 'address_8', 888);


INSERT INTO prestamos (id_book, id_user, fec_prestamo, fec_devolucion)

VALUES (1, 1, '2017-10-20', '2017-10-25'),

       (2, 2, '2017-11-20', '2017-11-22'),

       (3, 3, '2018-10-22', '2018-10-27'),

       (4, 3, '2018-11-15', '2017-11-20'),

       (5, 4, '2018-12-20', '2018-12-25'),

       (6, 5, '2019-10-16', '2019-10-18');


#Mostrar el título del libro, los nombres y apellidos, y la categoría de los usuarios que se prestaron libros donde la categoría sea COMEDIA o MANGA
#Resultado esperado: (8:15)

select concat(us.fullname,' ',us.lastname) as Nombre_Completo, us.ci as 'ci_user',c.type,b.title as 'libro prestado'
    from users as us
    inner join prestamos as pres on us.id_user = pres.id_user
    inner join book b on pres.id_book = b.id_book
    inner join category c on b.id_book = c.id_book
where c.type='comedia' or c.type ='manga'

#se desea saber cuantos usuarios se prestaron libros de la editorial ibrani y que la cantidad de sus paginas sea mayor a 90
create or replace function getEditorial(editorial varchar(20),pages int)
returns varchar(40)
begin
declare respuesta varchar(40);
    select concat(b.editorial) into respuesta
    from users as us
    inner join prestamos as pres on us.id_user = pres.id_user
    inner join book b on pres.id_book = b.id_book
    where b.editorial=editorial and b.pages>pages;
return respuesta;
end;

select getEditorial('IBRANI',90) as IBRANI_90;


#Se desea saber qué libros se prestaron de la categoría MANGA y la editorial IBRIANI
#Deberá de crear una función que verifique si es par o no y retornar un TEXT que indique PAR o IMPAR adicionalmente concatenado el número de páginas.
#Esta función recibe como parámetro la cantidad de páginas.
#La función deberá ser usada en la cláusula SELECT.
#Deberá de crear una función que concatena cadenas.
#Se tiene el siguiente comportamiento esperado. (Debe de usar los mismos alias que de la imagen)

create or replace function get_par_impar(pags int)
returns varchar(20)
begin
    DECLARE pags varchar(20);
   set pags=  case when pags%2=0 then 'par' else 'impar' end;
return pags;
end;

SELECT get_par_impar(8);

#Modulo = CASE WHEN Count(*) % 2 = 0 THEN 'Par' ELSE 'Impar' END

create or replace function getV1(editorial varchar(20),categoria varchar(20))
returns varchar(40)
begin
declare respuesta varchar(40);
    select concat('editorial: ',editorial,' ','categoria: ',categoria) as description into respuesta;
return respuesta;
end;


    select getv1(b.editorial,c.type), concat (b.pages,': ', get_par_impar(b.pages))
    from users as us
    inner join prestamos as pres on us.id_user = pres.id_user
    inner join book b on pres.id_book = b.id_book
    inner join category c on b.id_book = c.id_book
    where b.editorial='IBRANI' and c.type='MANGA';

select count(b.id_book)
    from book as b
    inner join prestamos p on b.id_book = p.id_book
where p.fec_prestamo like '2018%'