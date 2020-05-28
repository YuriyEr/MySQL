-- users
-- profiles
-- posts
-- communities
-- messages
-- media
-- likes
-- friends

-- for DBeaver connection successfully
set GLOBAL time_zone = '-3:00';

-- Check DB
DROP DATABASE IF EXISTS vk;
CREATE DATABASE vk;
USE vk;

-- Initial table
DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(50) COMMENT 'Фамилия',
    email VARCHAR(120) UNIQUE,
    phone INT(20) NOT NULL UNIQUE, 
    INDEX users_phone_idx(phone),
    INDEX users_firstname_lastname_idx(firstname),
    INDEX users_lastname_idx(lastname)
) COMMENT = 'Пользователи';

DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles` (
	user_id SERIAL PRIMARY KEY,
    gender CHAR(1) NOT NULL,
    birthday DATE NOT NULL,
	photo_id BIGINT UNSIGNED NULL,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE NOW(),
    hometown VARCHAR(100),
    
    FOREIGN KEY (user_id) REFERENCES users(id)
    	ON UPDATE CASCADE 
    	-- при изменении ключевого поля users(id) каскадно (во всех связанных таблицах) будет замен ID 
    	ON DELETE restrict
    	-- запрет на удаление записи в users(id) , если связанные таблицы имеют содержимое
) COMMENT = 'Информация о пользователе';

DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
	id SERIAL PRIMARY KEY,
	from_user_id BIGINT UNSIGNED NOT NULL,
    to_user_id BIGINT UNSIGNED NOT NULL,
    body TEXT NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    
    INDEX messages_from_user_id (from_user_id),
    INDEX messages_to_user_id (to_user_id),
    INDEX messages_to_created_at (created_at),
    
    FOREIGN KEY (from_user_id) REFERENCES users(id),
    FOREIGN KEY (to_user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS friend_requests;
CREATE TABLE friend_requests (
	initiator_user_id SERIAL,
	target_user_id BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (initiator_user_id, target_user_id),
    -- `status` TINYINT UNSIGNED,
    `status` ENUM('requested', 'approved', 'unfriended', 'declined'),
    -- `status` TINYINT UNSIGNED, -- в этом случае в коде хранили бы цифирный enum (0, 1, 2, 3...)
    created_at DATETIME DEFAULT NOW(),
	requested_at DATETIME DEFAULT NOW(),
	confirmed_at DATETIME,

	INDEX (initiator_user_id),
    INDEX (target_user_id),
    FOREIGN KEY (initiator_user_id) REFERENCES users(id),
    FOREIGN KEY (target_user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS communities;
CREATE TABLE communities(
	id SERIAL PRIMARY KEY,
	name VARCHAR(150),

	INDEX communities_name_idx(name)
) COMMENT = 'Сообщества';

DROP TABLE IF EXISTS users_communities;
CREATE TABLE users_communities(
	user_id BIGINT UNSIGNED NOT NULL,
	community_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT NOW(),
  
	PRIMARY KEY (user_id, community_id), -- чтобы не было 2 записей о пользователе и сообществе
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (community_id) REFERENCES communities(id)
);

DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types(
	id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS media;
CREATE TABLE media(
	id SERIAL PRIMARY KEY,
    media_type_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
  	body text,
    filename VARCHAR(255) NOT NULL,
    size INT,
	metadata JSON,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    INDEX (user_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (media_type_id) REFERENCES media_types(id)
);

-- добавлено состояние для лайков/дизлайков
DROP TABLE IF EXISTS likes_dislakes;
CREATE TABLE likes_dislakes(
	id SERIAL,
	state ENUM ('like', 'dislike'),
    user_id_for_like BIGINT UNSIGNED COMMENT 'Кому адресован лайк/дизлайк',
    user_id_init BIGINT UNSIGNED COMMENT 'От кого адресован лайк/дизлайк',
    media_id BIGINT UNSIGNED,
    messages_id BIGINT UNSIGNED, -- под лайками постов, понял лайки сообщений
    created_at DATETIME DEFAULT NOW(), 
    update_at DATETIME DEFAULT NOW() ON UPDATE NOW(), 
    
    INDEX (user_id_init, user_id_for_like, media_id, messages_id)
    PRIMARY KEY (user_id_init, user_id_for_like, media_id, messages_id), -- составной индекс, для отсутствия возможности многократных лайков одим пользователем одного ID контента
    FOREIGN KEY (user_id_for_like) REFERENCES users(id), 
    FOREIGN KEY (user_id_init) REFERENCES users(id),
    FOREIGN KEY (media_id) REFERENCES media(id),
    FOREIGN KEY (messages_id) REFERENCES messages(id),
);

DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
id SERIAL PRIMARY KEY,
name VARCHAR(255) NOT NULL,
body_text TEXT,
created_at DATETIME DEFAULT NOW(),
updated_at DATETIME DEFAULT NOW() ON UPDATE NOW(),

) COMMENT = 'Посты пользователей';

DROP TABLE IF EXISTS `photo_albums`;
CREATE TABLE `photo_albums` (
	`id` SERIAL,
	`name` varchar(255) DEFAULT NULL,
    `user_id` BIGINT UNSIGNED DEFAULT NULL,
    created_at DATETIME DEFAULT NOW(), 
    update_at DATETIME DEFAULT NOW() ON UPDATE NOW(), 
    
	PRIMARY KEY (`id`),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS `photos`;
CREATE TABLE `photos` (
	id SERIAL PRIMARY KEY,
	`album_id` BIGINT UNSIGNED NOT NULL,
	`media_id` BIGINT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT NOW(), 
    update_at DATETIME DEFAULT NOW() ON UPDATE NOW(), 

	FOREIGN KEY (album_id) REFERENCES photo_albums(id),
    FOREIGN KEY (media_id) REFERENCES media(id)
);
