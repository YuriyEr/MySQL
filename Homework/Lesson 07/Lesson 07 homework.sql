-- Домашнее задание, урок 06

/* Работаем с БД vk и тестовыми данными, которые вы сгенерировали ранее: */
-- Принимаем за 19 в качестве ID пользователя
SET @myID = 1;
-- и лимит возраста
SET @myAgeLimit = 15;

-- 1. Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.
-- Поскольку текущие значения в messages семмитричны запросу, перемешиваем их
	UPDATE messages SET to_user_id = ROUND((RAND()*(99-0+1)+0), 0); 
	SELECT to_user_id FROM messages m2 ;
	SELECT * FROM messages WHERE to_user_id = @myID;
	
	SELECT COUNT(*), from_user_id FROM messages WHERE to_user_id = @myID AND  from_user_id in (
	SELECT target_user_id AS user_id FROM friend_requests WHERE initiator_user_id = @myID AND status = 'approved' 
	UNION 
	SELECT initiator_user_id AS user_id FROM friend_requests WHERE target_user_id = @myID AND status = 'approved')
	GROUP BY from_user_id ORDER BY from_user_id LIMIT 1
	;

-- 2. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.

	SELECT user_id, COUNT(*) FROM likes WHERE user_id IN (
	SELECT * FROM(
	(SELECT user_id FROM profiles 
		WHERE TIMESTAMPDIFF(YEAR, birthday , NOW()) > @myAgeLimit LIMIT 10)) as value
	) GROUP BY user_id WITH ROLLUP;

-- 3. Определить кто больше поставил лайков (всего) - мужчины или женщины?
	SELECT COUNT(*), gender as Пол FROM profiles WHERE user_id in (
	SELECT user_id FROM likes
	) GROUP BY gender;

-- 4. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.
	-- Не очень понял задание - нет даты последнего входа ни в одной таблицы, 
	-- если агрегирровать по наличию их ID во всех таблицах - не очень понятны критериии
	
	
