USE SHOP;
set GLOBAL time_zone = '-3:00';

-- проверка на существование
-- позволяет выволнить код при повторном запуске скрипта
DROP TABLE IF EXISTS catalogs; 
-- создаем таблицу с наименованиями интернет магазинов, где id первичный ключ
CREATE TABLE catalogs (
id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(255) COMMENT 'Название раздела',
UNIQUE unique_name(name(10)) -- запрет на добавление уже вставленных ранее значений (на 10 символов)
) COMMENT = 'Название интернет магазина';

DROP TABLE IF EXISTS cat; 
CREATE TABLE cat (
id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(255) COMMENT 'Название каталога',
UNIQUE unique_name(name(10)) -- запрет на добавление уже вставленных ранее значений (на 10 символов)
) COMMENT = 'Название каталога магазина';

-- вставка данных построчно
-- INSERT INTO catalogs VALUES(NULL, 'Процессор');
-- или так
-- INSERT INTO catalogs(id,name) VALUES(NULL, 'Память');
-- или так
-- INSERT INTO catalogs(id,name) VALUES(DEFAULT, 'Видеокарта');
-- вставка данных многострочно 
INSERT IGNORE INTO catalogs VALUES
(NULL, 'Процессор'),
(NULL, 'Память'),
(NULL, 'Видеокарта ');

-- удаление данных 
-- DELETE FROM catalogs ; -- удаление всех записей
-- удаление данных 
-- DELETE FROM catalogs LIMIT 1; -- удаление первой записей
-- или по условию
DELETE FROM catalogs WHERE id > 1;

-- обновление данных
UPDATE
catalogs 
SET
name  = 'процессоры интел'
WHERE 
name  = 'Процессор';

-- копирование таблиц
INSERT INTO
cat
SELECT * FROM
catalogs ;
SELECT * FROM cat;

-- извлечение данных (или вывод на экран если не указан путь для результата)
SELECT * FROM catalogs; -- все столбцы
SELECT name, id FROM catalogs; -- конкретные в заданной последовательности

DROP TABLE IF EXISTS users; 
CREATE TABLE users (
-- id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
-- можно заменить на 
id SERIAL PRIMARY KEY, -- короткая запись
name VARCHAR(255) COMMENT 'Имя покупателя',
birthday_at DATE COMMENT 'Дата рождения',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания - автоматическая (во время записи)',
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время последнего обновления - автоматическая'
) COMMENT = 'Покупатели';

-- внесем пробную запись
INSERT INTO users (id, name, birthday_at) VALUE (1, 'hello', '1979-01-01');
SELECT * FROM users;


DROP TABLE IF EXISTS products;
CREATE TABLE products (
id SERIAL PRIMARY KEY,
name VARCHAR(255) COMMENT 'Название товара',
description TEXT COMMENT 'Описание',
price DECIMAL(11.2) COMMENT 'Цена',
catalog_id INT UNSIGNED,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания - автоматическая (во время записи)',
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время последнего обновления - автоматическая',
-- А создание индекса при инициализации таблицы
KEY index_of_catalog_id (catalog_id) 
) COMMENT = 'Товарные позиции';
-- Б создаем индекс для существующего столбца
-- CREATE INDEX index_of_catalog_id USING BTREE ON products(catalog_id);
-- удаление индекса из таблицы
-- DROP INDEX index_of_catalog_id ON products;
-- индекс можно задать и при создании таблицы - см А

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
id SERIAL PRIMARY KEY,
user_id INT UNSIGNED,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания - автоматическая (во время записи)',
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время последнего обновления - автоматическая',
KEY index_of_user_id(user_id)
) COMMENT = 'заказы';

DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
id SERIAL PRIMARY KEY,
order_id INT UNSIGNED,
product_id INT UNSIGNED,
total INT UNSIGNED DEFAULT 1 COMMENT 'Колличество заказанных позиций',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания - автоматическая (во время записи)',
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время последнего обновления - автоматическая'
-- составные индексы
-- KEY index_of_order_id(order_id, product_id),
-- KEY index_of_product_id(product_id, order_id)
) COMMENT = 'связывающая таблица';

DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts (
id INT UNSIGNED NOT NULL ,
user_id INT UNSIGNED,
started_at DATETIME,
finished_at DATETIME,
product_id INT UNSIGNED,
discount FLOAT UNSIGNED COMMENT 'от 0.0 до 1.0', -- как выполнить проверку поступающего значения?
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания - автоматическая (во время записи)',
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время последнего обновления - автоматическая',
KEY index_of_user_id(user_id),
KEY index_of_product_id(product_id)
) COMMENT = 'скидка';

DROP TABLE IF EXISTS storehouse;
CREATE TABLE storehouse (
id SERIAL PRIMARY KEY,
name CHAR(255) COMMENT 'название склада',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания - автоматическая (во время записи)',
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время последнего обновления - автоматическая'
) COMMENT = 'Склады хранения';

DROP TABLE IF EXISTS storehouse_products;
CREATE TABLE storehouse_products (
id SERIAL PRIMARY KEY,
products_id INT UNSIGNED,
storehouse_id INT UNSIGNED,
value INT UNSIGNED COMMENT 'запас товарной позиции на складе',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания - автоматическая (во время записи)',
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время последнего обновления - автоматическая'
) COMMENT = 'Запас продуктов на складе';

