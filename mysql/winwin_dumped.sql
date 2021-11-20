-- MySQL dump 10.13  Distrib 8.0.25, for Win64 (x86_64)
--
-- Host: localhost    Database: winwin
-- ------------------------------------------------------
-- Server version	8.0.25

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
-- Table structure for table `cardinfo`
--

DROP TABLE IF EXISTS `cardinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cardinfo` (
  `card_number` char(16) NOT NULL,
  `customer_ID` char(8) NOT NULL,
  `card_holder_name` varchar(16) NOT NULL,
  `expire_date` char(4) NOT NULL,
  PRIMARY KEY (`card_number`),
  KEY `customer_ID` (`customer_ID`),
  CONSTRAINT `cardinfo_ibfk_1` FOREIGN KEY (`customer_ID`) REFERENCES `customer` (`user_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cardinfo`
--

LOCK TABLES `cardinfo` WRITE;
/*!40000 ALTER TABLE `cardinfo` DISABLE KEYS */;
INSERT INTO `cardinfo` VALUES ('1111222233334444','UID00004','Holder4','0622'),('1111222233334445','UID00004','Holder4','0822'),('1111222233334446','UID00007','Holder7','0622'),('1111222233334447','UID00001','Holder1','1023'),('1111222233334448','UID00006','Holder6','1221');
/*!40000 ALTER TABLE `cardinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `user_ID` char(8) NOT NULL,
  `default_payment` enum('cash','bank_transfer','credit_card') NOT NULL,
  PRIMARY KEY (`user_ID`),
  CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`user_ID`) REFERENCES `user` (`user_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES ('UID00001','cash'),('UID00004','credit_card'),('UID00006','bank_transfer'),('UID00007','credit_card');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customersubscription`
--

DROP TABLE IF EXISTS `customersubscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customersubscription` (
  `subscription_type` char(8) NOT NULL,
  `customer_ID` char(8) NOT NULL,
  `buy_date` datetime NOT NULL,
  `start_date` date DEFAULT (now()),
  `end_date` date NOT NULL,
  `trips_left` int unsigned NOT NULL,
  PRIMARY KEY (`subscription_type`,`customer_ID`,`buy_date`),
  KEY `customer_ID` (`customer_ID`),
  CONSTRAINT `customersubscription_ibfk_1` FOREIGN KEY (`subscription_type`) REFERENCES `subscriptioninfo` (`subscription_type`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `customersubscription_ibfk_2` FOREIGN KEY (`customer_ID`) REFERENCES `customer` (`user_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `customersubscription_chk_1` CHECK ((`end_date` >= `start_date`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customersubscription`
--

LOCK TABLES `customersubscription` WRITE;
/*!40000 ALTER TABLE `customersubscription` DISABLE KEYS */;
INSERT INTO `customersubscription` VALUES ('SUB00001','UID00004','2021-11-19 16:33:23','2021-11-19','2021-11-19',5),('SUB00001','UID00007','2021-11-19 16:33:23','2021-11-19','2021-11-19',5),('SUB00002','UID00006','2021-11-19 16:33:23','2021-11-19','2021-11-19',5);
/*!40000 ALTER TABLE `customersubscription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `location` (
  `location_ID` char(8) NOT NULL,
  PRIMARY KEY (`location_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` VALUES ('LC000001'),('LC000002'),('LC000003'),('LC000004'),('LC000005'),('LC000006'),('LC000007'),('LC000008');
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manager`
--

DROP TABLE IF EXISTS `manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manager` (
  `manager_ID` char(8) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `working_area` varchar(64) NOT NULL,
  `number_of_riders` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`manager_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manager`
--

LOCK TABLES `manager` WRITE;
/*!40000 ALTER TABLE `manager` DISABLE KEYS */;
INSERT INTO `manager` VALUES ('MN000001','First1','Last1','Area1',2),('MN000002','First2','Last2','Area2',1),('MN000003','First3','Last3','Area3',0);
/*!40000 ALTER TABLE `manager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ride`
--

DROP TABLE IF EXISTS `ride`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ride` (
  `ride_ID` char(8) NOT NULL,
  `customer_ID` char(8) DEFAULT NULL,
  `rider_ID` char(8) DEFAULT NULL,
  `status` enum('matching','matched','cancelled','in_transit','arrived','paid','reviewing','completed') NOT NULL,
  `start_latitude` float NOT NULL,
  `start_longitude` float NOT NULL,
  `stop_latitude` float NOT NULL,
  `stop_longitude` float NOT NULL,
  `distance` float NOT NULL,
  `start_time` datetime NOT NULL DEFAULT (now()),
  `stop_time` datetime DEFAULT NULL,
  `review_rating` smallint DEFAULT NULL,
  `review_comment` text,
  PRIMARY KEY (`ride_ID`),
  KEY `rider_ID` (`rider_ID`),
  KEY `customer_ID` (`customer_ID`),
  CONSTRAINT `ride_ibfk_1` FOREIGN KEY (`rider_ID`) REFERENCES `rider` (`user_ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `ride_ibfk_2` FOREIGN KEY (`customer_ID`) REFERENCES `customer` (`user_ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `ride_chk_1` CHECK ((`distance` >= 0)),
  CONSTRAINT `ride_chk_2` CHECK (((`review_rating` >= 1) and (`review_rating` <= 5))),
  CONSTRAINT `ride_chk_3` CHECK (((`start_latitude` >= -(90)) and (`start_latitude` <= 90))),
  CONSTRAINT `ride_chk_4` CHECK (((`start_longitude` >= -(180)) and (`start_longitude` <= 180))),
  CONSTRAINT `ride_chk_5` CHECK (((`stop_latitude` >= -(90)) and (`stop_latitude` <= 90))),
  CONSTRAINT `ride_chk_6` CHECK (((`stop_longitude` >= -(180)) and (`stop_longitude` <= 180)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ride`
--

LOCK TABLES `ride` WRITE;
/*!40000 ALTER TABLE `ride` DISABLE KEYS */;
INSERT INTO `ride` VALUES ('RDE00001','UID00007','UID00002','matching',45,45,45,45,1,'2021-11-19 16:33:23','2021-11-19 16:33:23',2,'comment'),('RDE00002','UID00004','UID00003','completed',45,45,45,45,1,'2021-11-19 16:33:23','2021-11-19 16:33:23',2,'comment'),('RDE00003','UID00006','UID00002','completed',45,45,45,45,1,'2021-11-19 16:33:23','2021-11-19 16:33:23',2,'comment'),('RDE00004','UID00007','UID00005','completed',45,45,45,45,1,'2021-11-19 16:33:23','2021-11-19 16:33:23',2,'comment');
/*!40000 ALTER TABLE `ride` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rider`
--

DROP TABLE IF EXISTS `rider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rider` (
  `user_ID` char(8) NOT NULL,
  `station_ID` char(8) NOT NULL,
  `ref_no` char(16) NOT NULL,
  `citizen_ID` char(13) NOT NULL,
  `is_available` tinyint(1) NOT NULL DEFAULT '1',
  `rating` float DEFAULT NULL,
  `cash_credit` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_ID`),
  UNIQUE KEY `ref_no` (`ref_no`),
  UNIQUE KEY `citizen_ID` (`citizen_ID`),
  KEY `station_ID` (`station_ID`),
  CONSTRAINT `rider_ibfk_1` FOREIGN KEY (`user_ID`) REFERENCES `user` (`user_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rider_ibfk_2` FOREIGN KEY (`station_ID`) REFERENCES `station` (`station_ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `rider_chk_1` CHECK (((`rating` >= 1) and (`rating` <= 5))),
  CONSTRAINT `rider_chk_2` CHECK ((`cash_credit` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rider`
--

LOCK TABLES `rider` WRITE;
/*!40000 ALTER TABLE `rider` DISABLE KEYS */;
INSERT INTO `rider` VALUES ('UID00002','ST000002','ab11111111111111','1234567891011',1,NULL,0),('UID00003','ST000001','ab11111111111112','1234567891012',0,1,100),('UID00005','ST000003','ab11111111111113','1234567891013',1,5,500);
/*!40000 ALTER TABLE `rider` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `updateNumberOfRiders` AFTER UPDATE ON `rider` FOR EACH ROW BEGIN
	IF NEW.station_ID != OLD.station_ID THEN
    BEGIN
		DECLARE new_station_manager char(8);
        DECLARE old_station_manager char(8);
        
        select manager_ID into new_station_manager
        from station
        where station_ID = NEW.station_ID;
        
        select manager_ID into old_station_manager
        from station
        where station_ID = OLD.station_ID;
    
		update station
        set number_of_riders = number_of_riders + 1
        where station_ID = NEW.station_ID;
        
        update station
        set number_of_riders = number_of_riders - 1
        where station_ID = OLD.station_ID;
        
        IF new_station_manager != old_station_manager THEN
        BEGIN
			update manager
			set number_of_riders = number_of_riders + 1
			where manager_ID = new_station_manager;
			
			update manager
			set number_of_riders = number_of_riders - 1
			where manager_ID = old_station_manager;
        END;
        END IF;
    END;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ridervehicle`
--

DROP TABLE IF EXISTS `ridervehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ridervehicle` (
  `vehicle_ID` char(8) NOT NULL,
  `rider_ID` char(8) NOT NULL,
  `plate_number` varchar(16) NOT NULL,
  PRIMARY KEY (`vehicle_ID`),
  UNIQUE KEY `plate_number` (`plate_number`),
  KEY `rider_ID` (`rider_ID`),
  CONSTRAINT `ridervehicle_ibfk_1` FOREIGN KEY (`rider_ID`) REFERENCES `rider` (`user_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ridervehicle_ibfk_2` FOREIGN KEY (`plate_number`) REFERENCES `vehicle` (`plate_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ridervehicle`
--

LOCK TABLES `ridervehicle` WRITE;
/*!40000 ALTER TABLE `ridervehicle` DISABLE KEYS */;
INSERT INTO `ridervehicle` VALUES ('VEH00001','UID00002','123456789abcdefg'),('VEH00002','UID00003','123456784abcdefg'),('VEH00003','UID00005','123456780abcdefg');
/*!40000 ALTER TABLE `ridervehicle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ridetransaction`
--

DROP TABLE IF EXISTS `ridetransaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ridetransaction` (
  `transaction_ID` char(8) NOT NULL,
  `ride_ID` char(8) NOT NULL,
  PRIMARY KEY (`transaction_ID`),
  KEY `ride_ID` (`ride_ID`),
  CONSTRAINT `ridetransaction_ibfk_1` FOREIGN KEY (`transaction_ID`) REFERENCES `transactionrecord` (`transaction_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ridetransaction_ibfk_2` FOREIGN KEY (`ride_ID`) REFERENCES `ride` (`ride_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ridetransaction`
--

LOCK TABLES `ridetransaction` WRITE;
/*!40000 ALTER TABLE `ridetransaction` DISABLE KEYS */;
INSERT INTO `ridetransaction` VALUES ('TRN00007','RDE00001'),('TRN00008','RDE00002'),('TRN00009','RDE00003'),('TRN00010','RDE00004');
/*!40000 ALTER TABLE `ridetransaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `savedaddress`
--

DROP TABLE IF EXISTS `savedaddress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `savedaddress` (
  `customer_ID` char(8) NOT NULL,
  `location_ID` char(8) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`customer_ID`,`location_ID`),
  KEY `location_ID` (`location_ID`),
  CONSTRAINT `savedaddress_ibfk_1` FOREIGN KEY (`customer_ID`) REFERENCES `customer` (`user_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `savedaddress_ibfk_2` FOREIGN KEY (`location_ID`) REFERENCES `location` (`location_ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `savedaddress`
--

LOCK TABLES `savedaddress` WRITE;
/*!40000 ALTER TABLE `savedaddress` DISABLE KEYS */;
INSERT INTO `savedaddress` VALUES ('UID00001','LC000006','address1'),('UID00001','LC000007','address2'),('UID00001','LC000008','address3'),('UID00004','LC000006','address1'),('UID00004','LC000008','address2'),('UID00006','LC000008','address3'),('UID00007','LC000007','address4');
/*!40000 ALTER TABLE `savedaddress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `station`
--

DROP TABLE IF EXISTS `station`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `station` (
  `station_ID` char(8) NOT NULL,
  `location_ID` char(8) NOT NULL,
  `manager_ID` char(8) NOT NULL,
  `name` varchar(50) NOT NULL,
  `number_of_riders` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`station_ID`),
  UNIQUE KEY `location_ID` (`location_ID`),
  UNIQUE KEY `name` (`name`),
  KEY `manager_ID` (`manager_ID`),
  CONSTRAINT `station_ibfk_1` FOREIGN KEY (`location_ID`) REFERENCES `location` (`location_ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `station_ibfk_2` FOREIGN KEY (`manager_ID`) REFERENCES `manager` (`manager_ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `station`
--

LOCK TABLES `station` WRITE;
/*!40000 ALTER TABLE `station` DISABLE KEYS */;
INSERT INTO `station` VALUES ('ST000001','LC000001','MN000001','Station1',1),('ST000002','LC000002','MN000001','Station2',1),('ST000003','LC000003','MN000002','Station3',1),('ST000004','LC000004','MN000003','Station4',0),('ST000005','LC000005','MN000003','Station5',0);
/*!40000 ALTER TABLE `station` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscriptioninfo`
--

DROP TABLE IF EXISTS `subscriptioninfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscriptioninfo` (
  `subscription_type` char(8) NOT NULL,
  `name` varchar(30) NOT NULL,
  `price` float NOT NULL,
  `trips` int unsigned NOT NULL,
  `duration` int unsigned NOT NULL,
  PRIMARY KEY (`subscription_type`),
  CONSTRAINT `subscriptioninfo_chk_1` CHECK ((`price` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriptioninfo`
--

LOCK TABLES `subscriptioninfo` WRITE;
/*!40000 ALTER TABLE `subscriptioninfo` DISABLE KEYS */;
INSERT INTO `subscriptioninfo` VALUES ('SUB00001','SubA',200,10,10),('SUB00002','SubB',300,20,20),('SUB00003','SubC',400,30,30);
/*!40000 ALTER TABLE `subscriptioninfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscriptiontransaction`
--

DROP TABLE IF EXISTS `subscriptiontransaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscriptiontransaction` (
  `transaction_ID` char(8) NOT NULL,
  `customer_ID` char(8) NOT NULL,
  PRIMARY KEY (`transaction_ID`),
  KEY `customer_ID` (`customer_ID`),
  CONSTRAINT `subscriptiontransaction_ibfk_1` FOREIGN KEY (`transaction_ID`) REFERENCES `transactionrecord` (`transaction_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `subscriptiontransaction_ibfk_2` FOREIGN KEY (`customer_ID`) REFERENCES `customer` (`user_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriptiontransaction`
--

LOCK TABLES `subscriptiontransaction` WRITE;
/*!40000 ALTER TABLE `subscriptiontransaction` DISABLE KEYS */;
INSERT INTO `subscriptiontransaction` VALUES ('TRN00005','UID00004'),('TRN00006','UID00006'),('TRN00004','UID00007');
/*!40000 ALTER TABLE `subscriptiontransaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topuptransaction`
--

DROP TABLE IF EXISTS `topuptransaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `topuptransaction` (
  `transaction_ID` char(8) NOT NULL,
  `rider_ID` char(8) NOT NULL,
  PRIMARY KEY (`transaction_ID`),
  KEY `rider_ID` (`rider_ID`),
  CONSTRAINT `topuptransaction_ibfk_1` FOREIGN KEY (`transaction_ID`) REFERENCES `transactionrecord` (`transaction_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `topuptransaction_ibfk_2` FOREIGN KEY (`rider_ID`) REFERENCES `rider` (`user_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topuptransaction`
--

LOCK TABLES `topuptransaction` WRITE;
/*!40000 ALTER TABLE `topuptransaction` DISABLE KEYS */;
INSERT INTO `topuptransaction` VALUES ('TRN00001','UID00002'),('TRN00002','UID00003'),('TRN00003','UID00005');
/*!40000 ALTER TABLE `topuptransaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactionrecord`
--

DROP TABLE IF EXISTS `transactionrecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactionrecord` (
  `transaction_ID` char(8) NOT NULL,
  `type` enum('top-up','subscription','ride') NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT (now()),
  `status` enum('pending','success','declined') NOT NULL,
  `amount` float NOT NULL DEFAULT '0',
  `payment_method` enum('cash','bank_transfer','credit_card') NOT NULL,
  PRIMARY KEY (`transaction_ID`),
  CONSTRAINT `transactionrecord_chk_1` CHECK ((`amount` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactionrecord`
--

LOCK TABLES `transactionrecord` WRITE;
/*!40000 ALTER TABLE `transactionrecord` DISABLE KEYS */;
INSERT INTO `transactionrecord` VALUES ('TRN00001','top-up','2021-11-19 09:33:23','pending',100,'cash'),('TRN00002','top-up','2021-11-19 09:33:23','success',100,'bank_transfer'),('TRN00003','top-up','2021-11-19 09:33:23','success',100,'credit_card'),('TRN00004','subscription','2021-11-19 09:33:23','pending',100,'cash'),('TRN00005','subscription','2021-11-19 09:33:23','success',100,'bank_transfer'),('TRN00006','subscription','2021-11-19 09:33:23','pending',100,'credit_card'),('TRN00007','ride','2021-11-19 09:33:23','pending',100,'cash'),('TRN00008','ride','2021-11-19 09:33:23','pending',100,'bank_transfer'),('TRN00009','ride','2021-11-19 09:33:23','success',100,'credit_card'),('TRN00010','ride','2021-11-19 09:33:23','success',100,'credit_card');
/*!40000 ALTER TABLE `transactionrecord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `triggertime`
--

DROP TABLE IF EXISTS `triggertime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `triggertime` (
  `time` datetime NOT NULL,
  `userID` char(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `triggertime`
--

LOCK TABLES `triggertime` WRITE;
/*!40000 ALTER TABLE `triggertime` DISABLE KEYS */;
/*!40000 ALTER TABLE `triggertime` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_ID` char(8) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` text NOT NULL,
  `email` varchar(100) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `phone_num` char(10) NOT NULL,
  `user_type` enum('customer','rider') NOT NULL,
  PRIMARY KEY (`user_ID`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('UID00001','username1','password1','email1@gmail.com','CustomerFirst1','CustomerLast1','0800000001','customer'),('UID00002','username2','password2','email2@gmail.com','RiderFirst2','RiderLast2','0800000002','rider'),('UID00003','username3','password3','email3@gmail.com','RiderFirst3','RiderLast3','0800000003','rider'),('UID00004','username4','password4','email4@gmail.com','CustomerFirst4','CustomerLast4','0800000004','customer'),('UID00005','username5','password5','email5@gmail.com','RiderFirst5','RiderLast5','0800000005','rider'),('UID00006','username6','password6','email6@gmail.com','CustomerFirst6','CustomerLast6','0800000006','customer'),('UID00007','username7','password7','email7@gmail.com','CustomerFirst7','CustomerLast7','0800000007','customer');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `deleteAccountLog` AFTER DELETE ON `user` FOR EACH ROW INSERT INTO TriggerTime VALUES (NOW() , OLD.user_ID) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `vehicle`
--

DROP TABLE IF EXISTS `vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicle` (
  `plate_number` varchar(16) NOT NULL,
  `model` varchar(50) NOT NULL,
  `color` varchar(16) NOT NULL,
  PRIMARY KEY (`plate_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle`
--

LOCK TABLES `vehicle` WRITE;
/*!40000 ALTER TABLE `vehicle` DISABLE KEYS */;
INSERT INTO `vehicle` VALUES ('123456780abcdefg','ABC3','red'),('123456784abcdefg','ABC2','red'),('123456789abcdefg','ABC','red');
/*!40000 ALTER TABLE `vehicle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'winwin'
--
/*!50003 DROP FUNCTION IF EXISTS `calcPrice` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `calcPrice`(dist float) RETURNS int
    DETERMINISTIC
BEGIN
	DECLARE price INT;
	DECLARE remDist float;
	IF dist > 5 THEN
	BEGIN
		set remDist = dist - 5;
		IF MOD(remDist,1) < 0.5 THEN
			set remDist = remDist - MOD(remDist,1);
		ELSE
			set remDist = remDist - MOD(remDist,1) + 1;
		END IF;
		set price = (48 + remDist*12);
	END;
	ELSEIF (dist <= 5 AND dist > 2.5) THEN
	BEGIN
		set remDist = dist - 2.5;
		IF MOD(remDist,1) < 0.5 THEN
			set remDist = remDist - MOD(remDist,1);
		ELSE
			set remDist = remDist - MOD(remDist,1) + 1;
		END IF;
		set price = (30 + remDist*6);
	END;
	ELSEIF (dist <= 2.5 AND dist > 0) THEN
		set price = 30;
	END IF;
	RETURN (price);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `calcRideT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `calcRideT`(startT datetime, stopT datetime) RETURNS time
    DETERMINISTIC
BEGIN
	DECLARE totalT INT;
	set totalT = abs(timediff(stopT, startT));
	RETURN (totalT);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `addBooking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addBooking`(
	IN ride_ID char(8), 
    IN customer_ID char(8), 
    IN rider_ID char(8), 
	IN start_latitude float, 
    IN start_longitude float, 
    IN stop_latitude float, 
    IN stop_longitude float, 
    IN distance float, 
    IN start_time datetime,
	IN transaction_ID char(8), 
    IN payment_method enum('cash','bank_transfer','credit_card')
)
BEGIN
	-- error handler
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		Resignal;
	END;

	SET autocommit = 1;
	START TRANSACTION;
	INSERT INTO ride(ride_ID,customer_ID,rider_ID,status,start_latitude,start_longitude,stop_latitude,stop_longitude,distance,start_time) VALUES
    (ride_ID,customer_ID,rider_ID,'matching',start_latitude,start_longitude,stop_latitude,stop_longitude,distance,start_time);
    
    INSERT INTO transactionrecord(transaction_ID,type,status,amount,payment_method) VALUES
    (transaction_ID,'ride','pending',calcPrice(distance),payment_method);
    
    INSERT INTO ridetransaction VALUES
    (transaction_ID,ride_ID);
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetRiderFromStation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetRiderFromStation`(IN stationName varchar(50))
BEGIN 
	SELECT u.first_name, u.last_name, u.phone_num, R.ref_no, R.citizen_ID, R.is_available, R.rating 
	FROM  rider R natural join station S natural join user U
	WHERE S.name = stationName;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateRiderStation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateRiderStation`(
 	IN i_user_ID CHAR(8),
 	IN i_station_ID CHAR(8)
 )
BEGIN
	DECLARE exit handler for sqlexception
	Begin
		Rollback;
		Resignal;
	End;

	start transaction;

	update Rider 
    set station_ID=i_station_ID 
    where user_ID = i_user_ID;

	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-20  0:02:37
