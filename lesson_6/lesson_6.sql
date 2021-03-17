/* Задача 1
 * Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека,
 * который больше всех общался с выбранным пользователем (написал ему сообщений).
 */

-- выбор id пользователя, который больше всего написал сообщений пользователю с id = 1
SELECT from_user_id AS most_active_user
FROM messages
WHERE to_user_id = 1
GROUP BY from_user_id
ORDER BY COUNT(from_user_id) DESC
LIMIT 1;

-- выбор пользователя, который больше всего написал сообщений пользователю с id = 1
SELECT
	id,
	firstname,
	lastname
FROM users
WHERE id = (
	SELECT from_user_id AS most_active_user
	FROM messages
	WHERE to_user_id = 1
	GROUP BY from_user_id
	ORDER BY COUNT(from_user_id) DESC
	LIMIT 1
	);

/* Задача 2
 * Подсчитать общее количество лайков, которые получили пользователи младше 10 лет.
 */

-- выбор id пользователей младше 10 лет
SELECT user_id
FROM profiles
WHERE TIMESTAMPDIFF(YEAR, birthday, NOW()) < 10;

-- выбор id контента пользователей младше 10 лет
SELECT id
FROM media
WHERE user_id IN (
	SELECT user_id
	FROM profiles
	WHERE TIMESTAMPDIFF(YEAR, birthday, NOW()) < 10
	);

-- подсчёт общего количества лайков, которые получили пользователи младше 10 лет
SELECT COUNT(*)
FROM likes
WHERE media_id IN (
	SELECT id
	FROM media
	WHERE user_id IN (
		SELECT user_id
		FROM profiles
		WHERE TIMESTAMPDIFF(YEAR, birthday, NOW()) < 10
	)
);

/* Задача 3
 * Определить кто больше поставил лайков (всего): мужчины или женщины.
 */

-- выбор пользователей мужского пола
SELECT user_id, gender 
FROM profiles
WHERE gender = 'm';

-- выбор пользователей женского пола
SELECT user_id, gender 
FROM profiles
WHERE gender = 'f';

-- выбор id пользователей, поставивших лайки
SELECT user_id
FROM likes;

-- выбор id пользователей мужского пола, поставивших лайки
SELECT user_id
FROM likes
WHERE user_id IN (
	SELECT user_id 
	FROM profiles
	WHERE gender = 'm'
	);

-- выбор id пользователей женского пола, поставивших лайки
SELECT user_id
FROM likes
WHERE user_id IN (
	SELECT user_id 
	FROM profiles
	WHERE gender = 'f'
	);

-- подсчёт общего количества лайков, поставленных пользователями мужского пола
SELECT COUNT(*) AS men_likes
FROM likes
WHERE user_id IN (
	SELECT user_id
	FROM likes
	WHERE user_id IN (
		SELECT user_id 
		FROM profiles
		WHERE gender = 'm'
	)
);

-- подсчёт общего количества лайков, поставленных пользователями женского пола
SELECT COUNT(*) AS female_likes
FROM likes
WHERE user_id IN (
	SELECT user_id
	FROM likes
	WHERE user_id IN (
		SELECT user_id 
		FROM profiles
		WHERE gender = 'f'
	)
);

-- таблица распределения лайков между пользователями мужского и женского пола
SELECT 
	'men_likes' AS 'likes_type',
	COUNT(*) AS 'count_likes'
FROM likes
WHERE user_id IN (
	SELECT user_id
	FROM likes
	WHERE user_id IN (
		SELECT user_id 
		FROM profiles
		WHERE gender = 'm'
	)
)
UNION 
SELECT
	'female_likes' AS 'likes_type',
	COUNT(*) AS 'count_likes'
FROM likes
WHERE user_id IN (
	SELECT user_id
	FROM likes
	WHERE user_id IN (
		SELECT user_id 
		FROM profiles
		WHERE gender = 'f'
	)
);

-- выбор пола пользователей, поставивших болшее количество лайков
SELECT
	CASE
		WHEN (
		SELECT COUNT(*)
		FROM likes
		WHERE user_id IN (
			SELECT user_id
			FROM likes
			WHERE user_id IN (
				SELECT user_id 
				FROM profiles
				WHERE gender = 'm'
			)
		)
		) > (
		SELECT COUNT(*)
		FROM likes
		WHERE user_id IN (
			SELECT user_id
			FROM likes
			WHERE user_id IN (
				SELECT user_id 
				FROM profiles
				WHERE gender = 'f'
			)
		)
		)
		THEN 'men'
		ELSE 'female'
	END AS most_active_gender;
