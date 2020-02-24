/*
Navicat MySQL Data Transfer

Source Server         : 31_QA_New_copy
Source Server Version : 50727
Source Host           : 192.168.1.31:3312
Source Database       : cem_controller

Target Server Type    : MYSQL
Target Server Version : 50727
File Encoding         : 65001

Date: 2019-11-11 17:57:05
*/

SET FOREIGN_KEY_CHECKS=0;
CREATE DATABASE cem_controller CHARACTER SET utf8 COLLATE utf8_unicode_ci;

USE cem_controller;
-- ----------------------------
-- Table structure for `agent_data`
-- ----------------------------
DROP TABLE IF EXISTS `agent_data`;
CREATE TABLE `agent_data` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `AGENT_ID` bigint(20) DEFAULT NULL,
  `ATTRIBUTE_FIELD` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `COMMON_NAME` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATED_TS` datetime DEFAULT NULL,
  `CRED_CREATED_TS` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `distiguished_name` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `EMAIL` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ENTITLEMENT_CN` longtext COLLATE utf8_bin,
  `ENTITLEMENT_CREATED_TS` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ENTITLEMENT_DESC` longtext COLLATE utf8_bin,
  `ENTITLEMENT_DN` longtext COLLATE utf8_bin,
  `FIRST_NAME` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `IS_ROLE` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LAST_AUTH_TS` datetime DEFAULT NULL,
  `LAST_NAME` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `MANAGER` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `MIDDLE_NAME` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREDENTIAL_STATUS` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ADDITIONAL_COLUMNS` longtext COLLATE utf8_bin,
  `USER_ID` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ----------------------------
-- Records of AGENT_DATA
-- ----------------------------

-- ----------------------------
-- Table structure for `events`
-- ----------------------------
DROP TABLE IF EXISTS `events`;
CREATE TABLE `events` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `AGENT_ID` bigint(20) DEFAULT NULL,
  `AGENT_TYPE` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `STATUS` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `IAM_USER_RID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of EVENTS
-- ----------------------------

-- ----------------------------
-- Table structure for `GITHUB_AGENT_TOKEN`
-- ----------------------------
DROP TABLE IF EXISTS `github_agent_token`;
CREATE TABLE `github_agent_token` (
  `ROW_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `AGENT_ID` bigint(20) DEFAULT NULL,
  `TOKEN` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ROW_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


