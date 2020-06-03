-- lesson 04 CRUD

-- для корректной работы нуджно выполнить скрипт vk_db_creation для генерации исходных данных

-- PREPEARED

USE VK;

DROP TABLE IF EXISTS analystics_activity;
CREATE TABLE analystics_activity (
id SERIAL PRIMARY KEY AUTO_INCREMENT,
user_id BIGINT UNSIGNED NOT NULL,
total_photo BIGINT UNSIGNED,
total_posts BIGINT UNSIGNED,
total_media BIGINT UNSIGNED,
total_like BIGINT UNSIGNED,
analystics_created DATETIME DEFAULT NOW() ON UPDATE NOW(),
FOREIGN KEY (user_id) REFERENCES vk.users (id)
);

DROP TABLE IF EXISTS poligon;
CREATE TABLE poligon (
id SERIAL PRIMARY KEY,
body TEXT NOT NULL,
created_at datetime DEFAULT NOW()
);


-- CREATE --
-- https://dev.mysql.com/doc/refman/8.0/en/insert.html
-- вставка одного значения
INSERT INTO vk.poligon (`id`, `body`) VALUES (1, "Some text 1");
-- вставка нескольких значений
INSERT INTO vk.poligon (`id`, `body`) VALUES
(2, "Some text 2"),
(3, "Some text 3"),
(4, "Some text 4")
;
-- поведение при дублирование
INSERT INTO vk.poligon (`id`, `body`) VALUES (1, "Some text 1")
on duplicate key update created_at = now()
;
-- пропуск при дублирование c IGNORE
INSERT IGNORE INTO vk.poligon (`id`, `body`) VALUES (1, "Some text 1") 
;

-- SELECT --
-- https://dev.mysql.com/doc/refman/8.0/en/select.html
-- вывод всех значений в консоль
SELECT * FROM vk.poligon;
-- вывод определенный столбцов в консоль
SELECT body, created_at FROM vk.poligon;
-- ограничения и сортировка
SELECT body, created_at FROM vk.poligon 
LIMIT 2 
OFFSET 2;

SELECT * FROM vk.poligon
WHERE id != 3 AND body != "Some text 2"
;

-- UPDATE
-- https://dev.mysql.com/doc/refman/8.0/en/update.html
-- обновление определенных данных
UPDATE vk.poligon -- результирующая талблица
SET body = "Some text 99" -- на что меняем
WHERE id = 4
;
-- Обновление данных сплошное
UPDATE vk.poligon
SET body = "Some text 99" -- на что меняем
;

-- DELETE
-- при помощи двух операторов
-- А
DELETE FROM vk.poligon LIMIT 1; -- удаление одной записи
-- или по условию
DELETE FROM vk.poligon WHERE id > 3;

SELECT * FROM vk.poligon;

-- вызывает удаление ВСЕХ или ОПРЕДЕЛЕННЫХ строк, счетчик или автоинкремент не затрагивается
DELETE FROM vk.poligon;

-- В
-- вызывает очистку ВСЕХ записей таблицы и обнуляет счетчики автоинкрементов (автонумераторов id)


TRUNCATE vk.poligon ;
