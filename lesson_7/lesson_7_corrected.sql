/* Задача 1
 * Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
 */

-- выбор основных параметров описания пользователей
SELECT id, name, birthday_at FROM users;

-- выбор данных таблицы orders
SELECT * FROM orders;

-- заполнение данными таблицы orders
INSERT INTO orders (user_id)
SELECT id FROM users WHERE name = 'Геннадий';

-- выбор данных таблицы orders_products
SELECT * FROM orders_products;

-- заполнение данными таблицы orders_products
INSERT INTO orders_products (order_id, product_id, total)
SELECT LAST_INSERT_ID(), id, 2 FROM products
WHERE name = 'Intel Core i5-7400';

-- заполнение данными таблицы orders
INSERT INTO orders (user_id)
SELECT id FROM users WHERE name = 'Наталья';

-- заполнение данными таблицы orders_products
INSERT INTO orders_products (order_id, product_id, total)
SELECT LAST_INSERT_ID(), id, 1 FROM products
WHERE name IN ('Intel Core i5-7400', 'Gigabyte H310M S2H');

-- заполнение данными таблицы orders
INSERT INTO orders (user_id)
SELECT id FROM users WHERE name = 'Иван';

-- заполнение данными таблицы orders_products
INSERT INTO orders_products (order_id, product_id, total)
SELECT LAST_INSERT_ID(), id, 1 FROM products
WHERE name IN ('AMD FX-8320', 'ASUS ROG MAXIMUS X HERO');

-- выбор пользователей, которые осуществили хотя бы один заказ
SELECT
	id,
	name,
	birthday_at
FROM users
WHERE id IN (
SELECT DISTINCT user_id
FROM orders
);

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

-- вывод список рейсов с русскими названиями городов
SELECT
	`id`,
	(SELECT name FROM cities WHERE label = flights.`from`) AS `from`,
	(SELECT name FROM cities WHERE label = flights.`to`) AS `to`
FROM flights;