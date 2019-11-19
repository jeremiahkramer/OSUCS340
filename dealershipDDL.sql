-- MySQL dump 10.16  Distrib 10.1.41-MariaDB, for Linux (x86_64)
--
-- Host: classmysql.engr.oregonstate.edu    Database: cs340_peterkyl
-- ------------------------------------------------------
-- Server version	10.3.13-MariaDB-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `cs340_peterkyl`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `cs340_peterkyl` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `cs340_peterkyl`;

--
-- Table structure for table `dealership`
--

DROP TABLE IF EXISTS `dealership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dealership` (
  `dealership_id` int(11) NOT NULL AUTO_INCREMENT,
  `address_id` int(11) NOT NULL,
  `dealership_name` varchar(255) NOT NULL,
  `hours` varchar(20) NOT NULL,
  PRIMARY KEY (`dealership_id`),
  KEY `address_id` (`address_id`),
  CONSTRAINT `dealership_ibfk_1` FOREIGN KEY (`address_id`) REFERENCES `dealership_address` (`address_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dealership`
--

LOCK TABLES `dealership` WRITE;
/*!40000 ALTER TABLE `dealership` DISABLE KEYS */;
INSERT INTO `dealership` VALUES (1,1,'Sir Martins AutoMatic Autos','0800-1800'),(2,2,'A store','0000 2400'),(3,3,'We Sell You Trucks','1100am to 1300pm');
/*!40000 ALTER TABLE `dealership` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dealership_address`
--

DROP TABLE IF EXISTS `dealership_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dealership_address` (
  `address_id` int(11) NOT NULL AUTO_INCREMENT,
  `address_line_1` varchar(255) NOT NULL,
  `address_line_2` varchar(255) DEFAULT NULL,
  `city` varchar(50) NOT NULL,
  `zip` varchar(12) NOT NULL,
  `country` varchar(50) NOT NULL,
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dealership_address`
--

LOCK TABLES `dealership_address` WRITE;
/*!40000 ALTER TABLE `dealership_address` DISABLE KEYS */;
INSERT INTO `dealership_address` VALUES (1,'777 NW Ford Motors dr',NULL,'Corvallis','99999','United States of America'),(2,'29037 S Jackobs st','#B','Dallas','99977','Atlantis'),(3,'This is an address',NULL,'Some City','00000+1111','Mars');
/*!40000 ALTER TABLE `dealership_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employees` (
  `employee_id` int(11) NOT NULL AUTO_INCREMENT,
  `dealership_id` int(11) NOT NULL,
  `f_name` varchar(50) NOT NULL,
  `l_name` varchar(50) NOT NULL,
  `position` varchar(50) NOT NULL,
  PRIMARY KEY (`employee_id`),
  KEY `dealership_id` (`dealership_id`),
  CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`dealership_id`) REFERENCES `dealership` (`dealership_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,1,'Henry','Ford','Owner'),(2,1,'Julia','Roberts','Sales'),(3,1,'Katharine','Hepburn','Car Washing'),(4,2,'Jessica','Lange','Owner'),(5,2,'Meryl','Streep','Insurance'),(6,2,'Julia','Lange','Insurance'),(7,3,'Henry','Ford','Sales'),(8,3,'Elizabeth','Taylor','Sales'),(9,3,'Cate','Blanchett','Acting');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feature`
--

DROP TABLE IF EXISTS `feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `feature` (
  `feature_id` int(11) NOT NULL AUTO_INCREMENT,
  `feature_name` varchar(255) NOT NULL,
  `feature_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`feature_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feature`
--

LOCK TABLES `feature` WRITE;
/*!40000 ALTER TABLE `feature` DISABLE KEYS */;
INSERT INTO `feature` VALUES (1,'Towing Capacity','Maximum weight in pounds'),(2,'4wd','Powered 4-wheel drivetrain'),(3,'GPS','Global Position System using satellites'),(4,'Sunroof','Window in the roof'),(5,'is Gas','Runs on gasoline fuel'),(6,'is Diesel','Runs on diesel fuel'),(7,'is electric','Runs on eletricity'),(8,'drive range','Maximum range off a full charge in miles');
/*!40000 ALTER TABLE `feature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle`
--

DROP TABLE IF EXISTS `vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle` (
  `vehicle_id` int(11) NOT NULL AUTO_INCREMENT,
  `dealership_id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `vin` varchar(17) NOT NULL,
  PRIMARY KEY (`vehicle_id`),
  UNIQUE KEY `vin` (`vin`),
  KEY `dealership_id` (`dealership_id`),
  KEY `type` (`type`),
  CONSTRAINT `vehicle_ibfk_1` FOREIGN KEY (`dealership_id`) REFERENCES `dealership` (`dealership_id`),
  CONSTRAINT `vehicle_ibfk_2` FOREIGN KEY (`type`) REFERENCES `vehicle_type` (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle`
--

LOCK TABLES `vehicle` WRITE;
/*!40000 ALTER TABLE `vehicle` DISABLE KEYS */;
INSERT INTO `vehicle` VALUES (1,1,2,'9U9ZVBVZHE4715IGH'),(2,1,3,'F0Z2315X66N74GL01'),(3,1,3,'WW0475PR4YRFYO98F'),(4,2,1,'1DWGV8236CCHT4ZCC'),(5,2,7,'7NTZOLWM2RY3R0Y85'),(6,2,8,'36R5TYRTSMWW15WR1'),(7,3,6,'SMLZAHOIBMISARRKA'),(8,3,3,'JUA19TQI841E8JOJC'),(9,3,1,'FNBFQORXC1W90U2Z4');
/*!40000 ALTER TABLE `vehicle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle_feature`
--

DROP TABLE IF EXISTS `vehicle_feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle_feature` (
  `vehicle_id` int(11) NOT NULL,
  `feature_id` int(11) NOT NULL,
  `feature_value` varchar(255) DEFAULT NULL,
  UNIQUE KEY `unique_vehicle_feature` (`vehicle_id`,`feature_id`),
  KEY `feature_id` (`feature_id`),
  CONSTRAINT `vehicle_feature_ibfk_1` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`vehicle_id`) ON DELETE CASCADE,
  CONSTRAINT `vehicle_feature_ibfk_2` FOREIGN KEY (`feature_id`) REFERENCES `feature` (`feature_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle_feature`
--

LOCK TABLES `vehicle_feature` WRITE;
/*!40000 ALTER TABLE `vehicle_feature` DISABLE KEYS */;
INSERT INTO `vehicle_feature` VALUES (1,1,'10000'),(1,2,NULL),(1,4,NULL),(1,6,NULL),(2,7,NULL),(2,8,'400'),(3,2,NULL),(3,5,NULL),(3,7,NULL),(5,7,NULL),(5,8,NULL),(6,1,NULL),(6,2,NULL),(6,5,NULL),(7,5,NULL),(7,6,NULL),(8,6,NULL),(9,1,NULL),(9,4,NULL),(9,6,NULL);
/*!40000 ALTER TABLE `vehicle_feature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle_type`
--

DROP TABLE IF EXISTS `vehicle_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle_type` (
  `type_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(50) NOT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle_type`
--

LOCK TABLES `vehicle_type` WRITE;
/*!40000 ALTER TABLE `vehicle_type` DISABLE KEYS */;
INSERT INTO `vehicle_type` VALUES (1,'Car'),(2,'Truck'),(3,'SUV'),(4,'Sedan'),(5,'Sports'),(6,'Classic'),(7,'Non motorized'),(8,'Flying');
/*!40000 ALTER TABLE `vehicle_type` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-11-12  5:29:54
