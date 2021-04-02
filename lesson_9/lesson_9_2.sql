/* Задача 1
 * Создайте двух пользователей которые имеют доступ к базе данных shop. Первому
 * пользователю shop_read должны быть доступны только запросы на чтение данных, второму
 * пользователю shop — любые операции в пределах базы данных shop.
 */

-- создание нового пользователя
CREATE USER 'shop_read'@'localhost';

-- наделение созданного пользователя правами
GRANT SELECT, SHOW VIEW ON shop.* TO 'shop_read'@'localhost' IDENTIFIED BY ''; -- команда не срабатывает (SQL Error [1064] [42000])

-- создание нового пользователя
CREATE USER shop@localhost;

-- наделение созданного пользователя правами
GRANT ALL ON shop.* TO 'shop'@'localhost' IDENTIFIED BY ''; -- команда не срабатывает (SQL Error [1064] [42000])

/* Задача 2
 * (по желанию) Пусть имеется таблица accounts содержащая три столбца id, name, password,
 * содержащие первичный ключ, имя пользователя и его пароль. Создайте представление
 * username таблицы accounts, предоставляющий доступ к столбца id и name. Создайте
 * пользователя user_read, который бы не имел доступа к таблице accounts, однако, мог бы
 * извлекать записи из представления username.
 */

-- создание таблицы
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	password VARCHAR(255)
);

-- заполнение созданной таблицы
INSERT INTO accounts (name, password) VALUES
	('Геннадий', 'IHdjdnduU'),
	('Наталья', 'fghJklOP'),
	('Александр', 'ythdKL'),
	('Сергей', 'ffkYBBBdjd'),
	('Иван',  'jfdyhffnIOd'),
	('Мария', 'hfYidmTsj');
	
-- создание представления
CREATE VIEW username AS SELECT id, name FROM accounts;

-- создание пользователя
CREATE USER 'user_read'@'localhost';

-- наделение созданного пользователя правами
GRANT SELECT (id, name) ON shop.username TO 'user_read'@'localhost';