/* Задача 1
 * Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users,
 * catalogs и products в таблицу logs помещается время и дата создания записи, название
 * таблицы, идентификатор первичного ключа и содержимое поля name.
*/

-- создание таблицы логов
CREATE TABLE logs (
	tablename VARCHAR(255) COMMENT 'Название таблицы',
	extenal_id INT COMMENT 'Первичный ключ таблицы tablename',
	name VARCHAR(255) COMMENT 'Поле name таблицы tablename',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) COMMENT = 'Журнал интернет-магазина' ENGINE=Archive;

-- создание триггера для таблицы users 
DELIMITER //
CREATE TRIGGER log_after_insert_to_users AFTER INSERT ON users
FOR EACH ROW BEGIN
	INSERT INTO logs (tablename, extenal_id, name) VALUES('users', NEW.id, NEW.name);
END//

-- заполнение таблицы users
INSERT INTO users (name, birthday_at) VALUES ('Alexander', '1990-10-05')//

-- создание триггера таблицы catalogs
DELIMITER //
CREATE TRIGGER log_after_insert_to_catalogs AFTER INSERT ON catalogs
FOR EACH ROW BEGIN
	INSERT INTO logs (tablename, extenal_id, name) VALUES('catalogs', NEW.id, NEW.name);
END//

-- создание триггера таблицы products
DELIMITER //
CREATE TRIGGER log_after_insert_to_products AFTER INSERT ON products
FOR EACH ROW BEGIN
	INSERT INTO logs (tablename, extenal_id, name) VALUES('products', NEW.id, NEW.name);
END//

-- заполнение таблицы catalogs
DELIMITER //
INSERT INTO catalogs (name) VALUES
('Оператиная память'),
 ('Жесткие диски'),
 ('Блоки питания')//

-- заполнение таблицы products
DELIMITER //
INSERT INTO products
	(name, description, price, catalog_id)
VALUES
	('ASUS PRIME Z370-P', 'HDMI, SATA3, PCI Express 3.0, USB 3.0, USB 3.1', 9360.00, 2)//
	
/* Задача 2
 * (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.
*/

-- создание таблицы samples
CREATE TABLE samples (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) COMMENT 'Имя покупателя',
	birthday_at DATE COMMENT 'Дата рождения',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	uploaded_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';
	
-- заполнение таблицы samples
INSERT INTO samples (name, birthday_at) VALUES
	('Геннадий', '1990-10-05'),
	('Наталья', '1984-11-12'),
	('Алксандр', '1985-05-20'),
	('Сергей', '1988-02-14'),
	('Иван', '1988-01-12'),
	('Мария', '1992-08-29'),
	('Аркадий', '1994-03-17'),
	('Ольга', '1981-07-10'),
	('Владимир', '1988-06-12'),
	('Екатерина', '1992-09-20');

-- заполнение таблицы users
INSERT INTO
	users (name, birthday_at)
SELECT
	fst.name,
	fst.birthday_at
FROM
	samples AS fst,
	samples AS snd,
	samples AS thd,
	samples AS fth,
	samples AS fif,
	samples AS sth;