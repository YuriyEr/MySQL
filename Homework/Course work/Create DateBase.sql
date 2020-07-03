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

INSERT INTO `users` VALUES ('101','Norval','Schuppe','carroll.hope@example.com','1'),
('102','Ralph','Simonis','murazik.trevion@example.com','706'),
('103','Bulah','Miller','bkonopelski@example.net','47'),
('104','Theresia','Kuphal','clementina63@example.com','192293'),
('106','Dessie','Schmitt','schuster.buford@example.net','247'),
('107','Reina','Prosacco','augustine23@example.com','292'),
('108','Quincy','Gislason','haylee59@example.net','0'),
('109','Xzavier','Hayes','sanford.diamond@example.net','315909'),
('110','Adrienne','Mraz','xzavier.kertzmann@example.net','581879'),
('111','Bethany','Collins','kendra17@example.com','279628'),
('112','Zackary','King','cronin.rose@example.org','1139468454'),
('113','Warren','Bergnaum','addison50@example.com','201'),
('115','Maxie','Konopelski','quitzon.cara@example.com','541917'),
('116','Miracle','Ward','cummerata.marty@example.org','713'),
('119','Martine','Davis','mona.powlowski@example.org','667'),
('120','Clementina','Okuneva','oemmerich@example.com','112'),
('121','Kristin','Murazik','ashly91@example.net','493'),
('122','Dillon','Rippin','qwisozk@example.org','689'),
('123','Ludie','Grady','curtis.walsh@example.com','347496'),
('124','Carter','Ratke','mazie.wolff@example.net','92'),
('125','Lavon','Goodwin','murphy.aron@example.org','146105'),
('126','Petra','Johns','stanley87@example.net','172'),
('127','Granville','Erdman','altenwerth.franco@example.com','639'),
('128','Josie','Hills','joshua61@example.org','742'),
('130','Fernando','Hilll','eva10@example.net','6902299597'),
('132','Bradford','Rowe','cormier.tyreek@example.net','814'),
('134','Monserrate','Osinski','ugleichner@example.com','34'),
('137','Antonetta','Schneider','hlang@example.org','200204'),
('139','Edmond','Zieme','parisian.kaci@example.com','236486'),
('142','Kailyn','Mohr','roxane.runolfsson@example.net','108'),
('144','Allene','Cummerata','anabel99@example.com','8514487049'),
('146','Dangelo','Steuber','cdenesik@example.net','18'),
('147','Ron','Friesen','larissa65@example.com','8'),
('148','Helen','Wolff','xwintheiser@example.com','470'),
('149','Rhea','Koepp','elangosh@example.net','782'),
('151','Blake','Strosin','lreichert@example.net','190'),
('153','Lauren','Cruickshank','rocio.weimann@example.net','500307'),
('155','Barrett','Strosin','audie.halvorson@example.net','731255'),
('156','Nedra','Kuvalis','wmorissette@example.net','193336'),
('159','Aylin','Botsford','sleffler@example.com','970295'),
('162','Creola','Towne','hettie68@example.com','895'),
('163','Chelsey','Lesch','eugene62@example.net','530553'),
('165','Armando','Roberts','leone.cartwright@example.com','883'),
('168','Tania','Luettgen','dwisozk@example.net','394'),
('171','Angus','Vandervort','lennie15@example.org','7762720829'),
('172','Elias','Casper','linda34@example.org','405494'),
('173','Sincere','Feeney','araynor@example.com','2954559910'),
('179','Monserrat','Conroy','edaugherty@example.com','75'),
('180','Enos','Glover','camron05@example.net','2257968109'),
('182','Bonita','Connelly','esther75@example.com','866'),
('184','Axel','Barton','mina39@example.com','359506'),
('191','Arnaldo','Gutmann','abner70@example.org','504415'),
('194','Sean','Bailey','gibson.wilhelm@example.net','504'),
('195','Wyman','Smitham','yolanda.walsh@example.net','718620'),
('196','Eda','Yundt','runte.daren@example.net','4745711479'),
('197','Nigel','Langosh','nitzsche.olen@example.org','501779'),
('198','Wilbert','Wuckert','wgreen@example.org','769496'),
('199','Robbie','Wintheiser','windler.deron@example.net','865'),
('200','Price','Bailey','gerda.grant@example.com','806'); 

