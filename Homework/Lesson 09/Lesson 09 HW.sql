-- Практическое задание по теме “Транзакции, переменные, представления” 
/*1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.*/

-- sample нет в БД, скопируем ее и таблицу
DROP DATABASE IF EXISTS sample;
CREATE DATABASE sample;
CREATE TABLE sample.users  SELECT * FROM shop.users ;
TRUNCATE TABLE sample.users;

-- задание
START TRANSACTION;
SET @numID = 1;
INSERT INTO sample.users(id, name) 
SELECT id, name FROM shop.users u WHERE u.id = @numID;

DELETE FROM shop.users WHERE id = @numID;
SELECT 'Success first trnasaction from task one';

COMMIT;

/*2. Создайте представление, которое выводит название name товарной позиции из таблицы products
 * и соответствующее название каталога name из таблицы catalogs. */

CREATE OR REPLACE VIEW representation_one (prod_name, cat_name) AS
SELECT p.name, c.name FROM shop.products AS p 
JOIN shop.catalogs AS c ON p.catalog_id = c.id ;
SELECT * FROM representation_one;

-- Практическое задание по теме “Хранимые процедуры и функции, триггеры"
/* 1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
 * С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
 * с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
 * с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи". */ 

SET GLOBAL time_zone = '-3:00';
SELECT HOUR(NOW());
USE SHOP;

DROP FUNCTION IF EXISTS hello;

DELIMITER //
CREATE FUNCTION hello ()
RETURNS VARCHAR(255) ​​DETERMINISTIC
BEGIN
	DECLARE timeNow INT;
	DECLARE results VARCHAR(255);
	SET timeNow = 6;
	CASE timeNow
	WHEN 6 to 11 THEN 
	SET results = 'Доброе утро';
	WHEN 12 to 17 THEN 
	SET results = 'Добрый день';
	WHEN 18 to 23 THEN 
	SET results = 'Доброй ночи';
	ELSE 
	SET results = 'Иначе';
	END CASE;
	RETURN results
END //

DELIMITER ;

SELECT hello();




/* 2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
 * Допустимо присутствие обоих полей или одно из них. 
 * Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
 * Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
 * При попытке присвоить полям NULL-значение необходимо отменить операцию.
*/

