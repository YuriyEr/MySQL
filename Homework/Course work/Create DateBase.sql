DROP DATABASE IF EXISTS SolarCentury;

CREATE DATABASE SolarCentury;
USE SolarCentury;

CREATE TABLE users (
  `id` SERIAL PRIMARY KEY,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `email` varchar(120) NOT NULL,
  `phone` bigint NOT NULL,
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`),
  KEY `users_phone_idx` (`phone`),
  KEY `users_firstname_lastname_idx` (`firstname`,`lastname`)
);

CREATE TABLE planets (
  `id` SERIAL PRIMARY KEY,
  `name` varchar(50) NOT NULL,
  UNIQUE KEY `name` (`name`),
  KEY `id_idx` (`id`),
  KEY `name_idx` (`name`)
);

CREATE TABLE tours (
  `id` SERIAL PRIMARY KEY,
  `name` varchar(50) NOT NULL,
  `planet_from_id` BIGINT UNSIGNED NOT NULL,
  `planet_to_id` BIGINT UNSIGNED NOT NULL,
  `starship_id` BIGINT UNSIGNED NOT NULL,
  `hotels_id` BIGINT UNSIGNED NOT NULL,
  `price` BIGINT UNSIGNED NOT NULL,
  KEY `id_idx` (`id`),
  KEY `name_idx` (`name`)
  FOREIGN KEY (`planet_from_id`) REFERENCES planets (`id`),
  FOREIGN KEY (`planet_to_id`) REFERENCES planets (`id`),
);

CREATE TABLE starships (
  `id` SERIAL PRIMARY KEY,
  `name` varchar(50) NOT NULL,
  `speed` BIGINT UNSIGNED NOT NULL,
  `class` ENUM("A","B","C","VIP") NOT NULL,
  `capacity_people` ENUM("A","B","C","VIP") NOT NULL,
  `year_of_manufacture` YEAR NOT NULL,
  UNIQUE KEY `name` (`name`),
  KEY `id_idx` (`id`),
  KEY `name_idx` (`name`)
);

CREATE TABLE orders (
  `id` SERIAL PRIMARY KEY,
  `tours_id` BIGINT UNSIGNED NOT NULL,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `payments_id` BIGINT UNSIGNED NOT NULL,
  `date_at` DATETIME DEFAULT NOW()
); 

CREATE TABLE dangers (
  `id` SERIAL PRIMARY KEY,
  `type_dangerous` ENUM('planet','space'),
  `date_start` DATETIME DEFAULT NOW(),
  `date_finish` DATETIME NOT NULL,
  `planet_id` BIGINT UNSIGNED NOT NULL
); 

CREATE TABLE hotels (
  `id` SERIAL PRIMARY KEY,
  `name` varchar(50) DEFAULT NULL,
  `class` ENUM("A","B","C","VIP") NOT NULL,
  `capacity_people` BIGINT UNSIGNED NOT NULL,
  `year_of_manufacture` YEAR NOT NULL,
  `planet_id` BIGINT UNSIGNED NOT NULL,
  KEY `id_idx` (`id`),
  KEY `name_idx` (`name`)
); 

CREATE TABLE payments (
  `id` SERIAL PRIMARY KEY,
  `state` ENUM("purchased","failed","restored") NOT NULL,
  `date_at` DATETIME DEFAULT NOW(),
  `count` BIGINT UNSIGNED NOT NULL,
  KEY `id_idx` (`id`),
  KEY `count_idx` (`count`)
); 

CREATE TABLE discont (
 `id` SERIAL PRIMARY KEY,
 `discount_index` FLOAT UNSIGNED DEFAULT 1,
 `date_start` DATETIME DEFAULT NOW(),
 `date_finish` DATETIME NOT NULL,
 `tour_id` BIGINT UNSIGNED NOT NULL,
 KEY `id_idx` (`id`),
 KEY `discount_index_idx` (`discount_index`)
); 

CREATE TABLE logDB (
 `paiment_id` BIGINT UNSIGNED,
 `date_change_state` DATETIME DEFAULT NOW(),
 `paiment_user` BIGINT UNSIGNED
);

