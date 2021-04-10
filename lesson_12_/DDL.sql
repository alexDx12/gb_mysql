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