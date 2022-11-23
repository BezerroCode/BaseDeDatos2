CREATE DATABASE biblioteca;
use biblioteca;

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

#Mostrar el título del libro, los nombres y apellidos, y la categoría de los usuarios que se
# prestaron libros donde la categoría sea COMEDIA o MANGA
SELECT bo.title, us.fullname, us.lastname, ca.type
FROM prestamos p
         INNER JOIN book bo ON p.id_book = bo.id_book
         INNER JOIN users us ON p.id_user = us.id_user
         INNER JOIN category ca ON bo.id_book = ca.id_book
WHERE ca.type = 'COMEDIA' OR ca.type = 'MANGA';

#crear consulta que muestre el titulo del libro, editorial y paginas del libro
create view bookContent as
select
    title as 'titleBook',
    editorial as 'editorialBook',
    pages as 'pagesBook'
from book as bk;

select bc.*
    from bookContent as bc;

#crear una funcion debera ser bookContent
#la funcion debera de tener las seguientes columnas (titleBook, editorialBook, pagesBook y typeContextBook)
#el objetivo es mostrar en la columna typeContextBook los siguientes mensajes:
#contenido basico: si la cantidad de paginas es mayor a 10 y menor igual a 30
#contenido mediano: si la cantidad de paginas es mayor a 30 y menor igual a 80
#contenido superior: si la cantidad de paginas es mayor a 80 y menor igual a 150
#contenido avanzado: si la cantidad de paginas es mayor a 150

create or replace function get_current_pages(pages integer)
returns text
    begin
        declare resultado text default '';
        case
            when pages > 10 and pages <= 30 then set resultado= 'contenido basico';
            when pages > 30 and pages <= 80 then set resultado= 'contenido mediano';
            when pages > 80 and pages <= 150 then set resultado='contenido superior';
            when pages > 150 then set resultado= 'contenido avanzado';
        end case;
        return resultado;
    end;
#usar la funcion en una vista
create or replace view bookContent as
select
    bk.title as 'titleBook',
    bk.editorial as 'editorialBook',
    bk.pages as 'pagesBook',
    get_current_pages(bk.pages) as 'typeContextBook'
from book as bk;

select bc.*
    from bookContent as bc;

#crear una vista debera ser bookContent
#la vista debera de tener las seguientes columnas (titleBook, editorialBook, pagesBook y typeContextBook)
#el objetivo es mostrar en la columna typeContextBook los siguientes mensajes:
#contenido basico: si la cantidad de paginas es mayor a 10 y menor igual a 30
#contenido mediano: si la cantidad de paginas es mayor a 30 y menor igual a 80
#contenido superior: si la cantidad de paginas es mayor a 80 y menor igual a 150
#contenido avanzado: si la cantidad de paginas es mayor a 150

create or replace view bookContent1 as
select
    bk.title as 'titleBook',
    bk.editorial as 'editorialBook',
    bk.pages as 'pagesBook',
    (case
        when bk.pages > 10 and pages <= 30 then 'contenido basico'
        when bk.pages > 30 and pages <= 80 then 'contenido mediano'
        when bk.pages > 80 and pages <= 150 then 'contenido superior'
        when bk.pages > 150 then 'contenido avanzado'
    end) as 'typeContextBook'
from book as bk;

select bc.*
    from bookContent1 as bc;

#el nombre de la vista debera ser bookAndUser
#la vista debera de tener las siguientes columnas (book_id, book_title, book_editorial, y categoria del libro)
#y (id_autor, nombre_autor)
#el objetivo es mostrar los libros donde cuyos autores sean de nacionalidad boliviana o argentina
create or replace view bookAndUser as
select
    bk.title as 'book_detail',
    au.name as 'autor_detail'
from book as bk
         inner join autor as au on bk.id_autor = au.id_autor
where au.nacionality = 'boliviana' or au.nacionality = 'argentina';

select bu.*
    from bookAndUser as bu;