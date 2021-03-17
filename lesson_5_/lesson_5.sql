/* Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение”.
*/

/* Задача 1
 * Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их
 * текущими датой и временем.
*/
-- добавление полей created_at и updated_at в таблицу users
ALTER TABLE users
    ADD created_at DATETIME,
    ADD updated_at DATETIME
;
-- заполнение полей created_at и updated_at текущими датой и временем
UPDATE users
    SET
        created_at = NOW(),
        updated_at = NOW()
;

/* Задача 2
 * Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы
 * типом VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10".
 * Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.
*/
-- изменение типа полей created_at и updated_at в таблице users
ALTER TABLE users
	CHANGE COLUMN created_at created_at VARCHAR(255),
	CHANGE COLUMN updated_at updated_at VARCHAR(255)
;
-- перезаполнение полей created_at и updated_at
UPDATE users
	SET
		created_at = "20.10.2017 8:10",
		updated_at = "20.10.2017 8:10"
WHERE
	id BETWEEN 1 AND 20
;
-- выборка данных в требуемом формате
SELECT
	STR_TO_DATE(created_at, '%d.%m.%Y %h:%i'),
	STR_TO_DATE(updated_at, '%d.%m.%Y %h:%i')
FROM
	users
;
-- преобразование данных в требуемый формат
UPDATE users
	SET
		created_at = STR_TO_DATE(created_at, '%d.%m.%Y %h:%i'),
		updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %h:%i')
WHERE
	id BETWEEN 1 AND 20
;
-- преобразование типа полей в требуемый формат
ALTER TABLE users
	CHANGE COLUMN created_at created_at DATETIME,
	CHANGE COLUMN updated_at updated_at DATETIME
;

/* Задача 3
 * В таблице складских запасов storehouses_products в поле value могут встречаться самые
 * разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы.
 * Необходимо отсортировать записи таким образом, чтобы они выводились в порядке
 * увеличения значения value. Однако, нулевые запасы должны выводиться в конце, после всех
 * записей.
 */
-- создание таблицы storehouses_products
DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE IF NOT EXISTS storehouses_products(
	id SERIAL,
	value INT
);
-- заполнение таблицы storehouses_products данными
INSERT storehouses_products(
	id, value)
VALUES
	(DEFAULT, 0),
	(DEFAULT, 2500),
	(DEFAULT, 0),
	(DEFAULT, 30),
	(DEFAULT, 500),
	(DEFAULT, 1)
;
-- выборка данных
SELECT
	value
FROM 
	storehouses_products
ORDER BY
IF 
    (value > 0, 0, 1), value;

/* Задача 4
 * (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и
 * мае. Месяцы заданы в виде списка английских названий ('may', 'august').
 */
-- выборка данных
SELECT
	user_id, birthday,
	CASE
		WHEN DATE_FORMAT(birthday, '%m') = 05 THEN 'may'
		WHEN DATE_FORMAT(birthday, '%m') = 08 THEN 'august'
	END AS 'month'
FROM
	users
;

/* Задача 5
 * (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM
 * catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.
 */
-- выборка данных
SELECT
	*
FROM catalogs
WHERE id IN (5, 1, 2)
ORDER BY
CASE
	WHEN id = 5 THEN 0
	WHEN id = 1 THEN 1
	WHEN id = 2 THEN 2
END
;

/* Практическое задание теме “Агрегация данных”.
*/

/* Задача 1
 * Подсчитайте средний возраст пользователей в таблице users.
 */
-- выборка данных
SELECT
AVG(
	TIMESTAMPDIFF(YEAR, birthday_at, NOW())
)
AS
	average_age
FROM
	users
;

/* Задача 2
* Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели.
* Следует учесть, что необходимы дни недели текущего года, а не года рождения.
*/
-- выборка данных
SELECT
DAYNAME(
	CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))
)
AS
	birthday_day,
COUNT(
	*
)
AS
	total
FROM
	users
GROUP BY
	birthday_day
;

/* Задача 3
 * (по желанию) Подсчитайте произведение чисел в столбце таблицы.
 */
-- создание таблицы integers
CREATE TABLE IF NOT EXISTS integers(
	id SERIAL PRIMARY KEY,
	value INT)
;
-- заполнение таблицы integers данными
INSERT integers(
	id,
	value)
VALUES
	(DEFAULT, 1),
	(DEFAULT, 2),
	(DEFAULT, 3),
	(DEFAULT, 4),
	(DEFAULT, 5)
;
-- выборка данных на основе математического правила: логарифм произведения равен сумме логарифмов
SELECT EXP(SUM(LN(value))) AS result FROM integers;