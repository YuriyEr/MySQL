USE SHOP;

-- Практическое задание по теме “Оптимизация запросов”
/* 1. Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, 
 * catalogs и products в таблицу logs помещается время и дата создания записи, 
 * название таблицы, идентификатор первичного ключа и содержимое поля name. */

DROP TABLE IF EXISTS `logs`;
CREATE TABLE `logs` (
create_at DATETIME,
table_name ENUM('USER', 'CATALOG', 'PRODUCTS'),
id_object BIGINT,
name_include VARCHAR(255)
) ENGINE=ARCHIVE DEFAULT CHARSET=utf8;

DROP TRIGGER IF EXISTS userLog;
DELIMITER  $$ 
CREATE TRIGGER userLog BEFORE INSERT ON shop.catalogs
FOR EACH ROW 
BEGIN
	INSERT INTO logs VALUES (NOW(), 2, NEW.id, NEW.name);
END $$

DELIMITER  ;

DROP TRIGGER IF EXISTS catLog;
DELIMITER  $$ 
CREATE TRIGGER catLog BEFORE INSERT ON shop.catalogs
FOR EACH ROW 
BEGIN
	INSERT INTO logs VALUES (NOW(), 2, NEW.id, NEW.name);
END $$

DELIMITER  ;

DROP TRIGGER IF EXISTS prodLog;
DELIMITER  $$ 
CREATE TRIGGER prodLog BEFORE INSERT ON shop.catalogs
FOR EACH ROW 
BEGIN
	INSERT INTO logs VALUES (NOW(), 2, NEW.id, NEW.name);
END $$

DELIMITER  ;

-- 2. (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.
DROP FUNCTION IF EXISTS create_users;
DELIMITER  $$ 
CREATE FUNCTION create_users(num INT) 
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE limit_num INT DEFAULT 1000001;
	DECLARE step INT default 0;
	
	REPEAT
		INSERT INTO users(name) VALUES (step);
		SET step = step + 1;
	UNTIL  ( step = num OR step = limit_num )
	END REPEAT ;
	RETURN step;
	
END 
$$

SELECT create_users(100);

