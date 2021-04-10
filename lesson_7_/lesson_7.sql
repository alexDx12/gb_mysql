/* Задача 1
 * Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
 */

SELECT DISTINCT user_id
FROM orders;

/* Задача 2
* Выведите список товаров products и разделов catalogs, который соответствует товару.
*/

SELECT
	products.name,
	catalogs.name
FROM 
	products
JOIN
	catalogs
WHERE
	catalogs.id = products.catalog_id
	
/* Задача 3
 * (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
 * Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов 
 * flights с русскими названиями городов.
 */

-- создание таблицы flights
DROP TABLE IF EXISTS flights;
CREATE TABLE IF NOT EXISTS flights (
	id SERIAL PRIMARY KEY,
	`from` VARCHAR(255),
	`to` VARCHAR(255)
);

-- создание таблицы cities
DROP TABLE IF EXISTS cities;
CREATE TABLE IF NOT EXISTS cities (
	`label` VARCHAR(255),
	`name` VARCHAR(255)
);

-- заполнение таблицы flights
INSERT INTO flights
	(`from`, `to`)
VALUES
	('moscow', 'omsk'),
	('novgorod', 'kazan'),
	('irkutsk', 'moscow'),
	('omsk', 'irkutsk'),
	('moscow', 'kazan');

-- заполнение таблицы cities
INSERT INTO cities
	(`label`, `name`)
VALUES
	('moscow', 'Москва'),
	('irkutsk', 'Иркутск'),
	('novgorod', 'Новгород'),
	('kazan', 'Казань'),
	('omsk', 'Омск');

/* ПОКА РЕШЕНИЯ ЗАДАЧИ НЕ НАЙДЕНО */ 

/*
SELECT name AS `from`
FROM cities
WHERE label = (SELECT `from` FROM flights);

SELECT name AS `to`
FROM cities
WHERE label IN (SELECT `from` FROM flights);

SELECT name AS `to`
FROM cities
WHERE label IN (SELECT `from` FROM flights);


SELECT
	cities.name,
FROM
	cities
JOIN
	cities
ON
	cities.label = flight.`from`;
*/
/*
ALTER TABLE cities 
ADD FOREIGN KEY (`label`)
REFERENCES flights (id);
*/

