-- !!! начало раздела DDL-операций (создание структуры базы данных) !!!

-- создание базы данных
DROP DATABASE IF EXISTS substance_properties;
CREATE DATABASE IF NOT EXISTS substance_properties;

-- выбор базы данных
USE substance_properties;

-- создание таблиц
DROP TABLE IF EXISTS `components`;
CREATE TABLE IF NOT EXISTS `components` (
	`id` BIGINT UNSIGNED NOT NULL UNIQUE,
	`formula` VARCHAR(255), -- в будущем возможно попробовать определить более подходящий тип с целью оптимизации
	`name` VARCHAR(255) -- в будущем возможно попробовать определить более подходящий тип с целью оптимизации
) COMMENT = 'components';

DROP TABLE IF EXISTS `molar_weight`;
CREATE TABLE IF NOT EXISTS `molar_weight` (
	`component_id` BIGINT UNSIGNED NOT NULL,
	`molar_weight` FLOAT, -- в будущем возможно попробовать определить более подходящий тип с целью оптимизации
	FOREIGN KEY (`component_id`) REFERENCES `components`(`id`)
) COMMENT = 'molar weight, g/mol';

DROP TABLE IF EXISTS `boiling_temperature`;
CREATE TABLE IF NOT EXISTS `boiling_temperature` (
	`component_id` BIGINT UNSIGNED NOT NULL,
	`boiling_temperature` FLOAT, -- в будущем возможно попробовать определить более подходящий тип с целью оптимизации
	`data_quality` SET('data', 'estimate', 'rough estimate'), -- в будущем возможно попробовать определить более подходящий тип с целью оптимизации
	FOREIGN KEY (`component_id`) REFERENCES `components`(`id`)
) COMMENT = 'boiling temperature, K';

DROP TABLE IF EXISTS `critical_temperature`;
CREATE TABLE IF NOT EXISTS `critical_temperature` (
	`component_id` BIGINT UNSIGNED NOT NULL,
	`critical_temperature` FLOAT, -- в будущем возможно попробовать определить более подходящий тип с целью оптимизации
	`data_quality` SET('data', 'estimate', 'rough estimate'), -- в будущем возможно попробовать определить более подходящий тип с целью оптимизации
	FOREIGN KEY (`component_id`) REFERENCES `components`(`id`)
) COMMENT = 'critical temperature, K';

DROP TABLE IF EXISTS `critical_pressure`;
CREATE TABLE IF NOT EXISTS `critical_pressure` (
	`component_id` BIGINT UNSIGNED NOT NULL,
	`critical_pressure` FLOAT, -- в будущем возможно попробовать определить более подходящий тип с целью оптимизации
	`data_quality` SET('data', 'estimate', 'rough estimate'), -- в будущем возможно попробовать определить более подходящий тип с целью оптимизации
	FOREIGN KEY (`component_id`) REFERENCES `components`(`id`)
) COMMENT = 'critical pressure, bar';

DROP TABLE IF EXISTS `critical_volume`;
CREATE TABLE IF NOT EXISTS `critical_volume` (
	`component_id` BIGINT UNSIGNED NOT NULL,
	`critical_volume` FLOAT, -- в будущем возможно попробовать определить более подходящий тип с целью оптимизации
	`data_quality` SET('data', 'estimate', 'rough estimate'), -- в будущем возможно попробовать определить более подходящий тип с целью оптимизации
	FOREIGN KEY (`component_id`) REFERENCES `components`(`id`)
) COMMENT = 'critical volume, ml/mol';

DROP TABLE IF EXISTS `critical_density`;
CREATE TABLE IF NOT EXISTS `critical_density` (
	`component_id` BIGINT UNSIGNED NOT NULL,
	`critical_density` FLOAT, -- в будущем возможно попробовать определить более подходящий тип с целью оптимизации
	`data_quality` SET('data', 'estimate', 'rough estimate'), -- в будущем возможно попробовать определить более подходящий тип с целью оптимизации
	FOREIGN KEY (`component_id`) REFERENCES `components`(`id`)
) COMMENT = 'critical density, g/ml';

