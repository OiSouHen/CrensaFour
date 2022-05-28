CREATE DATABASE IF NOT EXISTS `creative`;
USE `creative`;

DROP TABLE IF EXISTS `summerz_accounts`;
CREATE TABLE `summerz_accounts` (
  `whitelist` tinyint(1) NOT NULL DEFAULT 0,
  `chars` int(1) NOT NULL DEFAULT 1,
  `gems` int(11) NOT NULL DEFAULT 0,
  `premium` int(11) NOT NULL DEFAULT 0,
  `predays` int(11) NOT NULL DEFAULT 0,
  `priority` int(3) NOT NULL DEFAULT 0,
  `login` varchar(25) NOT NULL DEFAULT '00/00/0000',
  `discord` varchar(50) NOT NULL DEFAULT '0',
  `steam` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`steam`) USING BTREE,
  KEY `steam` (`steam`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `summerz_banneds`;
CREATE TABLE `summerz_banneds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `steam` varchar(100) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `days` int(3) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `summerz_characters`;
CREATE TABLE `summerz_characters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `steam` varchar(100) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `serial` varchar(6) DEFAULT NULL,
  `name` varchar(50) DEFAULT 'Individuo',
  `name2` varchar(50) DEFAULT 'Indigente',
  `blood` int(1) DEFAULT NULL,
  `locate` varchar(50) DEFAULT 'Sul',
  `bank` int(11) NOT NULL DEFAULT 1500,
  `fines` int(11) NOT NULL DEFAULT 0,
  `prison` int(11) NOT NULL DEFAULT 0,
  `criminal` int(1) NOT NULL DEFAULT 0,
  `port` int(1) NOT NULL DEFAULT 0,
  `deleted` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `summerz_chests`;
CREATE TABLE `summerz_chests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `weight` int(10) NOT NULL DEFAULT 0,
  `perm` varchar(100) NOT NULL,
  `logs` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;

INSERT INTO `summerz_chests` VALUES (1,'State',250,'Police',0),(2,'Lspd',250,'Police',0),(3,'Sheriff',250,'Police',0),(4,'Sheriff',250,'Police',0),(5,'Ranger',250,'Police',0),(6,'Corrections',250,'Police',0),(7,'Paramedic',250,'Paramedic',0),(8,'Paramedic',250,'Paramedic',0),(9,'Paramedic',250,'Paramedic',0),(10,'Mechanic',250,'Mechanic',0),(11,'Ballas',100,'Ballas',0),(12,'Vagos',100,'Vagos',0),(13,'Vanilla',100,'Vanilla',0),(14,'Triads',100,'Triads',0),(15,'Arcade',100,'Arcade',0),(16,'Desserts',100,'Desserts',0),(17,'Aztecas',100,'Aztecas',0),(18,'Families',100,'Families',0),(19,'EastSide',100,'EastSide',0),(20,'Bloods',100,'Bloods',0),(21,'TheLost',100,'TheLost',0),(22,'Vinhedo',100,'Vinhedo',0),(23,'Playboy',100,'Playboy',0),(24,'Salieris',100,'Salieris',0),(25,'PizzaThis',100,'PizzaThis',0),(26,'Crips',100,'Crips',0),(27,'Streets',100,'Streets',0),(28,'trayShot',25,'Admin',0),(29,'trayDesserts',25,'Admin',0),(30,'trayPops',25,'Admin',0),(31,'trayPizza',25,'Admin',0);

DROP TABLE IF EXISTS `summerz_entitydata`;
CREATE TABLE `summerz_entitydata` (
  `dkey` varchar(100) NOT NULL,
  `dvalue` text DEFAULT NULL,
  PRIMARY KEY (`dkey`),
  KEY `dkey` (`dkey`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `summerz_playerdata`;
CREATE TABLE `summerz_playerdata` (
  `user_id` int(11) NOT NULL,
  `dkey` varchar(100) NOT NULL,
  `dvalue` text DEFAULT NULL,
  PRIMARY KEY (`user_id`,`dkey`),
  KEY `user_id` (`user_id`),
  KEY `dkey` (`dkey`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `summerz_prison`;
CREATE TABLE `summerz_prison` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `police` varchar(255) DEFAULT '0',
  `nuser_id` int(11) NOT NULL DEFAULT 0,
  `services` int(11) NOT NULL DEFAULT 0,
  `fines` int(11) NOT NULL DEFAULT 0,
  `text` longtext DEFAULT NULL,
  `date` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `summerz_propertys`;
CREATE TABLE `summerz_propertys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL DEFAULT 'Homes0001',
  `interior` varchar(255) NOT NULL DEFAULT 'Middle',
  `tax` int(20) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `price` int(11) NOT NULL DEFAULT 0,
  `residents` int(11) NOT NULL DEFAULT 1,
  `vault` int(11) NOT NULL DEFAULT 1,
  `fridge` int(11) NOT NULL DEFAULT 1,
  `owner` int(1) NOT NULL DEFAULT 0,
  `contract` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `summerz_races`;
CREATE TABLE `summerz_races` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `raceid` int(11) NOT NULL DEFAULT 0,
  `user_id` int(9) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `vehicle` varchar(100) NOT NULL DEFAULT '0',
  `points` int(20) NOT NULL DEFAULT 0,
  `date` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `summerz_vehicles`;
CREATE TABLE `summerz_vehicles` (
  `user_id` int(11) NOT NULL,
  `vehicle` varchar(100) NOT NULL,
  `tax` int(20) NOT NULL DEFAULT 0,
  `plate` varchar(20) DEFAULT NULL,
  `rental` int(11) NOT NULL DEFAULT 0,
  `rendays` int(11) NOT NULL DEFAULT 0,
  `arrest` int(11) NOT NULL DEFAULT 0,
  `time` int(11) NOT NULL DEFAULT 0,
  `engine` int(11) NOT NULL DEFAULT 1000,
  `body` int(11) NOT NULL DEFAULT 1000,
  `fuel` int(11) NOT NULL DEFAULT 100,
  `nitro` int(11) NOT NULL DEFAULT 0,
  `work` varchar(10) NOT NULL DEFAULT 'false',
  `doors` varchar(254) NOT NULL,
  `windows` varchar(254) NOT NULL,
  `tyres` varchar(254) NOT NULL,
  PRIMARY KEY (`user_id`,`vehicle`),
  KEY `user_id` (`user_id`),
  KEY `vehicle` (`vehicle`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;