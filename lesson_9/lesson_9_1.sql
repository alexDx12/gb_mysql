/* Задача 1 +
 * В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
 * Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте
 * транзакции.
 */

-- приведение структуры таблицы users базы данных sample к структуре таблицы users базы данных shop
ALTER TABLE sample.users
ADD COLUMN birthday_at DATE,
ADD COLUMN created_at DATETIME,
ADD COLUMN updated_at DATETIME;

-- реализация транзакции
START TRANSACTION;
INSERT INTO sample.users (name, birthday_at, created_at, updated_at)
SELECT name, birthday_at, created_at, updated_at FROM shop.users
WHERE id = 1;
DELETE FROM shop.users
WHERE id = 1;
COMMIT;

/* Задача 2 +
 * Создайте представление, которое выводит название name товарной позиции из таблицы
 * products и соответствующее название каталога name из таблицы catalogs.
 */

-- создание представления
CREATE OR REPLACE VIEW tbl1 (products_name, catalogs_name)
AS SELECT products.name, catalogs.name FROM products, catalogs;
SELECT * FROM tbl1;

/* Задача 3 - не понятно условие задачи
 * (по желанию) Пусть имеется таблица с календарным полем created_at. В ней размещены
 * разряженые календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и
 * 2018-08-17. Составьте запрос, который выводит полный список дат за август, выставляя в
 * соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она
 * отсутствует.
 */

DROP TABLE IF EXISTS dates;
CREATE TABLE dates (
  id SERIAL PRIMARY KEY,
  created_at DATE
);

INSERT INTO dates (id, created_at)
VALUES
(DEFAULT, '2018-08-01'),
(DEFAULT,'2016-08-04'),
(DEFAULT, '2018-08-16'),
(DEFAULT, '2018-08-17');

/* Задача 4 -
 * (по желанию) Пусть имеется любая таблица с календарным полем created_at. Создайте
 * запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих
 * записей.
 */

INSERT INTO users (id)
VALUES
(DEFAULT),
(DEFAULT),
(DEFAULT),
(DEFAULT),
(DEFAULT);

SELECT * FROM users;