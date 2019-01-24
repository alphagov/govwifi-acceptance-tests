/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP TABLE IF EXISTS `ip_locations`;

CREATE TABLE `ip_locations` (
  `ip` varchar(30) DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `sessions`;

CREATE TABLE `sessions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `start` timestamp NULL DEFAULT NULL,
  `stop` timestamp NULL DEFAULT NULL,
  `siteIP` char(15) DEFAULT NULL,
  `username` char(64) DEFAULT NULL,
  `cert_name` varchar(64) DEFAULT NULL,
  `mac` char(17) DEFAULT NULL,
  `ap` char(17) DEFAULT NULL,
  `building_identifier` varchar(20) DEFAULT NULL,
  `success` BOOLEAN DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `siteIP` (`siteIP`,`username`),
  KEY `sessions_username` (`username`),
  KEY `sessions_start_username` (`start`,`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `userdetails`;

CREATE TABLE `userdetails` (
  `username` varchar(10) NOT NULL DEFAULT '',
  `contact` varchar(100) DEFAULT NULL,
  `sponsor` varchar(100) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `notifications_opt_out` tinyint(1) NOT NULL DEFAULT '0',
  `survey_opt_out` tinyint(1) NOT NULL DEFAULT '0',
  `last_login` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`username`),
  KEY `userdetails_created_at` (`created_at`),
  KEY `userdetails_contact` (`contact`),
  KEY `userdetails_last_login` (`last_login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
