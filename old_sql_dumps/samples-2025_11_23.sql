-- MySQL dump 10.13  Distrib 8.0.44, for Linux (x86_64)
--
-- Host: localhost    Database: samples
-- ------------------------------------------------------
-- Server version	8.0.44-0ubuntu0.24.04.1

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
-- Table structure for table `artist`
--

DROP TABLE IF EXISTS `artist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artist` (
  `artist_id` int NOT NULL AUTO_INCREMENT,
  `name` text,
  `nationality` text,
  `genre` text,
  PRIMARY KEY (`artist_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artist`
--

LOCK TABLES `artist` WRITE;
/*!40000 ALTER TABLE `artist` DISABLE KEYS */;
INSERT INTO `artist` VALUES (1,'revenxnt','American','breakcore'),(2,'Shygirl','British','club'),(3,'Cosha','Irish',NULL),(4,'Club Shy',NULL,NULL),(5,'SG Lewis','British','dance'),(6,'Ian Asher','American','dance'),(7,'Phantogram','American','electronic rock'),(8,'Kenny Barron Trio','American','jazz'),(9,'biko','American','dance'),(20,'test artist','for m2m CRUD','test genre'),(21,'test artist 2','m2m crud test 2','HELLO'),(22,'test artist 3','artist 3','3');
/*!40000 ALTER TABLE `artist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artist_song`
--

DROP TABLE IF EXISTS `artist_song`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artist_song` (
  `artist_id` int NOT NULL,
  `song_id` int NOT NULL,
  PRIMARY KEY (`artist_id`,`song_id`),
  KEY `song_id` (`song_id`),
  CONSTRAINT `artist_song_ibfk_1` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`artist_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `artist_song_ibfk_2` FOREIGN KEY (`song_id`) REFERENCES `song` (`song_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artist_song`
--

LOCK TABLES `artist_song` WRITE;
/*!40000 ALTER TABLE `artist_song` DISABLE KEYS */;
INSERT INTO `artist_song` VALUES (2,1),(3,1),(4,1),(5,2),(1,3),(1,4),(6,5),(7,5),(8,6),(1,7),(9,7),(2,12),(5,12),(1,16),(9,16),(21,18);
/*!40000 ALTER TABLE `artist_song` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mySong`
--

DROP TABLE IF EXISTS `mySong`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mySong` (
  `song_id` int NOT NULL,
  `finished` tinyint(1) NOT NULL,
  PRIMARY KEY (`song_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mySong`
--

LOCK TABLES `mySong` WRITE;
/*!40000 ALTER TABLE `mySong` DISABLE KEYS */;
INSERT INTO `mySong` VALUES (3,1),(4,1),(7,1);
/*!40000 ALTER TABLE `mySong` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `release`
--

DROP TABLE IF EXISTS `release`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `release` (
  `type` text NOT NULL,
  `releaseDate` date NOT NULL,
  `numSongs` int DEFAULT NULL,
  `title` varchar(100) NOT NULL,
  `UPC` varchar(15) NOT NULL,
  PRIMARY KEY (`UPC`),
  UNIQUE KEY `UPC` (`UPC`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `release`
--

LOCK TABLES `release` WRITE;
/*!40000 ALTER TABLE `release` DISABLE KEYS */;
INSERT INTO `release` VALUES ('album','2025-09-05',10,'Anemoia','00602478202438'),('single','2025-07-11',2,'Sugar (feat. Shygirl)','00602478202544'),('single','2025-08-15',1,'Black Out Days (Stay Away)','00602478924026'),('single','2024-10-04',1,'eternal','055855825308'),('tType','2099-01-01',99,'tTitle','12345678910'),('single','2025-10-10',1,'Cyanica','199740065803'),('album','2009-08-19',10,'Minor Blues','4538182548462'),('EP','2024-02-09',6,'Club Shy','5056556135012');
/*!40000 ALTER TABLE `release` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `release_song`
--

DROP TABLE IF EXISTS `release_song`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `release_song` (
  `UPC` varchar(15) NOT NULL,
  `ISRC` char(12) NOT NULL,
  `song_id` int NOT NULL,
  PRIMARY KEY (`UPC`,`ISRC`),
  KEY `ISRC` (`ISRC`),
  KEY `song_id` (`song_id`),
  CONSTRAINT `release_song_ibfk_1` FOREIGN KEY (`ISRC`) REFERENCES `song` (`ISRC`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `release_song_ibfk_2` FOREIGN KEY (`song_id`) REFERENCES `song` (`song_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `release_song_ibfk_3` FOREIGN KEY (`UPC`) REFERENCES `release` (`UPC`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `release_song`
--

LOCK TABLES `release_song` WRITE;
/*!40000 ALTER TABLE `release_song` DISABLE KEYS */;
INSERT INTO `release_song` VALUES ('5056556135012','GBMVH2300650',1),('00602478202438','GBUM72503544',2),('00602478202544','GBUM72503544',2),('055855825308','CALVP2475952',3),('00602478924026','USUM72509197',5),('4538182548462','JPI291065403',6),('199740065803','QT3F32561928',7),('00602478202438','GBUM72503569',12);
/*!40000 ALTER TABLE `release_song` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `repo`
--

DROP TABLE IF EXISTS `repo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `repo` (
  `source_id` int NOT NULL,
  `custodian` text,
  `type` text,
  `price` decimal(8,2) DEFAULT NULL,
  `billed` text,
  `name` text,
  PRIMARY KEY (`source_id`),
  CONSTRAINT `repo_ibfk_1` FOREIGN KEY (`source_id`) REFERENCES `sampleSource` (`source_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `repo`
--

LOCK TABLES `repo` WRITE;
/*!40000 ALTER TABLE `repo` DISABLE KEYS */;
INSERT INTO `repo` VALUES (4,'Splice',NULL,12.99,'monthly','Splice Sounds'),(6,'NastyNasty','pack',0.00,NULL,'Breakcore is not a good way to get laid');
/*!40000 ALTER TABLE `repo` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`kai`@`10.0.0.%`*/ /*!50003 TRIGGER `repo_source_id_before_in` BEFORE INSERT ON `repo` FOR EACH ROW begin
        insert into sampleSource values ();
        set NEW.source_id = last_insert_id();
    end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `sample`
--

DROP TABLE IF EXISTS `sample`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sample` (
  `sample_id` int NOT NULL AUTO_INCREMENT,
  `instrument` text,
  `genre` text,
  `source_id` int DEFAULT NULL,
  PRIMARY KEY (`sample_id`),
  KEY `sample_ibfk_1` (`source_id`),
  CONSTRAINT `sample_ibfk_1` FOREIGN KEY (`source_id`) REFERENCES `sampleSource` (`source_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sample`
--

LOCK TABLES `sample` WRITE;
/*!40000 ALTER TABLE `sample` DISABLE KEYS */;
INSERT INTO `sample` VALUES (1,'vocal','dance',1),(2,'synth','pop',2),(3,'drum loop','dance',3),(4,'piano','jazz',7),(6,'drum loop','breakcore',6);
/*!40000 ALTER TABLE `sample` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sampleSong`
--

DROP TABLE IF EXISTS `sampleSong`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sampleSong` (
  `ISRC` char(12) NOT NULL,
  `song_id` int NOT NULL,
  `source_id` int NOT NULL,
  PRIMARY KEY (`song_id`),
  KEY `ISRC` (`ISRC`),
  KEY `source_id` (`source_id`),
  CONSTRAINT `sampleSong_ibfk_1` FOREIGN KEY (`song_id`) REFERENCES `song` (`song_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sampleSong_ibfk_2` FOREIGN KEY (`ISRC`) REFERENCES `song` (`ISRC`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sampleSong_ibfk_3` FOREIGN KEY (`source_id`) REFERENCES `sampleSource` (`source_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sampleSong`
--

LOCK TABLES `sampleSong` WRITE;
/*!40000 ALTER TABLE `sampleSong` DISABLE KEYS */;
INSERT INTO `sampleSong` VALUES ('GBMVH2300650',1,1),('GBUM72503544',2,2),('USUM72509197',5,3),('JPI291065403',6,7);
/*!40000 ALTER TABLE `sampleSong` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`kai`@`10.0.0.%`*/ /*!50003 TRIGGER `sampleSong_source_id_before_in` BEFORE INSERT ON `sampleSong` FOR EACH ROW begin
        insert into sampleSource values ();
        set NEW.source_id = last_insert_id();
    end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `sampleSource`
--

DROP TABLE IF EXISTS `sampleSource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sampleSource` (
  `source_id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`source_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sampleSource`
--

LOCK TABLES `sampleSource` WRITE;
/*!40000 ALTER TABLE `sampleSource` DISABLE KEYS */;
INSERT INTO `sampleSource` VALUES (1),(2),(3),(4),(6),(7);
/*!40000 ALTER TABLE `sampleSource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sample_on_song`
--

DROP TABLE IF EXISTS `sample_on_song`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sample_on_song` (
  `sample_id` int NOT NULL,
  `song_id` int NOT NULL,
  PRIMARY KEY (`sample_id`,`song_id`),
  KEY `song_id` (`song_id`),
  CONSTRAINT `sample_on_song_ibfk_1` FOREIGN KEY (`sample_id`) REFERENCES `sample` (`sample_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sample_on_song_ibfk_2` FOREIGN KEY (`song_id`) REFERENCES `song` (`song_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sample_on_song`
--

LOCK TABLES `sample_on_song` WRITE;
/*!40000 ALTER TABLE `sample_on_song` DISABLE KEYS */;
INSERT INTO `sample_on_song` VALUES (2,3),(1,4),(3,4);
/*!40000 ALTER TABLE `sample_on_song` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `song`
--

DROP TABLE IF EXISTS `song`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `song` (
  `song_id` int NOT NULL AUTO_INCREMENT,
  `genre` text,
  `title` varchar(100) NOT NULL,
  `key` varchar(3) DEFAULT NULL,
  `ISRC` char(12) DEFAULT NULL,
  `bpm` smallint DEFAULT NULL,
  PRIMARY KEY (`song_id`),
  UNIQUE KEY `ISRC` (`ISRC`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `song`
--

LOCK TABLES `song` WRITE;
/*!40000 ALTER TABLE `song` DISABLE KEYS */;
INSERT INTO `song` VALUES (1,'dance','thicc','CM','GBMVH2300650',130),(2,'pop','Sugar','DbM','GBUM72503544',130),(3,'breakcore','eternal','GM','CALVP2475952',160),(4,'breakcore','10o3//dusk',NULL,'CALVP2413177',170),(5,'dance','Black Out Days (Stay Away)','Gbm','USUM72509197',155),(6,'jazz','Emily','CM','JPI291065403',115),(7,'dance','Cyanica','Am','QT3F32561928',123),(12,'pop','Baby Blue','C#M','GBUM72503569',125),(16,'Techno','Fortune Lies','Am','',130),(18,'test genre','test song for m2m CRUD','CM','123456789',100);
/*!40000 ALTER TABLE `song` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-24  0:33:03
