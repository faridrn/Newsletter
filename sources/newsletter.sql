/*
Navicat MySQL Data Transfer

Source Server         : Localhost
Source Server Version : 50626
Source Host           : localhost:3306
Source Database       : newsletter

Target Server Type    : MYSQL
Target Server Version : 50626
File Encoding         : 65001

Date: 2015-10-17 01:25:29
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for emails
-- ----------------------------
DROP TABLE IF EXISTS `emails`;
CREATE TABLE `emails` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `email` varchar(1000) NOT NULL,
  `enabled` tinyint(3) NOT NULL DEFAULT '1',
  `subscribed` tinyint(3) NOT NULL DEFAULT '1',
  `type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `emails_types` (`type_id`),
  CONSTRAINT `emails_types` FOREIGN KEY (`type_id`) REFERENCES `types` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of emails
-- ----------------------------
INSERT INTO `emails` VALUES ('1', 'faridv@gmail.com', '1', '1', '1');
INSERT INTO `emails` VALUES ('2', 'farid4fr@hotmail.com', '1', '1', '1');
INSERT INTO `emails` VALUES ('3', 'farid_vazagh@yahoo.com', '1', '1', '1');

-- ----------------------------
-- Table structure for logs
-- ----------------------------
DROP TABLE IF EXISTS `logs`;
CREATE TABLE `logs` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `status` int(7) NOT NULL,
  `email_id` int(32) NOT NULL,
  `newsletter_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `logs_newsletters` (`newsletter_id`),
  KEY `logs_users` (`user_id`),
  KEY `logs_emails` (`email_id`),
  CONSTRAINT `logs_emails` FOREIGN KEY (`email_id`) REFERENCES `emails` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `logs_newsletters` FOREIGN KEY (`newsletter_id`) REFERENCES `newsletters` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `logs_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of logs
-- ----------------------------

-- ----------------------------
-- Table structure for newsletters
-- ----------------------------
DROP TABLE IF EXISTS `newsletters`;
CREATE TABLE `newsletters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `url` varchar(1500) DEFAULT NULL,
  `html` text,
  `user_id` int(11) NOT NULL,
  `type_id` int(7) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `user` FOREIGN KEY (`id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of newsletters
-- ----------------------------

-- ----------------------------
-- Table structure for types
-- ----------------------------
DROP TABLE IF EXISTS `types`;
CREATE TABLE `types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `alias` varchar(255) DEFAULT NULL,
  `url` varchar(2000) NOT NULL DEFAULT '',
  `params` text COMMENT '"{}"',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of types
-- ----------------------------
INSERT INTO `types` VALUES ('1', 'PressTV', 'press', 'http://presstv.com/Callback/Newsletter?ids={0},{1},{2},{3},{4}', '\"{}\"');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(7) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `active` tinyint(5) NOT NULL,
  `type_id` int(11) NOT NULL,
  `params` varchar(2000) DEFAULT '{}',
  PRIMARY KEY (`id`),
  KEY `users_types` (`type_id`),
  CONSTRAINT `users_types` FOREIGN KEY (`type_id`) REFERENCES `types` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('1', 'farid', 'farid', 'pass', 'faridv@gmail.com', '1', '1', '{}');
INSERT INTO `users` VALUES ('2', 'test', 'havij', 'testpass', 'faridr.ir@gmail.com', '1', '1', '{}');

-- ----------------------------
-- Procedure structure for getEmails
-- ----------------------------
DROP PROCEDURE IF EXISTS `getEmails`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getEmails`()
BEGIN
	select * from emails;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for getEmailsById
-- ----------------------------
DROP PROCEDURE IF EXISTS `getEmailsById`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getEmailsById`(email_id INT(0))
BEGIN
	select * from emails where id = email_id;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for getTypes
-- ----------------------------
DROP PROCEDURE IF EXISTS `getTypes`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getTypes`()
BEGIN
	select * from types;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for getTypesByAlias
-- ----------------------------
DROP PROCEDURE IF EXISTS `getTypesByAlias`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getTypesByAlias`(type_alias VARCHAR(255))
BEGIN
	select * from types where alias = type_alias;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for getUsers
-- ----------------------------
DROP PROCEDURE IF EXISTS `getUsers`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUsers`()
BEGIN
	select * from users;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for getUsersById
-- ----------------------------
DROP PROCEDURE IF EXISTS `getUsersById`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUsersById`(
	user_id INT(0)
)
BEGIN
	select * from users where id = user_id;
END
;;
DELIMITER ;