CREATE TABLE planets (
  `id` SERIAL PRIMARY KEY,
  `name` varchar(50) NOT NULL,
  `avarage_distatnse` BIGINT NOT NULL,
  UNIQUE KEY `name` (`name`),
  KEY `id_idx` (`id`),
  KEY `name_idx` (`name`)
);

INSERT INTO planets VALUES -- км от Земли - среднее расстояние
(1, "Меркурий", 149500000), 
(2, "Венера", 149500000), 
(4, "Марс", 228000000), 
(5, "Юпитер", 778547200), 
(6, "Сатурн", 1427000000), 
(7, "Уран", 2721400000 ), 
(8, "Нептун", 4500000000);

CREATE TABLE starships (
  `id` SERIAL PRIMARY KEY,
  `name` varchar(50) NOT NULL,
  `speed` BIGINT UNSIGNED NOT NULL,
  `class` ENUM("A","B","C","VIP") NOT NULL,
  `capacity_people` INT NOT NULL,
  UNIQUE KEY `name` (`name`),
  KEY `id_idx` (`id`),
  KEY `name_idx` (`name`)
);

INSERT INTO starships VALUES -- км/ч 
(1,"Феникс", 100000, 1, 100), 
(2,"Джей", 110000, 2, 400), 
(3,"Дедал", 200000, 2, 150), 
(4,"Созвездие", 46000, 3, 1000), 
(5,"Конестога", 75000, 1, 1500),
(6,"Конституция", 90000, 2, 750),
(7,"Энтерпрайз", 300000, 4, 250);

CREATE TABLE hotels (
  `id` SERIAL PRIMARY KEY,
  `name` varchar(50) DEFAULT NULL,
  `class` ENUM("A","B","C","VIP") NOT NULL,
  `capacity_people` BIGINT UNSIGNED NOT NULL,
  `planet_id` BIGINT UNSIGNED NOT NULL,
  KEY `id_idx` (`id`),
  KEY `name_idx` (`name`),
  FOREIGN KEY (`planet_id`) REFERENCES planets (`id`)
); 

INSERT INTO `hotels` VALUES 
('1','East Audie','C',100, 1),
('2','Hayesborough','C',1000, 1),
('3','Reynaview','VIP',2000, 8),
('4','Lake Reynold','B',1000, 8),
('5','North Nicolas','B',100, 7),
('6','South Gino','VIP', 60, 4),
('7','North Deja','VIP',90, 1),
('8','East Darrin','A',80, 5),
('9','Bessiestad','C',1000, 6),
('10','West Clemmie','C',500, 1),
('11','Port Evansmouth','VIP',2000, 4),
('12','Imeldaport','VIP',1000, 2),
('13','Gottliebshire','VIP',200, 2),
('14','South Gregoryton','A',300, 2),
('15','South Eliseotown','B',600, 8),
('16','West Cullenmouth','VIP', 500, 5),
('17','West Zackary','C',500, 6),
('18','West Rachaelmouth','C',900, 7),
('19','Rhiannontown','A',200, 7),
('20','East Chase','A',100, 7),
('21','Rennerchester','B',333, 2),
('22','Bradtkemouth','A', 400, 2),
('23','South Alejandrinbury','C',434, 7),
('24','Shaynachester','B',545, 5),
('25','East Tillman','B',40, 2),
('26','South Adriana','A',100, 1),
('27','West Makayla','C',300, 2),
('28','New Felicitaview','C',400, 5),
('29','North Frankie','B', 900, 6),
('30','New Bernhard','B',340, 8),
('31','Monteville','B',10, 1),
('32','East Immanuel','C',400, 4),
('33','Nicolashaven','B',500, 4),
('34','East Wadeport','A',20, 5),
('35','Arvidton','VIP',20, 1),
('36','Nikitafort','VIP',50, 1),
('37','West Jovan','B',900, 2),
('38','Harryshire','A',400, 2),
('39','Kennithburgh','C',200, 7),
('40','South Jeanneport','B',300, 8),
('41','Tiffanyville','VIP',400, 1),
('42','North Lisa','B',700, 4),
('43','Rigobertoborough','B',80, 4),
('44','Port Hollie','A',40, 4),
('45','Madilynborough','A',500, 5),
('46','North Gabriella','A',20, 2),
('47','Valentinton','VIP',20, 2),
('48','Orphamouth','A',340, 2),
('49','Yolandahaven','C',70, 1),
('50','Pollichmouth','C',90, 4); 

