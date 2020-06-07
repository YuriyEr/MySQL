-- запускать данный скрипт после выполнения init_BD_shop_create.sql 

USE shop;

-- Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение” --

-- 1 задание
/* Пусть в таблице users поля created_at и updated_at оказались незаполненными. 
 * Заполните их текущими датой и временем.
 */

UPDATE users  SET created_at = NOW(), 
updated_at = NOW(); 
-- SELECT * FROM users;

-- Задание 2 - противоречит логике задания 1, пропустил, вместо сделал все доп задания

-- Задание 3
/* В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры:
 *  0, если товар закончился и выше нуля, если на складе имеются запасы. 
 * Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. 
 * Однако, нулевые запасы должны выводиться в конце, после всех записей.
 * */

TRUNCATE TABLE shop.storehouses_products;
INSERT INTO storehouses_products (storehouse_id, product_id , value ) VALUES 
(1, 1, 0),
(1, 1, 2500),
(1, 1, 0),
(1, 1, 30),
(1, 1, 500),
(1, 1, 1);

SELECT value,
CASE 
WHEN value > 0 THEN 0
ELSE 1 
END AS newRow
FROM storehouses_products ORDER BY newRow , value 
;

-- Задание 4
/* (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. 
Месяцы заданы в виде списка английских названий ('may', 'august') */

SELECT * FROM users WHERE MONTH(birthday_at) = 5 OR MONTH(birthday_at) = 6;

-- задание 5
/* (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. 
 * SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.
*/

SELECT *,
CASE 
WHEN id = 5 THEN 0
WHEN id = 1 THEN 1
WHEN id = 2 THEN 2
ELSE 4 
END AS category
FROM catalogs ORDER BY category
;

-- Практическое задание теме “Агрегация данных” --
-- Задание 1
/* Подсчитайте средний возраст пользователей в таблице users */

SELECT 
ROUND(AVG(TIMESTAMPDIFF(YEAR, birthday_at , NOW())),0) AS AverageAge
FROM users;

-- Задание 2
/*
* Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
* Следует учесть, что необходимы дни недели текущего года, а не года рождения.
*/

SELECT
COUNT(*), 
DAYNAME(CONCAT(YEAR(NOW()), '-',MONTH (birthday_at ), '-', DAY(birthday_at ))) 
AS day_of_weak
FROM users GROUP BY day_of_weak ;