DROP TABLE IF EXISTS `critical_compressibility_factor`;
CREATE TABLE IF NOT EXISTS `critical_compressibility_factor` (
	`component_id` BIGINT UNSIGNED NOT NULL,
	`critical_compressibility_factor` FLOAT, -- в будущем возможно попробовать определить более подходящий тип с целью оптимизации
	`data_quality` SET('data', 'estimate', 'rough estimate'), -- в будущем возможно попробовать определить более подходящий тип с целью оптимизации
	FOREIGN KEY (`component_id`) REFERENCES `components`(`id`)
) COMMENT = 'critical compressibility factor';

DROP TABLE IF EXISTS `acentric_factor`;
CREATE TABLE IF NOT EXISTS `acentric_factor` (
	`component_id` BIGINT UNSIGNED NOT NULL,
	`acentric_factor` FLOAT, -- в будущем возможно попробовать определить более подходящий тип с целью оптимизации
	`data_quality` SET('data', 'estimate', 'rough estimate'), -- в будущем возможно попробовать определить более подходящий тип с целью оптимизации
	FOREIGN KEY (`component_id`) REFERENCES `components`(`id`)
) COMMENT = 'acentric factor';

DROP TABLE IF EXISTS `parameters`;
CREATE TABLE IF NOT EXISTS `parameters` (
	`parameter_id` BIGINT UNSIGNED NOT NULL,
	`parameter` VARCHAR(255), -- в будущем возможно попробовать определить более подходящий тип с целью оптимизации
	`unit_of_measure` VARCHAR(100), -- в будущем возможно попробовать определить более подходящий тип с целью оптимизации
	`description` TEXT -- в будущем возможно попробовать определить более подходящий тип с целью оптимизации
) COMMENT = 'parameters description';

DROP TABLE IF EXISTS component_list;
CREATE TABLE component_list (
	`component_id` BIGINT UNSIGNED NOT NULL,
	`name` VARCHAR (255) -- в будущем возможно попробовать определить более подходящий тип с целью оптимизации
) COMMENT = 'user component list';

DROP TABLE IF EXISTS missed_values;
CREATE TABLE missed_values (
	`parameter_id` BIGINT UNSIGNED NOT NULL,
	`id_missed_values` TEXT -- в будущем возможно попробовать определить более подходящий тип с целью оптимизации
) COMMENT = 'missed values';

-- !!! конец раздела DDL-операций (создание структуры базы данных) !!!

-- !!! начало раздела DML-операций (управление данными) !!!

/* заполнение таблиц components, molar_weight, boiling_temperature, critical_volume, critical_compressibility_factor, critical_density и 
acentric factor выполняется путём импорта из файлов формата csv с помощью функционала DBeaver*/

-- заполнение таблицы вывода отсуствующих значений параметров
INSERT INTO missed_values (
	`parameter_id`,
	`id_missed_values`
) VALUES
	(5, (SELECT GROUP_CONCAT(component_id SEPARATOR ' , ') FROM molar_weight WHERE ISNULL(molar_weight) > 0)),
	(6, (SELECT GROUP_CONCAT(component_id SEPARATOR ' , ') FROM boiling_temperature WHERE ISNULL(boiling_temperature) > 0)),
	(7, (SELECT GROUP_CONCAT(component_id SEPARATOR ' , ') FROM critical_temperature WHERE ISNULL(critical_temperature) > 0)),
	(8, (SELECT GROUP_CONCAT(component_id SEPARATOR ' , ') FROM critical_pressure WHERE ISNULL(critical_pressure) > 0)),
	(9, (SELECT GROUP_CONCAT(component_id SEPARATOR ' , ') FROM critical_volume WHERE ISNULL(critical_volume) > 0)),
	(10, (SELECT GROUP_CONCAT(component_id SEPARATOR ' , ') FROM critical_density WHERE ISNULL(critical_density) > 0)),
	(11, (SELECT GROUP_CONCAT(component_id SEPARATOR ' , ') FROM critical_compressibility_factor WHERE ISNULL(critical_compressibility_factor) > 0)),
	(12, (SELECT GROUP_CONCAT(component_id SEPARATOR ' , ') FROM acentric_factor WHERE ISNULL(acentric_factor) > 0));

