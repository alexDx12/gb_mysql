/* Задача 1
Установите СУБД MySQL. Создайте в домашней директории файл .my.cnf,
задав в нем логин и пароль, который указывался при установке.
*/
/* После установки СУБД MySQL на своей системе (macOS Big Sur), 
я создал в директории /etc/ файл my.cnf, при указании имени файла
.my.cnf (с точкой впереди) настройки не срабатывали
*/
-- содержание файла my.cnf
-- [client]
-- user=root
-- password=abc1234567

/* Задача 2
Создайте базу данных example, разместите в ней таблицу users, состоящую
из двух столбцов, числового id и строкового name.
*/
-- создание базы данных
DROP DATABASE IF EXISTS example;
CREATE DATABASE IF NOT EXISTS example;
-- создание таблиц
USE example;
DROP TABLE IF EXISTS users;
CREATE TABLE IF NOT EXISTS users (
	id SERIAL PRIMARY KEY,
    name VARCHAR(255)
    );
-- наполнение нужными данными
INSERT INTO users VALUES
	(DEFAULT, 'user_1'),
	(DEFAULT, 'user_2'),
	(DEFAULT, 'user_3');
-- выборки данных
SELECT * FROM users;

/* Задача 3
Создайте дамп базы данных example из предыдущего задания, разверните содержимое
дампа в новую базу данных sample.
*/
-- создание дампа базы данных example (команда в терминале)
-- /usr/local/mysql-8.0.23-macos10.15-x86_64/bin/mysqldump example > /Users/alexander/Desktop/example_dump.sql
-- создание базы данных
CREATE DATABASE IF NOT EXISTS sample;
-- развёртка дампа в новую базу данных sample (команда в терминале)
-- /usr/local/mysql-8.0.23-macos10.15-x86_64/bin/mysql sample < /Users/alexander/Desktop/example_dump.sql

/* Задача 4
(по желанию) Ознакомьтесь более подробно с документацией утилиты mysqldump. Создайте дамп единственной таблицы
help_keyword базы данных mysql. Причем добейтесь того, чтобы дамп содержал только первые 100 строк таблицы.
*/
-- создание дампа первых 100 строк таблицы help_keyword базы данных mysql (команда в терминале)
-- /usr/local/mysql-8.0.23-macos10.15-x86_64/bin/mysqldump --where="true limit 100" mysql help_keyword > /Users/alexander/Desktop/mysql_dump.sql