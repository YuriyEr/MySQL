-- lesson 07b

-- Task 01
-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

-- Проверяем на текущие данные
SELECT * FROM orders; -- заказов нет

-- корректируем исходные данные
ALTER TABLE orders 
CHANGE user_id user_id BIGINT UNSIGNED DEFAULT NULL;
ALTER TABLE orders 
ADD FOREIGN KEY (user_id) REFERENCES users(id)
ON UPDATE CASCADE
ON DELETE NO ACTION
; 
-- Добавляем произвольные данные
INSERT INTO orders (id, user_id, created_at, updated_at) VALUES 
(1, 1, NOW(), NOW()),
(2, 1, NOW(), NOW()),
(3, 2, NOW(), NOW())
;

-- выводим нужный результат

SELECT name, COUNT(*) AS NUM_Orders FROM users JOIN orders
ON users.id = user_id GROUP BY name
;

-- Task 02 
-- Выведите список товаров products и разделов catalogs, который соответствует товару.
SELECT * FROM catalogs JOIN products 
ON catalogs.id = products.catalog_id 
ORDER BY catalogs.id;

-- Task 03
/* (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
Поля from, to и label содержат английские названия городов, поле name — русское. 
Выведите список рейсов flights с русскими названиями городов. */

-- вводим исходные данные
DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
id SERIAL PRIMARY KEY,
`from` VARCHAR(255),
`to` VARCHAR(255)
);

INSERT INTO flights(`from`, `to`) VALUES 
('moscow', 'omsk'),
('novgorod', 'kazan'),
('irkutsk', 'moscow'),
('omsk', 'irkutsk'),
('moscow', 'kazan')
;

DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
id SERIAL PRIMARY KEY,
label VARCHAR(255),
name VARCHAR(255)
);

INSERT INTO cities(label, name) VALUES 
('moscow', 'Москва'),
('irkutsk', 'Иркутск'),
('novgorod', 'Новгород'),
('kazan', 'Казань'),
('omsk', 'Омск')
;

-- выводим результат
SELECT IDF, `FROM`, `TO` FROM 
(SELECT flights.id as IDF, name as `FROM` FROM flights JOIN cities ON `from` = label) as `from`
JOIN
(SELECT flights.id as IDT, name as `TO` FROM flights JOIN cities ON `to` = label) as `to`
ON idf = idt
ORDER BY IDF
;

