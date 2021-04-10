DROP TABLE IF EXISTS residence;
CREATE TABLE residence(
    residence_id SERIAL,
    user_id BIGINT UNSIGNED NOT NULL UNIQUE,
    residence_name ENUM('Moscow', 'New York', 'Paris', 'Tokyo'),

	INDEX residence_idx(residence_name),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS games;
CREATE TABLE games(
	game_id SERIAL,
    user_id BIGINT UNSIGNED NOT NULL,
    joined_at DATETIME DEFAULT NOW(),
    game_name ENUM('Game 1', 'Game 2', 'Game 3', 'Game 4'),

	INDEX game_idx(game_name),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS calls;
CREATE TABLE calls(
	call_id SERIAL,
	from_user_id BIGINT UNSIGNED NOT NULL,
    to_user_id BIGINT UNSIGNED NOT NULL,
    duration TIME,
    created_at DATETIME DEFAULT NOW(),
    call_type ENUM('video call', 'audio call'),

    FOREIGN KEY (from_user_id) REFERENCES users(id),
    FOREIGN KEY (to_user_id) REFERENCES users(id)
);