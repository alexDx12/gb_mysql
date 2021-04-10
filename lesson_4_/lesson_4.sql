/* 
 * Задача 1
 * Заполнить все таблицы БД vk данными (по 10-100 записей в каждой таблице).
 * 
 * Заполнение таблиц реализовано в скрипте fulldb-07-03-2021-19-12-beta.sql.
*/

/* Задача 2
 * Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке.
*/
SELECT DISTINCT firstname FROM USERS ORDER BY firstname;

/* Задача 3
 * Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = false).
 * Предварительно добавить такое поле в таблицу profiles со значением по умолчанию = true (или 1).
*/
-- корректировка таблицы
-- ALTER TABLE profiles DROP is_active;
ALTER TABLE profiles ADD is_active tinyint DEFAULT 1;
UPDATE profiles SET is_active = 0 WHERE TIMESTAMPDIFF(YEAR, birthday, NOW()) < 18;

/* Задача 4
 * Написать скрипт, удаляющий сообщения «из будущего» (дата больше сегодняшней).
*/
-- корректировка таблицы
DELETE FROM messages WHERE created_at > NOW();

/* Задача 5
 * Написать название темы курсового проекта (в комментарии).
 * 
 * Тема курсового проекта: "База данных физико-химических свойств веществ: Substance Properties Data Base (SPDB)."
 */
