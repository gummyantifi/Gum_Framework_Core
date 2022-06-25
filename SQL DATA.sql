/*
Navicat MySQL Data Transfer

Source Server         : RedWest_Windows_copy_copy
Source Server Version : 100421
Source Host           : 51.68.190.184:3306
Source Database       : redwest

Target Server Type    : MYSQL
Target Server Version : 100421
File Encoding         : 65001

Date: 2022-03-07 11:09:15
*/

SET FOREIGN_KEY_CHECKS=0;

CREATE TABLE `bank_users` (
  `identifier` varchar(50) DEFAULT '0',
  `charidentifier` varchar(5) DEFAULT '0',
  `money` varchar(255)  DEFAULT '0',
  `gold` varchar(255) DEFAULT '0',
  `name` varchar(255) DEFAULT '0',
  `borrow` double DEFAULT 0,
  `borrow_pay` datetime DEFAULT NULL,
  `borrow_money` double DEFAULT 0
) ENGINE=InnoDB;



-- ----------------------------
-- Table structure for bans
-- ----------------------------
DROP TABLE IF EXISTS `bans`;
CREATE TABLE `bans` (
  `identifier` varchar(50) DEFAULT NULL,
  `reason` varchar(500)  DEFAULT NULL,
  `date` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  KEY `identifier` (`identifier`),
  KEY `reason` (`reason`)
) ENGINE=InnoDB;

-- ----------------------------
-- Table structure for drops
-- ----------------------------
DROP TABLE IF EXISTS `drops`;
CREATE TABLE `drops` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `drop_list` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7857;

-- ----------------------------
-- Table structure for characters
-- ----------------------------
DROP TABLE IF EXISTS `characters`;
CREATE TABLE `characters` (
  `identifier` varchar(50) NOT NULL DEFAULT '',
  `charidentifier` int(11) NOT NULL AUTO_INCREMENT,
  `money` double(11,2) DEFAULT 0.00,
  `gold` double(11,2) DEFAULT 0.00,
  `rol` double(11,2) NOT NULL DEFAULT 0.00,
  `inventory` longtext DEFAULT NULL,
  `job` varchar(50) DEFAULT 'unemployed',
  `status` varchar(140) DEFAULT '{}',
  `meta` varchar(255) NOT NULL DEFAULT '{}',
  `firstname` varchar(50) DEFAULT ' ',
  `lastname` varchar(50) DEFAULT ' ',
  `skinPlayer` longtext DEFAULT NULL,
  `compPlayer` longtext DEFAULT NULL,
  `jobgrade` int(11) DEFAULT 0,
  `coords` varchar(75) DEFAULT '{}',
  `isdead` tinyint(1) DEFAULT 0,
  `walking_style` varchar(50) DEFAULT 'Default',
  UNIQUE KEY `identifier_charidentifier` (`identifier`,`charidentifier`) USING BTREE,
  KEY `charidentifier` (`charidentifier`) USING BTREE,
  KEY `coords` (`coords`),
  KEY `compPlayer` (`compPlayer`(768)),
  KEY `skinPlayer` (`skinPlayer`(768)),
  KEY `money` (`money`),
  KEY `status` (`status`),
  CONSTRAINT `FK_characters_users` FOREIGN KEY (`identifier`) REFERENCES `users` (`identifier`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for inventory_storage
-- ----------------------------
DROP TABLE IF EXISTS `inventory_storage`;
CREATE TABLE `inventory_storage` (
  `identifier` varchar(50) NOT NULL,
  `charid` int(11) NOT NULL DEFAULT 0,
  `items` longtext NOT NULL DEFAULT '{}',
  `size` double DEFAULT 0
) ENGINE=InnoDB;

-- ----------------------------
-- Table structure for items
-- ----------------------------
DROP TABLE IF EXISTS `items`;
CREATE TABLE `items` (
  `item` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `limit` varchar(11) NOT NULL DEFAULT '1',
  `can_remove` tinyint(1) NOT NULL DEFAULT 1,
  `type` varchar(50) DEFAULT NULL,
  `usable` tinyint(1) DEFAULT NULL,
  `descriptions` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`item`) USING BTREE,
  KEY `label` (`label`)
) ENGINE=InnoDB;

-- ----------------------------
-- Table structure for loadout
-- ----------------------------
DROP TABLE IF EXISTS `loadout`;
CREATE TABLE `loadout` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) DEFAULT NULL,
  `charidentifier` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `ammo` varchar(255) NOT NULL DEFAULT '{}',
  `dirtlevel` double DEFAULT 0,
  `conditionlevel` double DEFAULT 0,
  `used` tinyint(4) DEFAULT 0,
  `comps` varchar(15000) DEFAULT '{}',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `id` (`id`) USING BTREE,
  KEY `identifier` (`identifier`),
  KEY `charidentifier` (`charidentifier`)
) ENGINE=InnoDB AUTO_INCREMENT=1;

-- ----------------------------
-- Table structure for outfits
-- ----------------------------
DROP TABLE IF EXISTS `outfits`;
CREATE TABLE `outfits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(45) NOT NULL,
  `charidentifier` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `comps` longtext DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `identifier` (`identifier`),
  KEY `charidentifier` (`charidentifier`)
) ENGINE=InnoDB AUTO_INCREMENT=1;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `identifier` varchar(50) NOT NULL,
  `group` varchar(50) DEFAULT 'user',
  `warnings` int(11) DEFAULT 0,
  `banned` tinyint(4) DEFAULT 0,
  `chars` int(1) DEFAULT 1,
  PRIMARY KEY (`identifier`) USING BTREE,
  UNIQUE KEY `identifier` (`identifier`) USING BTREE,
  KEY `group` (`group`)
) ENGINE=InnoDB;

-- ----------------------------
-- Table structure for whitelist
-- ----------------------------
DROP TABLE IF EXISTS `whitelist`;
CREATE TABLE `whitelist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `identifier` (`identifier`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1;
SET FOREIGN_KEY_CHECKS=1;

INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `descriptions`) VALUES ('Bread', 'Bread', '1', '1', 'item_standard', '1', 'Good bread');
INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `descriptions`) VALUES ('Water', 'Water', '1', '1', 'item_standard', '1', 'Good water');
INSERT INTO `users` (`identifier`, `group`, `warnings`, `banned`, `chars`) VALUES ('steam:', 'user', '0', '0', '1');

