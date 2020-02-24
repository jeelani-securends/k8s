/*
Navicat MySQL Data Transfer

Source Server         : 104
Source Server Version : 50726
Source Host           : 192.168.1.104:3306
Source Database       : cem

Target Server Type    : MYSQL
Target Server Version : 50726
File Encoding         : 65001

Date: 2020-01-07 20:13:47
*/


SET FOREIGN_KEY_CHECKS=0;

DROP database IF EXISTS `cem`;

CREATE DATABASE cem CHARACTER SET utf8 COLLATE utf8_unicode_ci;

USE cem;

-- ----------------------------
-- Table structure for `action`
-- ----------------------------
DROP TABLE IF EXISTS `action`;
CREATE TABLE `action` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `CONFIGURATION` longtext COLLATE utf8_unicode_ci,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `AGENT_TYPE` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`),
  KEY `FKl84g1g2il5jo7i9colucinhhj` (`AGENT_TYPE`),
  CONSTRAINT `FKl84g1g2il5jo7i9colucinhhj` FOREIGN KEY (`AGENT_TYPE`) REFERENCES `end_point_type` (`ROW_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of action
-- ----------------------------
INSERT INTO `action` VALUES ('1', '{\"Organizational Unit\":\"Organizational Unit\",\"Roles\":\"Roles\"}', 'Create User', '1');
INSERT INTO `action` VALUES ('2', null, 'Disable User', '1');
INSERT INTO `action` VALUES ('3', '{\"Organizational Unit\":\"Organizational Unit\",\"Roles\":\"Roles\"}', 'Transfer User', '1');

-- ----------------------------
-- Table structure for `app_configuration`
-- ----------------------------
DROP TABLE IF EXISTS `app_configuration`;
CREATE TABLE `app_configuration` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `IS_SELECTED` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PROPERTY` longtext COLLATE utf8_unicode_ci,
  `TYPE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CUSTOMER_RID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of app_configuration
-- ----------------------------
INSERT INTO `app_configuration` VALUES ('1', '1', '{\"mail.port\":\"587\",\"mail.transport.protocol\":\"smtp\",\"mail.debug\":true,\"mail.to\":\"cem@securends.com\",\"mail.from\":\"cem@securends.com\",\"mail.host\":\"smtp.office365.com\",\"mail.username\":\"cem@securends.com\",\"mail.password\":\"Charter@123!\",\"mail.reset.password.expiration.timeout\":\"60\",\"mail.smtp.auth\":true,\"mail.smtp.starttls.enable\":true}', 'mail', '1');
INSERT INTO `app_configuration` VALUES ('2', '0', '{\"jira.projectKey\":\"project key\",\"jira.assignee.username\":\"admin\",\"jira.issue.url\":\"https://atlassian.net/rest/api/3/issue\",\"jira.password\":\"fyWg1WjAyBj7mIgFswB0BDFC\",\"jira.username\":\"username\",\"jira.instance.type\":\"Cloud\"}', 'jira', '1');
INSERT INTO `app_configuration` VALUES ('3', '0', '{\"servicenow.url\":\"https://dev27354.service-now.com/api/now/table/incident\",\"servicenow.username\":\"admin\",\"servicenow.assignee.username\":\"billie.tinnes\",\"servicenow.password\":\"Charter@123\"}', 'serviceNow', '1');
INSERT INTO `app_configuration` VALUES ('4', '1', '{\"semi.sync.cron.exp\":\"16000\",\"full.sync.cron.exp\":\"30000\",\"automatic.restart.server.time\":\"2\"}', 'syncFrequency', '1');
INSERT INTO `app_configuration` VALUES ('5', '1', '{\"static_campaign_name\":\"ATTR_CAMPAIGN\"}', 'STATIC_CAMPAIGN', '1');

-- ----------------------------
-- Table structure for `assignment`
-- ----------------------------
DROP TABLE IF EXISTS `assignment`;
CREATE TABLE `assignment` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `CREATED_TS` datetime DEFAULT NULL,
  `REFRESH_STATUS` varchar(255) DEFAULT NULL,
  `STATUS` varchar(255) DEFAULT NULL,
  `CRED_RID` bigint(20) DEFAULT NULL,
  `ENTITLEMENT_RID` bigint(20) DEFAULT NULL,
  `ENTITLEMENT_CREATED_TS` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`),
  UNIQUE KEY `ASSIGNMENT_U1` (`CRED_RID`,`ENTITLEMENT_RID`),
  KEY `ASSIGNMENT_FK1` (`ENTITLEMENT_RID`),
  CONSTRAINT `ASSIGNMENT_FK1` FOREIGN KEY (`ENTITLEMENT_RID`) REFERENCES `entitlement` (`ROW_ID`) ON DELETE CASCADE,
  CONSTRAINT `ASSIGNMENT_FK2` FOREIGN KEY (`CRED_RID`) REFERENCES `credential` (`ROW_ID`) ON DELETE CASCADE,
  CONSTRAINT `FKj8xdlp0tcq96ioq7x4sum5sg9` FOREIGN KEY (`ENTITLEMENT_RID`) REFERENCES `entitlement` (`ROW_ID`),
  CONSTRAINT `FKn1w55om2duhjaai68vh2dxwog` FOREIGN KEY (`CRED_RID`) REFERENCES `credential` (`ROW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of assignment
-- ----------------------------

-- ----------------------------
-- Table structure for `attribute`
-- ----------------------------
DROP TABLE IF EXISTS `attribute`;
CREATE TABLE `attribute` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `END_POINT_RID` bigint(20) DEFAULT NULL,
  `ENTITY_RID` bigint(20) DEFAULT NULL,
  `FIELD_NAME` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `FIELD_TYPE` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`),
  KEY `FKtqpj5tg8bfm0o8nr8f4539r00` (`END_POINT_RID`),
  KEY `FK8jvuyhlm5lo5l9m138hxv5tt2` (`ENTITY_RID`),
  CONSTRAINT `FK8jvuyhlm5lo5l9m138hxv5tt2` FOREIGN KEY (`ENTITY_RID`) REFERENCES `entity` (`ROW_ID`),
  CONSTRAINT `FKtqpj5tg8bfm0o8nr8f4539r00` FOREIGN KEY (`END_POINT_RID`) REFERENCES `end_point` (`ROW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of attribute
-- ----------------------------

