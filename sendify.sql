-- MySQL dump 10.13  Distrib 8.0.28, for Linux (x86_64)
--
-- Host: localhost    Database: sendify
-- ------------------------------------------------------
-- Server version	8.0.28-0ubuntu0.20.04.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `sendify`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `sendify` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `sendify`;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sender_id` int DEFAULT NULL,
  `reciver_id` int DEFAULT NULL,
  `content` varchar(100) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '0',
  `date_` datetime DEFAULT CURRENT_TIMESTAMP,
  `file` varchar(30) DEFAULT ' ',
  PRIMARY KEY (`id`),
  KEY `sender_id` (`sender_id`),
  KEY `reciver_id` (`reciver_id`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`),
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`reciver_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,1,3,'hello',0,'2022-01-02 17:02:54',' '),(2,3,1,'hi',0,'2022-01-02 17:03:25',' '),(3,1,8,'slm1',0,'2022-01-02 17:15:13',' '),(4,1,8,'slm2',0,'2022-01-02 17:38:22',' '),(5,1,8,'slm3',0,'2022-01-02 17:38:35',' '),(6,1,8,'youu hooo1',0,'2022-01-04 22:26:44',' '),(7,1,8,'youu hooo2',0,'2022-01-04 22:27:16',' '),(8,1,11,'hi how are bro thas very good hhh',0,'2022-01-04 22:28:52',' '),(9,1,8,'hola1',0,'2022-01-10 02:16:26',' '),(10,8,1,'gogo',0,'2022-01-10 02:16:39',' '),(11,8,1,'hi bro how are you',0,'2022-01-10 02:16:54',' '),(12,8,1,'are steal living in the oranous ?',0,'2022-01-10 02:43:04',' '),(13,1,8,'good joke bre i think you steal redicules you have bad imagination dude',0,'2022-01-10 02:44:08',' '),(14,1,8,'',0,'2022-01-12 16:40:38',' '),(15,1,8,'noway',0,'2022-01-12 16:41:51',' '),(16,1,8,'you',0,'2022-01-12 16:44:47',' '),(17,1,8,'gh',0,'2022-01-12 16:48:20',' '),(18,1,8,'b',0,'2022-01-12 16:48:25',' '),(19,1,8,'hhhh',0,'2022-01-12 21:32:25',' '),(20,1,3,'good',0,'2022-01-19 21:22:33',' '),(21,1,10,'baraka 3lik',0,'2022-01-19 21:23:01',' '),(22,15,16,'😭',0,'2022-01-19 22:27:16',' '),(23,15,16,'😃',0,'2022-01-19 22:28:11',' '),(24,15,16,'😃',0,'2022-01-19 22:30:17',' '),(25,1,10,'😀',0,'2022-01-19 22:45:46',' '),(26,1,8,'😂😂',0,'2022-01-19 22:55:48',' '),(27,1,8,'😃😄😘🤩😘😗😜😜😗☺☺🤪😗☺😗🤪😘😗',0,'2022-01-19 23:04:00',' '),(28,1,8,'yes',0,'2022-01-19 23:07:31',' '),(29,1,8,'no',0,'2022-01-19 23:07:47',' '),(30,1,8,'yhj\nhjj\njj',0,'2022-01-19 23:09:26',' '),(31,1,8,'ghh\nhhhuiii😂😂😂😂',0,'2022-01-19 23:11:04',' '),(32,1,1,'hi',0,'2022-01-28 04:42:21',' '),(33,1,1,'holla',0,'2022-01-28 04:42:26',' '),(34,1,3,'than',0,'2022-01-28 04:42:46',' ');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `replay`
--

DROP TABLE IF EXISTS `replay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `replay` (
  `id` int NOT NULL AUTO_INCREMENT,
  `message_id` int DEFAULT NULL,
  `sender_id` int DEFAULT NULL,
  `reciver_id` int DEFAULT NULL,
  `content` varchar(100) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '0',
  `date_` datetime DEFAULT CURRENT_TIMESTAMP,
  `file` varchar(30) DEFAULT ' ',
  PRIMARY KEY (`id`),
  KEY `sender_id` (`sender_id`),
  KEY `reciver_id` (`reciver_id`),
  KEY `message_id` (`message_id`),
  CONSTRAINT `replay_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`),
  CONSTRAINT `replay_ibfk_2` FOREIGN KEY (`reciver_id`) REFERENCES `users` (`id`),
  CONSTRAINT `replay_ibfk_3` FOREIGN KEY (`message_id`) REFERENCES `messages` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `replay`
--

LOCK TABLES `replay` WRITE;
/*!40000 ALTER TABLE `replay` DISABLE KEYS */;
/*!40000 ALTER TABLE `replay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `date_` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `status_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1018 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status`
--

LOCK TABLES `status` WRITE;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
INSERT INTO `status` VALUES (454,3,'2022-01-19 20:54:06'),(566,4,'2022-01-19 22:12:43'),(571,8,'2022-01-19 22:15:25'),(1017,1,'2022-01-28 05:13:43');
/*!40000 ALTER TABLE `status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token`
--

DROP TABLE IF EXISTS `token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `token` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `token_` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `date_` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token_` (`token_`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `token_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=239 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token`
--

LOCK TABLES `token` WRITE;
/*!40000 ALTER TABLE `token` DISABLE KEYS */;
INSERT INTO `token` VALUES (5,8,'user:-b46gc1hojkxwazhlq','2022-01-01 21:54:28'),(9,4,'user:-b46gc1hojkxwb3v3m','2022-01-01 21:57:52'),(18,3,'user:-b46gc1jotkxwbmtpf','2022-01-01 22:12:37'),(110,16,'user:-b46gcfozky53bzve','2022-01-08 01:30:10'),(238,1,'user:-b46gchg5kyxvl7r1','2022-01-28 04:58:43');
/*!40000 ALTER TABLE `token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fname` varchar(25) NOT NULL,
  `lname` varchar(25) NOT NULL,
  `picture` varchar(100) DEFAULT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'amine','ben',NULL,'amineben24','123qwe'),(3,'mohamed','malik',NULL,'moh31','123asd'),(4,'karima','ben',NULL,'karima31','123qwe'),(8,'karima','ben',NULL,'karima32','123qwe'),(9,'salma','mahdi',NULL,'salma55','123qwe'),(10,'ibra','him',NULL,'ibramo','123qwe'),(11,'mahid','moh',NULL,'mahdi27','123qwe'),(12,'ikram','ikrama',NULL,'ika2200','asd123'),(13,'we','hh',NULL,'aminyhhj','qwe123'),(14,'we','hh',NULL,'aminee','qwe123'),(15,'we','hh',NULL,'amine27','qwe123'),(16,'fet','hi',NULL,'fethi44','123qwe');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-02-11 16:54:24
