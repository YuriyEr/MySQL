-- Основные тригеры и функции 
USE SolarCentury;

DROP TRIGGER IF EXISTS paymentLogUpdate;
DELIMITER  $$ 
CREATE TRIGGER paymentLogUpdate BEFORE UPDATE ON SolarCentury.payments 
FOR EACH ROW 
BEGIN
	INSERT INTO logDB VALUES (NEW.id, NOW(), NEW.user_id);
END $$

DELIMITER  ;

DROP TRIGGER IF EXISTS paymentLogInsert;
DELIMITER  $$ 
CREATE TRIGGER paymentLogInsert BEFORE INSERT ON SolarCentury.payments 
FOR EACH ROW 
BEGIN
	INSERT INTO logDB VALUES (NEW.id, NOW(), NEW.user_id);
END $$

DELIMITER  ;

-- функция подсчета максимальной пассажироперевозки всеми кораблями
DROP FUNCTION IF EXISTS max_passenger_transportation;
DELIMITER  $$ 
CREATE FUNCTION max_passenger_transportation() 
RETURNS BIGINT DETERMINISTIC
BEGIN
	DECLARE counter BIGINT default 0;
	SELECT SUM(SolarCentury.starships.capacity_people) INTO counter FROM SolarCentury.starships;
	RETURN counter;
	
END 
$$

DELIMITER  ;

SELECT max_passenger_transportation();

-- функция подсчета максимальной пассажироперевозки всеми зафрахтованными кораблями (входящими в группу tours)
DROP FUNCTION IF EXISTS max_passenger_transportation_uses;
DELIMITER  $$ 
CREATE FUNCTION max_passenger_transportation_uses() 
RETURNS BIGINT DETERMINISTIC
BEGIN
	DECLARE counter BIGINT default 0;
	SELECT SUM(s.capacity_people) INTO counter FROM SolarCentury.starships AS s
	JOIN SolarCentury.tours AS t ON s.id = t.starship_id ;
	RETURN counter;
	
END 
$$

DELIMITER  ;

SELECT max_passenger_transportation_uses();

-- функция подсчета поступлений от туров от забранированных клиентов
DROP FUNCTION IF EXISTS potensional_value_users;
DELIMITER  $$ 
CREATE FUNCTION potensional_value_users() 
RETURNS BIGINT DETERMINISTIC
BEGIN
	DECLARE counter BIGINT default 0;
	SELECT SUM(t.price) INTO counter FROM SolarCentury.tours AS t
	JOIN SolarCentury.orders AS o ON t.id = o.tours_id
	;
	RETURN counter;
	
END 
$$

DELIMITER  ;

SELECT potensional_value_users();

-- функция подсчета потенциальных поступлений от запланированных туров
DROP FUNCTION IF EXISTS potensional_value;
DELIMITER  $$ 
CREATE FUNCTION potensional_value() 
RETURNS BIGINT DETERMINISTIC
BEGIN
	DECLARE counter BIGINT default 0;
	SELECT SUM(t.price * s.capacity_people) INTO counter FROM SolarCentury.tours AS t
	JOIN SolarCentury.orders AS o ON t.id = o.tours_id
	JOIN SolarCentury.payments AS p ON p.tour_id = o.tours_id 
	JOIN SolarCentury.starships AS s ON s.id = t.starship_id 
	;
	RETURN counter;
	
END 
$$

DELIMITER  ;

SELECT potensional_value();