-- заполнение таблицы пользовательского списка компонентов
INSERT INTO component_list (
	component_id,
	name
) VALUES
	(30, 'formaldehyde'),
	(5, 'dibromodifluoromethane'),
	(20, 'fluoroform'),
	(38, 'formamide'),
	(65, 'dichlorotetrafluoroethane'),
	(3, 'bromotrichloromethane'),
	(43, 'ammonium thiocyanate'),
	(17, 'chlorodifluoromethane');

-- создание представления общей таблицы физико-химических свойств компонентов
CREATE OR REPLACE VIEW general_table (
	`name`,
	`formula`,
	`molar weight, g/mol`,
	`boiling temperature, K`,
	`critical pressure, bar`,
	`critical temperature, K`,
	`critical volume, ml/mol`,
	`critical compressibility factor`,
	`critical density, g/ml`,
	`acentric factor`
) AS
	SELECT
		c.name,
		c.formula,
		mw.molar_weight,
		bt.boiling_temperature,
		cp.critical_pressure,
		ct.critical_temperature,
		cv.critical_volume,
		ccf.critical_compressibility_factor,
		cd.critical_density,
		af.acentric_factor
	FROM
		components AS c
	JOIN
		molar_weight AS mw
	ON
		c.id = mw.component_id
	JOIN
		boiling_temperature AS bt
	ON
		c.id = bt.component_id
	JOIN
		critical_pressure AS cp
	ON
		c.id = cp.component_id
	JOIN
		critical_temperature AS ct
	ON
		c.id = ct.component_id
	JOIN
		critical_volume AS cv
	ON
		c.id = cv.component_id
	JOIN
		critical_compressibility_factor as ccf
	ON
		c.id = ccf.component_id
	JOIN
		critical_density AS cd
	ON
		c.id = cd.component_id
	JOIN
		acentric_factor AS af
	ON
		c.id = af.component_id;

-- создание представления проверки отсуствующих значений параметров
CREATE OR REPLACE VIEW parameters_check (
	`parameter`,
	`id missed values`
) AS
	SELECT
		p.`parameter`,
		mv.`id_missed_values`
	FROM
		parameters AS p
	JOIN
		missed_values AS mv
	ON
		p.parameter_id = mv.parameter_id;
	
-- процедура получения физико-химических свойств для пользовательского списка компонентов
DELIMITER //
DROP PROCEDURE IF EXISTS get_data//
CREATE PROCEDURE get_data ()
BEGIN
	SELECT
		cl.component_id,
		cl.name,
		mw.molar_weight,
		bt.boiling_temperature,
		cp.critical_pressure,
		ct.critical_temperature,
		cv.critical_volume,
		ccf.critical_compressibility_factor,
		cd.critical_density,
		af.acentric_factor
	FROM 
		component_list AS cl
	JOIN
		molar_weight AS mw
	ON
		cl.component_id = mw.component_id
	JOIN
		boiling_temperature AS bt
	ON
		cl.component_id = bt.component_id
	JOIN
		critical_pressure AS cp
	ON
		cl.component_id = cp.component_id
	JOIN
		critical_temperature AS ct
	ON
		cl.component_id = ct.component_id
	JOIN
		critical_volume AS cv
	ON
		cl.component_id = cv.component_id
	JOIN
		critical_compressibility_factor as ccf
	ON
		cl.component_id = ccf.component_id
	JOIN
		critical_density AS cd
	ON
		cl.component_id = cd.component_id
	JOIN
		acentric_factor AS af
	ON
		cl.component_id = af.component_id;
END//

-- вызов процедуры получения физико-химических свойств для списка компонентов
CALL get_data();

-- !!! конец раздела DML-операций (управление данными) !!!