/*
Navicat MySQL Data Transfer

Source Server         : Localhost
Source Server Version : 50626
Source Host           : localhost:3306
Source Database       : newsletter

Target Server Type    : MYSQL
Target Server Version : 50626
File Encoding         : 65001

Date: 2015-10-20 22:01:28
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of logs
-- ----------------------------
INSERT INTO `logs` VALUES ('1', '2015-10-20 16:37:29', '1', '1', '1', '1');
INSERT INTO `logs` VALUES ('2', '2015-10-20 16:38:52', '2', '2', '1', '1');
INSERT INTO `logs` VALUES ('3', '2015-10-20 16:39:13', '1', '3', '1', '1');
INSERT INTO `logs` VALUES ('4', '2015-10-20 16:39:38', '2', '1', '1', '1');
INSERT INTO `logs` VALUES ('5', '2015-10-20 16:39:50', '2', '2', '1', '1');
INSERT INTO `logs` VALUES ('6', '2015-10-20 16:40:01', '1', '3', '1', '1');
INSERT INTO `logs` VALUES ('7', '2015-10-20 16:40:16', '1', '1', '1', '1');
INSERT INTO `logs` VALUES ('8', '2015-10-20 16:40:36', '1', '2', '1', '1');
INSERT INTO `logs` VALUES ('9', '2015-10-20 16:40:40', '0', '3', '1', '1');

-- ----------------------------
-- Table structure for newsletters
-- ----------------------------
DROP TABLE IF EXISTS `newsletters`;
CREATE TABLE `newsletters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `url` varchar(1500) DEFAULT NULL,
  `html` text,
  `user_id` int(11) NOT NULL,
  `type_id` int(7) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `user` FOREIGN KEY (`id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of newsletters
-- ----------------------------
INSERT INTO `newsletters` VALUES ('1', 'Item Title', '2015-10-19 12:55:11', 'http://presstv.com/Callback/Newsletter?ids=432759,432754,432731,432730,432743', '<html>Hi</html>', '1', '1');
INSERT INTO `newsletters` VALUES ('2', 'Test Newsletter', '2015-10-12 12:55:35', 'http://presstv.com/Callback/Newsletter?ids=432759,432754,432731,432730,432743', '<some><html></html></some>', '2', '1');

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of types
-- ----------------------------
INSERT INTO `types` VALUES ('1', 'PressTV', 'press', 'http://presstv.com/Callback/Newsletter?ids={0},{1},{2},{3},{4}', '\"{}\"');
INSERT INTO `types` VALUES ('2', 'HispanTV', 'hispan', 'http://presstv.com/Callback/Newsletter?ids={0},{1},{2},{3},{4}', '\"{}\"');

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
  `params` varchar(2000) DEFAULT '{}',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('1', 'Farid Rn', 'farid', 'pass', 'faridv@gmail.com', '1', '{}');
INSERT INTO `users` VALUES ('2', 'Name', 'havij', 'testpass', 'faridr.ir@gmail.com', '1', '{}');

-- ----------------------------
-- Table structure for users_types
-- ----------------------------
DROP TABLE IF EXISTS `users_types`;
CREATE TABLE `users_types` (
  `user_id` int(11) NOT NULL,
  `type_id` int(7) NOT NULL,
  KEY `users_types` (`user_id`),
  CONSTRAINT `users_types` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of users_types
-- ----------------------------
INSERT INTO `users_types` VALUES ('1', '1');
INSERT INTO `users_types` VALUES ('1', '2');
INSERT INTO `users_types` VALUES ('2', '1');

-- ----------------------------
-- Procedure structure for getEmails
-- ----------------------------
DROP PROCEDURE IF EXISTS `getEmails`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getEmails`()
BEGIN
    select e.*, t.id type_id, t.name type, t.alias type_alias from emails e
    left join types t on e.type_id = t.id;
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
	select e.*, t.id type_id, t.name type, t.alias type_alias from emails e
    left join types t on e.type_id = t.id
    where e.id = email_id;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for getNewsletters
-- ----------------------------
DROP PROCEDURE IF EXISTS `getNewsletters`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getNewsletters`()
BEGIN
	select n.*, t.name as type_name, t.alias as type_alias, u.name as user_name,
		count(case when l.status = 0 then 1 end) as state0,
		count(case when l.status = 1 then 1 end) as state1,
		count(case when l.status = 2 then 1 end) as state2,
		count(*) as `count`
	from newsletters n
    left join types t on n.type_id = t.id
    left join users u on n.user_id = u.id
		left join logs l on l.newsletter_id = n.id
	group by l.newsletter_id;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for getNewslettersById
-- ----------------------------
DROP PROCEDURE IF EXISTS `getNewslettersById`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getNewslettersById`(newsletter_id INT(0))
BEGIN
	select n.*, t.name as type_name, t.alias as type_alias, u.name as user_name,
		count(case when l.status = 0 then 1 end) as state0,
		count(case when l.status = 1 then 1 end) as state1,
		count(case when l.status = 2 then 1 end) as state2,
		count(*) as `count`
	from newsletters n
    left join types t on n.type_id = t.id
    left join users u on n.user_id = u.id
		left join logs l on l.newsletter_id = n.id
	where n.id = newsletter_id
    group by l.newsletter_id;
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
	SELECT
		id,
		name,
		username,
		email,
		active,
		params,
		GROUP_CONCAT(type_alias SEPARATOR ', ') AS types
	FROM
		(
			SELECT
				u.*, t.id type_id,
				t. NAME type,
				t.alias type_alias
			FROM
				users u
			INNER JOIN users_types ut ON u.id = ut.user_id
			LEFT JOIN types t ON ut.type_id = t.id
		) a
	GROUP BY id;
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
	SELECT
		id,
		name,
		username,
		email,
		active,
		params,
		GROUP_CONCAT(type_alias SEPARATOR ', ') AS types
	FROM
		(
			SELECT
				u.*, t.id type_id,
				t. NAME type,
				t.alias type_alias
			FROM
				users u
			INNER JOIN users_types ut ON u.id = ut.user_id
			LEFT JOIN types t ON ut.type_id = t.id
            where u.id = user_id
		) a
	GROUP BY id;
END
;;
DELIMITER ;
