/* Задача 1
 * В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
 * Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте
 * транзакции.
 */

-- активация базы данных
USE shop;

-- реализация транзакции
START TRANSACTION;
INSERT INTO sample.users SELECT * FROM shop.users WHERE id = 1;
DELETE FROM shop.users WHERE id = 1 LIMIT 1;
COMMIT;

/* Задача 2
 * Создайте представление, которое выводит название name товарной позиции из таблицы
 * products и соответствующее название каталога name из таблицы catalogs.
 */

-- создание представления
CREATE OR REPLACE VIEW products_catalogs 
AS SELECT 
	p.name AS product,
	c.name AS catalog
FROM
	products AS p
JOIN
	catalogs AS c
ON
	p.catalog_id = c.id;

/* Задача 3
 * (по желанию) Пусть имеется таблица с календарным полем created_at. В ней размещены
 * разряженые календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и
 * 2018-08-17. Составьте запрос, который выводит полный список дат за август, выставляя в
 * соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она
 * отсутствует.
 */

-- создание основной таблицы
DROP TABLE IF EXISTS posts;
CREATE TABLE IF NOT EXISTS posts (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  created_at DATE NOT NULL
);

-- заполнение основной таблицы данными 
INSERT INTO posts VALUES
(DEFAULT, 'первая запись', '2018-08-01'),
(DEFAULT,'вторая запись', '2016-08-04'),
(DEFAULT, 'третья запись', '2018-08-16'),
(DEFAULT, 'четвёртая запись', '2018-08-17');

-- создание дополнительной (временной) таблицы
CREATE TEMPORARY TABLE last_days (
	day INT
);

-- заполнеие дополнительной таблицы данными
INSERT INTO last_days VALUES
(0), (1), (2), (3), (4), (5), (6), (7), (8), (9), (10),
(11), (12), (13), (14), (15), (16), (17), (18), (19), (20),
(21), (22), (23), (24), (25), (26), (27), (28), (29), (30);

-- создание календаря
SELECT
	DATE(DATE('2018-08-31') - INTERVAL l.day DAY) AS day
FROM
	last_days AS l
ORDER BY day;

-- создание результирующего запроса
SELECT
	DATE(DATE('2018-08-31') - INTERVAL l.day DAY) AS day,
	NOT ISNULL(p.name) AS order_exist
FROM
	last_days AS l
LEFT JOIN
	posts AS p
ON
	DATE(DATE('2018-08-31') - INTERVAL l.day DAY) = p.created_at
ORDER BY
	day;

/* Задача 4
 * (по желанию) Пусть имеется любая таблица с календарным полем created_at. Создайте
 * запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих
 * записей.
 */

-- создание основной таблицы
DROP TABLE IF EXISTS posts;
CREATE TABLE IF NOT EXISTS posts (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  created_at DATE NOT NULL
);

-- заполнение основной таблицы данными 
INSERT INTO posts VALUES
(NULL, 'первая запись', '2018-11-01'),
(NULL,'вторая запись', '2018-11-02'),
(NULL, 'третья запись', '2018-11-03'),
(NULL, 'четвёртая запись', '2018-11-04'),
(NULL, 'пятая запись', '2018-11-05'),
(NULL, 'шестая запись', '2018-11-06'),
(NULL, 'седьмая запись', '2018-11-07'),
(NULL, 'восьмая запись', '2018-11-08'),
(NULL, 'девятая запись', '2018-11-09'),
(NULL, 'десятая запись', '2018-11-04');

-- создание финальной транзакции
START TRANSACTION;
PREPARE postdel FROM 'DELETE FROM posts ORDER BY created_at LIMIT ?';
SET @total = (SELECT COUNT(*) - 5 FROM posts);
EXECUTE postdel USING @total;
COMMIT;