-- ----------------------------
-- Table structure for `automatic_end_point`
-- ----------------------------
DROP TABLE IF EXISTS `automatic_end_point`;
CREATE TABLE `automatic_end_point` (
  `AGENT` varchar(255) DEFAULT NULL,
  `END_POINT_RID` bigint(20) NOT NULL,
  `CRON_EXPRESSION` varchar(255) DEFAULT NULL,
  `LAST_RAN_DATE` datetime DEFAULT NULL,
  `SYNC_STATUS_MESSAGE` varchar(255) DEFAULT NULL,
  `Fetch_Inactive_Users` char(1) DEFAULT NULL,
  `ENTITLEMENT` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`END_POINT_RID`),
  CONSTRAINT `FKg0op40kbm9q7wn0cb41fygu1p` FOREIGN KEY (`END_POINT_RID`) REFERENCES `end_point` (`ROW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of automatic_end_point
-- ----------------------------

-- ----------------------------
-- Table structure for `campaign`
-- ----------------------------
DROP TABLE IF EXISTS `campaign`;
CREATE TABLE `campaign` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `CREATED_TS` datetime DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `PERIOD_END` datetime DEFAULT NULL,
  `ENTITLEMENTS_ENABLED` char(1) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `PERIOD_START` datetime DEFAULT NULL,
  `STATUS` varchar(255) DEFAULT NULL,
  `UPDATED_TS` datetime DEFAULT NULL,
  `visibility` tinyint(1) DEFAULT '1',
  `TEMPLATE_RID` bigint(20) DEFAULT NULL,
  `CUSTOMER_RID` bigint(20) DEFAULT NULL,
  `CAMAPAIGN_TYPE` varchar(255) DEFAULT NULL,
  `EMAIL_TEXT` longtext,
  `CAMPAIGN_REMINDER` bigint(20) DEFAULT NULL,
  `CAMPAIGN_OWNER` varchar(255) DEFAULT NULL,
  `CONSECUTIVE_DAYS` tinyint(1) DEFAULT '1',
  `DELTA` tinyint(1) DEFAULT '0',
  `REVIEWER_TYPE` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`),
  KEY `FKhwy89j9dqeqb0q5ww9gpbyau6` (`TEMPLATE_RID`),
  KEY `FKdur6sgn9s1uogqq6sl7t15d33` (`CUSTOMER_RID`),
  CONSTRAINT `FKdur6sgn9s1uogqq6sl7t15d33` FOREIGN KEY (`CUSTOMER_RID`) REFERENCES `customer` (`ROW_ID`),
  CONSTRAINT `FKhwy89j9dqeqb0q5ww9gpbyau6` FOREIGN KEY (`TEMPLATE_RID`) REFERENCES `campaign_template` (`ROW_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of campaign
-- ----------------------------
INSERT INTO `campaign` VALUES ('1', '2019-08-16 15:42:15', 'Access Control Template', null, 'Y', 'Access Control Campaign', '2019-06-25 15:42:07', 'O', null, '0', '1', '1', 'MANUAL', null, null, null, '1', '0', null);

-- ----------------------------
-- Table structure for `campaignpreview`
-- ----------------------------
DROP TABLE IF EXISTS `campaignpreview`;
CREATE TABLE `campaignpreview` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ROW_ID` bigint(20) DEFAULT NULL,
  `FIRST_NAME` varchar(255) DEFAULT NULL,
  `LAST_NAME` varchar(255) DEFAULT NULL,
  `EMAIL` varchar(255) DEFAULT NULL,
  `TOTAL` bigint(21) DEFAULT NULL,
  `PENDING` bigint(21) DEFAULT NULL,
  `CUSTOMER_RID` bigint(20) DEFAULT NULL,
  `CAMPAIGN_RID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of campaignpreview
-- ----------------------------

-- ----------------------------
-- Table structure for `campaign_assignment_ui`
-- ----------------------------
DROP TABLE IF EXISTS `campaign_assignment_ui`;
CREATE TABLE `campaign_assignment_ui` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ASSIGNEE_RID` bigint(20) DEFAULT NULL,
  `CAMPAIGN_RID` bigint(20) DEFAULT NULL,
  `E_TYPE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FULL_NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `OWNER_ID` bigint(20) DEFAULT NULL,
  `PENDING` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TOTAL` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `NOTIFY_TERMINATED_DATE` datetime DEFAULT NULL,
  `NOTIFY_UPDATED_MANAGER` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of campaign_assignment_ui
-- ----------------------------

-- ----------------------------
-- Table structure for `campaign_election`
-- ----------------------------
DROP TABLE IF EXISTS `campaign_election`;
CREATE TABLE `campaign_election` (
  `SUBTYPE` varchar(31) NOT NULL,
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ETYPE` varchar(255) DEFAULT NULL,
  `CREATED_TS` datetime DEFAULT NULL,
  `ELECTION` varchar(255) DEFAULT NULL,
  `UPDATED_TS` datetime DEFAULT NULL,
  `ASSIGNEE_RID` bigint(20) DEFAULT NULL,
  `CAMPAIGN_RID` bigint(20) DEFAULT NULL,
  `REVIEWER_RID` bigint(20) DEFAULT NULL,
  `ASSIGNMENT_RID` bigint(20) DEFAULT NULL,
  `CREDENTIAL_RID` bigint(20) DEFAULT NULL,
  `TICKET_ID` varchar(45) DEFAULT NULL,
  `ELECTION_REF_ID` bigint(20) DEFAULT NULL,
  `NOTIFY_TERMINATED_DATE` datetime DEFAULT NULL,
  `NOTIFY_UPDATED_MANAGER` varchar(255) DEFAULT NULL,
  `IAM_USER_RID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`),
  KEY `CAMPAIGN_ELECTION_FK1` (`CAMPAIGN_RID`),
  KEY `CAMPAIGN_ELECTION_FK2` (`ASSIGNEE_RID`),
  KEY `CAMPAIGN_ELECTION_FK3` (`REVIEWER_RID`),
  KEY `CAMPAIGN_CREDENTIAL_RID_FK4` (`CREDENTIAL_RID`),
  KEY `CAMPAIGN_ASSIGNMENT_RID_FK5` (`ASSIGNMENT_RID`),
  KEY `FKpfg6dv3oamxnyvvcm13y83c0` (`IAM_USER_RID`),
  CONSTRAINT `CAMPAIGN_ASSIGNMENT_RID_FK5` FOREIGN KEY (`ASSIGNMENT_RID`) REFERENCES `assignment` (`ROW_ID`) ON DELETE CASCADE,
  CONSTRAINT `CAMPAIGN_CREDENTIAL_RID_FK4` FOREIGN KEY (`CREDENTIAL_RID`) REFERENCES `credential` (`ROW_ID`) ON DELETE CASCADE,
  CONSTRAINT `CAMPAIGN_ELECTION_FK1` FOREIGN KEY (`CAMPAIGN_RID`) REFERENCES `campaign` (`ROW_ID`) ON DELETE CASCADE,
  CONSTRAINT `CAMPAIGN_ELECTION_FK2` FOREIGN KEY (`ASSIGNEE_RID`) REFERENCES `iam_user` (`ROW_ID`),
  CONSTRAINT `CAMPAIGN_ELECTION_FK3` FOREIGN KEY (`REVIEWER_RID`) REFERENCES `iam_user` (`ROW_ID`),
  CONSTRAINT `FK6jmeo6lj4sb9u75jsro3oyfl9` FOREIGN KEY (`CAMPAIGN_RID`) REFERENCES `campaign` (`ROW_ID`),
  CONSTRAINT `FK8w5iyjan3gbm34ordj4nokhvd` FOREIGN KEY (`ASSIGNEE_RID`) REFERENCES `iam_user` (`ROW_ID`),
  CONSTRAINT `FK9hjdd2ltdthjjgx9l70hghco2` FOREIGN KEY (`REVIEWER_RID`) REFERENCES `iam_user` (`ROW_ID`),
  CONSTRAINT `FKl1fxar0d29wt5j294cs4mbk6r` FOREIGN KEY (`CREDENTIAL_RID`) REFERENCES `credential` (`ROW_ID`),
  CONSTRAINT `FKmhac782qe7dfr5vwqu20i9d3w` FOREIGN KEY (`ASSIGNMENT_RID`) REFERENCES `assignment` (`ROW_ID`),
  CONSTRAINT `FKpfg6dv3oamxnyvvcm13y83c0` FOREIGN KEY (`IAM_USER_RID`) REFERENCES `iam_user` (`ROW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of campaign_election
-- ----------------------------

-- ----------------------------
-- Table structure for `campaign_election_note`
-- ----------------------------
DROP TABLE IF EXISTS `campaign_election_note`;
CREATE TABLE `campaign_election_note` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `CREATED_TS` datetime DEFAULT NULL,
  `DETAILS` varchar(255) DEFAULT NULL,
  `AUTHOR_RID` bigint(20) DEFAULT NULL,
  `ELECTION_RID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`),
  KEY `CAMPAIGN_ELECTION_NOTE_FK1` (`ELECTION_RID`),
  KEY `CAMPAIGN_ELECTION_NOTE_FK2` (`AUTHOR_RID`),
  CONSTRAINT `CAMPAIGN_ELECTION_NOTE_FK1` FOREIGN KEY (`ELECTION_RID`) REFERENCES `campaign_election` (`ROW_ID`) ON DELETE CASCADE,
  CONSTRAINT `CAMPAIGN_ELECTION_NOTE_FK2` FOREIGN KEY (`AUTHOR_RID`) REFERENCES `iam_user` (`ROW_ID`),
  CONSTRAINT `FKetwjg5xp52985y1i40qyym16j` FOREIGN KEY (`ELECTION_RID`) REFERENCES `campaign_election` (`ROW_ID`),
  CONSTRAINT `FKnd2cupu3ub5p321tqo25v79uw` FOREIGN KEY (`AUTHOR_RID`) REFERENCES `iam_user` (`ROW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of campaign_election_note
-- ----------------------------

-- ----------------------------
-- Table structure for `campaign_template`
-- ----------------------------
DROP TABLE IF EXISTS `campaign_template`;
CREATE TABLE `campaign_template` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `INCLUDE_ENTITLEMENTS` char(1) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `MANAGER_RID` bigint(20) DEFAULT NULL,
  `visibility` tinyint(1) DEFAULT '1',
  `CUSTOMER_RID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`),
  KEY `CAMPAIGN_TEMPLATE_FK1` (`MANAGER_RID`),
  KEY `FKmg3gpngx36620fqnrkc0h0og7` (`CUSTOMER_RID`),
  CONSTRAINT `CAMPAIGN_TEMPLATE_FK1` FOREIGN KEY (`MANAGER_RID`) REFERENCES `iam_user` (`ROW_ID`),
  CONSTRAINT `FKmg3gpngx36620fqnrkc0h0og7` FOREIGN KEY (`CUSTOMER_RID`) REFERENCES `customer` (`ROW_ID`),
  CONSTRAINT `FKseato78fcs9xwvkmwcynbc4pb` FOREIGN KEY (`MANAGER_RID`) REFERENCES `iam_user` (`ROW_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of campaign_template
-- ----------------------------
INSERT INTO `campaign_template` VALUES ('1', 'Access Control Template', 'Y', 'Access Control Template', null, '0', '1');

-- ----------------------------
-- Table structure for `campaign_template_element`
-- ----------------------------
DROP TABLE IF EXISTS `campaign_template_element`;
CREATE TABLE `campaign_template_element` (
  `SUBTYPE` varchar(31) NOT NULL,
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `TEMPLATE_RID` bigint(20) DEFAULT NULL,
  `ENTITLEMENT_RID` bigint(20) DEFAULT NULL,
  `CREDENTIAL_RID` bigint(20) DEFAULT NULL,
  `END_POINT_RID` bigint(20) DEFAULT NULL,
  `ENDPOINT_ENTITLEMENTS` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`),
  KEY `CAMPAIGN_TEMPLATE_ELEMENT_FK1` (`TEMPLATE_RID`),
  KEY `CAMPAIGN_TEMPLATE_ELEMENT_FK2` (`END_POINT_RID`),
  KEY `CAMPAIGN_TEMPLATE_ELEMENT_FK3` (`CREDENTIAL_RID`),
  KEY `CAMPAIGN_TEMPLATE_ELEMENT_FK4` (`ENTITLEMENT_RID`),
  CONSTRAINT `CAMPAIGN_TEMPLATE_ELEMENT_FK1` FOREIGN KEY (`TEMPLATE_RID`) REFERENCES `campaign_template` (`ROW_ID`) ON DELETE CASCADE,
  CONSTRAINT `CAMPAIGN_TEMPLATE_ELEMENT_FK2` FOREIGN KEY (`END_POINT_RID`) REFERENCES `end_point` (`ROW_ID`) ON DELETE CASCADE,
  CONSTRAINT `CAMPAIGN_TEMPLATE_ELEMENT_FK3` FOREIGN KEY (`CREDENTIAL_RID`) REFERENCES `credential` (`ROW_ID`) ON DELETE CASCADE,
  CONSTRAINT `CAMPAIGN_TEMPLATE_ELEMENT_FK4` FOREIGN KEY (`ENTITLEMENT_RID`) REFERENCES `entitlement` (`ROW_ID`) ON DELETE CASCADE,
  CONSTRAINT `FK48b9x31boxuonobttvtftxxwo` FOREIGN KEY (`END_POINT_RID`) REFERENCES `end_point` (`ROW_ID`),
  CONSTRAINT `FKgbcyt00ewckwd32jn1gwwsjey` FOREIGN KEY (`CREDENTIAL_RID`) REFERENCES `credential` (`ROW_ID`),
  CONSTRAINT `FKr138i1e76wxgpwwrqcp9w6ipb` FOREIGN KEY (`TEMPLATE_RID`) REFERENCES `campaign_template` (`ROW_ID`),
  CONSTRAINT `FKs0905s2ur99d8b4n2jbi75hdq` FOREIGN KEY (`ENTITLEMENT_RID`) REFERENCES `entitlement` (`ROW_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of campaign_template_element
-- ----------------------------
INSERT INTO `campaign_template_element` VALUES ('EP', '1', '1', null, null, '1', null);

-- ----------------------------
-- Table structure for `credential`
-- ----------------------------
DROP TABLE IF EXISTS `credential`;
CREATE TABLE `credential` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `CN` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CREATED_TS` datetime DEFAULT NULL,
  `DN` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `EMAIL` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FIRST_NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `LAST_AUTH_TS` datetime DEFAULT NULL,
  `LAST_NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `MANAGER_DN` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `MIDDLE_NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `REFRESH_STATUS` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `STATUS` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `END_POINT_RID` bigint(20) DEFAULT NULL,
  `IAM_USER_RID` bigint(20) DEFAULT NULL,
  `CREDENTIAL_CREATED_DATE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CREDENTIAL_STATUS` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ATTRIBUTE_FIELD_VALUES` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `STATUS_CODE` int(11) DEFAULT NULL,
  `FULL_NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `USER_ID` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ADDITIONAL_COLUMNS` longtext COLLATE utf8_unicode_ci,
  `IS_MATCH_PERFORMED` tinyint(1) NOT NULL DEFAULT '0',
  `ASSIGN_STATUS` tinyint(1) NOT NULL DEFAULT '0',
  `REVIEWER_RID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`),
  UNIQUE KEY `CREDENTIAL_U1` (`END_POINT_RID`,`DN`),
  KEY `CREDENTIAL_FK1` (`IAM_USER_RID`),
  KEY `FK9bwo57yl0qb1m3vfwueqgu98i` (`REVIEWER_RID`),
  CONSTRAINT `CREDENTIAL_FK1` FOREIGN KEY (`IAM_USER_RID`) REFERENCES `iam_user` (`ROW_ID`),
  CONSTRAINT `CREDENTIAL_FK2` FOREIGN KEY (`END_POINT_RID`) REFERENCES `end_point` (`ROW_ID`) ON DELETE CASCADE,
  CONSTRAINT `FK96duxajrvesr51lj860w6e3p3` FOREIGN KEY (`END_POINT_RID`) REFERENCES `end_point` (`ROW_ID`),
  CONSTRAINT `FK9bwo57yl0qb1m3vfwueqgu98i` FOREIGN KEY (`REVIEWER_RID`) REFERENCES `iam_user` (`ROW_ID`),
  CONSTRAINT `FKk5cadht9jjokqc9sm27n4d2s8` FOREIGN KEY (`IAM_USER_RID`) REFERENCES `iam_user` (`ROW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of credential
-- ----------------------------

-- ----------------------------
-- Table structure for `csv_end_point`
-- ----------------------------
DROP TABLE IF EXISTS `csv_end_point`;
CREATE TABLE `csv_end_point` (
  `CN_ATTR` varchar(255) DEFAULT NULL,
  `DN_ATTR` varchar(255) DEFAULT NULL,
  `EMAIL_ATTR` varchar(255) DEFAULT NULL,
  `FIRST_NAME_ATTR` varchar(255) DEFAULT NULL,
  `LAST_AUTH_ATTR` varchar(255) DEFAULT NULL,
  `LAST_AUTH_FORMAT` varchar(255) DEFAULT NULL,
  `LAST_NAME_ATTR` varchar(255) DEFAULT NULL,
  `MANAGER_DN_ATTR` varchar(255) DEFAULT NULL,
  `MEM_CN_ATTR` varchar(255) DEFAULT NULL,
  `MEM_DESC_ATTR` varchar(255) DEFAULT NULL,
  `MEMBERSHIP_ATTR` varchar(255) DEFAULT NULL,
  `MIDDLE_NAME_ATTR` varchar(255) DEFAULT NULL,
  `END_POINT_RID` bigint(20) NOT NULL,
  `AGENT` varchar(255) DEFAULT NULL,
  `CREDENTIAL_CREATED_TS` varchar(255) DEFAULT NULL,
  `CREDENTIAL_STATUS` varchar(255) DEFAULT NULL,
  `ENTITLEMENT_CREATED_TS` varchar(255) DEFAULT NULL,
  `USER_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`END_POINT_RID`),
  CONSTRAINT `CSV_END_POINT_FK1` FOREIGN KEY (`END_POINT_RID`) REFERENCES `end_point` (`ROW_ID`) ON DELETE CASCADE,
  CONSTRAINT `FK9v254ddfo1l5xbkh33gdjpoct` FOREIGN KEY (`END_POINT_RID`) REFERENCES `end_point` (`ROW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of csv_end_point
-- ----------------------------
INSERT INTO `csv_end_point` VALUES ('Common Name', 'Distinguished Name', 'Email', 'First Name', 'Last Authentication', null, 'Last Name', 'Manager DN', 'Entitlement CN', 'Entitlement Description', 'Entitlement DN', 'Middle Name', '1', 'AD', null, null, null, null);

-- ----------------------------
-- Table structure for `csv_row`
-- ----------------------------
DROP TABLE IF EXISTS `csv_row`;
CREATE TABLE `csv_row` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `COMMON_NAME` varchar(255) DEFAULT NULL,
  `CREATED_TS` datetime DEFAULT NULL,
  `DISTIGUISHED_NAME` varchar(255) DEFAULT NULL,
  `EMAIL` varchar(255) DEFAULT NULL,
  `ENTITLEMENT_CN` varchar(255) DEFAULT NULL,
  `ENTITLEMENT_DESC` varchar(255) DEFAULT NULL,
  `ENTITLEMENT_DN` varchar(255) DEFAULT NULL,
  `FIRST_NAME` varchar(255) DEFAULT NULL,
  `LAST_AUTH_TS` datetime DEFAULT NULL,
  `LAST_NAME` varchar(255) DEFAULT NULL,
  `MANAGER` varchar(255) DEFAULT NULL,
  `MIDDLE_NAME` varchar(255) DEFAULT NULL,
  `END_POINT_RID` bigint(20) DEFAULT NULL,
  `CREDENTIAL_CREATED_TS` varchar(255) DEFAULT NULL,
  `ENTITLEMENT_CREATED_TS` varchar(255) DEFAULT NULL,
  `CREDENTIAL_STATUS` varchar(255) DEFAULT NULL,
  `USER_ID` varchar(255) DEFAULT NULL,
  `ADDITIONAL_COLUMNS` longtext,
  PRIMARY KEY (`ROW_ID`),
  KEY `CSV_ROW_END_POINT_FK1` (`END_POINT_RID`),
  CONSTRAINT `CSV_ROW_END_POINT_FK1` FOREIGN KEY (`END_POINT_RID`) REFERENCES `end_point` (`ROW_ID`),
  CONSTRAINT `FK2nhifahnj4q7y6mgvsn75gtdy` FOREIGN KEY (`END_POINT_RID`) REFERENCES `end_point` (`ROW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of csv_row
-- ----------------------------

-- ----------------------------
-- Table structure for `customer`
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ACTIVE` bit(1) DEFAULT NULL,
  `ADDRESS` varchar(255) DEFAULT NULL,
  `CREATED_TS` datetime DEFAULT NULL,
  `EMAIL` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `PHONE_NUMBER` varchar(255) DEFAULT NULL,
  `PRODUCT_TYPE` varchar(255) DEFAULT NULL,
  `2FA_TYPE` varchar(255) DEFAULT NULL,
  `2FA_ENABLED` bit(1) DEFAULT NULL,
  `ENVIRONMENT_DESCRIPTION` varchar(255) DEFAULT NULL,
  `ENVIRONMENT_TYPE` varchar(255) DEFAULT NULL,
  `CUSTOMER_HOST` varchar(255) DEFAULT NULL,
  `TYPE_OF_LOGIN` varchar(255) DEFAULT NULL,
  `REVIEW_ACTIONS_CONFIG` longtext,
  PRIMARY KEY (`ROW_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES ('1', '', 'HYD', '2018-08-01 12:09:38', 'pickles@charterglobal.com', 'Securends', '7893075948', 'accesscontrol', null, '', 'on permises', 'onPrimises', '192.168.1.104', 'usernameAndPassword', '{\"reviewAllPage_approveAllRevokeAll\":\"footer\",\"actions_column_campaignAssignment\":true,\"reviewAll_campaignAssignment\":false,\"approveAll_campaignAssignment\":true,\"campaignelections_approveAllRevokeAll\":true}');

-- ----------------------------
-- Table structure for `customer_attributes`
-- ----------------------------
DROP TABLE IF EXISTS `customer_attributes`;
CREATE TABLE `customer_attributes` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `CUSTOMER_KEY` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CUSTOMER_VALUE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CUSTOMER_RID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`),
  KEY `FKswgftjwiagb00colfcnydyd8m` (`CUSTOMER_RID`),
  CONSTRAINT `FKswgftjwiagb00colfcnydyd8m` FOREIGN KEY (`CUSTOMER_RID`) REFERENCES `customer` (`ROW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of customer_attributes
-- ----------------------------

-- ----------------------------
-- Table structure for `database_end_point`
-- ----------------------------
DROP TABLE IF EXISTS `database_end_point`;
CREATE TABLE `database_end_point` (
  `CRED_CN_COLUMN` varchar(255) DEFAULT NULL,
  `CREDENTIAL_COLUMN` varchar(255) DEFAULT NULL,
  `CREDENTIAL_TABLE` varchar(255) DEFAULT NULL,
  `EMAIL_COLUMN` varchar(255) DEFAULT NULL,
  `FIRST_NAME_COLUMN` varchar(255) DEFAULT NULL,
  `JDBC_URL` varchar(255) DEFAULT NULL,
  `LAST_NAME_COLUMN` varchar(255) DEFAULT NULL,
  `MANAGER_COLUMN` varchar(255) DEFAULT NULL,
  `MIDDLE_NAME_COLUMN` varchar(255) DEFAULT NULL,
  `PASSWORD` varchar(255) DEFAULT NULL,
  `USERNAME` varchar(255) DEFAULT NULL,
  `END_POINT_RID` bigint(20) NOT NULL,
  PRIMARY KEY (`END_POINT_RID`),
  CONSTRAINT `DATABASE_END_POINT_FK1` FOREIGN KEY (`END_POINT_RID`) REFERENCES `end_point` (`ROW_ID`) ON DELETE CASCADE,
  CONSTRAINT `FK1vd91e9vbun6t6cdqc7bner3o` FOREIGN KEY (`END_POINT_RID`) REFERENCES `end_point` (`ROW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of database_end_point
-- ----------------------------

-- ----------------------------
-- Table structure for `email_audit`
-- ----------------------------
DROP TABLE IF EXISTS `email_audit`;
CREATE TABLE `email_audit` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `EMAIL_CONTENT` longtext COLLATE utf8_unicode_ci,
  `CREATED_DATE` datetime DEFAULT NULL,
  `CUSTOMER_RID` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DESCRIPTION` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `EMAIL_FROM` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `EMAIL_TEMPLATE_NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `EMAIL_TO` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `STATUS` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SUBJECT` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of email_audit
-- ----------------------------

-- ----------------------------
-- Table structure for `email_template_data`
-- ----------------------------
DROP TABLE IF EXISTS `email_template_data`;
CREATE TABLE `email_template_data` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `EMAIL_CONTENT` longtext COLLATE utf8_unicode_ci,
  `CUSTOMER_RID` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DESCRIPTION` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `EMAIL_TEMPLATE_NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `EMAIL_TEMPLATE_TYPE_RID` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `IS_DEFAULT` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `STATUS` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SUBJECT` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of email_template_data
-- ----------------------------
INSERT INTO `email_template_data` VALUES ('1', '<p>&nbsp;</p>\n<p>&nbsp;</p>\n<table style=\"width: 600px; margin: 0 auto; font-family: arial; background: #fff;\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td style=\"background: #fff; height: 50px; padding-left: 40px;\" align=\"left\"><img src=\"http://securends.com/images/securends-logo.png\" width=\"150\" height=\"24\" /></td>\n</tr>\n<tr>\n<td style=\"font-size: 15px; padding-top: 30px; padding-left: 40px; color: #333;\" align=\"left\">Access Review Campaign ${campaignname}</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 20px; padding-left: 40px; padding-right: 40px;\" align=\"left\">This email is auto-generated by the ${customername} SecurEnds system. It is not a security awareness training exercise.</td>\n</tr>\n<tr>\n<td style=\"font-size: 15px; padding-top: 30px; padding-left: 40px; color: #333;\" align=\"left\">Hello ${username},</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 20px; padding-left: 40px; padding-right: 40px;\" align=\"left\">This is a friendly reminder that you have one or more PENDING Access Review Campaign elections. This campaign is scheduled to end on ${campaignenddate}.</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 20px; padding-left: 40px; padding-right: 40px;\" align=\"left\">To make your final elections before the scheduled end date, please access SecurEnds at the following internal location <a style=\"color: #333;\" href=\"${url}/campaign\">${url}/campaign</a></td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 20px; padding-left: 40px;\" align=\"left\">Thank you in advance for your help and participation.</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 5px; padding-left: 40px;\" align=\"left\">${customername}</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 5px; padding-left: 40px;\" align=\"left\">IT-Security</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 10px; padding-left: 40px;\" align=\"left\">If you have any questions or concerns please contact the ${customername} IT Security team by sending an email to ${email}.</td>\n</tr>\n</tbody>\n</table>', '1', 'Mail will be sent to manager for pending Access review campaign reminder', 'Campaign Reminder', 'Campaign Reminder', null, 'Enabled', 'Pending access review campaign election remainder');
INSERT INTO `email_template_data` VALUES ('2', '<p>&nbsp;</p>\n<table style=\"width: 600px; margin: 0 auto; font-family: arial; background: #fff;\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td style=\"background: #fff; height: 50px; border-bottom: 1px solid #cacaca; padding-left: 40px;\" align=\"left\"><img src=\"http://securends.com/images/securends-logo.png\" width=\"150\" height=\"24\" /></td>\n</tr>\n<tr>\n<td style=\"font-size: 15px; padding-top: 30px; padding-left: 40px; color: #333;\" align=\"left\">Hello Team,</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 20px; padding-left: 40px; padding-right: 40px;\" align=\"left\">As part of Access Review Campaign, managers have performed user access reviews for the ${campaignname}.These review changes need to be updated in the applications.</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 20px; padding-left: 40px; padding-right: 40px;\" align=\"left\">Please create tickets for attached document(s).</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 20px; padding-left: 40px;\" align=\"left\">Thanks,</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 5px; padding-left: 40px;\" align=\"left\">${customername}</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 5px; padding-bottom: 40px; padding-left: 40px;\" align=\"left\">IT-Security</td>\n</tr>\n</tbody>\n</table>', '1', 'Mail will be sent to manager when end of the campaign', 'End of the campaign', 'End of the campaign', null, 'Enabled', 'Access Review Campaign - Ticket Request');
INSERT INTO `email_template_data` VALUES ('3', '<p>&nbsp;</p>\n<p>&nbsp;</p>\n<table style=\"width: 600px; margin: 0 auto; font-family: arial; background: #fff;\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td style=\"background: #fff; height: 50px; border-bottom: 1px solid #cacaca; padding-left: 40px;\" align=\"left\"><img src=\"http://securends.com/images/securends-logo.png\" width=\"150\" height=\"24\" /></td>\n</tr>\n<tr>\n<td style=\"font-size: 15px; padding-top: 30px; padding-left: 40px; color: #333;\" align=\"left\">Hello Team,</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 20px; padding-left: 40px; padding-right: 40px;\" align=\"left\">As part of Access Review Campaign, ${managername} have performed user access reviews. These review changes need to be updated in the applications.</td>\n</tr>\n<tr>\n<td style=\"padding-left: 40px;\" align=\"left\">\n<p style=\"margin-bottom: 5px; margin-top: 20px; width: fit-content; color: #333; border-radius: 3px; font-size: 14px;\">Campaign Name : ${campaignname}</p>\n<p style=\"margin-bottom: 5px; margin-top: 0px; width: fit-content; color: #333; font-size: 14px;\">Credential : ${credential},</p>\n<p style=\"margin-bottom: 5px; margin-top: 0px; width: fit-content; color: #333; font-size: 14px;\">${entitlement}</p>\n<p style=\"margin-bottom: 5px; margin-top: 0px; width: fit-content; color: #333; font-size: 14px;\">Action : ${action}</p>\n</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 20px; padding-left: 40px;\" align=\"left\">Thanks,</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 5px; padding-left: 40px;\" align=\"left\">${customername}</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 5px; padding-bottom: 40px; padding-left: 40px;\" align=\"left\">IT-Security</td>\n</tr>\n</tbody>\n</table>', '1', 'Mail will be sent to Manager based on election action', 'Manager Action', 'Manager Action', null, 'Enabled', 'Access Review Campaign - Ticket Request');
INSERT INTO `email_template_data` VALUES ('4', '<p>&nbsp;</p>\n<p>&nbsp;</p>\n<table style=\"width: 600px; margin: 0 auto; font-family: arial; background: #fff;\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td style=\"background: #fff; height: 50px; border-bottom: 1px solid #cacaca; padding-left: 40px;\" align=\"left\"><img src=\"http://securends.com/images/securends-logo.png\" width=\"150\" height=\"24\" /></td>\n</tr>\n<tr>\n<td style=\"font-size: 15px; padding-top: 30px; padding-left: 40px; color: #333;\" align=\"left\">Hello IT Security,</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 20px; padding-left: 40px; padding-right: 40px;\" align=\"left\">As part of Access Review campaign the following managers are identified to perform the user access reviews.</td>\n</tr>\n<tr>\n<td style=\"font-size: 15px; padding-top: 30px; padding-left: 40px; color: #333;\" align=\"left\">Campaign Name : ${campaignname}</td>\n</tr>\n<tr>\n<td style=\"font-size: 15px; padding-top: 30px; padding-left: 40px; color: #333;\" align=\"left\">Recipients List: ${recipients}</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 20px; padding-left: 40px;\" align=\"left\">Thanks,</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 5px; padding-left: 40px;\" align=\"left\">${customername}</td>\n</tr>\n</tbody>\n</table>', '1', 'Mail will be sent to IT team', 'Recipients List', 'Recipients List', null, 'Enabled', 'Access Review Campaign Recipients List');
INSERT INTO `email_template_data` VALUES ('5', '<p>&nbsp;</p>\n<p>&nbsp;</p>\n<table style=\"width: 600px; margin: 0 auto; font-family: arial; background: #fff;\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td style=\"background: #fff; height: 50px; border-bottom: 1px solid #cacaca; padding-left: 40px;\" align=\"left\"><img src=\"http://securends.com/images/securends-logo.png\" width=\"150\" height=\"24\" /></td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 20px; padding-left: 40px; padding-right: 40px;\" align=\"left\">Access Review Campaign :${campaignname}</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 20px; padding-left: 40px; padding-right: 40px;\" align=\"left\">This email is auto-generated by the SecurEnds system. It is not a security awareness training exercise.</td>\n</tr>\n<tr>\n<td style=\"font-size: 15px; padding-top: 30px; padding-left: 40px;\" align=\"left\">Hello ${username},</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 20px; padding-left: 40px; padding-right: 40px;\" align=\"left\">You have been identified as a manager of users with access to ${customername} systems or as a custodian of these systems. As a result, your participation in a Credential/Entitlement review is required.</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 20px; padding-left: 40px; padding-right: 40px;\" align=\"left\">As part of this review, you will need to review and confirm your team\'s access by performing an election (approve/revoke) on each team member\'s credentials. This campaign is scheduled to end on ${campaignenddate}</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 20px; padding-left: 40px; padding-right: 40px;\" align=\"left\">\n<p style=\"margin-bottom: 5px; margin-top: 0px; width: fit-content; font-size: 14px;\">The goals of this Access Review Campaign are to:</p>\n<div>\n<ol>\n<li style=\"padding-top: 10px;\">Identify and remove unnecessary accounts to prevent unauthorized access</li>\n<li style=\"padding-top: 10px;\">Ensure all individuals and services are properly authenticated, authorized and audited</li>\n</ol>\n</div>\n</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 20px; padding-left: 40px; padding-right: 40px;\" align=\"left\">To make your elections, please access SecurEnds at the following internal location: <a style=\"color: #333;\" href=\"${url}/openCampaigns\">${url}/openCampaigns</a></td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 20px; padding-left: 40px;\" align=\"left\">Thank you in advance for your help and participation.</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 5px; padding-left: 40px;\" align=\"left\">${customername}</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 5px; padding-left: 40px;\" align=\"left\">IT-Security</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 10px; padding-left: 40px;\" align=\"left\">If you have any questions or concerns please contact the ${customername} IT Security team by sending an email to ${email}.</td>\n</tr>\n</tbody>\n</table>', '1', 'Mail will be sent after successful campaign launch', 'Launch Campaign', 'Launch Campaign', null, 'Enabled', 'Open Access Review Campaign Notification');
INSERT INTO `email_template_data` VALUES ('6', '<p>&nbsp;</p>\n<table style=\"width: 600px; margin: 0 auto; font-family: arial !important; background: #fff;\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td style=\"background: #fff; height: 50px; border-bottom: 1px solid #cacaca; padding-left: 40px;\" align=\"left\"><img src=\"http://securends.com/images/securends-logo.png\" width=\"150\" height=\"24\" /></td>\n</tr>\n<tr>\n<td style=\"font-size: 15px; padding-top: 30px; padding-left: 40px; color: #333;\" align=\"left\">Hello ${username},</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 20px; padding-left: 40px; padding-right: 60px;\" align=\"left\">Your SecurEnds password was reset using the email address ${email} on ${currentdate}</td>\n</tr>\n<tr>\n<td style=\"padding-left: 40px;\" align=\"left\">\n<p style=\"margin-bottom: 5px; margin-top: 20px; width: fit-content; color: #333; border-radius: 3px; font-size: 14px;\">Your new password is ${password}</p>\n</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; color: #333; height: 20px; padding-left: 40px; padding-top: 5px; padding-bottom: 30px;\" align=\"left\"><a style=\"color: #006698;\" href=\"${url}/login\">Click here</a> to login to SecurEnds product with your new password.</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-left: 40px;\" align=\"left\">Thanks,</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 5px; padding-left: 40px;\" align=\"left\">${customername}</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 5px; padding-left: 40px;\" align=\"left\">IT-Security</td>\n</tr>\n</tbody>\n</table>', '1', 'Mail will be sent after successful Password reset', 'Reset Password', 'Reset Password', null, 'Enabled', 'CEM Password');
INSERT INTO `email_template_data` VALUES ('7', '<p>&nbsp;</p>\n<table style=\"width: 600px; margin: 0 auto; font-family: arial; background: #fff;\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td style=\"background: #fff; height: 50px; padding-left: 40px;\" align=\"left\"><img src=\"http://securends.com/images/securends-logo.png\" alt=\"logo\" width=\"150\" height=\"24\" /></td>\n</tr>\n<tr>\n<td style=\"font-size: 15px; padding-top: 30px; padding-left: 40px; color: #333;\" align=\"left\">Hello ${managername}</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 20px; padding-left: 40px; padding-right: 40px;\" align=\"left\">A request has been created for your approval for the following application.</td>\n</tr>\n<tr>\n<td style=\"padding-left: 40px;\" align=\"left\">\n<p style=\"margin-bottom: 5px; margin-top: 20px; width: fit-content; color: #333; border-radius: 3px; font-size: 14px;\">User Name : ${username}</p>\n<p style=\"margin-bottom: 5px; margin-top: 0px; width: fit-content; color: #333; font-size: 14px;\">Application Name : ${applicationname}</p>\n<p style=\"margin-bottom: 5px; margin-top: 0px; width: fit-content; color: #333; font-size: 14px;\">${groupsorschemas}</p>\n<p style=\"margin-bottom: 5px; margin-top: 0px; width: fit-content; color: #333; font-size: 14px;\">${roles}</p>\n<p style=\"margin-bottom: 5px; margin-top: 0px; width: fit-content; color: #333; font-size: 14px;\">${license}</p>\n<p style=\"margin-bottom: 5px; margin-top: 0px; width: fit-content; color: #333; font-size: 14px;\">${action}</p>\n<p style=\"margin-bottom: 5px; margin-top: 20px; width: fit-content; color: #333; font-size: 14px;\">To approve or reject this request, please click on the following link.</p>\n<p style=\"margin-bottom: 5px; margin-top: 0px; width: fit-content; color: #333; font-size: 14px;\"><a style=\"color: #333;\" href=\"${url}\" target=\"_blank\" rel=\"noopener noreferrer\" data-auth=\"NotApplicable\">${url}</a></p>\n</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 20px; padding-left: 40px;\" align=\"left\">Thanks,</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 5px; padding-left: 40px;\" align=\"left\">${customername}</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 5px; padding-left: 40px;\" align=\"left\">IT-Security</td>\n</tr>\n</tbody>\n</table>', '1', 'Mail will be sent for Managers approval', 'Access Management', 'Access Management', null, 'Enabled', 'Access Management Approval');
INSERT INTO `email_template_data` VALUES ('8', '<p>&nbsp;</p>\n<p>&nbsp;</p>\n<table style=\"width: 600px; margin: 0 auto; font-family: arial; background: #fff;\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td style=\"background: #fff; height: 50px; border-bottom: 1px solid #cacaca; padding-left: 40px;\" align=\"left\"><img src=\"http://securends.com/images/securends-logo.png\" alt=\"logo\" width=\"150\" height=\"24\" /></td>\n</tr>\n<tr>\n<td style=\"font-size: 15px; padding-top: 30px; padding-left: 40px; color: #333;\" align=\"left\">Hello IT Security,</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 20px; padding-left: 40px; padding-right: 40px;\" align=\"left\">The Email Template has been sent to Launch/ Re-Launch.</td>\n</tr>\n<tr>\n<td style=\"font-size: 15px; padding-top: 30px; padding-left: 40px; color: #333;\" align=\"left\">Campaign Name : ${campaignname}</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 20px; padding-left: 40px;\" align=\"left\">Thanks,</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 5px; padding-left: 40px;\" align=\"left\">${customername}</td>\n</tr>\n</tbody>\n</table>', '1', 'Mail will be sent after Campaign launch or relaunch', 'Campaign Launch And Relaunch Email To IT', 'Campaign Launch And Relaunch Email To IT', null, 'Enabled', 'Launch/ Re-Launch Access Review Campaign Notification');
INSERT INTO `email_template_data` VALUES ('9', '<p>&nbsp;</p>\n<p>&nbsp;</p>\n<table style=\"width: 600px; margin: 0 auto; font-family: arial; background: #fff;\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td style=\"background: #fff; height: 50px; border-bottom: 1px solid #cacaca; padding-left: 40px;\" align=\"left\"><img src=\"http://securends.com/images/securends-logo.png\" width=\"150\" height=\"24\" /></td>\n</tr>\n<tr>\n<td style=\"font-size: 15px; padding-top: 30px; padding-left: 40px; color: #333;\" align=\"left\">Hello IT Security,</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 20px; padding-left: 40px; padding-right: 40px;\" align=\"left\">The Email Template has been sent to Pending Remainder.</td>\n</tr>\n<tr>\n<td style=\"font-size: 15px; padding-top: 30px; padding-left: 40px; color: #333;\" align=\"left\">Campaign Name : ${campaignname}</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 20px; padding-left: 40px;\" align=\"left\">Thanks,</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 5px; padding-left: 40px;\" align=\"left\">${customername}</td>\n</tr>\n</tbody>\n</table>', '1', 'Mail will be sent to IT team for campaign reminder', 'Campaign Reminder For IT Team', 'Campaign Reminder For IT Team', null, 'Enabled', 'Pending Access Review Campaign Remainder');
INSERT INTO `email_template_data` VALUES ('11', '<p>&nbsp;</p>\n<table style=\"width: 600px; margin: 0 auto; font-family: arial; background: #fff;\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td style=\"background: #fff; height: 50px; padding-left: 40px;\" align=\"left\"><img src=\"http://securends.com/images/securends-logo.png\" width=\"150\" height=\"24\" /></td>\n</tr>\n<tr>\n<td style=\"font-size: 15px; padding-top: 30px; padding-left: 40px; color: #333;\" align=\"left\">Hello ${name}</td>\n</tr>\n<tr>\n<td style=\"font-size: 15px; padding-top: 30px; padding-left: 40px; color: #333;\" align=\"left\">Reminder Email !!</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 20px; padding-left: 40px; padding-right: 40px;\" align=\"left\">A request has been created for your approval for the following application.</td>\n</tr>\n<tr>\n<td style=\"padding-left: 40px;\" align=\"left\">\n<p style=\"margin-bottom: 5px; margin-top: 20px; width: fit-content; color: #333; border-radius: 3px; font-size: 14px;\">User Name : ${username}</p>\n<p style=\"margin-bottom: 5px; margin-top: 0px; width: fit-content; color: #333; font-size: 14px;\">Application Name : ${applicationname}</p>\n<p style=\"margin-bottom: 5px; margin-top: 0px; width: fit-content; color: #333; font-size: 14px;\">${groupsorschemas}</p>\n<p style=\"margin-bottom: 5px; margin-top: 0px; width: fit-content; color: #333; font-size: 14px;\">${roles}</p>\n<p style=\"margin-bottom: 5px; margin-top: 0px; width: fit-content; color: #333; font-size: 14px;\">${license}</p>\n<p style=\"margin-bottom: 5px; margin-top: 0px; width: fit-content; color: #333; font-size: 14px;\">${action}</p>\n<p style=\"margin-bottom: 5px; margin-top: 20px; width: fit-content; color: #333; font-size: 14px;\">To approve or reject this request, please click on the following link.</p>\n<p style=\"margin-bottom: 5px; margin-top: 0px; width: fit-content; color: #333; font-size: 14px;\"><a style=\"color: #333;\" href=\"${url}\" target=\"_blank\" rel=\"noopener noreferrer\" data-auth=\"NotApplicable\">${url}</a></p>\n</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 20px; padding-left: 40px;\" align=\"left\">Thanks,</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 5px; padding-left: 40px;\" align=\"left\">${customername}</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 5px; padding-left: 40px;\" align=\"left\">IT-Security</td>\n</tr>\n</tbody>\n</table>', '1', 'Mail will be sent after escalation days period completes', 'Escalation Mail', 'Escalation Mail', null, 'Enabled', 'Reminder: Access Management Approval');
INSERT INTO `email_template_data` VALUES ('12', '<p>&nbsp;</p>\n<table style=\"width: 600px; margin: 0 auto; font-family: arial !important; background: #fff;\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td style=\"background: #fff; height: 50px; border-bottom: 1px solid #cacaca; padding-left: 40px;\" align=\"left\"><img src=\"http://securends.com/images/securends-logo.png\" alt=\"\" width=\"150\" height=\"24\" /></td>\n</tr>\n<tr>\n<td style=\"font-size: 15px; padding-top: 30px; padding-left: 40px; color: #333;\" align=\"left\">Hello ${name}</td>\n</tr>\n<tr>\n<td style=\"font-size: 15px; padding-top: 30px; padding-left: 40px; color: #333;\" align=\"left\">This is your one time password&nbsp; for login : ${otp}</td>\n</tr>\n<tr>\n<td style=\"padding-left: 40px;\" align=\"left\">\n<p style=\"margin-bottom: 5px; margin-top: 20px; width: fit-content; color: #333; border-radius: 3px; font-size: 14px;\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-left: 40px;\" align=\"left\">Thanks,</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-left: 40px;\" align=\"left\">${customername}</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 5px; padding-left: 40px;\" align=\"left\">IT-Security</td>\n</tr>\n</tbody>\n</table>', '1', 'One-time Password', '2-Factor Authentication', '2-Factor Authentication', null, 'Enabled', 'One-time Password');
INSERT INTO `email_template_data` VALUES ('13', '<p>&nbsp;</p>\n<table style=\"width: 600px; margin: 0 auto; font-family: arial !important; background: #fff;\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td style=\"background: #fff; height: 50px; border-bottom: 1px solid #cacaca; padding-left: 40px;\" align=\"left\"><img src=\"http://securends.com/images/securends-logo.png\" width=\"150\" height=\"24\" /></td>\n</tr>\n<tr>\n<td style=\"font-size: 15px; padding-top: 30px; padding-left: 40px; color: #333;\" align=\"left\">Hi IT Security,</td>\n</tr>\n<tr>\n<td style=\"font-size: 15px; padding-top: 30px; padding-left: 40px; color: #333;\" align=\"left\">\n<p>The Email Template has been sent to notify update manager of the user ${username}.</p>\n<p>Campaign Name : ${campaignname}</p>\n<p>Comments: ${comments}</p>\n</td>\n</tr>\n<tr>\n<td style=\"padding-left: 40px;\" align=\"left\">\n<p>&nbsp;</p>\n<p><span style=\"font-size: 14px;\">Thanks,</span></p>\n<p><span style=\"font-size: 14px;\">${customername}</span></p>\n<p><span style=\"color: #333333; font-size: 15px;\">IT Security,</span></p>\n</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-left: 40px;\" align=\"left\">&nbsp;</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-left: 40px;\" align=\"left\">&nbsp;</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 5px; padding-left: 40px;\" align=\"left\">&nbsp;</td>\n</tr>\n</tbody>\n</table>', '1', 'Notification will be sent when manager gets update', 'Notify Update Manager', 'Notify Update Manager', null, 'Enabled', 'Update Manager Notification');
INSERT INTO `email_template_data` VALUES ('14', '<p>&nbsp;</p>\n<table style=\"width: 600px; margin: 0 auto; font-family: arial !important; background: #fff;\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td style=\"background: #fff; height: 50px; border-bottom: 1px solid #cacaca; padding-left: 40px;\" align=\"left\"><img src=\"http://securends.com/images/securends-logo.png\" width=\"150\" height=\"24\" /></td>\n</tr>\n<tr>\n<td style=\"font-size: 15px; padding-top: 30px; padding-left: 40px; color: #333;\" align=\"left\">Hi IT Security,</td>\n</tr>\n<tr>\n<td style=\"font-size: 15px; padding-top: 30px; padding-left: 40px; color: #333;\" align=\"left\">\n<p><span style=\"color: #000000; font-size: 14px;\">The Email Template has been sent to notify terminated date of the user ${username}</span></p>\n<p>Campaign Name : ${campaignname}</p>\n<p>Termination Date:${terminationDate}</p>\n</td>\n</tr>\n<tr>\n<td style=\"padding-left: 40px;\" align=\"left\">\n<p style=\"margin-bottom: 5px; margin-top: 20px; width: fit-content; color: #333; border-radius: 3px; font-size: 14px;\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-left: 40px;\" align=\"left\">\n<p>Thanks,</p>\n<p>${customername}</p>\n<p>IT-Security</p>\n</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-left: 40px;\" align=\"left\">&nbsp;</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 5px; padding-left: 40px;\" align=\"left\">&nbsp;</td>\n</tr>\n</tbody>\n</table>', '1', 'Mail will be sent to notify terminated date', 'Notify Terminated Date', 'Notify Terminated Date', null, 'Enabled', 'Notify Terminated Date');
INSERT INTO `email_template_data` VALUES ('15', '<table style=\"width: 600px; margin: 0 auto; font-family: arial; background: #fff;\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td style=\"background: #fff; height: 50px; padding-left: 40px;\" align=\"left\"><img src=\"http://securends.com/images/securends-logo.png\" width=\"150\" height=\"24\" /></td>\n</tr>\n<tr>\n<td style=\"font-size: 15px; padding-top: 30px; padding-left: 40px; color: #333;\" align=\"left\">Hello ${name}</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 20px; padding-left: 40px; padding-right: 40px;\" align=\"left\">Your Request for access to ${applicationname} Has been ${manageraction} by ${managername}.</td>\n</tr>\n<tr>\n<td style=\"padding-left: 40px;\" align=\"left\">\n<p style=\"margin-bottom: 5px; margin-top: 0px; width: fit-content; color: #333; font-size: 14px;\">&nbsp;</p>\n<p style=\"margin-bottom: 5px; margin-top: 0px; width: fit-content; color: #333; font-size: 14px;\">${groupsorschemas}</p>\n<p style=\"margin-bottom: 5px; margin-top: 0px; width: fit-content; color: #333; font-size: 14px;\">${roles}</p>\n</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 20px; padding-left: 40px; padding-right: 40px;\" align=\"left\">${message}.</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 20px; padding-left: 40px; padding-right: 40px;\" align=\"left\">To view your application approval History, please click on the following link..\n<p style=\"margin-bottom: 5px; margin-top: 0px; width: fit-content; color: #333; font-size: 14px;\"><a style=\"color: #333;\" href=\"${url}\" target=\"_blank\" rel=\"noopener noreferrer\" data-auth=\"NotApplicable\">${url}</a></p>\n</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 20px; padding-left: 40px;\" align=\"left\">Thanks,</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 5px; padding-left: 40px;\" align=\"left\">${customername}</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 5px; padding-left: 40px;\" align=\"left\">IT-Security</td>\n</tr>\n</tbody>\n</table>', '1', 'Mail will be sent after managers action on user request', 'User Request Status ', 'User Request Status', null, 'Enabled', 'Application Request Access Status ');
INSERT INTO `email_template_data` VALUES ('16', '<p>&nbsp;</p>\n<table style=\"width: 600px; margin: 0 auto; font-family: arial; background: #fff;\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td style=\"background: #fff; height: 50px; border-bottom: 1px solid #cacaca; padding-left: 40px;\" align=\"left\"><img src=\"http://securends.com/images/securends-logo.png\" width=\"150\" height=\"24\" /></td>\n</tr>\n<tr>\n<td style=\"font-size: 15px; padding-top: 30px; padding-left: 40px; color: #333;\" align=\"left\">Hello Team,</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 20px; padding-left: 40px; padding-right: 40px;\" align=\"left\">As part of to get Request Access for any endpoint, request has to be reviewed and&nbsp; must provide approval from the hierarchy for provisioning and deprovisioning</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 20px; padding-left: 40px; padding-right: 40px;\" align=\"left\">\n<p>Please do changes as mentioned in the below in application.</p>\n<p style=\"margin-bottom: 5px; margin-top: 20px; width: fit-content; color: #333; border-radius: 3px; font-size: 14px;\">User Name : ${username}</p>\n<p style=\"margin-bottom: 5px; margin-top: 0px; width: fit-content; color: #333; font-size: 14px;\">Application Name : ${applicationname}</p>\n<p style=\"margin-bottom: 5px; margin-top: 0px; width: fit-content; color: #333; font-size: 14px;\">${groupsorschemas}</p>\n<p style=\"margin-bottom: 5px; margin-top: 0px; width: fit-content; color: #333; font-size: 14px;\">${roles}</p>\n<p style=\"margin-bottom: 5px; margin-top: 0px; width: fit-content; color: #333; font-size: 14px;\">${license}</p>\n<p style=\"margin-bottom: 5px; margin-top: 0px; width: fit-content; color: #333; font-size: 14px;\">${action}</p>\n<p style=\"margin-bottom: 5px; margin-top: 0px; width: fit-content; color: #333; font-size: 14px;\">${timezone}</p>\n</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 20px; padding-left: 40px;\" align=\"left\">Thanks,</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 5px; padding-left: 40px;\" align=\"left\">${customername}</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 5px; padding-bottom: 40px; padding-left: 40px;\" align=\"left\">IT-Security</td>\n</tr>\n</tbody>\n</table>', '1', 'Mail will be sent to IT team when end of the approval hierarchy', 'Hierarchy Approval', 'Hierarchy Approval', null, 'Enabled', 'Request Access For Endpoint - Ticket Request');
INSERT INTO `email_template_data` VALUES ('17', '<p>&nbsp;</p>\n<table style=\"width: 600px; margin: 0 auto; font-family: arial !important; background: #fff;\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td style=\"background: #fff; height: 50px; border-bottom: 1px solid #cacaca; padding-left: 40px;\" align=\"left\"><img src=\"http://securends.com/images/securends-logo.png\" alt=\"\" width=\"150\" height=\"24\" /></td>\n</tr>\n<tr>\n<td style=\"font-size: 15px; padding-top: 30px; padding-left: 40px; color: #333;\" align=\"left\">Email Successfully Sent</td>\n</tr>\n<tr>\n<td style=\"padding-left: 40px;\" align=\"left\">\n<p style=\"margin-bottom: 5px; margin-top: 20px; width: fit-content; color: #333; border-radius: 3px; font-size: 14px;\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-left: 40px;\" align=\"left\">Thanks,</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-left: 40px;\" align=\"left\">${customername}</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 5px; padding-left: 40px;\" align=\"left\">IT-Security</td>\n</tr>\n</tbody>\n</table>', '1', 'Mail will be sent if email connection successful', 'Test Email Connection', 'Test Email Connection', null, 'Enabled', 'Email Connection Test');
INSERT INTO `email_template_data` VALUES ('18', '<p>&nbsp;</p>\n<table style=\"width: 600px; margin: 0px auto; background: #ffffff; font-family: arial !important; height: 187px;\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr style=\"height: 50px;\">\n<td style=\"background: #ffffff; height: 50px; border-bottom: 1px solid #cacaca; padding-left: 40px; width: 551.609px;\" align=\"left\"><img src=\"http://securends.com/images/securends-logo.png\" width=\"150\" height=\"24\" /></td>\n</tr>\n<tr style=\"height: 20px;\">\n<td style=\"font-size: 15px; padding-top: 30px; padding-left: 40px; color: #333333; height: 20px; width: 551.609px;\" align=\"left\">Hello ${name}</td>\n</tr>\n<tr style=\"height: 20px;\">\n<td style=\"font-size: 15px; padding-top: 30px; padding-left: 40px; color: #333333; height: 20px; width: 551.609px;\" align=\"left\">\n<p>Click the link below to sign in to your account. <br />This link will expire in 15 minutes and can only be used once.</p>\n<p><a style=\"color: white; font-size: 14px; font-weight: 400; font-style: normal; background-color: #03a87c; display: inline-block; height: 36px; text-decoration: none; white-space: nowrap; border-radius: 4px; margin-top: 25px; margin-bottom: 25px; text-align: center; padding: 7px; border-width: 0; outline: 0; line-height: 40px;\" title=\"\" href=\"${url}\">Sign in to SecurEnds</a></p>\n<p>If the button above doesn&rsquo;t work, paste this link into your web browser: <br /><a title=\"${url}\" href=\"${url}\">${url}</a></p>\n</td>\n</tr>\n<tr style=\"height: 43px;\">\n<td style=\"padding-left: 40px; height: 43px; width: 551.609px;\" align=\"left\">\n<p style=\"margin-bottom: 5px; margin-top: 20px; width: fit-content; color: #333; border-radius: 3px; font-size: 14px;\">&nbsp;</p>\n</td>\n</tr>\n<tr style=\"height: 18px;\">\n<td style=\"font-size: 14px; padding-left: 40px; height: 18px; width: 551.609px;\" align=\"left\">Thanks,</td>\n</tr>\n<tr style=\"height: 18px;\">\n<td style=\"font-size: 14px; padding-left: 40px; height: 18px; width: 551.609px;\" align=\"left\">${customername}</td>\n</tr>\n<tr style=\"height: 18px;\">\n<td style=\"font-size: 14px; padding-top: 5px; padding-left: 40px; height: 18px; width: 551.609px;\" align=\"left\">IT-Security</td>\n</tr>\n</tbody>\n</table>', '1', 'Login Account Url', 'Email Login', 'Email Login', null, 'Enabled', 'Login your Account');
INSERT INTO `email_template_data` VALUES ('19', '<p>&nbsp;</p>\n<table style=\"width: 600px; margin: 0 auto; font-family: arial !important; background: #fff;\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td style=\"background: #fff; height: 50px; border-bottom: 1px solid #cacaca; padding-left: 40px;\" align=\"left\"><img src=\"http://securends.com/images/securends-logo.png\" alt=\"\" width=\"150\" height=\"24\" /></td>\n</tr>\n<tr>\n<td style=\"font-size: 15px; padding-top: 30px; padding-left: 40px; color: #333;\" align=\"left\">Hello ${name},</td>\n</tr>\n<tr>\n<td style=\"padding-left: 40px;\" align=\"left\">\n<p style=\"margin-bottom: 5px; margin-top: 20px; width: fit-content; color: #333; border-radius: 3px; font-size: 14px;\">Principal Name : ${principalname}</p>\n<p style=\"margin-bottom: 5px; margin-top: 0px; width: fit-content; color: #333; font-size: 14px;\">Delegate Name : ${delegatename}</p>\n</td>\n</tr>\n<tr>\n<td style=\"padding-left: 40px;\" align=\"left\">\n<p style=\"margin-bottom: 5px; margin-top: 20px; width: fit-content; color: #333; border-radius: 3px; font-size: 14px;\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-left: 40px;\" align=\"left\">Thanks,</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-left: 40px;\" align=\"left\">${customername}</td>\n</tr>\n<tr>\n<td style=\"font-size: 14px; padding-top: 5px; padding-left: 40px;\" align=\"left\">IT-Security</td>\n</tr>\n</tbody>\n</table>', '1', 'Mail will be sent to Principal when delegation happens', 'Delegation Email', 'Delegation Email', null, 'Enabled', 'Delegation Email');
INSERT INTO `email_template_data` VALUES ('20', '<p>&nbsp;</p> <p>&nbsp;</p> <table style=\"width: 600px; margin: 0 auto; font-family: arial; background: #fff;\" cellspacing=\"0\" cellpadding=\"0\"> <tbody> <tr> <td style=\"background: #fff; height: 50px; border-bottom: 1px solid #cacaca; padding-left: 40px;\" align=\"left\"><img src=\"http://securends.com/images/securends-logo.png\" width=\"150\" height=\"24\" /></td> </tr> <tr> <td style=\"font-size: 15px; padding-top: 30px; padding-left: 40px; color: #333;\" align=\"left\">Hello Team,</td> </tr> <tr> <td style=\"font-size: 14px; padding-top: 20px; padding-left: 40px; padding-right: 40px;\" align=\"left\">As part of Access Review Campaign, ${managername} have performed user access reviews. These review changes need to be updated in the applications.</td> </tr> <tr> <td style=\"padding-left: 40px;\" align=\"left\"> <p style=\"margin-bottom: 5px; margin-top: 20px; width: fit-content; color: #333; border-radius: 3px; font-size: 14px;\">Campaign Name : ${campaignname}</p> <p style=\"margin-bottom: 5px; margin-top: 0px; width: fit-content; color: #333; font-size: 14px;\">All Elections under ${managername} are Approved </p> </td> </tr> <tr> <td style=\"font-size: 14px; padding-top: 20px; padding-left: 40px;\" align=\"left\">Thanks,</td> </tr> <tr> <td style=\"font-size: 14px; padding-top: 5px; padding-left: 40px;\" align=\"left\">${customername}</td> </tr> <tr> <td style=\"font-size: 14px; padding-top: 5px; padding-bottom: 40px; padding-left: 40px;\" align=\"left\">IT-Security</td> </tr> </tbody> </table>', '1', 'Mail will be sent to Manager based on election action', 'Manager Approve All', 'Manager Approve All', null, 'Enabled', 'Access Review Campaign - Ticket Request');

-- ----------------------------
-- Table structure for `email_template_type`
-- ----------------------------
DROP TABLE IF EXISTS `email_template_type`;
CREATE TABLE `email_template_type` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `EMAIL_TYPE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of email_template_type
-- ----------------------------
INSERT INTO `email_template_type` VALUES ('1', 'Campaign Reminder');
INSERT INTO `email_template_type` VALUES ('2', 'End of the campaign');
INSERT INTO `email_template_type` VALUES ('3', 'Campaign Reminder For IT Team');
INSERT INTO `email_template_type` VALUES ('4', 'Manager Action');
INSERT INTO `email_template_type` VALUES ('5', 'Recipients List');
INSERT INTO `email_template_type` VALUES ('6', 'Launch Campaign');
INSERT INTO `email_template_type` VALUES ('7', 'Reset Password');
INSERT INTO `email_template_type` VALUES ('8', 'Access Management');
INSERT INTO `email_template_type` VALUES ('9', 'Campaign Launch And Relaunch Email To IT');
INSERT INTO `email_template_type` VALUES ('10', 'Hierarchy Approval');
INSERT INTO `email_template_type` VALUES ('11', 'Escalation Mail');
INSERT INTO `email_template_type` VALUES ('12', '2-Factor Authentication');
INSERT INTO `email_template_type` VALUES ('13', 'Notify Update Manager');
INSERT INTO `email_template_type` VALUES ('14', 'Notify Terminated Date');
INSERT INTO `email_template_type` VALUES ('15', 'User Request Status');
INSERT INTO `email_template_type` VALUES ('16', 'Test Email Connection');
INSERT INTO `email_template_type` VALUES ('17', 'Delegation Email');
INSERT INTO `email_template_type` VALUES ('18', 'Email Login');
INSERT INTO `email_template_type` VALUES ('19', 'Manager Approve All');

-- ----------------------------
-- Table structure for `endpoint_approval`
-- ----------------------------
DROP TABLE IF EXISTS `endpoint_approval`;
CREATE TABLE `endpoint_approval` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `APPROVER_EMAIL` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `APPROVER_TYPE` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATED_DATE` datetime DEFAULT NULL,
  `END_POINT_NAME` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `UPDATED_DATE` datetime DEFAULT NULL,
  `USER_ID` bigint(20) DEFAULT NULL,
  `ESCALATION_DAYS` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TICKET_GEN_TYPE` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TO_EMAIL` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CUSTOMER_RID` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of endpoint_approval
-- ----------------------------

-- ----------------------------
-- Table structure for `endpoint_approval_audit_log`
-- ----------------------------
DROP TABLE IF EXISTS `endpoint_approval_audit_log`;
CREATE TABLE `endpoint_approval_audit_log` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `AGENT_TYPE` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `APPROVE_STATUS` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `APPROVER_Id` bigint(20) DEFAULT NULL,
  `CREATED_TS` datetime DEFAULT NULL,
  `END_POINT_NAME` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `GROUPS` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `MANAGER_EMAIL_ID` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `RECJECTION_COMMENT` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ROLES` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TICKET_ID` bigint(20) DEFAULT NULL,
  `UPDATED_DATE` datetime DEFAULT NULL,
  `USER_EMAIL_ID` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID` bigint(20) DEFAULT NULL,
  `REQUEST_ID` bigint(20) DEFAULT NULL,
  `REQUESTER` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ACTION_TAKEN_BY_USER_EMAIL` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TICKET_NO` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `APP_STATUS` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `IS_MANAGER_UPDATED` char(1) COLLATE utf8_bin DEFAULT NULL,
  `USER_NAME` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PENDING_APPROVAL_PARAMETER_RID` bigint(20) DEFAULT NULL,
  `EVENT_NAME` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `IS_ABAC_REQ` bit(1) DEFAULT NULL,
  `POLICY_NAME` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CUSTOMER_ID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`),
  KEY `FK1gl08rrwnyh4r7k305g7db7sd` (`PENDING_APPROVAL_PARAMETER_RID`),
  CONSTRAINT `FK1gl08rrwnyh4r7k305g7db7sd` FOREIGN KEY (`PENDING_APPROVAL_PARAMETER_RID`) REFERENCES `pending_approval_parameter` (`ROW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of endpoint_approval_audit_log
-- ----------------------------

-- ----------------------------
-- Table structure for `endpoint_config_attributes`
-- ----------------------------
DROP TABLE IF EXISTS `endpoint_config_attributes`;
CREATE TABLE `endpoint_config_attributes` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `CONFIG_ATTRIBUTES` longtext COLLATE utf8_unicode_ci,
  `ENDPOINT_TYPE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SUB_TYPE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of endpoint_config_attributes
-- ----------------------------
INSERT INTO `endpoint_config_attributes` VALUES ('1', '{\"Distinguished Name Column ID\":true,\"Common Name Column ID\":true,\"First Name Column ID\":true,\"Middle Name Column ID\":true,\"Last Name Column ID\":true,\"Manager DN Column ID\":true,\"Email Column ID\":true,\"Entitlement DN Column ID\":true,\"Entitlement CN Column ID\":true,\"Entitlement Description Column ID\":true,\"Last Authentication Column ID\":true,\"Last Authentication Format Column ID\":false,\"Status\":true,\"Credential Created Date\":true,\"Entitlement Created Date\":true,\"User Id\":true}', 'AD', 'CSV');
INSERT INTO `endpoint_config_attributes` VALUES ('2', '{\"Global Catalog Url\":true,\"Directory Url\":true,\"AD Username\":true,\"AD Password\":true,\"User Filter\":true,\"Group Filter\":true,\"Active Users Filter\":false}', 'AD', 'AUTOMATIC');
INSERT INTO `endpoint_config_attributes` VALUES ('3', '{\"Office365 Tenent Id\":true,\"Office365 Client Secret\":true,\"Office365 Client Id\":true}', 'OFFICE365', 'AUTOMATIC');
INSERT INTO `endpoint_config_attributes` VALUES ('5', '{\"Salesforce Username\":true,\"Salesforce Password\":true,\"Salesforce Client Id\":true,\"Salesforce Client Secret\":true,\"Salesforce Security Token\":true,\"Salesforce Login Url\":true}', 'SALESFORCE', 'AUTOMATIC');
INSERT INTO `endpoint_config_attributes` VALUES ('7', '{\"Google Drive Application Name\":true,\"Google Drive Client JSON\":true}', 'GOOGLE DRIVE', 'AUTOMATIC');
INSERT INTO `endpoint_config_attributes` VALUES ('9', '{\"SAP Username\":true,\"SAP Password\":true,\"SAP Login URL\":true}', 'SAP', 'AUTOMATIC');
INSERT INTO `endpoint_config_attributes` VALUES ('10', '{\"Share Point Domain\":true,\"Share Point Username\":true,\"Share Point Password\":true}', 'SHAREPOINT', 'AUTOMATIC');
INSERT INTO `endpoint_config_attributes` VALUES ('11', '{\"Windows Sharefolder Dir\":true,\"Folder paths\":true,\"User Name\":true,\"Password\":true,\"Domain\":true,\"Active Directory Url\":true, \"AD Username\":true, \"AD Password\":true,\"Fetch Type\":true}', 'WINDOWS SHARE', 'AUTOMATIC');
INSERT INTO `endpoint_config_attributes` VALUES ('12', '{\"Jira Domain\":true,\"Jira Username\":true,\"Jira API Token\":true}', 'JIRA', 'AUTOMATIC');
INSERT INTO `endpoint_config_attributes` VALUES ('13', '{\"Confluence Domain\":true,\"Confluence Username\":true,\"Confluence API Token\":true}', 'CONFLUENCE', 'AUTOMATIC');
INSERT INTO `endpoint_config_attributes` VALUES ('15', '{\"Distinguished Name Column ID\":true,\"Common Name Column ID\":true,\"First Name Column ID\":true,\"Middle Name Column ID\":true,\"Last Name Column ID\":true,\"Manager DN Column ID\":true,\"Email Column ID\":true,\"Entitlement DN Column ID\":true,\"Entitlement CN Column ID\":true,\"Entitlement Description Column ID\":true,\"Last Authentication Column ID\":true,\"Last Authentication Format Column ID\":false,\"Status\":true,\"Credential Created Date\":true,\"Entitlement Created Date\":true,\"User Id\":true}', 'OFFICE365', 'CSV');
INSERT INTO `endpoint_config_attributes` VALUES ('16', '{\"Distinguished Name Column ID\":true,\"Common Name Column ID\":true,\"First Name Column ID\":true,\"Middle Name Column ID\":true,\"Last Name Column ID\":true,\"Manager DN Column ID\":true,\"Email Column ID\":true,\"Entitlement DN Column ID\":true,\"Entitlement CN Column ID\":true,\"Entitlement Description Column ID\":true,\"Last Authentication Column ID\":true,\"Last Authentication Format Column ID\":false,\"Status\":true,\"Credential Created Date\":true,\"Entitlement Created Date\":true,\"User Id\":true}', 'AWS', 'CSV');
INSERT INTO `endpoint_config_attributes` VALUES ('17', '{\"Distinguished Name Column ID\":true,\"Common Name Column ID\":true,\"First Name Column ID\":true,\"Middle Name Column ID\":true,\"Last Name Column ID\":true,\"Manager DN Column ID\":true,\"Email Column ID\":true,\"Entitlement DN Column ID\":true,\"Entitlement CN Column ID\":true,\"Entitlement Description Column ID\":true,\"Last Authentication Column ID\":true,\"Last Authentication Format Column ID\":false,\"Status\":true,\"Credential Created Date\":true,\"Entitlement Created Date\":true,\"User Id\":true}', 'DB', 'CSV');
INSERT INTO `endpoint_config_attributes` VALUES ('18', '{\"Distinguished Name Column ID\":true,\"Common Name Column ID\":true,\"First Name Column ID\":true,\"Middle Name Column ID\":true,\"Last Name Column ID\":true,\"Manager DN Column ID\":true,\"Email Column ID\":true,\"Entitlement DN Column ID\":true,\"Entitlement CN Column ID\":true,\"Entitlement Description Column ID\":true,\"Last Authentication Column ID\":true,\"Last Authentication Format Column ID\":false,\"Status\":true,\"Credential Created Date\":true,\"Entitlement Created Date\":true,\"User Id\":true}', 'DROPBOX', 'CSV');
INSERT INTO `endpoint_config_attributes` VALUES ('19', '{\"Distinguished Name Column ID\":true,\"Common Name Column ID\":true,\"First Name Column ID\":true,\"Middle Name Column ID\":true,\"Last Name Column ID\":true,\"Manager DN Column ID\":true,\"Email Column ID\":true,\"Entitlement DN Column ID\":true,\"Entitlement CN Column ID\":true,\"Entitlement Description Column ID\":true,\"Last Authentication Column ID\":true,\"Last Authentication Format Column ID\":false,\"Status\":true,\"Credential Created Date\":true,\"Entitlement Created Date\":true,\"User Id\":true}', 'GITHUB', 'CSV');
INSERT INTO `endpoint_config_attributes` VALUES ('20', '{\"Distinguished Name Column ID\":true,\"Common Name Column ID\":true,\"First Name Column ID\":true,\"Middle Name Column ID\":true,\"Last Name Column ID\":true,\"Manager DN Column ID\":true,\"Email Column ID\":true,\"Entitlement DN Column ID\":true,\"Entitlement CN Column ID\":true,\"Entitlement Description Column ID\":true,\"Last Authentication Column ID\":true,\"Last Authentication Format Column ID\":false,\"Status\":true,\"Credential Created Date\":true,\"Entitlement Created Date\":true,\"User Id\":true}', 'GOOGLE DRIVE', 'CSV');
INSERT INTO `endpoint_config_attributes` VALUES ('21', '{\"Distinguished Name Column ID\":true,\"Common Name Column ID\":true,\"First Name Column ID\":true,\"Middle Name Column ID\":true,\"Last Name Column ID\":true,\"Manager DN Column ID\":true,\"Email Column ID\":true,\"Entitlement DN Column ID\":true,\"Entitlement CN Column ID\":true,\"Entitlement Description Column ID\":true,\"Last Authentication Column ID\":true,\"Last Authentication Format Column ID\":false,\"Status\":true,\"Credential Created Date\":true,\"Entitlement Created Date\":true,\"User Id\":true}', 'SALESFORCE', 'CSV');
INSERT INTO `endpoint_config_attributes` VALUES ('22', '{\"Distinguished Name Column ID\":true,\"Common Name Column ID\":true,\"First Name Column ID\":true,\"Middle Name Column ID\":true,\"Last Name Column ID\":true,\"Manager DN Column ID\":true,\"Email Column ID\":true,\"Entitlement DN Column ID\":true,\"Entitlement CN Column ID\":true,\"Entitlement Description Column ID\":true,\"Last Authentication Column ID\":true,\"Last Authentication Format Column ID\":false,\"Status\":true,\"Credential Created Date\":true,\"Entitlement Created Date\":true,\"User Id\":true}', 'SAP', 'CSV');
INSERT INTO `endpoint_config_attributes` VALUES ('24', '{\"Distinguished Name Column ID\":true,\"Common Name Column ID\":true,\"First Name Column ID\":true,\"Middle Name Column ID\":true,\"Last Name Column ID\":true,\"Manager DN Column ID\":true,\"Email Column ID\":true,\"Entitlement DN Column ID\":true,\"Entitlement CN Column ID\":true,\"Entitlement Description Column ID\":true,\"Last Authentication Column ID\":true,\"Last Authentication Format Column ID\":false,\"Status\":true,\"Credential Created Date\":true,\"Entitlement Created Date\":true,\"User Id\":false,\"User Id\":true}', 'WINDOWS SHARE', 'CSV');
INSERT INTO `endpoint_config_attributes` VALUES ('25', '{\"Distinguished Name Column ID\":true,\"Common Name Column ID\":true,\"First Name Column ID\":true,\"Middle Name Column ID\":true,\"Last Name Column ID\":true,\"Manager DN Column ID\":true,\"Email Column ID\":true,\"Entitlement DN Column ID\":true,\"Entitlement CN Column ID\":true,\"Entitlement Description Column ID\":true,\"Last Authentication Column ID\":true,\"Last Authentication Format Column ID\":false,\"Status\":true,\"Credential Created Date\":true,\"Entitlement Created Date\":true,\"User Id\":true}', 'JIRA', 'CSV');
INSERT INTO `endpoint_config_attributes` VALUES ('26', '{\"Distinguished Name Column ID\":true,\"Common Name Column ID\":true,\"First Name Column ID\":true,\"Middle Name Column ID\":true,\"Last Name Column ID\":true,\"Manager DN Column ID\":true,\"Email Column ID\":true,\"Entitlement DN Column ID\":true,\"Entitlement CN Column ID\":true,\"Entitlement Description Column ID\":true,\"Last Authentication Column ID\":true,\"Last Authentication Format Column ID\":false,\"Status\":true,\"Credential Created Date\":true,\"Entitlement Created Date\":true,\"User Id\":true}', 'CONFLUENCE', 'CSV');
INSERT INTO `endpoint_config_attributes` VALUES ('27', '{\"Postgres DB Url\":true,\"Postgres Username\":true,\"Postgres Password\":true,\"Postgres Driver\":true}', 'POSTGRES', 'AUTOMATIC');
INSERT INTO `endpoint_config_attributes` VALUES ('28', '{\"Mysql DBUrl\":true,\"Mysql Username\":true,\"Mysql Password\":true,\"Mysql Driver\":true}', 'MYSQL', 'AUTOMATIC');
INSERT INTO `endpoint_config_attributes` VALUES ('29', '{\"Oracle DB Url\":true,\"Oracle Username\":true,\"Oracle Password\":true,\"Oracle Driver\":true}', 'ORACLE', 'AUTOMATIC');
INSERT INTO `endpoint_config_attributes` VALUES ('30', '{\"Box UserId\":true,\"Box ClientID\":true,\"Box ClientSecret\":true,\"Box PublicKeyID\":true,\"Box PrivateKey\":true,\"Box PassPhrase\":true,\"Box EnterpriseID\":true}', 'BOX', 'AUTOMATIC');
INSERT INTO `endpoint_config_attributes` VALUES ('31', '{\"Distinguished Name Column ID\":true,\"Common Name Column ID\":true,\"First Name Column ID\":true,\"Middle Name Column ID\":true,\"Last Name Column ID\":true,\"Manager DN Column ID\":true,\"Email Column ID\":true,\"Entitlement DN Column ID\":true,\"Entitlement CN Column ID\":true,\"Entitlement Description Column ID\":true,\"Last Authentication Column ID\":true,\"Last Authentication Format Column ID\":false,\"Status\":true,\"Credential Created Date\":true,\"Entitlement Created Date\":true,\"User Id\":true}', 'ORACLE', 'CSV');
INSERT INTO `endpoint_config_attributes` VALUES ('32', '{\"Distinguished Name Column ID\":true,\"Common Name Column ID\":true,\"First Name Column ID\":true,\"Middle Name Column ID\":true,\"Last Name Column ID\":true,\"Manager DN Column ID\":true,\"Email Column ID\":true,\"Entitlement DN Column ID\":true,\"Entitlement CN Column ID\":true,\"Entitlement Description Column ID\":true,\"Last Authentication Column ID\":true,\"Last Authentication Format Column ID\":false,\"Status\":true,\"Credential Created Date\":true,\"Entitlement Created Date\":true,\"User Id\":true}', 'SHAREPOINT', 'CSV');
INSERT INTO `endpoint_config_attributes` VALUES ('34', '{\"Distinguished Name Column ID\":true,\"Common Name Column ID\":true,\"First Name Column ID\":true,\"Middle Name Column ID\":true,\"Last Name Column ID\":true,\"Manager DN Column ID\":true,\"Email Column ID\":true,\"Entitlement DN Column ID\":true,\"Entitlement CN Column ID\":true,\"Entitlement Description Column ID\":true,\"Last Authentication Column ID\":true,\"Last Authentication Format Column ID\":false,\"Status\":true,\"Credential Created Date\":true,\"Entitlement Created Date\":true,\"User Id\":true}', 'BOX', 'CSV');
INSERT INTO `endpoint_config_attributes` VALUES ('36', '{\"Distinguished Name Column ID\":true,\"Common Name Column ID\":true,\"First Name Column ID\":true,\"Middle Name Column ID\":true,\"Last Name Column ID\":true,\"Manager DN Column ID\":true,\"Email Column ID\":true,\"Entitlement DN Column ID\":true,\"Entitlement CN Column ID\":true,\"Entitlement Description Column ID\":true,\"Last Authentication Column ID\":true,\"Last Authentication Format Column ID\":false,\"Status\":true,\"Credential Created Date\":true,\"Entitlement Created Date\":true,\"User Id\":true}', 'MYSQL', 'CSV');
INSERT INTO `endpoint_config_attributes` VALUES ('37', '{\"Distinguished Name Column ID\":true,\"Common Name Column ID\":true,\"First Name Column ID\":true,\"Middle Name Column ID\":true,\"Last Name Column ID\":true,\"Manager DN Column ID\":true,\"Email Column ID\":true,\"Entitlement DN Column ID\":true,\"Entitlement CN Column ID\":true,\"Entitlement Description Column ID\":true,\"Last Authentication Column ID\":true,\"Last Authentication Format Column ID\":false,\"Status\":true,\"Credential Created Date\":true,\"Entitlement Created Date\":true,\"User Id\":true}', 'POSTGRES', 'CSV');
INSERT INTO `endpoint_config_attributes` VALUES ('38', '{\"GitHub Client Id\":true,\"GitHub Client Secret\":true,\"GitHub AuthCode\":true}', 'GITHUB', 'AUTOMATIC');
INSERT INTO `endpoint_config_attributes` VALUES ('39', '{\"Dropbox AccesToken\":true,\"Dropbox Manager\":true}', 'DROPBOX', 'AUTOMATIC');
INSERT INTO `endpoint_config_attributes` VALUES ('40', '{\"AWS Access Key\":true,\"AWS Secret Key\":true}', 'AWS', 'AUTOMATIC');
INSERT INTO `endpoint_config_attributes` VALUES ('41', '{\"DB Username\":true,\"DB Password\":true,\"DB Url\":true,\"DB Driver Name\":true,\"Table Name\":true,\"IAM User Column\":true,\"Common Name Column\":true,\"Distiguished Name Column\":true,\"Last Authentication Column\":false,\"First Name Column\":true,\"Middle Name Column\":false,\"Last Name Column\":true,\"Email Column\":true,\"Manager Column\":true,\"Entitlement CN Column\":true,\"Entitlement DN Column\":true,\"Entitlement Description Column\":true,\"Access Status\":false,\"SQL\":false}', 'DB', 'AUTOMATIC');
INSERT INTO `endpoint_config_attributes` VALUES ('42', '{\"Distinguished Name Column ID\":true,\"Common Name Column ID\":true,\"First Name Column ID\":true,\"Middle Name Column ID\":true,\"Last Name Column ID\":true,\"Manager DN Column ID\":true,\"Email Column ID\":true,\"Entitlement DN Column ID\":true,\"Entitlement CN Column ID\":true,\"Entitlement Description Column ID\":true,\"Last Authentication Column ID\":true,\"Last Authentication Format Column ID\":false,\"Status\":true,\"Credential Created Date\":true,\"Entitlement Created Date\":true,\"User Id\":true}', 'SAP ERP', 'CSV');
INSERT INTO `endpoint_config_attributes` VALUES ('43', '{\"SAP Username\":true,\"SAP Password\":true,\"SAP Create URL\":true,\"SAP XCRF Token for Create User\":true,\"SAP Update URL\":true,\"SAP XCRF Token for Update User\":true,\"SAP Lock URL\":true,\"SAP XCRF Token for Lock User\":true,\"SAP Unlock URL\":true,\"SAP XCRF Token for Unlock User\":true,\"SAP Login URL\":true,\"SAP All Roles URL\":true,\"SAP Populate User\":true,\"SAP Active Users\":true}', 'SAP ERP', 'AUTOMATIC');
INSERT INTO `endpoint_config_attributes` VALUES ('44', '{\"Url\":true,\"Password\":true,\"UserName\":true,\"Company\":true,\"Domain\":true}', 'AX', 'AUTOMATIC');
INSERT INTO `endpoint_config_attributes` VALUES ('45', '{\"Url\":true,\"Password\":true,\"UserName\":true}', 'VIRIMA', 'AUTOMATIC');
INSERT INTO `endpoint_config_attributes` VALUES ('46', '{\"Domain\":true,\"Access token\":true}', 'OKTA', 'AUTOMATIC');
INSERT INTO `endpoint_config_attributes` VALUES ('47', '{\"Endpoint Location\":true,\"Username\":false,\"Password\":false,\"User Id\":false,\"Distinguished Name\":true,\"Common Name\":true,\"First Name\":true,\"Middle Name\":false,\"Last Name\":true,\"Manager DN\":true,\"Email\":true,\"Roles Key\":false,\"Entitlement DN\":false,\"Entitlement CN\":false,\"Entitlement Description\":false,\"Last Authentication\":false,\"Status\":false,\"Credential Created Date\":false,\"Entitlement Created Date\":false}', 'RESTFUL', 'AUTOMATIC');
INSERT INTO `endpoint_config_attributes` VALUES ('48', '{\"Schema Details\":{\"DB Username\":true,\"DB Password\":true,\"DB Url\":true,\"DB Driver Name\":true},\"DB Details\":{\"Table Name\":true,\"IAM User Column\":true,\"Common Name Column\":true,\"Distiguished Name Column\":true,\"Last Authentication Column\":false,\"First Name Column\":true,\"Middle Name Column\":false,\"Last Name Column\":true,\"Email Column\":true,\"Manager Column\":true,\"Entitlement CN Column\":true,\"Entitlement DN Column\":true,\"Entitlement Description Column\":true,\"Access Status\":true,\"SQL\":true}}', 'CUSTOM DB', 'AUTOMATIC');
INSERT INTO `endpoint_config_attributes` VALUES ('49', '{\"FTP Host\":true,\"FTP Port\":true,\"FTP Username\":true,\"FTP Password\":true,\"FTP File Location\":true, \"Type\":true}', 'FTP', 'AUTOMATIC');
INSERT INTO `endpoint_config_attributes` VALUES ('50', '{\"Distinguished Name Column ID\":true,\"Common Name Column ID\":true,\"First Name Column ID\":true,\"Middle Name Column ID\":true,\"Last Name Column ID\":true,\"Manager DN Column ID\":true,\"Email Column ID\":true,\"Entitlement DN Column ID\":true,\"Entitlement CN Column ID\":true,\"Entitlement Description Column ID\":true,\"Last Authentication Column ID\":true,\"Last Authentication Format Column ID\":false,\"Status\":true,\"Credential Created Date\":true,\"Entitlement Created Date\":true,\"User Id\":true}', 'OKTA', 'CSV');
INSERT INTO `endpoint_config_attributes` VALUES ('51', '{\"Distinguished Name Column ID\":true,\"Common Name Column ID\":true,\"First Name Column ID\":true,\"Middle Name Column ID\":true,\"Last Name Column ID\":true,\"Manager DN Column ID\":true,\"Email Column ID\":true,\"Entitlement DN Column ID\":true,\"Entitlement CN Column ID\":true,\"Entitlement Description Column ID\":true,\"Last Authentication Column ID\":true,\"Last Authentication Format Column ID\":false,\"Status\":true,\"Credential Created Date\":true,\"Entitlement Created Date\":true,\"User Id\":true}', 'AX', 'CSV');
INSERT INTO `endpoint_config_attributes` VALUES ('52', '{\"SQL Server DBUrl\":true,\"SQL Server Username\":true,\"SQL Server Password\":true,\"SQL Server Driver\":true}', 'SQL SERVER', 'AUTOMATIC');
INSERT INTO `endpoint_config_attributes` VALUES ('53', '{\"Distinguished Name Column ID\":true,\"Common Name Column ID\":true,\"First Name Column ID\":true,\"Middle Name Column ID\":true,\"Last Name Column ID\":true,\"Manager DN Column ID\":true,\"Email Column ID\":true,\"Entitlement DN Column ID\":true,\"Entitlement CN Column ID\":true,\"Entitlement Description Column ID\":true,\"Last Authentication Column ID\":true,\"Last Authentication Format Column ID\":false,\"Status\":true,\"Credential Created Date\":true,\"Entitlement Created Date\":true,\"User Id\":true}', 'SQL SERVER', 'CSV');
INSERT INTO `endpoint_config_attributes` VALUES ('54', '{\"Azure Tenant Id\":true,\"Azure Client Secret\":true,\"Azure Client Id\":true}', 'AZUREAD', 'AUTOMATIC');
INSERT INTO `endpoint_config_attributes` VALUES ('55', '{\"Distinguished Name Column ID\":true,\"Common Name Column ID\":true,\"First Name Column ID\":true,\"Middle Name Column ID\":true,\"Last Name Column ID\":true,\"Manager DN Column ID\":true,\"Email Column ID\":true,\"Entitlement DN Column ID\":true,\"Entitlement CN Column ID\":true,\"Entitlement Description Column ID\":true,\"Last Authentication Column ID\":true,\"Last Authentication Format Column ID\":false,\"Status\":true,\"Credential Created Date\":true,\"Entitlement Created Date\":true,\"User Id\":true}', 'AZUREAD', 'CSV');

-- ----------------------------
-- Table structure for `endpoint_entitlements`
-- ----------------------------
DROP TABLE IF EXISTS `endpoint_entitlements`;
CREATE TABLE `endpoint_entitlements` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ENDPOINT_TYPE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ENTITLEMENTS` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of endpoint_entitlements
-- ----------------------------
INSERT INTO `endpoint_entitlements` VALUES ('1', 'AD', 'Access Control Assistance Operators');
INSERT INTO `endpoint_entitlements` VALUES ('2', 'AD', 'Account Operators');
INSERT INTO `endpoint_entitlements` VALUES ('3', 'AD', 'Backup Operators');
INSERT INTO `endpoint_entitlements` VALUES ('4', 'AD', 'Certificate Service DCOM Access');
INSERT INTO `endpoint_entitlements` VALUES ('5', 'AD', 'Cryptographic Operators');
INSERT INTO `endpoint_entitlements` VALUES ('6', 'AD', 'Distributed COM Users');
INSERT INTO `endpoint_entitlements` VALUES ('7', 'AD', 'Event Log Readers');
INSERT INTO `endpoint_entitlements` VALUES ('8', 'AD', 'Guests');
INSERT INTO `endpoint_entitlements` VALUES ('9', 'AD', 'Hyper-V Administrators');
INSERT INTO `endpoint_entitlements` VALUES ('10', 'AD', 'IIS_IUSRS');
INSERT INTO `endpoint_entitlements` VALUES ('11', 'AD', 'Incoming Forest Trust Builders');
INSERT INTO `endpoint_entitlements` VALUES ('12', 'AD', 'Network Configuration Operators');
INSERT INTO `endpoint_entitlements` VALUES ('13', 'AD', 'Performance Log Users');
INSERT INTO `endpoint_entitlements` VALUES ('14', 'AD', 'Performance Monitor Users');
INSERT INTO `endpoint_entitlements` VALUES ('15', 'AD', 'Pre-Windows 2000 Compatible Access');
INSERT INTO `endpoint_entitlements` VALUES ('16', 'AD', 'Print Operators');
INSERT INTO `endpoint_entitlements` VALUES ('17', 'AD', 'RDS Endpoint Servers');
INSERT INTO `endpoint_entitlements` VALUES ('18', 'AD', 'RDS Management Servers');
INSERT INTO `endpoint_entitlements` VALUES ('19', 'AD', 'RDS Remote Access Servers');
INSERT INTO `endpoint_entitlements` VALUES ('20', 'AD', 'Remote Desktop Users');
INSERT INTO `endpoint_entitlements` VALUES ('21', 'AD', 'Remote Management Users');
INSERT INTO `endpoint_entitlements` VALUES ('22', 'AD', 'Replicator');
INSERT INTO `endpoint_entitlements` VALUES ('23', 'AD', 'Server Operators');
INSERT INTO `endpoint_entitlements` VALUES ('24', 'AD', 'Terminal Server License Servers');
INSERT INTO `endpoint_entitlements` VALUES ('25', 'AD', 'Users');
INSERT INTO `endpoint_entitlements` VALUES ('26', 'AD', 'Windows Authorization Access Group');
INSERT INTO `endpoint_entitlements` VALUES ('27', 'SVN', 'admin');
INSERT INTO `endpoint_entitlements` VALUES ('28', 'SVN', 'member');
INSERT INTO `endpoint_entitlements` VALUES ('29', 'OFFICE365', 'member');
INSERT INTO `endpoint_entitlements` VALUES ('30', 'OFFICE365', 'admin');
INSERT INTO `endpoint_entitlements` VALUES ('31', 'BOX', 'Owner');
INSERT INTO `endpoint_entitlements` VALUES ('32', 'BOX', 'Editor');
INSERT INTO `endpoint_entitlements` VALUES ('33', 'DB', 'Owner');
INSERT INTO `endpoint_entitlements` VALUES ('34', 'DB', 'view');
INSERT INTO `endpoint_entitlements` VALUES ('35', 'AWS', 'Admin');
INSERT INTO `endpoint_entitlements` VALUES ('36', 'AWS', 'Owner');
INSERT INTO `endpoint_entitlements` VALUES ('37', 'AWS', 'Editor');
INSERT INTO `endpoint_entitlements` VALUES ('38', 'CONFLUENCE', 'User');
INSERT INTO `endpoint_entitlements` VALUES ('39', 'CONFLUENCE', 'Editor');

-- ----------------------------
-- Table structure for `end_point`
-- ----------------------------
DROP TABLE IF EXISTS `end_point`;
CREATE TABLE `end_point` (
  `SUBTYPE` varchar(31) NOT NULL,
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `CREATED_TS` datetime DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `LAST_REFRESH` datetime DEFAULT NULL,
  `LOAD_ENTITLEMENTS` char(1) DEFAULT NULL,
  `MATCH_PLUGIN` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `REFRESH_STATUS` varchar(255) DEFAULT NULL,
  `STATUS` varchar(255) DEFAULT NULL,
  `USER_PLUGIN` varchar(255) DEFAULT NULL,
  `CUSTODIAN_RID` bigint(20) DEFAULT NULL,
  `CUSTOMER_RID` bigint(20) DEFAULT NULL,
  `CONFIGURATION` longtext,
  `TICKET_TRACKER` varchar(255) DEFAULT NULL,
  `TICKET_GEN` varchar(255) DEFAULT NULL,
  `ENDPOINT_TYPE` varchar(255) DEFAULT NULL,
  `TO_EMAIL` varchar(255) DEFAULT NULL,
  `VISIBILITY` tinyint(1) DEFAULT '1',
  `END_POINT_DOMAIN_CONFIG` bigint(20) DEFAULT NULL,
  `AGENT_TYPE` bigint(20) DEFAULT NULL,
  `HOST` varchar(255) DEFAULT NULL,
  `OWNER` varchar(255) DEFAULT NULL,
  `NOTIFICATION_REVIEW` tinyint(1) DEFAULT '0',
  `IS_SWITCHED_MATCH_BY` tinyint(1) NOT NULL DEFAULT '0',
  `MATCH_BY` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`),
  KEY `END_POINT_FK1` (`CUSTODIAN_RID`),
  KEY `FKk387vfxligmb1u4gv5asw2fe` (`CUSTOMER_RID`),
  KEY `FKp8mer3rjy6vustsm73wuo04xa` (`AGENT_TYPE`),
  CONSTRAINT `END_POINT_FK1` FOREIGN KEY (`CUSTODIAN_RID`) REFERENCES `iam_user` (`ROW_ID`),
  CONSTRAINT `FKi4hx81si8pq6rop8wx36ba18p` FOREIGN KEY (`CUSTODIAN_RID`) REFERENCES `iam_user` (`ROW_ID`),
  CONSTRAINT `FKk387vfxligmb1u4gv5asw2fe` FOREIGN KEY (`CUSTOMER_RID`) REFERENCES `customer` (`ROW_ID`),
  CONSTRAINT `FKp8mer3rjy6vustsm73wuo04xa` FOREIGN KEY (`AGENT_TYPE`) REFERENCES `end_point_type` (`ROW_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of end_point
-- ----------------------------
INSERT INTO `end_point` VALUES ('CSV', '1', null, 'Access Control Endpoint', null, 'Y', null, 'Access Control Endpoint', 'C', 'E', null, null, '1', null, null, null, null, null, '0', null, null, null, null, '0', '0', null);

-- ----------------------------
-- Table structure for `end_point_action`
-- ----------------------------
DROP TABLE IF EXISTS `end_point_action`;
CREATE TABLE `end_point_action` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `END_POINT_RID` bigint(20) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`),
  KEY `FKmxlf7uktnnoi8yln3gdt5a5th` (`END_POINT_RID`),
  CONSTRAINT `FKmxlf7uktnnoi8yln3gdt5a5th` FOREIGN KEY (`END_POINT_RID`) REFERENCES `end_point` (`ROW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of end_point_action
-- ----------------------------

-- ----------------------------
-- Table structure for `end_point_attribute`
-- ----------------------------
DROP TABLE IF EXISTS `end_point_attribute`;
CREATE TABLE `end_point_attribute` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `END_POINT_RID` bigint(20) DEFAULT NULL,
  `FIELD_NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FIELD_TYPE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `END_POINT_TYPE` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`),
  KEY `FK2fmvw7c63ttmrroc87auwnv3a` (`END_POINT_RID`),
  KEY `FKkt1w2ou02c6eg27amx22cuwy1` (`END_POINT_TYPE`),
  CONSTRAINT `FK2fmvw7c63ttmrroc87auwnv3a` FOREIGN KEY (`END_POINT_RID`) REFERENCES `end_point` (`ROW_ID`),
  CONSTRAINT `FKkt1w2ou02c6eg27amx22cuwy1` FOREIGN KEY (`END_POINT_TYPE`) REFERENCES `end_point_type` (`ROW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of end_point_attribute
-- ----------------------------

-- ----------------------------
-- Table structure for `end_point_domain_config`
-- ----------------------------
DROP TABLE IF EXISTS `end_point_domain_config`;
CREATE TABLE `end_point_domain_config` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `configuration` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of end_point_domain_config
-- ----------------------------

-- ----------------------------
-- Table structure for `end_point_event`
-- ----------------------------
DROP TABLE IF EXISTS `end_point_event`;
CREATE TABLE `end_point_event` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `CUSTOMER_RID` bigint(20) DEFAULT NULL,
  `END_POINT_RID` bigint(20) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `END_POINT_TYPE` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`),
  KEY `FKeq4t9a7ifdyhbtq69ktt8kak1` (`CUSTOMER_RID`),
  KEY `FKjhlyf0e1ayf4814scaf4aonor` (`END_POINT_RID`),
  KEY `FKpo7dtg5ow6yrerlscje67h3xu` (`END_POINT_TYPE`),
  CONSTRAINT `FKeq4t9a7ifdyhbtq69ktt8kak1` FOREIGN KEY (`CUSTOMER_RID`) REFERENCES `customer` (`ROW_ID`),
  CONSTRAINT `FKjhlyf0e1ayf4814scaf4aonor` FOREIGN KEY (`END_POINT_RID`) REFERENCES `end_point` (`ROW_ID`),
  CONSTRAINT `FKpo7dtg5ow6yrerlscje67h3xu` FOREIGN KEY (`END_POINT_TYPE`) REFERENCES `end_point_type` (`ROW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of end_point_event
-- ----------------------------

-- ----------------------------
-- Table structure for `end_point_event_condition`
-- ----------------------------
DROP TABLE IF EXISTS `end_point_event_condition`;
CREATE TABLE `end_point_event_condition` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ATTRIBUTE_VALUE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `COMPORATOR` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `END_POINT_ATTRIBUTE_RID` bigint(20) DEFAULT NULL,
  `END_POINT_EVENT_RID` bigint(20) DEFAULT NULL,
  `OPERATOR` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`),
  KEY `FK1t86b9vgntltwq0o7ma3uvssc` (`END_POINT_ATTRIBUTE_RID`),
  KEY `FKqewee9rkebrp90lwtue6ye62n` (`END_POINT_EVENT_RID`),
  CONSTRAINT `FK1t86b9vgntltwq0o7ma3uvssc` FOREIGN KEY (`END_POINT_ATTRIBUTE_RID`) REFERENCES `end_point_attribute` (`ROW_ID`),
  CONSTRAINT `FKqewee9rkebrp90lwtue6ye62n` FOREIGN KEY (`END_POINT_EVENT_RID`) REFERENCES `end_point_event` (`ROW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of end_point_event_condition
-- ----------------------------

-- ----------------------------
-- Table structure for `end_point_type`
-- ----------------------------
DROP TABLE IF EXISTS `end_point_type`;
CREATE TABLE `end_point_type` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `TYPE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CATEGORY` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of end_point_type
-- ----------------------------
INSERT INTO `end_point_type` VALUES ('1', 'AD', 'Directory service');
INSERT INTO `end_point_type` VALUES ('2', 'GOOGLE DRIVE', 'File storage');
INSERT INTO `end_point_type` VALUES ('3', 'OFFICE365', 'Software as a service');
INSERT INTO `end_point_type` VALUES ('4', 'AWS', 'Cloud Computing platform');
INSERT INTO `end_point_type` VALUES ('5', 'DROPBOX', 'Online backup service');
INSERT INTO `end_point_type` VALUES ('6', 'GITHUB', 'Git-repository hosting service');
INSERT INTO `end_point_type` VALUES ('7', 'DB', 'RDBMS');
INSERT INTO `end_point_type` VALUES ('8', 'MYSQL', 'RDBMS');
INSERT INTO `end_point_type` VALUES ('9', 'ORACLE', 'Multi-model database');
INSERT INTO `end_point_type` VALUES ('10', 'POSTGRES', 'ORDBMS');
INSERT INTO `end_point_type` VALUES ('11', 'SAP', 'Cloud Platform');
INSERT INTO `end_point_type` VALUES ('12', 'SAP ERP', 'ERP');
INSERT INTO `end_point_type` VALUES ('13', 'WINDOWS SHARE', 'Shared resource');
INSERT INTO `end_point_type` VALUES ('14', 'BOX', 'Content management and file sharing');
INSERT INTO `end_point_type` VALUES ('15', 'SALESFORCE', 'Cloud computing Platform');
INSERT INTO `end_point_type` VALUES ('16', 'SHAREPOINT', 'Content Management Systems');
INSERT INTO `end_point_type` VALUES ('17', 'AX', 'Enterprise resource planning');
INSERT INTO `end_point_type` VALUES ('18', 'VIRIMA', 'IT Asset Management');
INSERT INTO `end_point_type` VALUES ('19', 'OKTA', 'Identity and Access management ');
INSERT INTO `end_point_type` VALUES ('20', 'CUSTOM DB', 'RDBMS');
INSERT INTO `end_point_type` VALUES ('21', 'FTP', 'FTP Server');
INSERT INTO `end_point_type` VALUES ('22', 'RESTFUL', 'Webservice API');
INSERT INTO `end_point_type` VALUES ('23', 'JIRA', 'Bug life cycle management');
INSERT INTO `end_point_type` VALUES ('24', 'SQL SERVER', 'RDBMS');
INSERT INTO `end_point_type` VALUES ('25', 'CONFLUENCE', 'Content Management Systems');
INSERT INTO `end_point_type` VALUES ('26', 'AZUREAD', 'Directory service');

-- ----------------------------
-- Table structure for `entitlement`
-- ----------------------------
DROP TABLE IF EXISTS `entitlement`;
CREATE TABLE `entitlement` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `CN` varchar(255) DEFAULT NULL,
  `CREATED_TS` datetime DEFAULT NULL,
  `DESCRIPTION` varchar(1000) DEFAULT NULL,
  `DN` varchar(255) DEFAULT NULL,
  `REFRESH_STATUS` varchar(255) DEFAULT NULL,
  `STATUS` varchar(255) DEFAULT NULL,
  `CUSTODIAN_RID` bigint(20) DEFAULT NULL,
  `END_POINT_RID` bigint(20) DEFAULT NULL,
  `ENTITLEMENT_DESCRIPTION` varchar(255) DEFAULT NULL,
  `TYPE` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`),
  UNIQUE KEY `ENTITLEMENT_U1` (`END_POINT_RID`,`DN`),
  KEY `ENTITLEMENT_FK2` (`CUSTODIAN_RID`),
  CONSTRAINT `ENTITLEMENT_FK1` FOREIGN KEY (`END_POINT_RID`) REFERENCES `end_point` (`ROW_ID`) ON DELETE CASCADE,
  CONSTRAINT `ENTITLEMENT_FK2` FOREIGN KEY (`CUSTODIAN_RID`) REFERENCES `iam_user` (`ROW_ID`),
  CONSTRAINT `FKlfat9ne3h54xxuvsy7yplyhl7` FOREIGN KEY (`END_POINT_RID`) REFERENCES `end_point` (`ROW_ID`),
  CONSTRAINT `FKpi255ro17ayy6pf54bkbvgk72` FOREIGN KEY (`CUSTODIAN_RID`) REFERENCES `iam_user` (`ROW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of entitlement
-- ----------------------------

-- ----------------------------
-- Table structure for `entity`
-- ----------------------------
DROP TABLE IF EXISTS `entity`;
CREATE TABLE `entity` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `CUSTOMER_RID` bigint(20) DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of entity
-- ----------------------------

-- ----------------------------
-- Table structure for `ftp_end_point`
-- ----------------------------
DROP TABLE IF EXISTS `ftp_end_point`;
CREATE TABLE `ftp_end_point` (
  `AGENT` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CRON_EXPRESSION` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `LAST_RAN_DATE` datetime DEFAULT NULL,
  `SYNC_STATUS_MESSAGE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `END_POINT_RID` bigint(20) NOT NULL,
  PRIMARY KEY (`END_POINT_RID`),
  CONSTRAINT `FKfwhlqjaepaja4xvsh9bu1c8u7` FOREIGN KEY (`END_POINT_RID`) REFERENCES `end_point` (`ROW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of ftp_end_point
-- ----------------------------

-- ----------------------------
-- Table structure for `hibernate_sequence`
-- ----------------------------
DROP TABLE IF EXISTS `hibernate_sequence`;
CREATE TABLE `hibernate_sequence` (
  `next_val` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of hibernate_sequence
-- ----------------------------
INSERT INTO `hibernate_sequence` VALUES ('1');

-- ----------------------------
-- Table structure for `iam_event`
-- ----------------------------
DROP TABLE IF EXISTS `iam_event`;
CREATE TABLE `iam_event` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `customer_rid` bigint(20) DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of iam_event
-- ----------------------------

-- ----------------------------
-- Table structure for `iam_password`
-- ----------------------------
DROP TABLE IF EXISTS `iam_password`;
CREATE TABLE `iam_password` (
  `IAM_USER_RID` bigint(20) NOT NULL,
  `SALT` varchar(250) DEFAULT NULL,
  `HASHED_VALUE` varchar(255) DEFAULT NULL,
  `IS_PASSWORD_UPDATED` bit(1) DEFAULT NULL,
  PRIMARY KEY (`IAM_USER_RID`),
  CONSTRAINT `IAM_PASSWORD_FK1` FOREIGN KEY (`IAM_USER_RID`) REFERENCES `iam_user` (`ROW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of iam_password
-- ----------------------------
INSERT INTO `iam_password` VALUES ('1', '9D6F0BE01EC503F24CA90252EC2C269AEA50344F4B3022C870E24FDB15DA537B', '2C7E2EF28B1C543F8A779D0864144E0514309946362F6AF7D886C16F9A56CD29', '');
INSERT INTO `iam_password` VALUES ('2', '9D6F0BE01EC503F24CA90252EC2C269AEA50344F4B3022C870E24FDB15DA537B', '2C7E2EF28B1C543F8A779D0864144E0514309946362F6AF7D886C16F9A56CD29', '');

-- ----------------------------
-- Table structure for `iam_policy`
-- ----------------------------
DROP TABLE IF EXISTS `iam_policy`;
CREATE TABLE `iam_policy` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `END_POINT_ACTION_RID` bigint(20) DEFAULT NULL,
  `IAM_EVENT_RID` bigint(20) DEFAULT NULL,
  `END_POINT_EVENT_RID` bigint(20) DEFAULT NULL,
  `ENDPOINT_RID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`),
  KEY `FKo0cfhqye320l8r3grf02ubcgd` (`END_POINT_ACTION_RID`),
  KEY `FKmur763mmgx73dxidx9sdvck9l` (`IAM_EVENT_RID`),
  KEY `FK3dxyjrhml3jryqahh8rl137f7` (`END_POINT_EVENT_RID`),
  KEY `FKcyhwfjv51qrbdjs3q7epdbp3x` (`ENDPOINT_RID`),
  CONSTRAINT `FK3dxyjrhml3jryqahh8rl137f7` FOREIGN KEY (`END_POINT_EVENT_RID`) REFERENCES `end_point_event` (`ROW_ID`),
  CONSTRAINT `FKcyhwfjv51qrbdjs3q7epdbp3x` FOREIGN KEY (`ENDPOINT_RID`) REFERENCES `end_point` (`ROW_ID`),
  CONSTRAINT `FKmur763mmgx73dxidx9sdvck9l` FOREIGN KEY (`IAM_EVENT_RID`) REFERENCES `iam_event` (`ROW_ID`),
  CONSTRAINT `FKo0cfhqye320l8r3grf02ubcgd` FOREIGN KEY (`END_POINT_ACTION_RID`) REFERENCES `end_point_action` (`ROW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of iam_policy
-- ----------------------------

-- ----------------------------
-- Table structure for `iam_policy_action`
-- ----------------------------
DROP TABLE IF EXISTS `iam_policy_action`;
CREATE TABLE `iam_policy_action` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ACTION_RID` bigint(20) DEFAULT NULL,
  `END_POINT_ATTRIBUTE_RID` bigint(20) DEFAULT NULL,
  `FIELD_NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FIELD_VALUE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `IAM_POLICY_RID` bigint(20) DEFAULT NULL,
  `FIELD_TYPE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`),
  KEY `FK1xengw43qorcdubs25cn3j8np` (`ACTION_RID`),
  KEY `FKad5t8m6ko553p1238jxrn4caw` (`END_POINT_ATTRIBUTE_RID`),
  KEY `FKeu3y36onx383b6dkolas4yw8o` (`IAM_POLICY_RID`),
  CONSTRAINT `FK1xengw43qorcdubs25cn3j8np` FOREIGN KEY (`ACTION_RID`) REFERENCES `action` (`ROW_ID`),
  CONSTRAINT `FKad5t8m6ko553p1238jxrn4caw` FOREIGN KEY (`END_POINT_ATTRIBUTE_RID`) REFERENCES `end_point_attribute` (`ROW_ID`),
  CONSTRAINT `FKeu3y36onx383b6dkolas4yw8o` FOREIGN KEY (`IAM_POLICY_RID`) REFERENCES `iam_policy` (`ROW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of iam_policy_action
-- ----------------------------

-- ----------------------------
-- Table structure for `iam_policy_condition`
-- ----------------------------
DROP TABLE IF EXISTS `iam_policy_condition`;
CREATE TABLE `iam_policy_condition` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ATTRIBUTE_VALUE` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `COMPORATOR` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `OPERATOR` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ATTRIBUTE_RID` bigint(20) DEFAULT NULL,
  `IAM_POLICY_RID` bigint(20) DEFAULT NULL,
  `END_POINT_ATTRIBUTE_RID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`),
  KEY `FK7p44n9e2v2y9l7hmyey7kgi02` (`ATTRIBUTE_RID`),
  KEY `FKd9bmjvtiv9qqyd6xolyraxel4` (`IAM_POLICY_RID`),
  KEY `FKqj9l57yek4sp822owyr256cr1` (`END_POINT_ATTRIBUTE_RID`),
  CONSTRAINT `FK7p44n9e2v2y9l7hmyey7kgi02` FOREIGN KEY (`ATTRIBUTE_RID`) REFERENCES `attribute` (`ROW_ID`),
  CONSTRAINT `FKd9bmjvtiv9qqyd6xolyraxel4` FOREIGN KEY (`IAM_POLICY_RID`) REFERENCES `iam_policy` (`ROW_ID`),
  CONSTRAINT `FKqj9l57yek4sp822owyr256cr1` FOREIGN KEY (`END_POINT_ATTRIBUTE_RID`) REFERENCES `end_point_attribute` (`ROW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of iam_policy_condition
-- ----------------------------

-- ----------------------------
-- Table structure for `iam_policy_report`
-- ----------------------------
DROP TABLE IF EXISTS `iam_policy_report`;
CREATE TABLE `iam_policy_report` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ACTION_TYPE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DATE` datetime DEFAULT NULL,
  `EMAIL` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ENDPOINT_RID` bigint(20) DEFAULT NULL,
  `EVENT_NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `POLICY_NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `REASON` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `STATUS` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `REPROCESS_FLAG` bit(1) DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of iam_policy_report
-- ----------------------------

-- ----------------------------
-- Table structure for `iam_user`
-- ----------------------------
DROP TABLE IF EXISTS `iam_user`;
CREATE TABLE `iam_user` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `CREATED_TS` datetime DEFAULT NULL,
  `EMAIL` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FIRST_NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `LAST_NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `MIDDLE_NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `STATUS` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `UTYPE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DELEGATE_RID` bigint(20) DEFAULT NULL,
  `MANAGER_RID` bigint(20) DEFAULT NULL,
  `CUSTOMER_RID` bigint(20) DEFAULT NULL,
  `QR_CODE_ACTIVE` bit(1) DEFAULT NULL,
  `SECRET` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FULL_NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `USER_ID` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ADDITIONAL_COLUMNS` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`ROW_ID`),
  KEY `IAM_USER_FK1` (`MANAGER_RID`),
  KEY `IAM_USER_FK2` (`DELEGATE_RID`),
  KEY `FKrmq4cbmbnbbyw0m7sh5k3c8e5` (`CUSTOMER_RID`),
  CONSTRAINT `FK6d628h24j8arwx60w8e4otc8p` FOREIGN KEY (`DELEGATE_RID`) REFERENCES `iam_user` (`ROW_ID`),
  CONSTRAINT `FKdajp4d9duv3u13qpnxwnel9el` FOREIGN KEY (`MANAGER_RID`) REFERENCES `iam_user` (`ROW_ID`),
  CONSTRAINT `FKrmq4cbmbnbbyw0m7sh5k3c8e5` FOREIGN KEY (`CUSTOMER_RID`) REFERENCES `customer` (`ROW_ID`),
  CONSTRAINT `IAM_USER_FK1` FOREIGN KEY (`MANAGER_RID`) REFERENCES `iam_user` (`ROW_ID`),
  CONSTRAINT `IAM_USER_FK2` FOREIGN KEY (`DELEGATE_RID`) REFERENCES `iam_user` (`ROW_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of iam_user
-- ----------------------------
INSERT INTO `iam_user` VALUES ('1', '2018-08-01 14:13:06', 'superadmin@securends.com', 'Super Admin', 'Admin', '', 'E', 'R', null, '1', '1', null, null, null, null, null);
INSERT INTO `iam_user` VALUES ('2', '2019-04-01 09:20:29', 'admin@securends.com', 'Admin', 'Admin', '', 'E', 'R', null, null, '1', null, null, null, null, null);

-- ----------------------------
-- Table structure for `ipaendpoint`
-- ----------------------------
DROP TABLE IF EXISTS `ipaendpoint`;
CREATE TABLE `ipaendpoint` (
  `df` tinyblob,
  `ROW_ID` bigint(20) NOT NULL,
  PRIMARY KEY (`ROW_ID`),
  CONSTRAINT `FKkky2w7ugnynk5io0d2vecvs21` FOREIGN KEY (`ROW_ID`) REFERENCES `ldapendpoint` (`ROW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ipaendpoint
-- ----------------------------

-- ----------------------------
-- Table structure for `ldapendpoint`
-- ----------------------------
DROP TABLE IF EXISTS `ldapendpoint`;
CREATE TABLE `ldapendpoint` (
  `ROW_ID` bigint(20) NOT NULL,
  PRIMARY KEY (`ROW_ID`),
  CONSTRAINT `FKscncrq7hyuallcjp1lfqu7ojo` FOREIGN KEY (`ROW_ID`) REFERENCES `end_point` (`ROW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ldapendpoint
-- ----------------------------

-- ----------------------------
-- Table structure for `ldap_end_point`
-- ----------------------------
DROP TABLE IF EXISTS `ldap_end_point`;
CREATE TABLE `ldap_end_point` (
  `GROUP_FILTER` varchar(255) DEFAULT NULL,
  `GROUP_URL` varchar(255) DEFAULT NULL,
  `PAGING_ENABLED` bit(1) DEFAULT NULL,
  `PASSWORD` varchar(255) DEFAULT NULL,
  `URL` varchar(255) DEFAULT NULL,
  `USER_FILTER` varchar(255) DEFAULT NULL,
  `USERNAME` varchar(255) DEFAULT NULL,
  `END_POINT_RID` bigint(20) NOT NULL,
  PRIMARY KEY (`END_POINT_RID`),
  CONSTRAINT `FKcm433ic7n48fxtjr80wbpb46j` FOREIGN KEY (`END_POINT_RID`) REFERENCES `end_point` (`ROW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ldap_end_point
-- ----------------------------

-- ----------------------------
-- Table structure for `login_history`
-- ----------------------------
DROP TABLE IF EXISTS `login_history`;
CREATE TABLE `login_history` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `IP_ADDRESS` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `LOGIN_TIME` datetime DEFAULT NULL,
  `LOGOUT_TIME` datetime DEFAULT NULL,
  `TIMEZONE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `USER_ID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`),
  KEY `FKag8oifbvmvxnqpghk5a0k7de1` (`USER_ID`),
  CONSTRAINT `FKag8oifbvmvxnqpghk5a0k7de1` FOREIGN KEY (`USER_ID`) REFERENCES `iam_user` (`ROW_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of login_history
-- ----------------------------
INSERT INTO `login_history` VALUES ('15', '192.168.99.1', '2020-01-07 19:03:39', null, 'India Standard Time', '2');

-- ----------------------------
-- Table structure for `notification`
-- ----------------------------
DROP TABLE IF EXISTS `notification`;
CREATE TABLE `notification` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `CREATED_TS` datetime DEFAULT NULL,
  `MESSAGE` longtext COLLATE utf8_unicode_ci,
  `NOTIFICATION_TYPE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `UN_READ` tinyint(1) DEFAULT '1',
  `USER_RID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`),
  KEY `FK2agqwjirxbr1f5x0e1g83o2fx` (`USER_RID`),
  CONSTRAINT `FK2agqwjirxbr1f5x0e1g83o2fx` FOREIGN KEY (`USER_RID`) REFERENCES `iam_user` (`ROW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of notification
-- ----------------------------

-- ----------------------------
-- Table structure for `pending_approval`
-- ----------------------------
DROP TABLE IF EXISTS `pending_approval`;
CREATE TABLE `pending_approval` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `APPLICATION_ID` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `APPROVE_STATUS` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `APPROVER_ID` bigint(20) DEFAULT NULL,
  `CREATED_DATE` datetime DEFAULT NULL,
  `EMAIL_ID` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `EMAIL_SENT` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ENTITLEMENTS` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `RECJECTION_COMMENT` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ROLES` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TICKET_ID` bigint(20) DEFAULT NULL,
  `UPDATED_DATE` datetime DEFAULT NULL,
  `USER_ID` bigint(20) DEFAULT NULL,
  `USER_NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `AGENT_TYPE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `GROUPS` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `MANAGER_EMAIL_ID` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `USER_EMAIL_ID` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `APP_STATUS` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ENDPOINT_NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PRIORITY` bigint(20) DEFAULT NULL,
  `REQUEST_ID` bigint(20) DEFAULT NULL,
  `REQUESTER` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PENDING_APPROVAL_PARAMETER_RID` bigint(20) DEFAULT NULL,
  `CUSTOMER_ID` bigint(20) DEFAULT NULL,
  `ESCALTION_REMINDER_DATE` datetime DEFAULT NULL,
  `EVENT_NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `IS_ABAC_REQ` bit(1) DEFAULT NULL,
  `POLICY_NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`),
  KEY `FK997g8gaaor4titixn761d6e2n` (`PENDING_APPROVAL_PARAMETER_RID`),
  CONSTRAINT `FK997g8gaaor4titixn761d6e2n` FOREIGN KEY (`PENDING_APPROVAL_PARAMETER_RID`) REFERENCES `pending_approval_parameter` (`ROW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of pending_approval
-- ----------------------------

-- ----------------------------
-- Table structure for `pending_approval_parameter`
-- ----------------------------
DROP TABLE IF EXISTS `pending_approval_parameter`;
CREATE TABLE `pending_approval_parameter` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `configuration` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of pending_approval_parameter
-- ----------------------------

-- ----------------------------
-- Table structure for `resource`
-- ----------------------------
DROP TABLE IF EXISTS `resource`;
CREATE TABLE `resource` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `RESOURCE_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`),
  UNIQUE KEY `UK_d87p0u38tfkcd35oaf004k5vg` (`RESOURCE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of resource
-- ----------------------------
INSERT INTO `resource` VALUES ('1', 'Endpoint Access', 'endpointLink');
INSERT INTO `resource` VALUES ('2', 'Applications Access', 'applications');
INSERT INTO `resource` VALUES ('3', 'Sync History Access', 'syncHistoryLink');
INSERT INTO `resource` VALUES ('4', 'Manage Iam User Access', 'manageIamUserLink');
INSERT INTO `resource` VALUES ('5', 'Access Review Campaign Tab Access', 'accessReviewCompaign');
INSERT INTO `resource` VALUES ('6', 'Campaign Link Access ', 'campaignLink');
INSERT INTO `resource` VALUES ('7', 'Template Link Access', 'templatesLink');
INSERT INTO `resource` VALUES ('8', 'Delegates Link Access', 'delegatesLink');
INSERT INTO `resource` VALUES ('9', 'Reports Link Access', 'reportsLink');
INSERT INTO `resource` VALUES ('10', 'Campaign Report Tab Access', 'campaignReport');
INSERT INTO `resource` VALUES ('11', 'Filter Campaigns Link Access', 'filterCampaigns');
INSERT INTO `resource` VALUES ('12', 'Access control', 'accessControl');
INSERT INTO `resource` VALUES ('13', 'Roles Report', 'rolesReport');
INSERT INTO `resource` VALUES ('14', 'Roles Link', 'rolesLink');
INSERT INTO `resource` VALUES ('15', 'Administration', 'administration');
INSERT INTO `resource` VALUES ('16', 'Customer', 'customer');
INSERT INTO `resource` VALUES ('17', 'NotificationSettings', 'notificationSettings');
INSERT INTO `resource` VALUES ('18', 'Dashboard', 'dashboard');
INSERT INTO `resource` VALUES ('19', 'User Access', 'userAccess');
INSERT INTO `resource` VALUES ('20', 'Setup Application', 'setupApplicationLink');
INSERT INTO `resource` VALUES ('21', 'Manage Attributes', 'manageAttributesLink');
INSERT INTO `resource` VALUES ('22', 'Manage Events', 'manageEventsLink');
INSERT INTO `resource` VALUES ('23', 'IdentityIntelligence', 'identityIntelligenceLink');
INSERT INTO `resource` VALUES ('24', 'Access Management', 'accessManagement');

-- ----------------------------
-- Table structure for `role`
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `CREATED_TS` date DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', '2023-03-20', 'Full access to manage Campaigns, Applications, and Users', 'ADMIN');
INSERT INTO `role` VALUES ('2', '2023-03-20', 'Reporting Access', 'AUDIT');
INSERT INTO `role` VALUES ('3', '2023-03-20', 'View User Access', 'ACCESS');
INSERT INTO `role` VALUES ('4', '2023-03-20', 'Application Manager', 'APPLICATION');
INSERT INTO `role` VALUES ('5', '2023-03-20', 'Super Admin', 'SUPERADMIN');

-- ----------------------------
-- Table structure for `role_assignment`
-- ----------------------------
DROP TABLE IF EXISTS `role_assignment`;
CREATE TABLE `role_assignment` (
  `IAM_USER_RID` bigint(20) NOT NULL,
  `ROLE_RID` bigint(20) NOT NULL,
  PRIMARY KEY (`IAM_USER_RID`,`ROLE_RID`),
  KEY `ROLE_ASSIGNMENT_FK1` (`ROLE_RID`),
  CONSTRAINT `FKd7kf0sibart3cdpdote7ac0s1` FOREIGN KEY (`IAM_USER_RID`) REFERENCES `iam_user` (`ROW_ID`),
  CONSTRAINT `FKh8sqsits3wje0hfxknq1pu9y9` FOREIGN KEY (`ROLE_RID`) REFERENCES `role` (`ROW_ID`),
  CONSTRAINT `ROLE_ASSIGNMENT_FK1` FOREIGN KEY (`ROLE_RID`) REFERENCES `role` (`ROW_ID`),
  CONSTRAINT `ROLE_ASSIGNMENT_FK2` FOREIGN KEY (`IAM_USER_RID`) REFERENCES `iam_user` (`ROW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role_assignment
-- ----------------------------
INSERT INTO `role_assignment` VALUES ('2', '1');
INSERT INTO `role_assignment` VALUES ('2', '2');
INSERT INTO `role_assignment` VALUES ('2', '3');
INSERT INTO `role_assignment` VALUES ('2', '4');
INSERT INTO `role_assignment` VALUES ('1', '5');

-- ----------------------------
-- Table structure for `role_resource`
-- ----------------------------
DROP TABLE IF EXISTS `role_resource`;
CREATE TABLE `role_resource` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `RESOURCE_ID` bigint(20) DEFAULT NULL,
  `ROLE_ID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`),
  KEY `FKc4sfhvw4ngc6lpuoom53al6uu` (`RESOURCE_ID`),
  KEY `FKkah7v6qmaqe6damf1bweasqwd` (`ROLE_ID`),
  CONSTRAINT `FKc4sfhvw4ngc6lpuoom53al6uu` FOREIGN KEY (`RESOURCE_ID`) REFERENCES `resource` (`ROW_ID`),
  CONSTRAINT `FKkah7v6qmaqe6damf1bweasqwd` FOREIGN KEY (`ROLE_ID`) REFERENCES `role` (`ROW_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role_resource
-- ----------------------------
INSERT INTO `role_resource` VALUES ('1', '1', '4');
INSERT INTO `role_resource` VALUES ('2', '2', '4');
INSERT INTO `role_resource` VALUES ('3', '3', '4');
INSERT INTO `role_resource` VALUES ('4', '4', '1');
INSERT INTO `role_resource` VALUES ('5', '5', '1');
INSERT INTO `role_resource` VALUES ('6', '6', '1');
INSERT INTO `role_resource` VALUES ('7', '7', '1');
INSERT INTO `role_resource` VALUES ('8', '8', '1');
INSERT INTO `role_resource` VALUES ('9', '9', '2');
INSERT INTO `role_resource` VALUES ('10', '10', '2');
INSERT INTO `role_resource` VALUES ('11', '11', '2');
INSERT INTO `role_resource` VALUES ('12', '12', '1');
INSERT INTO `role_resource` VALUES ('13', '13', '1');
INSERT INTO `role_resource` VALUES ('14', '14', '1');
INSERT INTO `role_resource` VALUES ('15', '15', '1');
INSERT INTO `role_resource` VALUES ('16', '16', '5');
INSERT INTO `role_resource` VALUES ('17', '17', '1');
INSERT INTO `role_resource` VALUES ('18', '18', '1');
INSERT INTO `role_resource` VALUES ('19', '18', '4');
INSERT INTO `role_resource` VALUES ('20', '19', '3');
INSERT INTO `role_resource` VALUES ('21', '1', '1');
INSERT INTO `role_resource` VALUES ('22', '3', '1');
INSERT INTO `role_resource` VALUES ('23', '7', '4');
INSERT INTO `role_resource` VALUES ('24', '9', '1');
INSERT INTO `role_resource` VALUES ('25', '10', '1');
INSERT INTO `role_resource` VALUES ('26', '11', '1');
INSERT INTO `role_resource` VALUES ('27', '13', '2');
INSERT INTO `role_resource` VALUES ('29', '20', '1');
INSERT INTO `role_resource` VALUES ('30', '20', '4');
INSERT INTO `role_resource` VALUES ('31', '21', '1');
INSERT INTO `role_resource` VALUES ('32', '22', '1');
INSERT INTO `role_resource` VALUES ('33', '15', '2');
INSERT INTO `role_resource` VALUES ('34', '15', '4');
INSERT INTO `role_resource` VALUES ('35', '23', '1');
INSERT INTO `role_resource` VALUES ('36', '24', '1');

-- ----------------------------
-- Table structure for `scheduled_campaign`
-- ----------------------------
DROP TABLE IF EXISTS `scheduled_campaign`;
CREATE TABLE `scheduled_campaign` (
  `ACTIVE` bit(1) DEFAULT NULL,
  `CRON_EXPRESSION` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DURATION` int(11) DEFAULT NULL,
  `LAST_RAN_DATE` datetime DEFAULT NULL,
  `NO_OF_TIMES_RAN` int(11) NOT NULL DEFAULT '0',
  `CAMPAIGN_RID` bigint(20) NOT NULL,
  PRIMARY KEY (`CAMPAIGN_RID`),
  CONSTRAINT `FKey3c81q9g94mdfkhnxr0gslid` FOREIGN KEY (`CAMPAIGN_RID`) REFERENCES `campaign` (`ROW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of scheduled_campaign
-- ----------------------------

-- ----------------------------
-- Table structure for `skipped_csv_rows`
-- ----------------------------
DROP TABLE IF EXISTS `skipped_csv_rows`;
CREATE TABLE `skipped_csv_rows` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `COMMON_NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CREATED_TS` datetime DEFAULT NULL,
  `CREDENTIAL_CREATED_TS` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DISTIGUISHED_NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `EMAIL` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `END_POINT_RID` bigint(20) DEFAULT NULL,
  `ENTITLEMENT_CN` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ENTITLEMENT_CREATED_TS` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ENTITLEMENT_DESC` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ENTITLEMENT_DN` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FIRST_NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `LAST_AUTH_TS` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `LAST_NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `MANAGER` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `MIDDLE_NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CREDENTIAL_STATUS` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ERROR_DESCRIPTION` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of skipped_csv_rows
-- ----------------------------

-- ----------------------------
-- Table structure for `sod_policy`
-- ----------------------------
DROP TABLE IF EXISTS `sod_policy`;
CREATE TABLE `sod_policy` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `CREATED_TS` datetime DEFAULT NULL,
  `SOD_QUERY` longtext COLLATE utf8_unicode_ci,
  `USER_ID` bigint(20) DEFAULT NULL,
  `CUSTOMER_RID` bigint(20) DEFAULT NULL,
  `END_POINT_RID` bigint(20) DEFAULT NULL,
  `IS_SELECTED` tinyint(1) NOT NULL DEFAULT '0',
  `IS_APP_POLICY` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ROW_ID`),
  KEY `FK93fdlcpdxspm3ql6m6dfrsgau` (`CUSTOMER_RID`),
  KEY `FKf1e6n25ri6yoxxlna9fcsh4bk` (`END_POINT_RID`),
  CONSTRAINT `FK93fdlcpdxspm3ql6m6dfrsgau` FOREIGN KEY (`CUSTOMER_RID`) REFERENCES `customer` (`ROW_ID`),
  CONSTRAINT `FKf1e6n25ri6yoxxlna9fcsh4bk` FOREIGN KEY (`END_POINT_RID`) REFERENCES `end_point` (`ROW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of sod_policy
-- ----------------------------

-- ----------------------------
-- Table structure for `ssh_end_point`
-- ----------------------------
DROP TABLE IF EXISTS `ssh_end_point`;
CREATE TABLE `ssh_end_point` (
  `HOSTNAME` varchar(255) DEFAULT NULL,
  `PASSWORD` varchar(255) DEFAULT NULL,
  `PORT` int(11) DEFAULT NULL,
  `USERNAME` varchar(255) DEFAULT NULL,
  `END_POINT_RID` bigint(20) NOT NULL,
  PRIMARY KEY (`END_POINT_RID`),
  CONSTRAINT `FK5g13klt4ewkkfutwf1uvqkeb4` FOREIGN KEY (`END_POINT_RID`) REFERENCES `end_point` (`ROW_ID`),
  CONSTRAINT `SSH_END_POINT_FK1` FOREIGN KEY (`END_POINT_RID`) REFERENCES `end_point` (`ROW_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ssh_end_point
-- ----------------------------

-- ----------------------------
-- Table structure for `svn_end_point`
-- ----------------------------
DROP TABLE IF EXISTS `svn_end_point`;
CREATE TABLE `svn_end_point` (
  `SVN_AUTH_PATH` varchar(255) DEFAULT NULL,
  `SVN_POLICY_PATH` varchar(255) DEFAULT NULL,
  `SSH_END_POINT_RID` bigint(20) NOT NULL,
  PRIMARY KEY (`SSH_END_POINT_RID`),
  CONSTRAINT `FKbsx46khh9ht08xymbe2kvrnt5` FOREIGN KEY (`SSH_END_POINT_RID`) REFERENCES `ssh_end_point` (`END_POINT_RID`),
  CONSTRAINT `SVN_END_POINT_FK1` FOREIGN KEY (`SSH_END_POINT_RID`) REFERENCES `ssh_end_point` (`END_POINT_RID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of svn_end_point
-- ----------------------------

-- ----------------------------
-- Table structure for `sync_event`
-- ----------------------------
DROP TABLE IF EXISTS `sync_event`;
CREATE TABLE `sync_event` (
  `SUBTYPE` varchar(31) NOT NULL,
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `CREATED_TS` datetime DEFAULT NULL,
  `STATUS` varchar(255) DEFAULT NULL,
  `ADMIN_RID` bigint(20) DEFAULT NULL,
  `MATCHED_RID` bigint(20) DEFAULT NULL,
  `ASSIGNMENT_RID` bigint(20) DEFAULT NULL,
  `ENTITLEMENT_RID` bigint(20) DEFAULT NULL,
  `IAM_USER_RID` bigint(20) DEFAULT NULL,
  `CREDENTIAL_RID` bigint(20) DEFAULT NULL,
  `CUSTOMER_ID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`),
  KEY `SYNC_EVENT_FK1` (`CREDENTIAL_RID`),
  KEY `SYNC_EVENT_FK2` (`ENTITLEMENT_RID`),
  KEY `SYNC_EVENT_FK3` (`ASSIGNMENT_RID`),
  KEY `SYNC_EVENT_FK4` (`ADMIN_RID`),
  KEY `SYNC_EVENT_FK5` (`MATCHED_RID`),
  KEY `SYNC_EVENT_FK6` (`IAM_USER_RID`),
  CONSTRAINT `FK34kgd5ocqbg8yu0caw0qshlie` FOREIGN KEY (`ENTITLEMENT_RID`) REFERENCES `entitlement` (`ROW_ID`),
  CONSTRAINT `FK89w01iciaa3hf4to9ryedn9x1` FOREIGN KEY (`MATCHED_RID`) REFERENCES `iam_user` (`ROW_ID`),
  CONSTRAINT `FKgdorpo2c7t0rgsj9km9hsonjc` FOREIGN KEY (`ADMIN_RID`) REFERENCES `iam_user` (`ROW_ID`),
  CONSTRAINT `FKjwebf2r6hadjwgqr8sb33744c` FOREIGN KEY (`ASSIGNMENT_RID`) REFERENCES `assignment` (`ROW_ID`),
  CONSTRAINT `FKjy5k2q37bmlk0ri9spyddxl7l` FOREIGN KEY (`CREDENTIAL_RID`) REFERENCES `credential` (`ROW_ID`),
  CONSTRAINT `FKk7q8x3p7axrw4a3r8bdo2im3h` FOREIGN KEY (`IAM_USER_RID`) REFERENCES `iam_user` (`ROW_ID`),
  CONSTRAINT `SYNC_EVENT_FK1` FOREIGN KEY (`CREDENTIAL_RID`) REFERENCES `credential` (`ROW_ID`) ON DELETE CASCADE,
  CONSTRAINT `SYNC_EVENT_FK2` FOREIGN KEY (`ENTITLEMENT_RID`) REFERENCES `entitlement` (`ROW_ID`) ON DELETE CASCADE,
  CONSTRAINT `SYNC_EVENT_FK3` FOREIGN KEY (`ASSIGNMENT_RID`) REFERENCES `assignment` (`ROW_ID`) ON DELETE CASCADE,
  CONSTRAINT `SYNC_EVENT_FK4` FOREIGN KEY (`ADMIN_RID`) REFERENCES `iam_user` (`ROW_ID`),
  CONSTRAINT `SYNC_EVENT_FK5` FOREIGN KEY (`MATCHED_RID`) REFERENCES `iam_user` (`ROW_ID`),
  CONSTRAINT `SYNC_EVENT_FK6` FOREIGN KEY (`IAM_USER_RID`) REFERENCES `iam_user` (`ROW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sync_event
-- ----------------------------

-- ----------------------------
-- Table structure for `tmp_campaign_assignment`
-- ----------------------------
DROP TABLE IF EXISTS `tmp_campaign_assignment`;
CREATE TABLE `tmp_campaign_assignment` (
  `ASSIGNEE_RID` bigint(20) DEFAULT NULL,
  `CAMPAIGN_RID` bigint(20) DEFAULT NULL,
  `E_TYPE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FULL_NAME` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `OWNER_ID` bigint(20) DEFAULT NULL,
  `PENDING` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TOTAL` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `NOTIFY_TERMINATED_DATE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `NOTIFY_UPDATED_MANAGER` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of tmp_campaign_assignment
-- ----------------------------

-- ----------------------------
-- Table structure for `update_mananger_election`
-- ----------------------------
DROP TABLE IF EXISTS `update_mananger_election`;
CREATE TABLE `update_mananger_election` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ETYPE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CREATED_TS` datetime DEFAULT NULL,
  `ELECTION` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ELECTION_ID` bigint(20) DEFAULT NULL,
  `ELECTION_REF_ID` bigint(20) DEFAULT NULL,
  `TICKET_ID` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `UPDATED_TS` datetime DEFAULT NULL,
  `ASSIGNEE_RID` bigint(20) DEFAULT NULL,
  `ASSIGNMENT_RID` bigint(20) DEFAULT NULL,
  `CAMPAIGN_RID` bigint(20) DEFAULT NULL,
  `CREDENTIAL_RID` bigint(20) DEFAULT NULL,
  `REVIEWER_RID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`),
  KEY `FKldg1pn18f27jlst7rbiv0recr` (`ASSIGNEE_RID`),
  KEY `FKfp6a1lan5i6iguuih5nkf4fxd` (`ASSIGNMENT_RID`),
  KEY `FKbopodmnvyt2ugkp4m03y3w1sf` (`CAMPAIGN_RID`),
  KEY `FKlfm7as6uaepdp0jbtoogdb9h6` (`CREDENTIAL_RID`),
  KEY `FKhjx8vockr0xky1a686xoumxl2` (`REVIEWER_RID`),
  CONSTRAINT `FKbopodmnvyt2ugkp4m03y3w1sf` FOREIGN KEY (`CAMPAIGN_RID`) REFERENCES `campaign` (`ROW_ID`),
  CONSTRAINT `FKfp6a1lan5i6iguuih5nkf4fxd` FOREIGN KEY (`ASSIGNMENT_RID`) REFERENCES `assignment` (`ROW_ID`),
  CONSTRAINT `FKhjx8vockr0xky1a686xoumxl2` FOREIGN KEY (`REVIEWER_RID`) REFERENCES `iam_user` (`ROW_ID`),
  CONSTRAINT `FKldg1pn18f27jlst7rbiv0recr` FOREIGN KEY (`ASSIGNEE_RID`) REFERENCES `iam_user` (`ROW_ID`),
  CONSTRAINT `FKlfm7as6uaepdp0jbtoogdb9h6` FOREIGN KEY (`CREDENTIAL_RID`) REFERENCES `credential` (`ROW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of update_mananger_election
-- ----------------------------

-- ----------------------------
-- Table structure for `user_notification`
-- ----------------------------
DROP TABLE IF EXISTS `user_notification`;
CREATE TABLE `user_notification` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ENDPOINT_RID` bigint(20) DEFAULT NULL,
  `NOTIFICATION_TYPE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `USER_RID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`),
  KEY `FKl7hvvp4kh0ijtc95qc86cho1m` (`ENDPOINT_RID`),
  CONSTRAINT `FKl7hvvp4kh0ijtc95qc86cho1m` FOREIGN KEY (`ENDPOINT_RID`) REFERENCES `end_point` (`ROW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of user_notification
-- ----------------------------

-- ----------------------------
-- View structure for `access_control_view`
-- ----------------------------
DROP VIEW IF EXISTS `access_control_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `access_control_view` AS select `election`.`ROW_ID` AS `ROW_ID`,`election`.`CAMPAIGN_RID` AS `CAMPAIGN_RID`,`election`.`ELECTION` AS `ELECTION`,`election`.`ASSIGNEE_RID` AS `ASSIGNEE_RID`,`election`.`CREATED_TS` AS `created`,`election`.`SUBTYPE` AS `subType`,`election`.`ASSIGNMENT_RID` AS `ASSIGMENT_RID`,`election`.`ETYPE` AS `ETYPE`,`election`.`REVIEWER_RID` AS `REVIEWER_RID`,(case when (`c`.`ROW_ID` is not null) then `ce`.`NAME` else `ee`.`NAME` end) AS `END_POINT`,(case when (`c`.`ROW_ID` is not null) then `ce`.`ROW_ID` else `ee`.`ROW_ID` end) AS `END_POINT_RID`,(case when (`c`.`ROW_ID` is not null) then `c`.`CN` else `ac`.`CN` end) AS `CREDENTIAL`,(case when (`c`.`ROW_ID` is not null) then `c`.`CREDENTIAL_STATUS` else NULL end) AS `CREDENTIAL_STATUS`,(case when (`c`.`ROW_ID` is not null) then `c`.`ROW_ID` else `ac`.`ROW_ID` end) AS `CREDENTIAL_RID`,`e`.`ROW_ID` AS `ENTITLEMENT_RID`,`e`.`CN` AS `ENTITLEMENT_CN`,`e`.`DN` AS `ENTITLEMENT_DN`,`e`.`DESCRIPTION` AS `DESCRIPTION`,(case when (`c`.`ROW_ID` is not null) then `c`.`IAM_USER_RID` else `ac`.`IAM_USER_RID` end) AS `IAM_USER_RID`,count(`note`.`ELECTION_RID`) AS `NOTE_COUNT`,`ce`.`LAST_REFRESH` AS `LAST_REFRESH` from (((((((`campaign_election` `election` left join `credential` `c` on((`election`.`CREDENTIAL_RID` = `c`.`ROW_ID`))) left join `end_point` `ce` on((`c`.`END_POINT_RID` = `ce`.`ROW_ID`))) left join `assignment` `a` on((`election`.`ASSIGNMENT_RID` = `a`.`ROW_ID`))) left join `entitlement` `e` on((`a`.`ENTITLEMENT_RID` = `e`.`ROW_ID`))) left join `end_point` `ee` on((`e`.`END_POINT_RID` = `ee`.`ROW_ID`))) left join `credential` `ac` on((`a`.`CRED_RID` = `ac`.`ROW_ID`))) left join `campaign_election_note` `note` on((`note`.`ELECTION_RID` = `election`.`ROW_ID`))) where (`election`.`ETYPE` = 'D') group by `election`.`ROW_ID`,`election`.`CAMPAIGN_RID`,(case when (`c`.`ROW_ID` is not null) then `ce`.`NAME` else `ee`.`NAME` end),(case when (`c`.`ROW_ID` is not null) then `ce`.`ROW_ID` else `ee`.`ROW_ID` end),(case when (`c`.`ROW_ID` is not null) then `c`.`CN` else `ac`.`CN` end),(case when (`c`.`ROW_ID` is not null) then `c`.`ROW_ID` else `ac`.`ROW_ID` end),`e`.`CN`,`e`.`ROW_ID`,`e`.`DESCRIPTION`,(case when (`c`.`ROW_ID` is not null) then `c`.`IAM_USER_RID` else `ac`.`IAM_USER_RID` end) order by (case when (`c`.`ROW_ID` is not null) then `ce`.`NAME` else `ee`.`NAME` end),(case when (`c`.`ROW_ID` is not null) then `c`.`CN` else `ac`.`CN` end),(`e`.`CN` is not null),`e`.`CN` desc ;

-- ----------------------------
-- View structure for `direct_election_view`
-- ----------------------------
DROP VIEW IF EXISTS `direct_election_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `direct_election_view` AS select `election`.`ROW_ID` AS `ROW_ID`,`election`.`CAMPAIGN_RID` AS `CAMPAIGN_RID`,`election`.`ELECTION` AS `ELECTION`,`election`.`ASSIGNEE_RID` AS `ASSIGNEE_RID`,(case when (`c`.`ROW_ID` is not null) then `ce`.`NAME` else `ee`.`NAME` end) AS `END_POINT`,(case when (`c`.`ROW_ID` is not null) then `ce`.`ROW_ID` else `ee`.`ROW_ID` end) AS `END_POINT_RID`,(case when (`c`.`ROW_ID` is not null) then `c`.`CN` else `ac`.`CN` end) AS `CREDENTIAL`,(case when (`c`.`ROW_ID` is not null) then `c`.`ROW_ID` else `ac`.`ROW_ID` end) AS `CREDENTIAL_RID`,`e`.`CN` AS `ENTITLEMENT_CN`,`e`.`DN` AS `ENTITLEMENT_DN`,`e`.`ROW_ID` AS `ENTITLEMENT_RID`,`e`.`DESCRIPTION` AS `DESCRIPTION`,(case when (`c`.`ROW_ID` is not null) then `c`.`IAM_USER_RID` else `ac`.`IAM_USER_RID` end) AS `IAM_USER_RID`,count(`note`.`ELECTION_RID`) AS `NOTE_COUNT`,(case when (`c`.`ROW_ID` is not null) then `c`.`CREDENTIAL_STATUS` else NULL end) AS `CREDENTIAL_STATUS`,`ce`.`LAST_REFRESH` AS `LAST_REFRESH` from (((((((`campaign_election` `election` left join `credential` `c` on((`election`.`CREDENTIAL_RID` = `c`.`ROW_ID`))) left join `end_point` `ce` on((`c`.`END_POINT_RID` = `ce`.`ROW_ID`))) left join `assignment` `a` on((`election`.`ASSIGNMENT_RID` = `a`.`ROW_ID`))) left join `entitlement` `e` on((`a`.`ENTITLEMENT_RID` = `e`.`ROW_ID`))) left join `end_point` `ee` on((`e`.`END_POINT_RID` = `ee`.`ROW_ID`))) left join `credential` `ac` on((`a`.`CRED_RID` = `ac`.`ROW_ID`))) left join `campaign_election_note` `note` on((`note`.`ELECTION_RID` = `election`.`ROW_ID`))) where (`election`.`ETYPE` = 'D') group by `election`.`ROW_ID`,`election`.`CAMPAIGN_RID`,`election`.`ELECTION`,`election`.`ASSIGNEE_RID`,(case when (`c`.`ROW_ID` is not null) then `ce`.`NAME` else `ee`.`NAME` end),(case when (`c`.`ROW_ID` is not null) then `ce`.`ROW_ID` else `ee`.`ROW_ID` end),(case when (`c`.`ROW_ID` is not null) then `c`.`CN` else `ac`.`CN` end),(case when (`c`.`ROW_ID` is not null) then `c`.`ROW_ID` else `ac`.`ROW_ID` end),`e`.`CN`,`e`.`ROW_ID`,`e`.`DESCRIPTION`,(case when (`c`.`ROW_ID` is not null) then `c`.`IAM_USER_RID` else `ac`.`IAM_USER_RID` end) order by (case when (`c`.`ROW_ID` is not null) then `ce`.`NAME` else `ee`.`NAME` end),(case when (`c`.`ROW_ID` is not null) then `c`.`CN` else `ac`.`CN` end),(`e`.`CN` is not null),`e`.`CN` desc ;

-- ----------------------------
-- View structure for `end_point_election_view`
-- ----------------------------
DROP VIEW IF EXISTS `end_point_election_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `end_point_election_view` AS select `election`.`ROW_ID` AS `ROW_ID`,`election`.`CAMPAIGN_RID` AS `CAMPAIGN_RID`,`election`.`ELECTION` AS `ELECTION`,`election`.`ASSIGNEE_RID` AS `ASSIGNEE_RID`,`election`.`ETYPE` AS `ETYPE`,`c`.`END_POINT_RID` AS `END_POINT_RID`,`c`.`CN` AS `CREDENTIAL`,`c`.`ROW_ID` AS `CREDENTIAL_RID`,`u`.`FIRST_NAME` AS `FIRST_NAME`,`u`.`LAST_NAME` AS `LAST_NAME`,`ee`.`NAME` AS `END_POINT`,count(`note`.`ELECTION_RID`) AS `NOTE_COUNT`,`c`.`CREDENTIAL_STATUS` AS `CREDENTIAL_STATUS`,`ee`.`LAST_REFRESH` AS `LAST_REFRESH`,`u`.`ROW_ID` AS `IAM_USER_RID` from ((((`campaign_election` `election` left join `credential` `c` on((`election`.`CREDENTIAL_RID` = `c`.`ROW_ID`))) left join `iam_user` `u` on((`election`.`IAM_USER_RID` = `u`.`ROW_ID`))) left join `campaign_election_note` `note` on((`note`.`ELECTION_RID` = `election`.`ROW_ID`))) left join `end_point` `ee` on((`c`.`END_POINT_RID` = `ee`.`ROW_ID`))) where (`election`.`ETYPE` = 'EP') group by `election`.`ROW_ID`,`election`.`CAMPAIGN_RID`,`election`.`ELECTION`,`election`.`ASSIGNEE_RID`,`c`.`END_POINT_RID`,`c`.`CN`,`c`.`ROW_ID`,`u`.`FIRST_NAME`,`u`.`LAST_NAME` order by `c`.`CN` ;

-- ----------------------------
-- View structure for `entitlement_election_view`
-- ----------------------------
DROP VIEW IF EXISTS `entitlement_election_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `entitlement_election_view` AS select `election`.`ROW_ID` AS `ROW_ID`,`election`.`CAMPAIGN_RID` AS `CAMPAIGN_RID`,`election`.`ELECTION` AS `ELECTION`,`election`.`ASSIGNEE_RID` AS `ASSIGNEE_RID`,`election`.`ETYPE` AS `ETYPE`,`ac`.`CN` AS `CREDENTIAL`,`ac`.`ROW_ID` AS `CREDENTIAL_RID`,`e`.`ROW_ID` AS `ENTITLEMENT_RID`,`u`.`FIRST_NAME` AS `FIRST_NAME`,`u`.`LAST_NAME` AS `LAST_NAME`,count(`note`.`ELECTION_RID`) AS `NOTE_COUNT`,`ac`.`CREDENTIAL_STATUS` AS `CREDENTIAL_STATUS`,`ep`.`LAST_REFRESH` AS `LAST_REFRESH`,`ee`.`NAME` AS `END_POINT`,`e`.`CN` AS `E_CN`,`e`.`DN` AS `E_DN`,`u`.`ROW_ID` AS `IAM_USER_RID` from (((((((`campaign_election` `election` left join `assignment` `a` on((`election`.`ASSIGNMENT_RID` = `a`.`ROW_ID`))) left join `entitlement` `e` on((`a`.`ENTITLEMENT_RID` = `e`.`ROW_ID`))) left join `end_point` `ee` on((`e`.`END_POINT_RID` = `ee`.`ROW_ID`))) left join `credential` `ac` on((`a`.`CRED_RID` = `ac`.`ROW_ID`))) left join `iam_user` `u` on((`election`.`IAM_USER_RID` = `u`.`ROW_ID`))) left join `campaign_election_note` `note` on((`note`.`ELECTION_RID` = `election`.`ROW_ID`))) left join `end_point` `ep` on((`ac`.`END_POINT_RID` = `ep`.`ROW_ID`))) where (`election`.`ETYPE` = 'E') group by `election`.`ROW_ID`,`election`.`CAMPAIGN_RID`,`election`.`ELECTION`,`election`.`ASSIGNEE_RID`,`ac`.`CN`,`ac`.`ROW_ID`,`e`.`ROW_ID`,`u`.`FIRST_NAME`,`u`.`LAST_NAME` order by `ac`.`CN` ;

-- ----------------------------
-- View structure for `sync_event_view`
-- ----------------------------
DROP VIEW IF EXISTS `sync_event_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sync_event_view` AS select `se`.`ROW_ID` AS `ROW_ID`,`se`.`STATUS` AS `STATUS`,`se`.`SUBTYPE` AS `EVT_TYPE`,(case when (`se`.`SUBTYPE` = 'A') then `ac`.`CN` else `c`.`CN` end) AS `CREDENTIAL`,(case when (`se`.`SUBTYPE` = 'A') then `ae`.`CN` else `e`.`CN` end) AS `ENTITLEMENT`,(case when (`se`.`SUBTYPE` = 'A') then `ac`.`ROW_ID` else `c`.`ROW_ID` end) AS `CREDENTIAL_RID`,(case when (`se`.`SUBTYPE` = 'A') then `ae`.`ROW_ID` else `e`.`ROW_ID` end) AS `ENTITLEMENT_RID`,`admin`.`EMAIL` AS `ADMIN`,(case when (`se`.`STATUS` = 'M') then (case when isnull(`matched`.`EMAIL`) then (`matched`.`FIRST_NAME` or ' ' or `matched`.`LAST_NAME` or ' (NO EMAIL)') else `matched`.`EMAIL` end) when (`se`.`SUBTYPE` = 'U') then (case when isnull(`iam`.`EMAIL`) then (`iam`.`FIRST_NAME` or ' ' or `iam`.`LAST_NAME` or ' (NO EMAIL)') else `iam`.`EMAIL` end) else NULL end) AS `IAM_USER`,`se`.`CUSTOMER_ID` AS `CUSTOMER_ID`,`se`.`CREATED_TS` AS `CREATED` from ((((((((`sync_event` `se` left join `credential` `c` on((`se`.`CREDENTIAL_RID` = `c`.`ROW_ID`))) left join `entitlement` `e` on((`se`.`ENTITLEMENT_RID` = `e`.`ROW_ID`))) left join `iam_user` `matched` on((`se`.`MATCHED_RID` = `matched`.`ROW_ID`))) left join `iam_user` `admin` on((`se`.`ADMIN_RID` = `admin`.`ROW_ID`))) left join `iam_user` `iam` on((`se`.`IAM_USER_RID` = `iam`.`ROW_ID`))) left join `assignment` `a` on((`se`.`ASSIGNMENT_RID` = `a`.`ROW_ID`))) left join `credential` `ac` on((`a`.`CRED_RID` = `ac`.`ROW_ID`))) left join `entitlement` `ae` on((`a`.`ENTITLEMENT_RID` = `ae`.`ROW_ID`))) ;

-- ----------------------------
-- Procedure structure for `Proc_campaignpreview_data`
-- ----------------------------
DROP PROCEDURE IF EXISTS `Proc_campaignpreview_data`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Proc_campaignpreview_data`(
IN campaignId long,IN customerId long,OUT stat INT
)
BEGIN
delete from campaignpreview where CUSTOMER_RID=customerId and CAMPAIGN_RID=campaignId;
commit;
SET stat =0;
INSERT into campaignpreview(ROW_ID , FIRST_NAME,LAST_NAME ,EMAIL ,TOTAL,PENDING , CUSTOMER_RID, CAMPAIGN_RID)
SELECT 
m.ROW_ID AS ROW_ID,
m.FIRST_NAME AS FIRST_NAME,
m.LAST_NAME AS LAST_NAME,
m.EMAIL AS EMAIL,
COUNT(ce.ROW_ID) AS TOTAL,
COUNT((CASE WHEN (ce.ELECTION = 'P') THEN ce.ROW_ID
ELSE NULL END)) AS PENDING,
m.CUSTOMER_RID AS CUSTOMER_RID,
ce.CAMPAIGN_RID AS CAMPAIGN_RID
FROM (campaign_election ce JOIN iam_user m)
WHERE (m.ROW_ID = ce.ASSIGNEE_RID) and m.CUSTOMER_RID=customerId and ce.CAMPAIGN_RID=campaignId
GROUP BY m.ROW_ID , m.FIRST_NAME , m.LAST_NAME , m.EMAIL , m.CUSTOMER_RID , ce.CAMPAIGN_RID ;
commit;
SET stat =1;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `Proc_userdata`
-- ----------------------------
DROP PROCEDURE IF EXISTS `Proc_userdata`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Proc_userdata`(IN campaignId long,IN assigneeId long,out pendingCount int,out totalCount int,OUT stat int)
BEGIN
Delete from tmp_campaign_assignment;

Commit;
set stat=0;

Insert into tmp_campaign_assignment
select
ce.ASSIGNEE_RID,
ce.CAMPAIGN_RID,
ce.etype,
concat (ifnull(u.first_name,''), ' ', ifnull(u.last_name,'')) as fname,
u.row_id,
COUNT(CASE
WHEN ce.election = 'P' THEN ce.row_id
ELSE NULL
END) AS PENDING,
COUNT(ce.row_id) as TOTAL,ce.NOTIFY_TERMINATED_DATE, ce.NOTIFY_UPDATED_MANAGER
FROM
campaign_election ce
LEFT JOIN
credential c ON (ce.credential_rid = c.row_id and ce.credential_rid is not null)
LEFT JOIN
assignment a ON (ce.assignment_rid = a.row_id and ce.assignment_rid is not null)
LEFT JOIN
credential ac ON a.cred_rid = ac.row_id
INNER JOIN
iam_user u ON (ce.iam_user_rid = u.row_id
OR ce.iam_user_rid = u.row_id)
WHERE ce.etype = 'D' and CAMPAIGN_RID=campaignId
GROUP BY ce.etype , u.row_id , u.first_name , u.last_name, ce.ASSIGNEE_RID,ce.CAMPAIGN_RID,ce.NOTIFY_TERMINATED_DATE, ce.NOTIFY_UPDATED_MANAGER;

Commit;

Insert into tmp_campaign_assignment
SELECT 
ce.ASSIGNEE_RID,
ce.CAMPAIGN_RID,
ce.etype,
concat (e.cn, ' (', ep.name,')') as fname,
e.row_id AS owner,
COUNT(CASE
WHEN ce.election = 'P' THEN ce.row_id
ELSE NULL
END) AS PENDING,
COUNT(ce.row_id) as TOTAL,ce.NOTIFY_TERMINATED_DATE, ce.NOTIFY_UPDATED_MANAGER
FROM
campaign_election ce
LEFT JOIN
assignment a ON ce.assignment_rid = a.row_id
LEFT JOIN
entitlement e ON a.entitlement_rid = e.row_id
LEFT JOIN
end_point ep ON e.end_point_rid = ep.row_id
WHERE ce.etype = 'E' and CAMPAIGN_RID=campaignId
GROUP BY ce.etype , e.row_id , e.cn , ep.name,ce.ASSIGNEE_RID, ce.CAMPAIGN_RID,ce.NOTIFY_TERMINATED_DATE, ce.NOTIFY_UPDATED_MANAGER;

Commit;

Insert into tmp_campaign_assignment
SELECT 
ce.ASSIGNEE_RID,
ce.CAMPAIGN_RID,
ce.etype,
ep.NAME,
ep.row_id as owner,
count(case when ce.election = 'P' then ce.row_id else NULL end) as pending ,
count(ce.row_id) total,ce.NOTIFY_TERMINATED_DATE, ce.NOTIFY_UPDATED_MANAGER
from campaign_election ce 
left join credential c on ce.credential_rid = c.row_id 
left join end_point ep on c.end_point_rid = ep.row_id 
where 
ce.etype = 'EP' and CAMPAIGN_RID=campaignId
group by 
ce.etype, ep.row_id, ep.name ,ce.ASSIGNEE_RID,ce.CAMPAIGN_RID,ce.NOTIFY_TERMINATED_DATE, ce.NOTIFY_UPDATED_MANAGER;

Commit;

Delete from campaign_assignment_ui where CAMPAIGN_RID=campaignId;

Commit;

insert into campaign_assignment_ui(ASSIGNEE_RID, CAMPAIGN_RID, E_TYPE, FULL_NAME, OWNER_ID, PENDING, TOTAL, NOTIFY_TERMINATED_DATE, NOTIFY_UPDATED_MANAGER)
select ASSIGNEE_RID, CAMPAIGN_RID, E_TYPE, FULL_NAME, OWNER_ID, PENDING, TOTAL, NOTIFY_TERMINATED_DATE, NOTIFY_UPDATED_MANAGER from tmp_campaign_assignment;

Commit;

SELECT 
SUM(PENDING), SUM(TOTAL)
INTO pendingCount , totalCount FROM
campaign_assignment_ui
WHERE
CAMPAIGN_RID = campaignId
AND ASSIGNEE_RID = assigneeId;

set stat=1;

END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `soundex_match`
-- ----------------------------
DROP FUNCTION IF EXISTS `soundex_match`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `soundex_match`(
needle varchar(128), haystack text, splitChar varchar(1)) RETURNS tinyint(4)
    DETERMINISTIC
BEGIN
declare spacePos int;
declare searchLen int default 0;
declare curWord varchar(128) default '';
declare tempStr text default haystack;
declare tmp text default '';
declare soundx1 varchar(64) default '';
declare soundx2 varchar(64) default ''; 

set searchLen = length(haystack);
set spacePos = locate(splitChar, tempStr);
set soundx1 = soundex(needle);

while searchLen > 0 do
if spacePos = 0 then
set tmp = tempStr;
select soundex(tmp) into soundx2;
if soundx1 = soundx2 then
return 1;
else
return 0;
end if;
else
set tmp = substr(tempStr, 1, spacePos-1);
set soundx2 = soundex(tmp);
if soundx1 = soundx2 then
return 1;
end if;

set tempStr = substr(tempStr, spacePos+1);
set searchLen = length(tempStr);
end if; 

set spacePos = locate(splitChar, tempStr);
end while; 

return 0;
END
;;
DELIMITER ;