CREATE TABLE tours (
  `id` SERIAL PRIMARY KEY,
  `name` varchar(50) NOT NULL,
  `planet_to_id` BIGINT UNSIGNED NOT NULL,
  `starship_id` BIGINT UNSIGNED NOT NULL,
  `hotels_id` BIGINT UNSIGNED NOT NULL,
  `price` BIGINT UNSIGNED NOT NULL,
  KEY `id_idx` (`id`),
  KEY `name_idx` (`name`),
  FOREIGN KEY (`planet_to_id`) REFERENCES planets (`id`),
  FOREIGN KEY (`starship_id`) REFERENCES starships (`id`),
  FOREIGN KEY (`hotels_id`) REFERENCES hotels (`id`)
);

INSERT INTO `tours` VALUES 
(1, "Меркурианская экскурсия", 1, 2, 36, 560000),
(2, "Меркурианская экскурсия", 1, 7, 41, 600000),
(3, "Венерианские закаты", 2, 1, 48, 800000),
(4, "Марсианское дерби", 4, 4, 32, 800000),
(5, "Марсианское дерби", 4, 3, 33, 200000);

CREATE TABLE payments (
  `id` SERIAL PRIMARY KEY,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `state` ENUM("purchased","failed","restored") NOT NULL,
  `date_at` DATETIME DEFAULT NOW(),
  `tour_id` BIGINT UNSIGNED NOT NULL,
  KEY `id_idx` (`id`),
  KEY `tour_id_idx` (`tour_id`),
  FOREIGN KEY (`user_id`) REFERENCES users (`id`),
  FOREIGN KEY (`tour_id`) REFERENCES tours (`id`)
);

INSERT INTO payments VALUES
(1, 120, 1, '2020-07-01 11:00:00' , 1),
(2, 102, 2, '2020-06-10 23:00:00' , 1)
;


CREATE TABLE orders (
  `id` SERIAL PRIMARY KEY,
  `tours_id` BIGINT UNSIGNED NOT NULL,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `payments_id` BIGINT UNSIGNED,
  `date_at` DATETIME DEFAULT NOW(),
  FOREIGN KEY (`tours_id`) REFERENCES tours (`id`),
  FOREIGN KEY (`payments_id`) REFERENCES payments (`id`),
  FOREIGN KEY (`user_id`) REFERENCES users (`id`)
); 

INSERT INTO orders VALUES
(1, 1, 102, NULL, '2020-07-01 23:00:59'),
(2, 1, 120, NULL, '2020-06-10 22:00:00'),
(3, 5, 122, NULL, NOW()),
(4, 1, 130, NULL, '2020-05-11 10:00:00')
;

CREATE TABLE dangers (
  `id` SERIAL PRIMARY KEY,
  `type_dangerous` ENUM('planet','space'),
  `date_start` DATE NOT NULL ,
  `date_finish` DATE NOT NULL,
  `planet_id` BIGINT UNSIGNED NOT NULL,
  FOREIGN KEY (`planet_id`) REFERENCES planets (`id`)
); 

INSERT INTO `dangers` VALUES 
(1, 1, '2020-06-01', '2020-08-01', 1 ),
(2, 2, '2020-08-01', '2020-08-25', 4 );

CREATE TABLE discont (
 `id` SERIAL PRIMARY KEY,
 `discount_index` FLOAT UNSIGNED DEFAULT 1,
 `date_start` DATETIME DEFAULT NOW(),
 `date_finish` DATETIME NOT NULL,
 `tour_id` BIGINT UNSIGNED NOT NULL,
 KEY `id_idx` (`id`),
 KEY `discount_index_idx` (`discount_index`),
 FOREIGN KEY (`tour_id`) REFERENCES tours (`id`)
); 

INSERT INTO `discont` VALUES 
(1, 0.6, '2020-06-01', '2020-07-01', 1);


CREATE TABLE logDB (
 `paiment_id` BIGINT UNSIGNED,
 `date_change_state` DATETIME DEFAULT NOW(),
 `paiment_user` BIGINT UNSIGNED
) ENGINE=ARCHIVE;

