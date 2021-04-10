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