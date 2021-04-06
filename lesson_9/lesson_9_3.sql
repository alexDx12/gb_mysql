/* Задача 1 -
 * Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от
 * текущего времени суток. С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с
 * 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый
 * вечер", с 00:00 до 6:00 — "Доброй ночи".
*/

-- создание функции
DELIMITER //
DROP FUNCTION IF EXISTS hello//
CREATE FUNCTION hello()
RETURNS TINYTEXT DETERMINISTIC -- NOT DETERMINISTIC выдает ошибку!
BEGIN
	DECLARE current_hour INT;
	SET current_hour = HOUR(NOW());
	CASE 
		WHEN current_hour BETWEEN 0 AND 5 THEN
			RETURN 'Доброй ночи!';
		WHEN current_hour BETWEEN 6 AND 11 THEN
			RETURN 'Доброе утро!';
		WHEN current_hour BETWEEN 12 AND 17 THEN
			RETURN 'Добрый день!';
		WHEN current_hour BETWEEN 18 AND 23 THEN
			RETURN 'Добрый вечер!';
	END CASE;
END//

-- вызов функции
SELECT hello()//

/* Задача 2
 * В таблице products есть два текстовых поля: name с названием товара и description с его
 * описанием. Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля
 * принимают неопределенное значение NULL неприемлема. Используя триггеры, добейтесь
 * того, чтобы одно из этих полей или оба поля были заполнены. При попытке присвоить полям
 * NULL-значение необходимо отменить операцию.
 */

-- создание триггера
DELIMITER //
CREATE TRIGGER validate_name_description_insert BEFORE INSERT ON products
FOR EACH ROW BEGIN
	IF NEW.name IS NULL AND NEW.description IS NULL THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Both name and description are NULL';
	END IF;
END//

-- вызов сработки триггера
DELIMITER //
INSERT INTO products
	(name, description, price, catalog_id)
VALUES
	(NULL, NULL, 9360.00, 2)//

/* Задача 3
* (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи.
* Числами Фибоначчи называется последовательность в которой число равно сумме двух
* предыдущих чисел. Вызов функции FIBONACCI(10) должен возвращать число 55.
*/

-- создание функции вычисления числа Фибоначчи по формуле Бине
DELIMITER //
DROP FUNCTION IF EXISTS FIBONACCI//
CREATE FUNCTION FIBONACCI(num INT)
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE fs DOUBLE;
	SET fs = SQRT(5);
	RETURN (POW((1 + fs) / 2.0, num) + POW((1 - fs) / 2.0, num)) / fs;
END//

-- вызов функции
DELIMITER //
SELECT fibonacci(10)//