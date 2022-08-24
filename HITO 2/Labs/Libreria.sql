create database libreria;
use libreria;

create table categories
(
    category_id integer auto_increment primary key not null,
    name varchar (20)
);

create table publishers
(
    publishers_id int auto_increment primary key not null,
    name varchar(20)
);

create table books
(
    book_id int auto_increment primary key not null,
    title varchar (20),
    isbn varchar (20),
    publisher_date date,
    description varchar (20),
    category_id int,
    publisher_id int,


    foreign key (category_id)references categories(category_id),
    foreign key (publisher_id)references publishers(publishers_id)
);