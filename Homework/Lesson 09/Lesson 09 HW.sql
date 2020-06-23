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

DROP FUNCTION IF EXISTS hello;

DELIMITER $$

CREATE FUNCTION hello ()
RETURNS VARCHAR(255) READS SQL DATA

BEGIN
	
	DECLARE timeNow INT;
	DECLARE results VARCHAR(255);

	SET timeNow = HOUR(NOW());
	IF timeNow BETWEEN  6 AND 11 THEN 
	SET results = 'Доброе утро';
	ELSEIF timeNow BETWEEN  12 AND 17 THEN 
	SET results = 'Добрый день';
	ELSEIF timeNow BETWEEN  18 AND 23 THEN
	SET results = 'Доброй ночи';
	ELSEIF (timeNow >  23 | timeNow < 6 ) THEN
	SET results = 'Пора спать';
	END IF;
	RETURN (results);
	
END 
$$

DELIMITER  ;

SELECT hello();

/* 2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
 * Допустимо присутствие обоих полей или одно из них. 
 * Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
 * Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
 * При попытке присвоить полям NULL-значение необходимо отменить операцию.
*/

DROP TRIGGER IF EXISTS notNulltrigger;

-- Вариант А - рабочий
/*
DELIMITER  $$ 
CREATE TRIGGER notNulltrigger BEFORE UPDATE ON shop.products 
FOR EACH ROW 
BEGIN 	
	IF (NEW.name | NEW.desription IS NULL)
	THEN 
	SIGNAL SQLSTATE '45000' 
	SET MESSAGE_TEXT = "Ошибка вставки значения";
	END IF ;
END $$

DELIMITER  ;
*/

-- Вариант Б - рабочий

DELIMITER  $$ 
CREATE TRIGGER notNulltrigger BEFORE UPDATE ON shop.products 
FOR EACH ROW 
BEGIN
	CASE
	WHEN (NEW.name | NEW.desription IS NULL) THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Ошибка вставки значения - все значения NULL";
	END CASE ;
END $$

DELIMITER  ;

/* (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. 
Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел. 
Вызов функции FIBONACCI(10) должен возвращать число 55.
*/ 

-- поскольку число Фибоначи бесконечно, требуемое выражение FIBONACCI(10) не корректно, 
-- т.к. должно быть два параметра: исходное число и число шагов

DROP FUNCTION IF EXISTS fib;
DELIMITER  $$ 
CREATE FUNCTION fib(num INT, step_num INT) 
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE limit_num INT DEFAULT 1000;
	DECLARE step INT default 0;
	DECLARE old_num INT;
	DECLARE new_num INT;
	DECLARE between_num INT DEFAULT 0;
	SET old_num = num;
	SET new_num = num;
	
	REPEAT
		SET between_num = old_num;
		SET new_num = between_num + new_num ;
		SET old_num = new_num - between_num ;
		SET step = step + 1;
	UNTIL  ( step >= step_num )
	END REPEAT ;
	RETURN new_num;
	
END 
$$

-- проверка
SELECT fib(10, 3); -- результат 50 соблюден (10+10) -> (10+20) -> (20+30) = 50 решение верно в 3 шага


