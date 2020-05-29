-- MySQL dump 10.13  Distrib 8.0.20, for macos10.15 (x86_64)
--
-- Host: localhost    Database: vk
-- ------------------------------------------------------
-- Server version	8.0.19

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `communities`
--

DROP TABLE IF EXISTS `communities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `communities` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `communities_name_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Сообщества';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `communities`
--

LOCK TABLES `communities` WRITE;
/*!40000 ALTER TABLE `communities` DISABLE KEYS */;
INSERT INTO `communities` VALUES (13,'adipisci'),(14,'corporis'),(5,'deleniti'),(10,'deserunt'),(4,'et'),(9,'ipsa'),(11,'nihil'),(12,'omnis'),(3,'qui'),(7,'qui'),(2,'ratione'),(8,'sed'),(6,'velit'),(1,'vero');
/*!40000 ALTER TABLE `communities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friend_requests`
--

DROP TABLE IF EXISTS `friend_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `friend_requests` (
  `initiator_user_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `target_user_id` bigint unsigned NOT NULL,
  `status` enum('requested','approved','unfriended','declined') CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `requested_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `confirmed_at` datetime DEFAULT NULL,
  PRIMARY KEY (`initiator_user_id`,`target_user_id`),
  UNIQUE KEY `initiator_user_id` (`initiator_user_id`),
  KEY `initiator_user_id_2` (`initiator_user_id`),
  KEY `target_user_id` (`target_user_id`),
  CONSTRAINT `friend_requests_ibfk_1` FOREIGN KEY (`initiator_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `friend_requests_ibfk_2` FOREIGN KEY (`target_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friend_requests`
--

LOCK TABLES `friend_requests` WRITE;
/*!40000 ALTER TABLE `friend_requests` DISABLE KEYS */;
INSERT INTO `friend_requests` VALUES (101,101,'requested','2016-10-11 07:39:49','1984-04-16 16:52:05','1998-10-21 16:42:09'),(102,102,'approved','1975-03-08 01:53:29','2004-09-19 17:50:14','1979-07-17 15:24:35'),(103,103,'requested','2002-09-03 01:09:33','2004-08-22 03:22:18','1977-02-11 18:19:40'),(106,108,'unfriended','2006-01-08 14:38:11','1993-10-27 08:11:40','2002-07-22 10:38:45'),(107,111,'declined','2014-06-19 14:50:05','2007-08-02 23:41:33','1994-01-18 19:49:26'),(108,112,'unfriended','2007-11-07 03:02:21','2001-06-19 00:07:44','1976-07-31 19:40:52'),(111,115,'requested','2002-04-29 23:51:48','1970-07-09 17:46:55','2020-04-14 12:26:22'),(112,117,'requested','1990-09-07 08:17:45','2016-01-18 08:31:41','1987-02-24 02:40:58'),(113,118,'declined','1995-11-20 06:27:21','1982-12-13 18:24:58','1973-11-14 12:27:08'),(114,121,'unfriended','1979-06-27 19:13:57','1988-01-24 07:09:44','2000-09-17 02:13:48'),(115,122,'approved','1987-05-24 10:07:28','2012-01-01 04:55:27','2008-11-04 14:42:45'),(117,124,'unfriended','1993-03-06 13:20:42','1989-09-13 16:27:25','1994-10-20 13:47:39'),(118,126,'requested','2009-05-01 10:05:53','1983-12-13 12:10:07','1990-08-03 21:11:24');
/*!40000 ALTER TABLE `friend_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes_dislakes_media`
--

DROP TABLE IF EXISTS `likes_dislakes_media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes_dislakes_media` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `state` enum('like','dislike') DEFAULT NULL,
  `user_id_init` bigint unsigned NOT NULL COMMENT 'От кого адресован лайк/дизлайк',
  `media_id` bigint unsigned NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `user_id_init` (`user_id_init`,`media_id`),
  KEY `media_id` (`media_id`),
  CONSTRAINT `likes_dislakes_media_ibfk_1` FOREIGN KEY (`user_id_init`) REFERENCES `users` (`id`),
  CONSTRAINT `likes_dislakes_media_ibfk_2` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes_dislakes_media`
--

LOCK TABLES `likes_dislakes_media` WRITE;
/*!40000 ALTER TABLE `likes_dislakes_media` DISABLE KEYS */;
INSERT INTO `likes_dislakes_media` VALUES (1,'like',101,1,'1991-05-08 03:17:17','1974-06-06 17:03:14'),(2,'dislike',102,2,'1989-09-01 21:49:47','1996-06-25 08:14:31'),(3,'like',103,3,'1994-11-05 12:58:19','1985-10-05 13:26:20'),(4,'dislike',106,4,'1972-11-15 01:08:52','1979-02-02 08:14:43'),(5,'like',107,5,'1977-03-14 14:00:49','1998-07-18 19:50:22'),(6,'dislike',108,6,'1978-03-30 01:10:44','2001-02-09 22:23:56'),(7,'like',111,7,'1978-11-11 13:45:46','1991-08-23 01:17:42'),(8,'like',112,8,'1989-11-23 03:57:15','2010-05-31 07:30:52'),(9,'dislike',113,9,'1981-08-22 01:36:48','2013-01-05 04:33:12'),(10,'dislike',114,10,'1979-10-28 08:16:44','1971-08-18 15:49:34'),(11,'dislike',115,1,'1984-06-01 21:20:04','2001-09-19 02:12:10'),(12,'like',117,2,'2006-01-11 02:27:54','1977-12-16 00:37:52'),(13,'dislike',118,3,'1976-08-16 04:30:38','2003-05-13 15:47:36'),(14,'like',121,4,'2011-10-18 07:02:29','2004-10-07 04:14:27'),(15,'like',122,5,'2010-07-05 00:38:11','2016-12-16 20:22:53');
/*!40000 ALTER TABLE `likes_dislakes_media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes_dislakes_post`
--

DROP TABLE IF EXISTS `likes_dislakes_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes_dislakes_post` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `state` enum('like','dislike') DEFAULT NULL,
  `user_id_init` bigint unsigned NOT NULL COMMENT 'От кого адресован лайк/дизлайк',
  `post_id` bigint unsigned NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `user_id_init` (`user_id_init`,`post_id`),
  KEY `post_id` (`post_id`),
  CONSTRAINT `likes_dislakes_post_ibfk_1` FOREIGN KEY (`user_id_init`) REFERENCES `users` (`id`),
  CONSTRAINT `likes_dislakes_post_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes_dislakes_post`
--

LOCK TABLES `likes_dislakes_post` WRITE;
/*!40000 ALTER TABLE `likes_dislakes_post` DISABLE KEYS */;
INSERT INTO `likes_dislakes_post` VALUES (1,'dislike',101,1,'2007-01-11 20:15:28','2009-06-12 08:10:43'),(2,'like',102,2,'1976-07-19 19:48:40','1995-09-04 06:10:55'),(3,'dislike',103,3,'1988-05-23 05:51:51','1988-08-17 07:42:58'),(4,'dislike',106,4,'1983-03-29 19:52:27','1982-10-24 18:16:03'),(5,'dislike',107,5,'1975-03-10 05:48:15','1981-09-10 07:54:39'),(6,'dislike',108,6,'1999-06-04 01:02:30','2003-07-17 00:10:28'),(7,'like',111,7,'1991-12-30 07:56:49','1978-05-23 14:03:21'),(8,'dislike',112,8,'1983-08-17 15:33:32','2011-10-26 17:37:28'),(9,'dislike',113,9,'1986-09-27 18:58:45','2006-12-21 05:08:45'),(10,'dislike',114,10,'1997-06-12 06:57:32','1977-10-25 08:39:02'),(11,'like',115,11,'1998-06-20 12:14:29','1988-07-01 19:33:44'),(12,'dislike',117,12,'2020-02-21 13:09:14','1993-06-11 22:27:37'),(13,'like',118,13,'2004-06-13 21:46:27','1978-11-23 02:06:07'),(14,'like',121,14,'2005-05-11 09:03:44','1993-12-11 17:25:59'),(15,'like',122,15,'2017-10-23 06:12:00','2018-02-26 06:10:51'),(16,'dislike',123,16,'1973-12-04 10:54:51','1980-10-16 16:09:56'),(17,'like',124,17,'2011-09-20 09:39:46','1995-02-23 03:25:43'),(18,'dislike',126,18,'1992-05-27 01:18:41','1988-01-15 02:15:22'),(19,'dislike',130,19,'2004-09-16 17:11:54','1977-05-20 04:59:06'),(20,'like',132,20,'1989-05-22 02:17:54','1992-06-07 19:08:43'),(21,'dislike',133,1,'1980-10-19 08:07:39','1974-04-30 09:57:16'),(22,'like',134,2,'1982-02-03 17:29:30','1988-12-26 10:44:42'),(23,'dislike',135,3,'1985-06-18 21:57:03','2013-01-21 14:07:14'),(24,'like',137,4,'1978-03-30 06:56:27','2001-11-16 15:31:59'),(25,'like',143,5,'1985-03-16 02:45:00','2006-07-18 05:56:48');
/*!40000 ALTER TABLE `likes_dislakes_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes_dislakes_user`
--

DROP TABLE IF EXISTS `likes_dislakes_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes_dislakes_user` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `state` enum('like','dislike') DEFAULT NULL,
  `user_id_init` bigint unsigned NOT NULL COMMENT 'От кого адресован лайк/дизлайк',
  `user_id_for_like` bigint unsigned NOT NULL COMMENT 'лайк/дизлайк пользователю',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `user_id_init` (`user_id_init`,`user_id_for_like`),
  KEY `user_id_for_like` (`user_id_for_like`),
  CONSTRAINT `likes_dislakes_user_ibfk_1` FOREIGN KEY (`user_id_for_like`) REFERENCES `users` (`id`),
  CONSTRAINT `likes_dislakes_user_ibfk_2` FOREIGN KEY (`user_id_init`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes_dislakes_user`
--

LOCK TABLES `likes_dislakes_user` WRITE;
/*!40000 ALTER TABLE `likes_dislakes_user` DISABLE KEYS */;
INSERT INTO `likes_dislakes_user` VALUES (1,'like',101,101,'1970-01-11 23:45:20','1992-03-11 19:12:37'),(2,'like',102,102,'1994-11-30 01:15:52','2013-05-04 16:01:16'),(3,'like',103,103,'2016-04-26 23:03:27','1976-10-05 10:03:46'),(4,'dislike',106,106,'1973-12-18 09:00:26','2015-10-22 18:30:27'),(5,'like',107,107,'2016-10-20 05:57:32','1988-03-05 17:43:51'),(6,'dislike',108,108,'1976-01-21 11:01:23','1972-08-25 05:07:29'),(7,'dislike',111,111,'2013-06-06 05:38:46','1994-04-18 04:20:22'),(8,'dislike',112,112,'2003-10-24 22:56:07','1972-06-18 14:38:18'),(9,'dislike',113,113,'1998-06-23 10:46:52','1977-07-01 17:47:51'),(10,'dislike',114,114,'2004-09-12 00:39:39','1983-12-19 22:18:22'),(11,'dislike',115,115,'2002-12-14 23:32:01','1999-12-27 20:27:14'),(12,'like',117,117,'1986-12-21 19:08:03','2001-10-29 02:12:59'),(13,'dislike',118,118,'2002-06-12 20:44:17','1999-02-09 23:34:41'),(14,'dislike',121,121,'2017-06-22 12:06:41','2015-12-25 15:38:48'),(15,'like',122,122,'1990-08-04 07:23:31','2012-05-15 02:58:32'),(16,'like',123,123,'2000-12-09 07:33:31','2017-04-18 19:45:24'),(17,'like',124,124,'2004-09-21 14:25:48','1997-01-31 10:23:33'),(18,'dislike',126,126,'2017-12-15 16:06:21','1971-06-11 04:09:15'),(19,'dislike',130,130,'2012-07-25 22:56:50','1999-11-13 08:31:54'),(20,'like',132,132,'1995-02-26 14:32:14','1977-12-07 01:29:02');
/*!40000 ALTER TABLE `likes_dislakes_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes_post_photo`
--

DROP TABLE IF EXISTS `likes_post_photo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes_post_photo` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `state` enum('like','dislike') DEFAULT NULL,
  `user_id_init` bigint unsigned NOT NULL COMMENT 'От кого адресован лайк/дизлайк',
  `photo_id` bigint unsigned NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `user_id_init` (`user_id_init`,`photo_id`),
  KEY `photo_id` (`photo_id`),
  CONSTRAINT `likes_post_photo_ibfk_1` FOREIGN KEY (`user_id_init`) REFERENCES `users` (`id`),
  CONSTRAINT `likes_post_photo_ibfk_2` FOREIGN KEY (`photo_id`) REFERENCES `photos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes_post_photo`
--

LOCK TABLES `likes_post_photo` WRITE;
/*!40000 ALTER TABLE `likes_post_photo` DISABLE KEYS */;
INSERT INTO `likes_post_photo` VALUES (1,'like',101,1,'2015-12-15 22:20:04','1990-08-23 01:32:47'),(2,'like',102,2,'1980-10-09 19:48:47','2013-05-26 04:40:01'),(3,'dislike',103,3,'1992-12-07 07:12:11','1989-12-17 22:38:49'),(4,'dislike',106,4,'1981-10-09 00:36:21','2007-07-29 21:45:56'),(5,'like',107,5,'1994-08-28 02:51:09','1996-04-30 08:08:48'),(6,'dislike',108,6,'1982-03-30 23:36:50','1975-07-30 09:52:14'),(7,'dislike',111,7,'1997-06-04 18:50:35','1978-01-09 21:07:40'),(8,'dislike',112,8,'1979-02-10 02:07:55','1982-08-26 03:06:06'),(9,'like',113,9,'1999-09-24 05:39:26','1976-10-24 10:54:08'),(10,'dislike',114,10,'2008-11-06 02:00:42','2012-07-08 20:04:44'),(11,'like',115,11,'1974-09-13 07:43:18','1984-07-26 13:13:52'),(12,'like',117,12,'1971-10-13 00:34:03','2006-03-30 12:24:38'),(13,'like',118,13,'1974-07-25 07:37:25','1978-06-29 10:36:24'),(14,'dislike',121,14,'2005-06-25 14:43:28','1979-01-03 23:40:33'),(15,'dislike',122,15,'1993-08-14 13:53:25','1971-08-13 20:06:43'),(16,'dislike',123,16,'2016-04-25 23:46:32','1995-10-19 03:19:05'),(17,'like',124,17,'2013-10-07 15:15:09','1986-07-07 17:51:28'),(18,'like',126,18,'2004-05-20 15:24:42','2017-05-21 10:18:48'),(19,'dislike',130,19,'2008-05-14 17:29:14','1980-08-03 14:56:45'),(20,'dislike',132,20,'1985-05-29 14:44:18','1976-10-20 02:39:45'),(21,'dislike',133,21,'2008-09-22 10:31:34','1989-06-21 01:20:38'),(22,'dislike',134,22,'1981-06-17 00:58:55','2006-07-15 21:30:10'),(23,'like',135,23,'1970-07-19 23:27:33','2014-06-01 02:13:18'),(24,'like',137,24,'1998-08-04 10:19:17','1971-04-15 13:25:09'),(25,'dislike',143,25,'1975-06-23 05:07:37','1985-04-26 21:27:15'),(26,'dislike',146,26,'1986-09-14 09:25:53','1973-12-01 21:04:12'),(27,'dislike',147,27,'1970-08-05 02:58:53','2003-04-22 20:50:04'),(28,'dislike',148,28,'2011-03-15 03:57:57','1974-03-03 11:44:17'),(29,'like',150,29,'2005-10-26 21:05:07','1987-06-21 08:55:33'),(30,'dislike',153,30,'1973-02-18 15:51:39','2005-03-27 02:46:48'),(31,'dislike',157,31,'1980-03-04 22:16:05','1984-01-13 17:20:22'),(32,'like',158,32,'1974-01-07 12:50:11','1971-08-02 18:55:06'),(33,'dislike',160,33,'2004-04-29 00:17:36','1974-06-13 04:46:57'),(34,'like',163,34,'1993-10-05 01:15:27','2014-08-10 16:53:39'),(35,'dislike',164,35,'1982-05-28 17:06:46','1992-10-31 12:37:58'),(36,'like',165,36,'1982-01-29 05:34:16','2008-02-24 04:38:24'),(37,'like',166,37,'2018-01-15 09:29:55','1997-02-11 16:21:16');
/*!40000 ALTER TABLE `likes_post_photo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `media_type_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `body` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `filename` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `size` int DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `media_type_id` (`media_type_id`),
  CONSTRAINT `media_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `media_ibfk_2` FOREIGN KEY (`media_type_id`) REFERENCES `media_types` (`id`),
  CONSTRAINT `media_chk_1` CHECK (json_valid(`metadata`))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
INSERT INTO `media` VALUES (1,1,101,'Dolores autem dolor blanditiis. Nisi ut cupiditate molestiae voluptas. Harum necessitatibus neque hic quaerat. Aut optio et aliquam est tenetur qui. In quibusdam nihil dolore animi et.','eos',325,NULL,'2018-08-08 00:35:53','1994-12-17 14:55:53'),(2,2,102,'Aut ducimus voluptate vel deserunt autem voluptates. Qui similique ipsam ut maxime vitae aut. Sed et est ratione. Aperiam rerum dolorem minus molestiae in.','unde',926066,NULL,'2000-06-17 16:27:40','2015-11-08 12:06:08'),(3,3,103,'Voluptatem consequatur sed suscipit sequi molestiae. Hic esse id voluptas quas. Quaerat accusamus odio facere in quaerat quas.','nesciunt',278798,NULL,'2005-04-30 02:12:32','1992-03-10 14:23:57'),(4,4,106,'Enim adipisci corrupti unde molestiae placeat est vel quis. Quasi sit reprehenderit quae illo pariatur molestias magni repellat. Nemo rerum atque soluta nulla nostrum molestiae.','debitis',34746314,NULL,'1998-12-05 14:19:14','1996-08-26 05:01:21'),(5,5,107,'Et officiis dolorem odit atque quia delectus modi. Maxime consectetur tempora asperiores ea sunt repellendus. Quisquam dolorum non saepe recusandae qui. Ut doloremque odio cum in molestiae quaerat.','numquam',0,NULL,'2000-01-18 04:10:19','1988-03-19 17:07:44'),(6,6,108,'Consequatur nesciunt quia sit ad libero et nihil. Ratione est accusantium aliquam ducimus ea quisquam. Qui et accusantium aut est.','sunt',828,NULL,'2016-09-26 20:51:33','2004-02-27 20:09:38'),(7,7,111,'Nisi sed et accusantium non. Aut ea dignissimos iusto praesentium fugiat autem. Voluptatibus nobis aperiam est vero.','unde',492492823,NULL,'2008-12-16 10:27:13','2000-01-02 18:33:34'),(8,8,112,'Illo animi aliquam similique numquam tenetur dolore. Aspernatur numquam non ipsa. Voluptatum magnam ex vitae velit ea.\nHarum iure ratione et maiores id. Adipisci dolorem veniam nemo reiciendis.','excepturi',0,NULL,'1975-01-24 09:29:28','2019-09-16 21:43:13'),(9,9,113,'Temporibus a quasi nobis. Iusto iure exercitationem libero nostrum ab dicta voluptate. Corrupti possimus beatae molestias sint.','magni',248489312,NULL,'1995-10-01 09:44:34','2008-10-22 09:37:37'),(10,10,114,'Commodi occaecati molestiae fugit excepturi consequatur. Quos repellendus error sint et et. Voluptatem quis ea et voluptates porro.','eos',49910055,NULL,'2003-07-06 03:30:42','2001-02-28 21:19:19');
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_types`
--

DROP TABLE IF EXISTS `media_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media_types` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_types`
--

LOCK TABLES `media_types` WRITE;
/*!40000 ALTER TABLE `media_types` DISABLE KEYS */;
INSERT INTO `media_types` VALUES (1,'voluptates','2015-02-25 10:21:57','1997-07-23 09:07:13'),(2,'sed','2009-09-09 02:15:05','1993-10-18 17:51:05'),(3,'molestiae','2008-11-03 06:45:56','2003-07-26 05:07:24'),(4,'in','1972-05-21 21:34:38','2002-11-22 03:38:43'),(5,'mollitia','1980-02-29 01:04:51','2004-03-18 06:02:32'),(6,'autem','1976-07-06 00:38:29','1980-09-18 03:46:31'),(7,'occaecati','1970-08-26 04:15:05','2005-04-12 08:20:45'),(8,'officiis','2008-03-31 01:21:51','1987-11-04 10:45:38'),(9,'libero','2018-12-17 21:03:07','1977-09-16 22:53:39'),(10,'asperiores','1982-08-23 08:12:44','1971-03-23 19:55:00'),(11,'consequatur','1976-12-27 07:37:50','2010-07-30 02:29:25'),(12,'rerum','1982-06-23 01:28:40','2008-10-31 15:21:47'),(13,'ex','1991-12-07 05:36:37','1996-04-13 07:01:16'),(14,'earum','1983-06-27 17:42:44','2001-10-14 21:41:48'),(15,'ipsa','1996-09-14 23:33:50','1974-06-25 11:26:36'),(16,'et','2002-07-10 07:18:18','2013-09-01 20:17:34'),(17,'aut','1984-05-16 09:02:06','1993-06-19 04:46:37'),(18,'iste','1980-10-23 05:53:47','1986-11-23 23:50:58'),(19,'culpa','1985-01-15 06:32:28','1986-01-15 15:44:43'),(20,'vel','1973-11-29 10:47:35','2019-04-09 09:47:01');
/*!40000 ALTER TABLE `media_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `from_user_id` bigint unsigned NOT NULL,
  `to_user_id` bigint unsigned NOT NULL,
  `body` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `messages_from_user_id` (`from_user_id`),
  KEY `messages_to_user_id` (`to_user_id`),
  KEY `messages_to_created_at` (`created_at`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`from_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`to_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,101,101,'Nihil excepturi nulla aspernatur et. Quis accusantium maxime porro ipsam ut eum. Itaque velit animi quae.','2015-12-09 19:43:45'),(2,102,102,'Est minus omnis error repellendus et. Architecto sit beatae et omnis excepturi. Voluptatibus hic et cumque veritatis voluptatibus sit ea. Animi omnis quas in corporis soluta.','2013-09-22 02:35:49'),(3,103,103,'Blanditiis recusandae esse quasi corporis pariatur quia recusandae omnis. Hic excepturi et id fugiat aut modi. Eos asperiores labore qui nemo itaque mollitia magni.','1981-10-30 22:23:01'),(4,106,106,'Iure perspiciatis incidunt quisquam voluptas omnis temporibus. Suscipit ut et consequuntur.','2005-03-13 17:36:10'),(5,107,107,'Quidem sequi iure iure. Distinctio ut magnam molestias ut beatae dolorem. Quo ducimus ipsum vel harum. Voluptatibus iste repudiandae voluptatibus molestiae nam voluptatibus suscipit.','2016-04-21 00:39:18'),(6,108,108,'Reiciendis ut quia aspernatur hic error. Libero sunt molestiae nemo pariatur inventore iusto quo. Nemo eos sed consectetur vero.','2019-05-18 12:56:53'),(7,111,111,'Non asperiores eaque suscipit quae non. Dolores rerum earum esse beatae animi provident consectetur placeat. Molestiae ut sint impedit non ipsam qui. Ut consequatur laborum consequuntur.','1991-12-15 01:29:03'),(8,112,112,'A veritatis minus ab aliquam sint. Ducimus pariatur quae quos ea in voluptate qui. Minima porro ut veritatis voluptas.','1997-06-22 21:26:41'),(9,113,113,'Eum et deleniti maiores commodi veritatis et eos. Minima placeat temporibus a tempora. Rerum id aut qui ad quam perferendis. Occaecati harum pariatur deserunt impedit. Ducimus inventore qui reiciendis asperiores consequatur ab deleniti.','1993-08-24 07:47:22'),(10,114,114,'Et soluta expedita rem. Sunt reprehenderit doloribus adipisci amet omnis sunt. Quo praesentium saepe quisquam enim omnis rerum voluptatem. Deserunt occaecati iure repudiandae praesentium. Qui asperiores consequatur odit et nulla blanditiis dolor.','2008-12-12 06:40:31'),(11,115,115,'Maxime iure non explicabo animi provident et aut est. Aut rem fugit aspernatur ducimus.','1982-02-01 00:28:33'),(12,117,117,'Odio qui repellat ipsum. Quasi pariatur et et laborum placeat aut. Omnis aliquam voluptas officia velit.','1981-03-04 19:38:32'),(13,118,118,'Voluptatem et consequuntur explicabo laudantium quia doloremque. Ut recusandae tempore explicabo voluptatem molestiae. Quia et et commodi libero suscipit ut nulla sunt.','2007-09-12 13:04:29'),(14,121,121,'Ut tempora ipsam velit sed sequi. Explicabo corrupti sunt autem et. Vel aspernatur qui eum sequi porro culpa ipsa.','1970-08-07 18:22:04'),(15,122,122,'Omnis animi molestiae ut saepe aut expedita debitis. Recusandae maiores assumenda dignissimos optio tempora. Dolor rerum sapiente laboriosam sit assumenda aliquam. Consequatur non occaecati sit perspiciatis debitis.','1999-05-11 17:37:12'),(16,123,123,'Consequatur aut nemo voluptate deleniti. Non soluta voluptatum est aliquam aut velit. Tenetur dicta aut fugit quibusdam sit. Repellat architecto ut beatae libero illo.','1984-04-14 00:45:54'),(17,124,124,'Voluptatum fugit placeat exercitationem adipisci ducimus nam. Sint necessitatibus porro omnis odio beatae illum autem. Non sint quo laudantium tempore aliquid iure.','1978-01-22 21:48:11'),(18,126,126,'Consequatur alias illo cupiditate ipsa. Ullam quibusdam in autem. Unde cupiditate et sed sequi. Cupiditate soluta sit et voluptate incidunt est molestias necessitatibus. Mollitia sit pariatur animi debitis reprehenderit voluptatibus placeat.','2003-11-11 22:10:13'),(19,130,130,'Est cum nulla magni. Voluptatum ut accusamus omnis sint ad quisquam.','1972-10-02 23:57:18'),(20,132,132,'Voluptates aliquam magnam accusamus magnam delectus dolorem. Deserunt quo ea fugit atque qui excepturi qui. Iusto cum consequatur omnis deleniti ad. Tenetur et veniam vel voluptatem sit illum.','1972-08-20 09:54:48'),(21,133,133,'Porro officiis commodi minima facilis sit. Ratione minima animi numquam nihil. Beatae repellendus molestiae quia eveniet qui voluptatibus aut.','2012-06-30 07:35:52'),(22,134,134,'Et aut nostrum voluptatum. Magni veritatis est est soluta optio. Porro tenetur possimus necessitatibus. Eaque laudantium quia magni neque.','2010-07-11 20:20:33'),(23,135,135,'Expedita iusto voluptatum velit alias ex iusto. Eveniet et nesciunt veritatis inventore qui officia id. Non exercitationem dolores earum dicta voluptatibus et iure. Corporis velit dolorem provident.','1986-05-05 11:07:34'),(24,137,137,'Quaerat natus doloribus quasi sint laboriosam omnis voluptatem excepturi. Delectus veritatis accusantium et. Saepe et nulla qui cupiditate dignissimos adipisci est. Quam aperiam reprehenderit et nihil iure dolorum eos.','1989-06-03 02:10:14'),(25,143,143,'Maxime ad et nulla doloremque. Consequatur sit explicabo velit eius. Eos animi rerum deserunt sed blanditiis harum est. Rem quo facere quasi accusamus corrupti.','2002-09-02 16:22:01'),(26,146,146,'Tenetur eveniet non omnis facilis repellat distinctio. Numquam alias eum laudantium mollitia odio et architecto optio. Saepe qui soluta et quo aut distinctio.','2000-10-30 12:29:19'),(27,147,147,'Reprehenderit accusamus mollitia consequatur rerum. Qui voluptatum et recusandae dolore omnis ut ut. Sed praesentium dignissimos tempora quidem eligendi nam.','1997-06-18 12:22:38'),(28,148,148,'Et consequuntur laborum labore vel animi dolore. Qui asperiores id ex ut laborum iure exercitationem. Quod recusandae dolore et laborum dicta atque nobis.','2013-03-02 15:42:41'),(29,150,150,'Ea voluptas id eaque recusandae et. Ipsam eos ipsum voluptatem animi inventore nihil. Illo necessitatibus nisi incidunt a. Quam earum qui amet et accusamus quia.','1975-11-14 13:10:38'),(30,153,153,'Non vel assumenda voluptate laborum molestiae odit recusandae. Architecto voluptas ducimus quia et necessitatibus quasi. Et vel officiis odio iure et voluptatem. Veritatis qui porro et.','1979-05-23 14:50:38'),(31,157,157,'Quisquam et fugit facere vel. Consequatur fugit cupiditate quo vel fugit dolore.','2015-04-20 03:03:36'),(32,158,158,'Aut tenetur in ratione nesciunt vel error molestias. Consequuntur nam sit et nihil et deserunt doloremque. Consequatur aut sunt dolorum ipsum veniam. Sint harum hic delectus voluptas porro dolores.','1988-01-16 13:32:40'),(33,160,160,'Adipisci quod velit sunt a sint iure et. Eum voluptas in quisquam debitis dolore error. Odit magni eveniet veniam et quod doloremque. Blanditiis a velit asperiores est.','1998-02-06 13:27:48'),(34,163,163,'Repellendus et similique enim quod sed. Est ipsum eum et magnam. Saepe consequuntur et maiores molestiae veniam voluptate aliquid. Excepturi optio dolore vero impedit aperiam officia doloremque.','2003-09-26 17:12:37'),(35,164,164,'Autem iusto ut sunt a. Voluptas qui cupiditate velit quod. Nam assumenda exercitationem vero hic.','2020-01-23 18:09:20'),(36,165,165,'In ut accusamus sint minima ipsa consectetur. Ex et unde culpa totam dolorem et. Recusandae vitae quia eum cum rerum.','1992-02-09 20:01:11'),(37,166,166,'Nostrum qui ut recusandae quia in. Pariatur aut error dolor et. Voluptas tempora id non vero beatae. Dolores voluptatibus quidem est et sequi eum voluptates.','1976-04-30 13:52:44'),(38,167,167,'Esse omnis qui natus itaque inventore. Aut possimus sed sit dolore dolor vitae. Voluptatem velit provident debitis magni illum et consequatur. Eius laudantium in distinctio explicabo.','2016-09-11 05:17:16'),(39,169,169,'Vero consequuntur fuga sunt asperiores voluptas. Animi non laborum excepturi dolores officia. Incidunt commodi maiores adipisci asperiores consequatur illum aut. Eum sunt quis ab aspernatur ut sed commodi.','1992-08-19 05:09:44'),(40,174,174,'Assumenda corporis vel ut corporis dolore quos. Similique et fugit rerum tempora.','1973-01-02 18:03:20'),(41,176,176,'Voluptates qui magnam aperiam quo sit aut accusantium laudantium. Ad aliquam nisi et ipsum perspiciatis. Harum sed repellendus maiores quis. Distinctio et fuga perspiciatis rerum iure exercitationem vero.','1971-10-21 05:58:17'),(42,177,177,'In repudiandae id dolores vero voluptatem molestiae. Commodi qui corrupti officiis itaque. Facilis necessitatibus explicabo eum quis neque.','1991-08-13 03:58:31'),(43,178,178,'Nihil quo earum est. Quisquam rerum itaque facilis nulla dolores non. Aliquid alias repellat libero pariatur.','1992-11-11 17:05:56'),(44,180,180,'Aut voluptatem optio aut eveniet dolor qui eum. Perferendis qui aut nihil eum aut omnis. Ut unde ut tempore ea consectetur.','2008-11-30 00:09:54'),(45,181,181,'Et aperiam iure vero sed rerum voluptas voluptates. Reiciendis officia molestiae quia ut suscipit enim qui. Est eveniet magnam natus quia itaque similique necessitatibus. Ut est consequuntur rerum consequatur.','1980-12-08 08:12:58'),(46,183,183,'Delectus blanditiis quo quis et corporis natus non. Excepturi provident nihil quo ad sed voluptatem beatae. Et magnam sed quod ab.','2003-06-08 06:45:22'),(47,186,186,'Quia impedit qui nostrum quasi consequuntur architecto corporis. Modi aut tempora laborum expedita recusandae dolores. Totam velit facilis iste fugit aut dolorem consequatur. Aut amet quo necessitatibus repudiandae repellendus.','1988-03-26 04:26:18'),(48,187,187,'Magnam et saepe quia. Quis in excepturi laborum distinctio dolorum.','2016-03-24 10:27:07'),(49,188,188,'Placeat eius atque et sit odit quo enim eaque. Consequatur ut consequatur at quibusdam ut dolor nesciunt fugiat. Totam fugiat dolores sit debitis earum qui culpa. Ut id consequuntur sed consequuntur optio atque.','2019-12-13 07:15:33'),(50,191,191,'Voluptatem totam pariatur mollitia dolor voluptatem nihil eaque. Cupiditate nobis expedita ea inventore distinctio rem. Et nisi illo occaecati ipsum et earum ipsam. Quod sit quo aspernatur in. Ut consequatur voluptas consequatur.','1995-01-05 15:10:27'),(51,193,193,'Quia voluptate corporis maiores molestias. Porro ut et laudantium nemo ut soluta.','1986-09-30 20:58:10'),(52,194,194,'Cupiditate reprehenderit doloremque vel. Dolorum voluptate laborum sunt doloremque iusto esse quod nihil. Illo ad animi sit ad et voluptas.','2005-10-24 12:39:26'),(53,197,197,'Quidem beatae totam et. Facere beatae adipisci dignissimos est. Cupiditate et dignissimos ipsam. Et molestias illo enim recusandae. Est doloribus et illum earum odio maxime.','1972-09-25 00:07:47'),(54,198,198,'Consectetur corporis et sed ut. Laborum nostrum eos neque vitae possimus aperiam ipsum. Temporibus deserunt cum placeat est dolorem hic. Autem quasi ratione et consequatur.','2002-09-26 23:12:46'),(55,199,199,'Possimus numquam veniam id. Temporibus id aspernatur libero debitis ut repellat. Omnis consequatur reprehenderit eius delectus. Aut vero numquam deserunt atque ut sit aliquid.','1999-11-17 18:57:20'),(56,200,200,'Repellat neque quis illo suscipit voluptatem. Sed blanditiis impedit aut delectus. Error tempora ipsa sunt nostrum.','1976-07-01 00:20:24'),(57,101,101,'Odio possimus quia est aut dolor ipsam rerum. Repudiandae omnis consequuntur aperiam est repellendus officiis animi. Consequatur perferendis odit dignissimos et suscipit temporibus eum. Voluptas dolores quis sed repudiandae veniam.','1975-09-25 12:13:56'),(58,102,102,'Ipsa qui animi blanditiis et repellat. Qui et harum iusto et sunt cupiditate doloribus. Eum omnis repudiandae est. Dolor optio nobis dignissimos ducimus quos aliquid. Minus iusto et voluptatem vero ex culpa.','2001-02-10 00:39:11'),(59,103,103,'Fugit quam odio delectus et nihil quaerat soluta. Omnis cum ipsam quia quidem odit. Ut ad qui autem iste.','1978-12-30 18:02:15'),(60,106,106,'Delectus ipsa hic molestiae eligendi eaque dolorem. Quae aut laborum non iste. Non ad dignissimos distinctio molestiae dolores aspernatur.','1978-11-04 11:41:48'),(61,107,107,'Sapiente fugiat aliquam et debitis quaerat aut quo et. Est expedita libero consequatur voluptas laudantium. Inventore omnis quibusdam doloremque molestiae similique.','1993-07-12 15:20:34'),(62,108,108,'Qui et possimus fugit consectetur et iusto sed. Architecto vero enim qui inventore et corporis. Tempore cumque praesentium rerum explicabo.','1972-06-22 21:18:28'),(63,111,111,'Tempore quos sit rerum excepturi aut. Quia est quo sunt iure eveniet. Deleniti voluptatem voluptate voluptatem non ut aspernatur. Quas rerum deleniti ipsam explicabo odit tempora aut natus.','2016-08-28 21:29:43'),(64,112,112,'Quis fugiat ut rerum ea unde. Libero est occaecati repellendus nam. Debitis dolor et ut maiores repellendus optio.','1981-10-13 02:33:52'),(65,113,113,'Quisquam ullam minus aspernatur omnis aut est qui ipsam. Dolores quod est eos et consequatur incidunt. Assumenda doloribus iure impedit ex consequatur qui expedita earum.','1970-04-13 10:38:27'),(66,114,114,'Atque officia aut ex architecto aut. Temporibus molestiae eveniet error totam et nobis. Cum ut sunt minus facere et quibusdam veniam. Pariatur dignissimos temporibus sit magnam sint laboriosam. Eaque molestiae quae eum nihil ipsam.','1973-06-15 18:13:48'),(67,115,115,'Numquam delectus ea et aliquid placeat magnam et molestias. Sint aspernatur blanditiis esse aperiam pariatur. Possimus ut quibusdam ut quia facilis occaecati necessitatibus. Nulla corporis exercitationem in qui dolore odio cumque ut.','1991-12-05 20:37:12'),(68,117,117,'Nesciunt modi repudiandae maxime asperiores provident velit. Ipsa eligendi dolor nemo incidunt.','2013-08-05 01:31:07'),(69,118,118,'Minima deleniti est libero nemo delectus. Et aspernatur voluptas omnis blanditiis excepturi qui. Minus earum odio ducimus adipisci voluptatum.','2011-11-28 20:22:13'),(70,121,121,'Aut non qui nostrum et cumque odio amet. Nihil quidem ab ea nesciunt consequatur. Ipsum id quis provident voluptatem vero doloribus.','2010-12-31 09:57:19'),(71,122,122,'Beatae deserunt incidunt molestias sit iusto. Non voluptatem maiores et quibusdam delectus. Quidem sit praesentium voluptas ea quas voluptate consequatur. Eum eveniet fuga eos.','2003-01-24 18:29:37'),(72,123,123,'In et rerum deserunt consequatur reprehenderit. Dolorem aut vero atque a sed omnis placeat. Cupiditate et doloremque est ullam voluptatem eos. Et illum praesentium consequuntur ut.','2020-03-01 05:56:17'),(73,124,124,'Repellat sint quo ut voluptates officiis repellendus. Voluptas quaerat commodi animi deserunt omnis. Eius libero enim dolorem fugiat nulla recusandae aut. Ut vel placeat quo minima eum modi fugit.','1973-04-23 15:52:17'),(74,126,126,'Fugiat corporis vero excepturi. Omnis ut totam explicabo nostrum minima vel. Autem vero sint quo eos hic reiciendis aut.','1979-07-23 11:46:32'),(75,130,130,'Qui ipsum dolorem possimus. Natus enim soluta itaque excepturi harum iure necessitatibus non. Aut et saepe nam quasi minus quidem cumque est. Similique consequuntur maiores qui dolorem perferendis. Vitae qui qui eligendi voluptas voluptas.','2017-04-21 11:09:51'),(76,132,132,'Rerum nihil alias dolorem. Veniam qui porro nesciunt sint velit. Esse assumenda est magnam natus. Dolor dolorum aspernatur animi temporibus.','1988-09-14 11:58:49'),(77,133,133,'Eos maiores explicabo placeat est. Et mollitia odit eum aperiam error voluptatibus incidunt. Necessitatibus natus ad reiciendis veniam et aperiam reiciendis.','1995-02-21 02:47:28'),(78,134,134,'Corporis non soluta provident. Nemo dolorum voluptatem ad eos quia. Est aliquam nemo perferendis ut amet.','1973-06-14 06:10:47'),(79,135,135,'Deleniti ipsam sit fugit commodi. Fugit reprehenderit at minima consequuntur dolore eligendi. Dolore provident quod voluptate omnis corporis necessitatibus voluptatem.','2003-12-22 09:20:21'),(80,137,137,'Dolorum incidunt quidem id error iusto impedit sequi. Sint molestiae officia magni rerum tempore eligendi. Ut et quo repellat et autem dignissimos. Quis qui voluptates maxime debitis aut commodi.','1975-03-21 16:20:59'),(81,143,143,'Aliquam aliquid error non dolor. Accusantium illo laudantium nostrum in sit exercitationem. Maxime occaecati rem eos et explicabo dolor omnis.','1996-08-18 05:51:14'),(82,146,146,'Saepe unde et distinctio dicta dolor consequuntur. Quia commodi fugit corrupti dolor. Alias consectetur eaque repellat et aliquid molestias praesentium.','1994-06-29 22:48:16'),(83,147,147,'A voluptatem quia eaque alias eligendi. Rerum porro numquam recusandae ad.','2010-11-03 01:32:34'),(84,148,148,'Nobis ut ut non ut enim. Aut non beatae odit reiciendis nisi. Iste natus quis deleniti voluptates ut saepe omnis.','2008-07-03 13:55:56'),(85,150,150,'Aut voluptate voluptas eos tempora. Vitae ea nisi ab ut aliquid odit cum iure. Distinctio omnis tenetur odit consequatur modi asperiores.','2003-12-25 19:05:51'),(86,153,153,'Accusantium dolorum ad quo velit nihil distinctio est. Qui eum facilis cupiditate veniam repellat quia. Fugiat minus exercitationem tempora suscipit accusamus suscipit ipsa omnis.','2020-05-13 15:57:29'),(87,157,157,'Dolores ea amet quidem commodi est est nostrum. Fugit est laudantium sint provident esse quos. Molestias eum quasi enim magni odio ut atque.','1984-05-19 15:54:56'),(88,158,158,'Qui aspernatur sit fuga. Consectetur impedit accusantium pariatur qui nam tempora. Autem voluptatem voluptatibus aut repellat perspiciatis maiores.','1970-02-15 05:03:22'),(89,160,160,'Voluptatum velit doloremque nisi atque. Sit molestiae quis sit dolorem. Reprehenderit autem illum saepe hic dolorem omnis aut.','1987-11-15 07:46:04'),(90,163,163,'Officiis quisquam iusto harum tenetur. Molestiae modi ipsa ipsam maiores nihil non necessitatibus. Nemo aspernatur explicabo facere ea aut tempore.','1986-09-04 03:41:56'),(91,164,164,'Repellat magnam quo fuga repellat. Necessitatibus rerum illum aut debitis. Repellendus est delectus sit enim.','2013-07-07 12:28:47'),(92,165,165,'Aut nostrum cupiditate officiis. Qui mollitia recusandae dolore ducimus magni corrupti. Id vel animi asperiores distinctio. Quisquam quibusdam eveniet illo atque officiis.','2001-06-09 00:17:25'),(93,166,166,'Nesciunt eum perspiciatis est qui necessitatibus amet. Voluptatum deleniti itaque aut quo numquam voluptatem. Dolores sed soluta magni in. Animi nihil rerum fugiat suscipit mollitia voluptatum vel dolores.','1985-12-12 14:31:41'),(94,167,167,'Eum enim possimus exercitationem omnis officia. Est labore voluptate et nemo exercitationem ut a quo. Labore neque praesentium ea quae dolore.','1978-12-21 00:27:43'),(95,169,169,'Esse optio et voluptatibus doloribus. Quis debitis nulla magni vel possimus doloremque. Velit consequatur aliquam quis maxime aliquid.','2000-07-05 17:57:49'),(96,174,174,'Dignissimos voluptas qui vel nam sapiente. Dolor eos qui est voluptatem. Illo iste maiores omnis dicta omnis nobis.','2015-07-06 01:31:56'),(97,176,176,'Iure illo reiciendis ut ut. Eum dolor dolores similique. Accusamus sit consectetur fugit iure quasi cupiditate et unde. Exercitationem provident quae distinctio. Commodi facilis totam hic autem accusamus non et.','2014-10-12 02:44:33'),(98,177,177,'Magnam officia nesciunt repellendus dolorem. Occaecati possimus voluptates incidunt aspernatur ut. Suscipit doloremque sint veritatis sed repellat sunt adipisci quis.','1977-02-26 20:27:05'),(99,178,178,'Non labore officia aspernatur error sit. Sint eligendi quo labore repudiandae fuga accusamus qui. Distinctio architecto dicta et quo. Delectus repudiandae et et ipsa itaque.','1994-03-11 10:07:05'),(100,180,180,'Perspiciatis incidunt porro dolores optio. Harum inventore et et consequatur perspiciatis non. Rerum qui ab laborum. Natus ut iste deserunt consectetur sunt doloremque officia.','2014-01-13 18:59:38');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photo_albums`
--

DROP TABLE IF EXISTS `photo_albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `photo_albums` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `photo_albums_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photo_albums`
--

LOCK TABLES `photo_albums` WRITE;
/*!40000 ALTER TABLE `photo_albums` DISABLE KEYS */;
INSERT INTO `photo_albums` VALUES (1,'assumenda',101,'2015-07-15 18:59:14','1996-08-06 11:43:05'),(2,'molestiae',102,'2009-11-15 05:02:41','1980-08-09 18:55:18'),(3,'et',103,'1985-07-12 23:47:48','1977-06-23 12:45:30'),(4,'omnis',106,'1998-04-19 02:48:00','2013-02-16 20:35:39');
/*!40000 ALTER TABLE `photo_albums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photos`
--

DROP TABLE IF EXISTS `photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `photos` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `album_id` bigint unsigned NOT NULL,
  `media_id` bigint unsigned NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `album_id` (`album_id`),
  KEY `media_id` (`media_id`),
  CONSTRAINT `photos_ibfk_1` FOREIGN KEY (`album_id`) REFERENCES `photo_albums` (`id`),
  CONSTRAINT `photos_ibfk_2` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photos`
--

LOCK TABLES `photos` WRITE;
/*!40000 ALTER TABLE `photos` DISABLE KEYS */;
INSERT INTO `photos` VALUES (1,1,1,'1981-09-05 12:48:00','1971-01-02 05:57:15'),(2,2,2,'2005-11-18 13:27:23','1996-12-11 14:33:28'),(3,3,3,'1976-06-15 15:30:17','2003-11-17 05:18:01'),(4,4,4,'1978-09-17 15:40:30','1995-03-17 00:59:13'),(5,1,5,'1972-01-03 13:06:01','2004-03-16 21:07:26'),(6,2,6,'1988-02-29 03:00:55','2003-06-04 07:53:22'),(7,3,7,'2013-05-07 18:08:46','1998-11-17 05:16:33'),(8,4,8,'1984-05-10 14:47:06','1983-12-03 05:29:55'),(9,1,9,'1985-12-03 09:57:14','1984-05-21 19:36:42'),(10,2,10,'1994-12-05 18:49:11','1976-11-23 13:35:10'),(11,3,1,'1984-05-14 19:38:15','1986-09-06 05:00:15'),(12,4,2,'2015-05-31 00:14:59','1971-10-18 05:51:01'),(13,1,3,'1991-07-28 11:43:31','1971-08-04 04:03:00'),(14,2,4,'1999-03-05 10:34:03','1980-11-12 10:18:59'),(15,3,5,'1996-01-19 19:08:54','1973-10-15 04:35:17'),(16,4,6,'1999-05-27 16:30:48','2006-07-09 08:10:44'),(17,1,7,'1974-03-02 01:52:20','1995-04-21 15:57:41'),(18,2,8,'2018-07-29 03:34:16','1995-04-18 22:15:03'),(19,3,9,'1972-07-14 04:41:28','1979-08-17 02:43:03'),(20,4,10,'2001-08-26 17:15:41','1982-11-14 17:06:20'),(21,1,1,'1981-10-09 07:02:07','1985-07-17 13:58:48'),(22,2,2,'1997-06-16 20:16:16','2002-11-16 23:14:18'),(23,3,3,'2006-11-09 11:43:36','1990-07-30 23:22:12'),(24,4,4,'2014-03-20 20:46:42','2017-03-29 05:16:56'),(25,1,5,'1975-04-18 23:34:27','1999-01-25 06:56:47'),(26,2,6,'1974-03-14 12:27:56','1979-10-16 17:46:31'),(27,3,7,'2011-10-09 20:08:27','2001-08-30 00:39:11'),(28,4,8,'1980-07-29 14:26:42','2004-10-09 11:57:27'),(29,1,9,'2002-05-15 17:54:55','1972-01-07 01:29:12'),(30,2,10,'1996-06-07 09:33:24','2019-11-18 14:06:04'),(31,3,1,'2000-01-01 01:55:16','1979-09-01 03:19:54'),(32,4,2,'2017-11-29 03:14:19','2016-03-27 08:10:24'),(33,1,3,'2016-01-24 05:55:37','1992-10-16 10:31:48'),(34,2,4,'1997-06-27 14:19:31','1994-07-29 09:21:24'),(35,3,5,'1992-11-07 12:36:16','1986-04-07 22:03:03'),(36,4,6,'2018-12-24 14:21:32','2014-03-29 06:17:43'),(37,1,7,'1981-09-20 07:49:37','1988-02-05 18:09:23'),(38,2,8,'1986-12-19 06:46:11','1973-05-23 09:14:58'),(39,3,9,'1978-06-17 18:57:06','1983-05-28 18:53:14'),(40,4,10,'2015-09-07 15:16:29','2013-12-22 21:23:11'),(41,1,1,'1976-01-15 05:45:42','1999-09-10 18:28:56'),(42,2,2,'1997-02-08 02:14:19','2003-02-07 10:24:56'),(43,3,3,'1977-12-22 19:23:29','2007-06-21 02:15:04'),(44,4,4,'2005-10-25 08:19:14','2013-02-15 12:11:38'),(45,1,5,'2000-04-01 21:33:57','1987-09-24 23:11:07'),(46,2,6,'2000-10-23 09:39:05','1982-02-26 08:52:39'),(47,3,7,'1990-08-12 15:41:20','1983-03-15 18:14:36'),(48,4,8,'2000-12-08 09:15:32','1979-10-30 04:29:05'),(49,1,9,'1989-01-25 16:02:57','2001-01-20 22:44:03'),(50,2,10,'2013-11-06 09:47:11','1987-02-20 18:23:37'),(51,3,1,'1985-06-23 17:23:54','1993-03-25 22:37:14'),(52,4,2,'2003-09-11 09:03:10','1980-11-28 23:05:38'),(53,1,3,'1991-03-20 06:48:33','1983-05-10 14:30:39'),(54,2,4,'2001-03-21 15:02:13','1971-05-23 15:02:11'),(55,3,5,'1990-05-08 07:49:38','1972-07-28 12:20:06'),(56,4,6,'2015-05-13 15:44:34','2002-02-11 13:49:04'),(57,1,7,'1989-09-03 10:03:28','2005-12-01 00:00:47'),(58,2,8,'1981-12-31 23:08:30','2018-06-30 08:05:25'),(59,3,9,'2009-12-24 11:35:05','1998-04-17 19:39:50'),(60,4,10,'1975-02-26 04:49:23','1971-06-23 14:52:49'),(61,1,1,'1988-09-28 04:26:39','1990-07-17 22:02:15'),(62,2,2,'2014-02-06 06:59:09','1991-11-26 11:24:08'),(63,3,3,'1988-03-26 19:34:14','1987-09-27 14:04:07'),(64,4,4,'1983-08-19 23:17:19','1979-01-12 15:17:42'),(65,1,5,'1983-02-18 17:36:09','1979-07-17 01:12:01'),(66,2,6,'1996-03-12 00:38:11','1990-01-19 13:23:34'),(67,3,7,'1980-12-18 10:05:16','1998-08-05 16:50:12'),(68,4,8,'1971-09-18 12:19:19','1990-05-21 22:35:25'),(69,1,9,'2013-09-05 22:34:09','1971-10-15 15:58:11'),(70,2,10,'1993-10-25 20:26:24','2018-02-03 01:43:26'),(71,3,1,'1983-12-16 04:22:57','1986-05-30 03:12:50'),(72,4,2,'1975-05-07 02:32:29','1976-04-20 00:44:03'),(73,1,3,'2010-09-13 01:58:36','1998-02-21 07:13:27'),(74,2,4,'1996-12-27 08:43:55','2008-03-14 01:51:01'),(75,3,5,'2008-09-05 23:21:10','1984-12-31 13:40:07'),(76,4,6,'1996-07-06 02:04:54','2009-12-23 05:43:59'),(77,1,7,'1987-09-20 13:41:59','2006-12-19 06:17:03'),(78,2,8,'1998-02-26 01:17:46','1985-09-06 23:58:30'),(79,3,9,'1980-02-13 03:20:38','2008-10-26 12:42:22'),(80,4,10,'2008-08-31 04:37:20','1997-11-08 06:28:27'),(81,1,1,'2003-04-11 16:26:04','1975-07-02 17:46:03'),(82,2,2,'1998-03-26 20:37:36','2018-06-04 10:19:03'),(83,3,3,'1998-01-09 03:50:15','2016-01-13 20:27:28'),(84,4,4,'2016-11-05 14:52:50','1989-10-08 16:38:50'),(85,1,5,'1984-02-07 17:16:10','1975-10-03 22:37:08'),(86,2,6,'1987-03-29 18:52:29','2001-02-14 23:00:21'),(87,3,7,'1973-05-20 13:02:13','2007-09-24 14:48:03'),(88,4,8,'2014-11-02 21:06:21','2011-06-16 13:15:58'),(89,1,9,'2012-10-01 15:22:39','1975-09-28 01:22:05'),(90,2,10,'1987-07-13 07:24:44','1992-03-18 17:10:01'),(91,3,1,'1973-12-14 17:15:46','2014-01-06 10:12:38'),(92,4,2,'2007-01-19 13:01:38','1993-06-01 07:27:48'),(93,1,3,'2015-03-30 10:49:30','2011-05-25 03:13:51'),(94,2,4,'1971-03-22 20:51:30','2017-11-18 05:16:42'),(95,3,5,'1994-10-21 15:44:46','1991-08-17 05:52:51'),(96,4,6,'2016-06-17 19:33:40','1970-07-27 05:08:47'),(97,1,7,'1984-06-26 02:36:20','1979-04-30 03:07:02'),(98,2,8,'2000-07-26 10:22:17','2009-05-22 17:49:57'),(99,3,9,'1992-02-24 01:47:22','2002-06-11 18:03:36'),(100,4,10,'1983-09-07 20:01:25','2016-05-06 00:11:01');
/*!40000 ALTER TABLE `photos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `author_id` bigint unsigned DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `body_text` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `connected_photo_id` bigint unsigned DEFAULT NULL,
  `connected_media_id` bigint unsigned DEFAULT NULL,
  `comments_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `author_id` (`author_id`),
  KEY `connected_photo_id` (`connected_photo_id`),
  KEY `connected_media_id` (`connected_media_id`),
  CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`),
  CONSTRAINT `posts_ibfk_2` FOREIGN KEY (`connected_photo_id`) REFERENCES `photos` (`id`),
  CONSTRAINT `posts_ibfk_3` FOREIGN KEY (`connected_media_id`) REFERENCES `media` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Посты пользователей';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,101,'Sit eligendi in saepe commodi ad consectetur voluptates. Voluptatem voluptatem voluptatem dolorum id autem quisquam voluptatem. Ut repudiandae velit doloribus et nesciunt a.',NULL,'2019-09-19 05:57:46','1999-04-03 09:25:13',1,1,NULL),(2,102,'Maxime eos omnis eos at. Corrupti ad id qui facere vero id sed natus. Laborum libero cumque dolor animi et dicta. Doloribus doloribus et in deserunt.',NULL,'1997-06-18 12:21:20','1987-04-07 20:17:06',2,2,NULL),(3,103,'Et autem amet repellendus odio. Reprehenderit at molestias ratione velit iure in. Eum aspernatur laborum enim cupiditate et. Modi quas quo perferendis totam quasi a porro.',NULL,'2005-08-02 17:53:48','1977-09-05 22:50:12',3,3,NULL),(4,106,'Quia illo aut rerum qui quis. Illo ullam est qui nihil maxime minus. Repellendus eos molestiae perspiciatis voluptates eaque.',NULL,'1996-06-05 12:40:57','1999-04-08 07:42:19',4,4,NULL),(5,107,'Et vel debitis molestiae perspiciatis natus molestiae aut suscipit. Laborum unde quo autem officiis voluptas error.',NULL,'1974-04-19 15:48:52','1976-07-07 12:17:20',5,5,NULL),(6,108,'Aspernatur laborum culpa ea. Eos et voluptates voluptatum sint qui. Sapiente voluptatibus deserunt magni sit. Officiis commodi expedita voluptates est commodi et dolores non.',NULL,'2011-03-05 19:00:49','1979-08-31 06:06:51',6,6,NULL),(7,111,'Sit iste quasi tempore molestiae. Voluptatem quis ex beatae incidunt totam. Qui earum mollitia excepturi earum quasi labore.',NULL,'1970-06-18 21:30:21','1999-09-07 22:17:05',7,7,NULL),(8,112,'Eveniet consequatur eos veritatis atque dolore doloribus dolores. Maxime et necessitatibus aliquid laudantium saepe nobis. Quae incidunt cupiditate et sit sed.',NULL,'1974-02-23 20:11:44','1993-08-17 07:39:30',8,8,NULL),(9,113,'Voluptas cum laboriosam aut vitae repellat quia. Sequi magni ad quia consequatur dolore iste nesciunt. Vel veritatis fugiat commodi dicta.',NULL,'1975-05-06 21:42:25','2008-08-22 06:17:00',9,9,NULL),(10,114,'Quia impedit velit rerum laborum magnam. Voluptas ut earum dignissimos repudiandae totam molestias consectetur. Molestias cum fuga laborum nihil deserunt cupiditate.',NULL,'2015-01-23 11:43:30','2005-05-25 09:02:02',10,10,NULL),(11,115,'Est molestias accusamus velit adipisci id. Voluptatem aliquam nemo ex. Rerum culpa autem est sequi.',NULL,'2015-12-09 19:35:24','2006-02-18 18:55:27',11,1,NULL),(12,117,'Ut provident ut qui qui vel quasi cumque. Soluta illo eligendi sint est facilis aut non. Ad ut dolores consequatur libero suscipit illum aut.',NULL,'1970-07-05 19:39:25','1971-11-07 03:42:47',12,2,NULL),(13,118,'Sed expedita ut excepturi aut commodi. Non consectetur non illo distinctio qui adipisci voluptatem facilis. Consequatur et modi facilis sed adipisci optio.',NULL,'1996-06-18 22:04:53','1998-08-01 10:43:54',13,3,NULL),(14,121,'Aliquam est ipsa id reprehenderit cupiditate maiores. Minus provident et magnam fugiat aliquid est rerum.',NULL,'2008-09-11 08:57:52','2006-10-17 06:32:57',14,4,NULL),(15,122,'Voluptatem culpa itaque et nesciunt. Quia est ut quisquam dignissimos hic sunt est. Illum molestiae et laborum esse. Enim numquam magni enim quod.',NULL,'1994-12-28 08:45:05','2010-04-08 00:21:03',15,5,NULL),(16,123,'Eos sit repellendus facere est. Consequatur sit officia quas voluptas quis sequi. Quaerat illum dolorum delectus quae in.',NULL,'2011-02-15 14:09:14','2019-04-20 00:34:26',16,6,NULL),(17,124,'Voluptatem nulla accusantium amet maiores exercitationem id. Corrupti similique perferendis accusantium temporibus. Architecto sed consequatur quod dolor perferendis. Quae velit ipsum omnis quae.',NULL,'2001-06-24 01:00:50','2019-10-04 18:03:40',17,7,NULL),(18,126,'Blanditiis natus et voluptatibus repellat. Quia voluptates reiciendis vitae velit occaecati ut. Asperiores accusantium rerum qui unde magnam.',NULL,'2014-12-02 07:49:21','2008-12-02 23:55:42',18,8,NULL),(19,130,'Minima maiores enim cum quidem. Sit doloribus inventore dignissimos officiis et. Omnis dignissimos dolorum rem. Voluptas omnis blanditiis possimus laboriosam quis consectetur aut.',NULL,'2005-11-23 06:09:13','1975-03-10 20:43:13',19,9,NULL),(20,132,'Itaque aut aut quisquam. Esse nisi quasi et omnis. Aliquid accusantium ut qui corporis est.',NULL,'1979-07-13 18:05:17','1995-07-28 16:44:33',20,10,NULL);
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profiles` (
  `user_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `gender` enum('male','female') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `birthday` date NOT NULL,
  `photo_id` bigint unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `hometown` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Информация о пользователе';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` VALUES (101,'male','1997-04-03',NULL,'1983-12-21 17:56:18','1986-06-27 03:47:45','Christianview'),(102,'female','2001-03-24',NULL,'1971-06-02 19:44:27','1971-03-25 17:32:08','Vivamouth'),(103,'male','1994-04-11',NULL,'1976-06-23 02:33:39','1972-03-05 01:11:50','Cruickshankstad'),(106,'male','2015-11-10',NULL,'1987-04-06 21:03:52','1975-07-26 00:26:42','Shanetown'),(107,'female','1997-01-12',NULL,'1981-09-25 08:16:19','2001-05-15 03:15:55','Lake Carlosborough'),(108,'female','1990-05-16',NULL,'1983-05-09 06:51:44','1990-04-17 02:06:12','New Monserratestad'),(111,'female','1999-03-01',NULL,'1977-04-20 00:42:15','1976-01-15 00:05:58','East Benton'),(112,'female','1980-01-01',NULL,'1975-03-27 08:26:45','1973-08-07 10:58:51','North Rosannafort'),(113,'male','1974-09-12',NULL,'1986-04-17 19:50:19','2002-09-21 08:30:33','Port Lavonne'),(114,'male','2007-11-26',NULL,'1971-12-31 16:19:52','1992-07-19 01:25:30','North Chasityton'),(115,'female','2008-06-12',NULL,'2014-09-01 22:43:11','2001-11-05 07:19:47','North Monserrate'),(117,'female','2013-05-17',NULL,'1984-10-11 12:12:06','1974-07-29 00:15:06','Dietrichborough'),(118,'male','2010-07-05',NULL,'1975-02-28 14:18:39','2005-11-26 04:47:43','Lake Nicholausland'),(121,'female','1999-04-10',NULL,'1983-10-08 09:37:15','2009-01-21 19:47:52','South Billy'),(122,'male','1992-12-16',NULL,'1997-10-28 18:59:46','2011-06-29 18:57:10','West Brandy'),(123,'female','2009-12-03',NULL,'1972-07-21 15:18:19','2009-09-25 15:07:45','New Ryleigh'),(124,'male','1991-07-22',NULL,'2016-09-16 17:57:33','1999-02-22 03:49:22','West Anibal'),(126,'female','1984-07-13',NULL,'1994-03-31 17:46:54','2011-10-23 11:07:13','Rolfsonport'),(130,'female','2015-07-11',NULL,'2008-07-25 20:20:20','1988-06-27 17:10:37','Volkmanport'),(132,'male','2017-02-22',NULL,'1988-01-21 03:49:57','2004-04-07 01:56:06','Horacechester'),(133,'female','2016-04-01',NULL,'1992-04-14 06:18:56','1982-04-15 05:48:01','Orlofurt'),(134,'female','1979-01-04',NULL,'1997-09-10 17:26:38','1975-08-06 23:23:22','West Harrison'),(135,'male','2009-11-09',NULL,'1994-01-11 10:29:30','2018-10-09 02:18:50','North Codystad'),(137,'male','1996-07-26',NULL,'1970-07-03 23:40:45','2014-05-26 22:43:26','Leliaside'),(143,'male','1984-11-23',NULL,'1984-05-29 08:25:03','2010-01-12 12:01:54','Port Rhianna'),(146,'male','2016-03-03',NULL,'1992-05-10 05:13:34','1997-08-10 06:21:45','Jacobsstad'),(147,'female','2015-05-06',NULL,'1977-08-24 13:39:21','1996-08-19 14:48:44','Altenwerthland'),(148,'female','2010-08-20',NULL,'2014-11-18 06:08:18','1991-06-11 13:23:28','Nienowchester'),(150,'female','1983-03-13',NULL,'2001-09-02 02:38:42','2003-06-13 15:34:11','Johnsville'),(153,'female','2010-03-21',NULL,'1971-01-21 18:18:26','1982-08-25 01:51:32','Paucekborough'),(157,'male','1985-11-14',NULL,'2008-03-13 18:46:24','1985-11-21 15:11:26','New Arnaldo'),(158,'female','2013-05-26',NULL,'1998-08-05 06:57:33','1977-07-28 06:18:55','New Vanessa'),(160,'male','1993-07-24',NULL,'1985-07-27 07:54:28','2013-12-31 06:49:56','Stehrhaven'),(163,'female','1971-03-19',NULL,'1982-06-25 21:21:14','2017-12-31 21:38:22','Port Dudleyshire'),(164,'male','2013-03-28',NULL,'2008-06-30 06:47:24','1998-08-04 04:10:09','South Genesis'),(165,'female','1991-07-19',NULL,'1986-09-29 21:29:10','1990-10-23 03:51:29','Cruzside'),(166,'male','1981-09-04',NULL,'2013-12-29 10:19:15','1974-11-23 17:30:54','Tillmanhaven'),(167,'male','1980-10-27',NULL,'2009-10-09 01:15:18','2002-04-04 14:31:43','New Maxie'),(169,'female','2002-12-22',NULL,'1991-02-05 04:06:10','1987-02-10 20:56:31','New Eldridge'),(174,'male','1974-03-05',NULL,'1979-11-11 19:02:27','1996-12-12 15:32:09','East Cletusshire'),(176,'female','1979-03-12',NULL,'1978-05-05 04:03:38','1996-09-19 07:46:03','South Corrine'),(177,'male','2018-07-14',NULL,'2006-12-15 14:28:17','1973-09-02 11:53:28','East Pearlie'),(178,'male','2018-02-18',NULL,'2001-05-23 05:28:04','1996-01-05 17:28:42','New Earleneside'),(180,'female','1972-10-30',NULL,'1975-07-26 02:11:15','1980-02-04 01:14:31','Murazikburgh'),(181,'male','1975-08-16',NULL,'2000-05-18 14:11:36','1989-02-10 21:17:56','Adamstown'),(183,'male','1982-12-29',NULL,'2010-07-28 06:46:02','2011-02-12 15:29:34','Lake Mattfurt'),(186,'female','2017-04-18',NULL,'1983-10-20 18:32:19','1999-03-25 10:57:38','Fayborough'),(187,'female','1997-10-04',NULL,'1993-03-15 14:27:18','1981-01-01 01:52:20','Waelchiland'),(188,'male','1982-06-27',NULL,'2011-04-06 08:07:38','1983-08-08 01:05:40','Agustinafurt'),(191,'male','1979-05-07',NULL,'2009-01-07 17:18:13','1978-10-12 12:17:17','East Fabiolahaven'),(193,'female','1992-01-13',NULL,'2007-02-07 20:29:16','1985-03-08 18:16:42','New Joberg'),(194,'female','1977-04-19',NULL,'1970-04-10 10:15:10','2015-12-10 23:48:22','Bayerstad'),(197,'female','1975-07-25',NULL,'2000-09-30 09:41:24','1980-11-04 20:43:08','Roobport'),(198,'male','2007-09-10',NULL,'2018-09-10 08:31:56','1992-02-13 22:24:06','South Tatumview'),(199,'female','1973-08-03',NULL,'2001-08-14 00:22:23','1986-08-15 00:04:38','East Rasheed'),(200,'female','1996-08-03',NULL,'2000-12-25 20:35:02','2015-03-21 14:59:24','North Mireille');
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `lastname` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Фамилия',
  `email` varchar(120) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone` (`phone`),
  UNIQUE KEY `email` (`email`),
  KEY `users_phone_idx` (`phone`),
  KEY `users_firstname_lastname_idx` (`firstname`),
  KEY `users_lastname_idx` (`lastname`)
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Пользователи';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (101,'Nannie','Sipes','kshlerin.kathryn@example.com',244),(102,'Trace','Bauch','ureynolds@example.org',523152),(103,'Maxine','Carroll','esauer@example.com',0),(106,'Cody','Walter','rowena.hessel@example.com',190),(107,'Addie','Schultz','ioberbrunner@example.org',97792),(108,'Marietta','Prosacco','orval44@example.com',2147483647),(111,'Claudine','Green','xemard@example.net',686),(112,'Eliezer','Graham','nhartmann@example.org',425),(113,'Leila','Wolf','brennan27@example.com',634),(114,'Aida','Johnson','hwalsh@example.net',1),(115,'Kraig','Schroeder','nelle.brekke@example.net',848255771),(117,'Courtney','Wolff','molson@example.com',9),(118,'Lula','Will','baumbach.myra@example.com',927457),(121,'Zoe','Goodwin','darius93@example.net',161),(122,'Alan','Considine','jeffrey37@example.net',694286),(123,'Merle','Johnson','tessie48@example.org',823537),(124,'Melba','Sipes','nienow.laurence@example.org',375630),(126,'Ellen','Collier','shields.catherine@example.com',376),(130,'Judah','Hartmann','walsh.archibald@example.com',345613),(132,'Stephon','Johns','donnelly.enrico@example.net',774960),(133,'Cecelia','Hodkiewicz','juwan.rogahn@example.net',44052),(134,'Gabriella','Greenholt','kaylee.o\'connell@example.org',83),(135,'Keyon','Dickinson','blair.turner@example.com',44),(137,'Vella','Roob','joyce.wehner@example.org',965),(143,'Adrien','Cremin','laisha.kertzmann@example.com',977),(146,'Tremaine','Moen','schulist.elisha@example.com',381500),(147,'Aaron','Ondricka','margarete58@example.net',440),(148,'Pat','Hoppe','bupton@example.com',282),(150,'Deonte','Bergstrom','pblanda@example.com',147016),(153,'Laura','Parker','heidenreich.hardy@example.org',609),(157,'Janie','Cartwright','collier.allie@example.org',182198),(158,'Sydni','Moen','ocrooks@example.org',639193),(160,'Lucienne','Grant','marguerite51@example.net',926559),(163,'Kayli','Heller','sheldon.dickinson@example.com',813),(164,'Russell','Bernier','cheyanne95@example.org',858),(165,'Murphy','Ullrich','koss.craig@example.org',36),(166,'Albin','Gutkowski','hattie73@example.org',574),(167,'Demario','Stokes','evert.swift@example.net',21),(169,'Ward','Kreiger','stanley.erdman@example.net',67),(174,'Jameson','Stroman','roselyn25@example.com',992),(176,'Isaiah','Konopelski','kamron24@example.org',621161),(177,'Claire','Luettgen','kelli31@example.org',687716),(178,'Rigoberto','Sawayn','caterina.corkery@example.com',718836),(180,'Kristin','Huel','stamm.ronaldo@example.net',924),(181,'Fiona','Thiel','pete64@example.net',833983),(183,'Zella','Ratke','spinka.damien@example.org',54),(186,'Corene','Mante','nader.mathias@example.net',114486),(187,'Joanie','Padberg','nrice@example.net',301723),(188,'Kade','Skiles','cody09@example.com',75),(191,'Myrtice','Walsh','leland.gleason@example.com',23),(193,'Elise','Harvey','edach@example.com',73),(194,'Foster','Hartmann','thessel@example.net',472394),(197,'Jane','Hegmann','pfannerstill.aida@example.org',48690),(198,'Wilhelmine','Leuschke','no\'conner@example.com',488),(199,'Dariana','Ritchie','collier.gertrude@example.net',556),(200,'Audrey','Miller','jasper68@example.com',236);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_communities`
--

DROP TABLE IF EXISTS `users_communities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_communities` (
  `user_id` bigint unsigned NOT NULL,
  `community_id` bigint unsigned NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`,`community_id`),
  KEY `community_id` (`community_id`),
  CONSTRAINT `users_communities_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `users_communities_ibfk_2` FOREIGN KEY (`community_id`) REFERENCES `communities` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_communities`
--

LOCK TABLES `users_communities` WRITE;
/*!40000 ALTER TABLE `users_communities` DISABLE KEYS */;
INSERT INTO `users_communities` VALUES (101,1,'1984-06-14 10:19:55'),(102,2,'1973-06-09 22:34:54'),(103,3,'1972-11-02 02:14:29'),(106,4,'1978-04-01 08:55:59'),(107,5,'1974-09-16 10:58:24'),(108,6,'1973-07-21 20:18:19'),(111,7,'2018-03-25 23:21:53'),(112,8,'2005-07-02 05:23:35'),(113,9,'1993-04-26 21:41:33'),(114,10,'1992-08-18 14:46:09'),(115,11,'1981-03-20 00:30:33'),(117,12,'1998-01-05 01:59:58'),(118,13,'1999-09-09 01:34:53'),(121,14,'2004-08-03 04:08:42'),(122,1,'1983-06-09 13:43:21'),(123,2,'2006-07-04 17:37:37'),(124,3,'2017-06-08 00:54:16'),(126,4,'2010-07-26 06:15:35'),(130,5,'1999-11-29 04:55:10'),(132,6,'1989-08-10 22:14:35');
/*!40000 ALTER TABLE `users_communities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'vk'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-29 19:48:15
