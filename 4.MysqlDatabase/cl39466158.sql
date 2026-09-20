-- MySQL dump 10.13  Distrib 5.7.31, for Linux (x86_64)
--
-- Host: localhost    Database: cl39466158
-- ------------------------------------------------------
-- Server version	5.7.31

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
-- Current Database: `cl39466158`
--

/*!40000 DROP DATABASE IF EXISTS `cl39466158`*/;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `cl39466158` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `cl39466158`;

--
-- Table structure for table `cheliangxinxi`
--

DROP TABLE IF EXISTS `cheliangxinxi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cheliangxinxi` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `cheliangbianhao` varchar(200) DEFAULT NULL COMMENT '车辆编号',
  `chepaihao` varchar(200) DEFAULT NULL COMMENT '车牌号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1710727509449 DEFAULT CHARSET=utf8 COMMENT='车辆信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cheliangxinxi`
--

LOCK TABLES `cheliangxinxi` WRITE;
/*!40000 ALTER TABLE `cheliangxinxi` DISABLE KEYS */;
INSERT INTO `cheliangxinxi` VALUES (101,'2024-03-18 02:01:20','车辆编号1','车牌号1'),(102,'2024-03-18 02:01:20','车辆编号2','车牌号2'),(103,'2024-03-18 02:01:20','车辆编号3','车牌号3'),(104,'2024-03-18 02:01:20','车辆编号4','车牌号4'),(105,'2024-03-18 02:01:20','车辆编号5','车牌号5'),(106,'2024-03-18 02:01:20','车辆编号6','车牌号6'),(1710727509448,'2024-03-18 02:05:09','2号车','02301');
/*!40000 ALTER TABLE `cheliangxinxi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) NOT NULL COMMENT '配置参数名称',
  `value` varchar(100) DEFAULT NULL COMMENT '配置参数值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='配置文件';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config`
--

LOCK TABLES `config` WRITE;
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT INTO `config` VALUES (1,'swiper1','file/swiperPicture1.jpg'),(2,'swiper2','file/swiperPicture2.jpg'),(3,'swiper3','file/swiperPicture3.jpg');
/*!40000 ALTER TABLE `config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jiaozhigong`
--

DROP TABLE IF EXISTS `jiaozhigong`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jiaozhigong` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `jiaoshigonghao` varchar(200) NOT NULL COMMENT '教师工号',
  `mima` varchar(200) NOT NULL COMMENT '密码',
  `jiaoshixingming` varchar(200) NOT NULL COMMENT '教师姓名',
  `touxiang` longtext COMMENT '头像',
  `lianxidianhua` varchar(200) DEFAULT NULL COMMENT '联系电话',
  `xingbie` varchar(200) DEFAULT NULL COMMENT '性别',
  PRIMARY KEY (`id`),
  UNIQUE KEY `jiaoshigonghao` (`jiaoshigonghao`)
) ENGINE=InnoDB AUTO_INCREMENT=1710727685516 DEFAULT CHARSET=utf8 COMMENT='教职工';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jiaozhigong`
--

LOCK TABLES `jiaozhigong` WRITE;
/*!40000 ALTER TABLE `jiaozhigong` DISABLE KEYS */;
INSERT INTO `jiaozhigong` VALUES (41,'2024-03-18 02:01:20','教师工号1','123456','教师姓名1','file/jiaozhigongTouxiang1.jpg','19819881111','男'),(42,'2024-03-18 02:01:20','教师工号2','123456','教师姓名2','file/jiaozhigongTouxiang2.jpg','19819881112','男'),(43,'2024-03-18 02:01:20','教师工号3','123456','教师姓名3','file/jiaozhigongTouxiang3.jpg','19819881113','男'),(44,'2024-03-18 02:01:20','教师工号4','123456','教师姓名4','file/jiaozhigongTouxiang4.jpg','19819881114','男'),(46,'2024-03-18 02:01:20','教师工号6','123456','教师姓名6','file/jiaozhigongTouxiang6.jpg','19819881116','男'),(1710727685515,'2024-03-18 02:08:05','1','1','李记','file/1710727680743.jpg','13201201201','男');
/*!40000 ALTER TABLE `jiaozhigong` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jiashiyuan`
--

DROP TABLE IF EXISTS `jiashiyuan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jiashiyuan` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `jiashiyuanzhanghao` varchar(200) NOT NULL COMMENT '驾驶员账号',
  `jiashiyuanmima` varchar(200) NOT NULL COMMENT '驾驶员密码',
  `jiashiyuanxingming` varchar(200) NOT NULL COMMENT '驾驶员姓名',
  `xingbie` varchar(200) DEFAULT NULL COMMENT '性别',
  `lianxidianhua` varchar(200) DEFAULT NULL COMMENT '联系电话',
  PRIMARY KEY (`id`),
  UNIQUE KEY `jiashiyuanzhanghao` (`jiashiyuanzhanghao`)
) ENGINE=InnoDB AUTO_INCREMENT=1710727454599 DEFAULT CHARSET=utf8 COMMENT='驾驶员';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jiashiyuan`
--

LOCK TABLES `jiashiyuan` WRITE;
/*!40000 ALTER TABLE `jiashiyuan` DISABLE KEYS */;
INSERT INTO `jiashiyuan` VALUES (51,'2024-03-18 02:01:20','驾驶员账号1','123456','驾驶员姓名1','男','19819881111'),(52,'2024-03-18 02:01:20','驾驶员账号2','123456','驾驶员姓名2','男','19819881112'),(53,'2024-03-18 02:01:20','驾驶员账号3','123456','驾驶员姓名3','男','19819881113'),(54,'2024-03-18 02:01:20','驾驶员账号4','123456','驾驶员姓名4','男','19819881114'),(55,'2024-03-18 02:01:20','驾驶员账号5','123456','驾驶员姓名5','男','19819881115'),(56,'2024-03-18 02:01:20','驾驶员账号6','123456','驾驶员姓名6','男','19819881116'),(1710727454598,'2024-03-18 02:04:14','111','111','司机','','');
/*!40000 ALTER TABLE `jiashiyuan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jiashiyuanquerenxinxi`
--

DROP TABLE IF EXISTS `jiashiyuanquerenxinxi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jiashiyuanquerenxinxi` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `luxianmingcheng` varchar(200) NOT NULL COMMENT '路线名称',
  `qidian` varchar(200) NOT NULL COMMENT '起点',
  `tingkaozhandian` varchar(200) DEFAULT NULL COMMENT '停靠站点',
  `zhongdian` varchar(200) NOT NULL COMMENT '终点',
  `xueshengzhanghao` varchar(200) DEFAULT NULL COMMENT '学生账号',
  `xueshengxingming` varchar(200) DEFAULT NULL COMMENT '学生姓名',
  `cheliangbianhao` varchar(200) DEFAULT NULL COMMENT '车辆编号',
  `chepaihao` varchar(200) DEFAULT NULL COMMENT '车牌号',
  `jiashiyuanzhanghao` varchar(200) DEFAULT NULL COMMENT '驾驶员账号',
  `jiashiyuanxingming` varchar(200) DEFAULT NULL COMMENT '驾驶员姓名',
  `querenshijian` datetime DEFAULT NULL COMMENT '确认时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1710727630794 DEFAULT CHARSET=utf8 COMMENT='驾驶员确认信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jiashiyuanquerenxinxi`
--

LOCK TABLES `jiashiyuanquerenxinxi` WRITE;
/*!40000 ALTER TABLE `jiashiyuanquerenxinxi` DISABLE KEYS */;
INSERT INTO `jiashiyuanquerenxinxi` VALUES (111,'2024-03-18 02:01:20','路线名称1','起点1','停靠站点1','终点1','学生账号1','学生姓名1','车辆编号1','车牌号1','驾驶员账号1','驾驶员姓名1','2024-03-18 10:01:20'),(112,'2024-03-18 02:01:20','路线名称2','起点2','停靠站点2','终点2','学生账号2','学生姓名2','车辆编号2','车牌号2','驾驶员账号2','驾驶员姓名2','2024-03-18 10:01:20'),(113,'2024-03-18 02:01:20','路线名称3','起点3','停靠站点3','终点3','学生账号3','学生姓名3','车辆编号3','车牌号3','驾驶员账号3','驾驶员姓名3','2024-03-18 10:01:20'),(114,'2024-03-18 02:01:20','路线名称4','起点4','停靠站点4','终点4','学生账号4','学生姓名4','车辆编号4','车牌号4','驾驶员账号4','驾驶员姓名4','2024-03-18 10:01:20'),(115,'2024-03-18 02:01:20','路线名称5','起点5','停靠站点5','终点5','学生账号5','学生姓名5','车辆编号5','车牌号5','驾驶员账号5','驾驶员姓名5','2024-03-18 10:01:20'),(116,'2024-03-18 02:01:20','路线名称6','起点6','停靠站点6','终点6','学生账号6','学生姓名6','车辆编号6','车牌号6','驾驶员账号6','驾驶员姓名6','2024-03-18 10:01:20'),(1710727630793,'2024-03-18 02:07:10','线路1','学校','订单,ddd','学校','11','李玉','2号车','02301','111','司机','2024-03-18 10:07:07');
/*!40000 ALTER TABLE `jiashiyuanquerenxinxi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `menujson` longtext COMMENT '菜单',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='菜单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,'2024-03-18 02:01:20','[{\"backMenu\":[{\"child\":[{\"appFrontIcon\":\"cuIcon-shop\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"menu\":\"轮播图\",\"menuJump\":\"列表\",\"tableName\":\"config\"}],\"fontClass\":\"icon-common37\",\"menu\":\"轮播图管理\",\"unicode\":\"&#xeea4;\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-addressbook\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"menu\":\"管理员\",\"menuJump\":\"列表\",\"tableName\":\"users\"},{\"appFrontIcon\":\"cuIcon-link\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"menu\":\"学生\",\"menuJump\":\"列表\",\"tableName\":\"xuesheng\"},{\"appFrontIcon\":\"cuIcon-keyboard\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"menu\":\"教职工\",\"menuJump\":\"列表\",\"tableName\":\"jiaozhigong\"},{\"appFrontIcon\":\"cuIcon-clothes\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"menu\":\"驾驶员\",\"menuJump\":\"列表\",\"tableName\":\"jiashiyuan\"}],\"fontClass\":\"icon-common2\",\"menu\":\"用户管理\",\"unicode\":\"&#xeda4;\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-explore\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"menu\":\"线路信息\",\"menuJump\":\"列表\",\"tableName\":\"xianluxinxi\"}],\"fontClass\":\"icon-common39\",\"menu\":\"线路信息管理\",\"unicode\":\"&#xeeba;\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-brand\",\"buttons\":[\"查看\",\"修改\",\"删除\",\"审核\",\"反馈\"],\"menu\":\"线路预约\",\"menuJump\":\"列表\",\"tableName\":\"xianluyuyue\"}],\"fontClass\":\"icon-common34\",\"menu\":\"线路预约管理\",\"unicode\":\"&#xee85;\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-attentionfavor\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"menu\":\"预约结果\",\"menuJump\":\"列表\",\"tableName\":\"yuyuejieguo\"}],\"fontClass\":\"icon-common19\",\"menu\":\"预约结果管理\",\"unicode\":\"&#xee00;\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-full\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"menu\":\"车辆信息\",\"menuJump\":\"列表\",\"tableName\":\"cheliangxinxi\"}],\"fontClass\":\"icon-common40\",\"menu\":\"车辆信息管理\",\"unicode\":\"&#xeebb;\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-link\",\"buttons\":[\"查看\",\"修改\",\"删除\"],\"menu\":\"驾驶员确认信息\",\"menuJump\":\"列表\",\"tableName\":\"jiashiyuanquerenxinxi\"}],\"fontClass\":\"icon-common10\",\"menu\":\"驾驶员确认信息管理\",\"unicode\":\"&#xedd1;\"}],\"frontMenu\":[{\"child\":[{\"appFrontIcon\":\"cuIcon-list\",\"buttons\":[\"查看\",\"预约\"],\"menu\":\"线路信息\",\"menuJump\":\"列表\",\"tableName\":\"xianluxinxi\"}],\"menu\":\"线路信息管理\"}],\"hasBackLogin\":\"是\",\"hasBackRegister\":\"否\",\"hasFrontLogin\":\"否\",\"hasFrontRegister\":\"否\",\"roleName\":\"管理员\",\"tableName\":\"users\"},{\"backMenu\":[{\"child\":[{\"appFrontIcon\":\"cuIcon-brand\",\"buttons\":[\"查看\",\"修改\",\"删除\"],\"menu\":\"线路预约\",\"menuJump\":\"列表\",\"tableName\":\"xianluyuyue\"}],\"fontClass\":\"icon-common34\",\"menu\":\"线路预约管理\",\"unicode\":\"&#xee85;\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-attentionfavor\",\"buttons\":[\"查看\",\"删除\"],\"menu\":\"预约结果\",\"menuJump\":\"列表\",\"tableName\":\"yuyuejieguo\"}],\"fontClass\":\"icon-common19\",\"menu\":\"预约结果管理\",\"unicode\":\"&#xee00;\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-goods\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"menu\":\"我的收藏\",\"menuJump\":\"1\",\"tableName\":\"storeup\"}],\"fontClass\":\"icon-common2\",\"menu\":\"我的收藏管理\",\"unicode\":\"&#xeda4;\"}],\"frontMenu\":[{\"child\":[{\"appFrontIcon\":\"cuIcon-list\",\"buttons\":[\"查看\",\"预约\"],\"menu\":\"线路信息\",\"menuJump\":\"列表\",\"tableName\":\"xianluxinxi\"}],\"menu\":\"线路信息管理\"}],\"hasBackLogin\":\"否\",\"hasBackRegister\":\"否\",\"hasFrontLogin\":\"是\",\"hasFrontRegister\":\"是\",\"roleName\":\"学生\",\"tableName\":\"xuesheng\"},{\"backMenu\":[{\"child\":[{\"appFrontIcon\":\"cuIcon-explore\",\"buttons\":[\"查看\"],\"menu\":\"线路信息\",\"menuJump\":\"列表\",\"tableName\":\"xianluxinxi\"}],\"fontClass\":\"icon-common39\",\"menu\":\"线路信息管理\",\"unicode\":\"&#xeeba;\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-brand\",\"buttons\":[\"查看\"],\"menu\":\"线路预约\",\"menuJump\":\"列表\",\"tableName\":\"xianluyuyue\"}],\"fontClass\":\"icon-common34\",\"menu\":\"线路预约管理\",\"unicode\":\"&#xee85;\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-attentionfavor\",\"buttons\":[\"查看\"],\"menu\":\"预约结果\",\"menuJump\":\"列表\",\"tableName\":\"yuyuejieguo\"}],\"fontClass\":\"icon-common19\",\"menu\":\"预约结果管理\",\"unicode\":\"&#xee00;\"}],\"frontMenu\":[{\"child\":[{\"appFrontIcon\":\"cuIcon-list\",\"buttons\":[\"查看\",\"预约\"],\"menu\":\"线路信息\",\"menuJump\":\"列表\",\"tableName\":\"xianluxinxi\"}],\"menu\":\"线路信息管理\"}],\"hasBackLogin\":\"是\",\"hasBackRegister\":\"是\",\"hasFrontLogin\":\"否\",\"hasFrontRegister\":\"否\",\"roleName\":\"教职工\",\"tableName\":\"jiaozhigong\"},{\"backMenu\":[{\"child\":[{\"appFrontIcon\":\"cuIcon-attentionfavor\",\"buttons\":[\"查看\",\"确认\"],\"menu\":\"预约结果\",\"menuJump\":\"列表\",\"tableName\":\"yuyuejieguo\"}],\"fontClass\":\"icon-common19\",\"menu\":\"预约结果管理\",\"unicode\":\"&#xee00;\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-link\",\"buttons\":[\"查看\",\"修改\",\"删除\"],\"menu\":\"驾驶员确认信息\",\"menuJump\":\"列表\",\"tableName\":\"jiashiyuanquerenxinxi\"}],\"fontClass\":\"icon-common10\",\"menu\":\"驾驶员确认信息管理\",\"unicode\":\"&#xedd1;\"}],\"frontMenu\":[{\"child\":[{\"appFrontIcon\":\"cuIcon-list\",\"buttons\":[\"查看\",\"预约\"],\"menu\":\"线路信息\",\"menuJump\":\"列表\",\"tableName\":\"xianluxinxi\"}],\"menu\":\"线路信息管理\"}],\"hasBackLogin\":\"是\",\"hasBackRegister\":\"否\",\"hasFrontLogin\":\"否\",\"hasFrontRegister\":\"否\",\"roleName\":\"驾驶员\",\"tableName\":\"jiashiyuan\"}]');
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `storeup`
--

DROP TABLE IF EXISTS `storeup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `storeup` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `refid` bigint(20) DEFAULT NULL COMMENT 'refid',
  `tablename` varchar(200) DEFAULT NULL COMMENT '表名',
  `name` varchar(200) NOT NULL COMMENT '名称',
  `picture` longtext NOT NULL COMMENT '图片',
  `type` varchar(200) DEFAULT NULL COMMENT '类型(1:收藏,21:赞,22:踩,31:竞拍参与,41:关注)',
  `inteltype` varchar(200) DEFAULT NULL COMMENT '推荐类型',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1710727575887 DEFAULT CHARSET=utf8 COMMENT='我的收藏';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storeup`
--

LOCK TABLES `storeup` WRITE;
/*!40000 ALTER TABLE `storeup` DISABLE KEYS */;
INSERT INTO `storeup` VALUES (1710727575886,'2024-03-18 02:06:15',1710727486712,'xianluxinxi','线路1','file/1710727466942.jpg','1',NULL,NULL,1710727536361);
/*!40000 ALTER TABLE `storeup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token`
--

DROP TABLE IF EXISTS `token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `token` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  `username` varchar(100) NOT NULL COMMENT '用户名',
  `tablename` varchar(100) DEFAULT NULL COMMENT '表名',
  `role` varchar(100) DEFAULT NULL COMMENT '角色',
  `token` varchar(200) NOT NULL COMMENT '密码',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `expiratedtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '过期时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='token表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token`
--

LOCK TABLES `token` WRITE;
/*!40000 ALTER TABLE `token` DISABLE KEYS */;
INSERT INTO `token` VALUES (1,1,'admin','users','管理员','y0exd9m3k4fmf03tt2x4y9vrdxw51jq8','2024-03-18 02:03:47','2024-03-18 03:07:22'),(2,1710727536361,'11','xuesheng','学生','88es86bva9550qs50nmpoh8vk06b6010','2024-03-18 02:05:41','2024-03-18 03:05:43'),(3,1710727454598,'111','jiashiyuan','驾驶员','h60a4cgbtwbdccvj16u5x4wxkdbuglhe','2024-03-18 02:07:04','2024-03-18 03:07:05'),(4,1710727685515,'1','jiaozhigong','管理员','0xslnh2ec3mhezk4ob3rzsjszyns9wjr','2024-03-18 02:08:11','2024-03-18 03:08:11');
/*!40000 ALTER TABLE `token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `username` varchar(200) NOT NULL COMMENT '用户名',
  `password` varchar(200) NOT NULL COMMENT '密码',
  `role` varchar(200) DEFAULT NULL COMMENT '角色',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='管理员';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'2024-03-18 02:01:20','admin','admin','管理员');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xianluxinxi`
--

DROP TABLE IF EXISTS `xianluxinxi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xianluxinxi` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `xianlumingcheng` varchar(200) NOT NULL COMMENT '线路名称',
  `xianlutupian` longtext COMMENT '线路图片',
  `qidian` varchar(200) NOT NULL COMMENT '起点',
  `tingkaozhandian` varchar(200) DEFAULT NULL COMMENT '停靠站点',
  `zhongdian` varchar(200) NOT NULL COMMENT '终点',
  `luxianxiangqing` longtext COMMENT '路线详情',
  `storeupnum` int(11) DEFAULT NULL COMMENT '收藏数量',
  `clicktime` datetime DEFAULT NULL COMMENT '最近点击时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1710727486713 DEFAULT CHARSET=utf8 COMMENT='线路信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xianluxinxi`
--

LOCK TABLES `xianluxinxi` WRITE;
/*!40000 ALTER TABLE `xianluxinxi` DISABLE KEYS */;
INSERT INTO `xianluxinxi` VALUES (61,'2024-03-18 02:01:20','线路名称1','file/xianluxinxiXianlutupian1.jpg,file/xianluxinxiXianlutupian2.jpg,file/xianluxinxiXianlutupian3.jpg','起点1','停靠站点1','终点1','路线详情1',1,'2024-03-18 10:01:20'),(62,'2024-03-18 02:01:20','线路名称2','file/xianluxinxiXianlutupian2.jpg,file/xianluxinxiXianlutupian3.jpg,file/xianluxinxiXianlutupian4.jpg','起点2','停靠站点2','终点2','路线详情2',2,'2024-03-18 10:01:20'),(63,'2024-03-18 02:01:20','线路名称3','file/xianluxinxiXianlutupian3.jpg,file/xianluxinxiXianlutupian4.jpg,file/xianluxinxiXianlutupian5.jpg','起点3','停靠站点3','终点3','路线详情3',3,'2024-03-18 10:01:20'),(64,'2024-03-18 02:01:20','线路名称4','file/xianluxinxiXianlutupian4.jpg,file/xianluxinxiXianlutupian5.jpg,file/xianluxinxiXianlutupian6.jpg','起点4','停靠站点4','终点4','路线详情4',4,'2024-03-18 10:01:20'),(65,'2024-03-18 02:01:20','线路名称5','file/xianluxinxiXianlutupian5.jpg,file/xianluxinxiXianlutupian6.jpg,file/xianluxinxiXianlutupian7.jpg','起点5','停靠站点5','终点5','路线详情5',5,'2024-03-18 10:01:20'),(66,'2024-03-18 02:01:20','线路名称6','file/xianluxinxiXianlutupian6.jpg,file/xianluxinxiXianlutupian7.jpg,file/xianluxinxiXianlutupian8.jpg','起点6','停靠站点6','终点6','路线详情6',6,'2024-03-18 10:01:20'),(1710727486712,'2024-03-18 02:04:45','线路1','file/1710727466942.jpg','学校','订单,ddd','学校','<p>111</p>',1,NULL);
/*!40000 ALTER TABLE `xianluxinxi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xianluyuyue`
--

DROP TABLE IF EXISTS `xianluyuyue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xianluyuyue` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `xianlumingcheng` varchar(200) NOT NULL COMMENT '线路名称',
  `tingkaozhandian` varchar(200) DEFAULT NULL COMMENT '停靠站点',
  `qidian` varchar(200) DEFAULT NULL COMMENT '起点',
  `zhongdian` varchar(200) DEFAULT NULL COMMENT '终点',
  `xueshengzhanghao` varchar(200) DEFAULT NULL COMMENT '学生账号',
  `xueshengxingming` varchar(200) DEFAULT NULL COMMENT '学生姓名',
  `sfsh` varchar(200) DEFAULT NULL COMMENT '是否审核',
  `shhf` longtext COMMENT '回复内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1710727571928 DEFAULT CHARSET=utf8 COMMENT='线路预约';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xianluyuyue`
--

LOCK TABLES `xianluyuyue` WRITE;
/*!40000 ALTER TABLE `xianluyuyue` DISABLE KEYS */;
INSERT INTO `xianluyuyue` VALUES (81,'2024-03-18 02:01:20','线路名称1','停靠站点1','起点1','终点1','学生账号1','学生姓名1','是',''),(82,'2024-03-18 02:01:20','线路名称2','停靠站点2','起点2','终点2','学生账号2','学生姓名2','是',''),(83,'2024-03-18 02:01:20','线路名称3','停靠站点3','起点3','终点3','学生账号3','学生姓名3','是',''),(84,'2024-03-18 02:01:20','线路名称4','停靠站点4','起点4','终点4','学生账号4','学生姓名4','是',''),(85,'2024-03-18 02:01:20','线路名称5','停靠站点5','起点5','终点5','学生账号5','学生姓名5','是',''),(86,'2024-03-18 02:01:20','线路名称6','停靠站点6','起点6','终点6','学生账号6','学生姓名6','是',''),(1710727571927,'2024-03-18 02:06:11','线路1','订单,ddd','学校','学校','11','李玉','是','通过');
/*!40000 ALTER TABLE `xianluyuyue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xuesheng`
--

DROP TABLE IF EXISTS `xuesheng`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xuesheng` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `touxiang` longtext COMMENT '头像',
  `xueshengzhanghao` varchar(200) NOT NULL COMMENT '学生账号',
  `mima` varchar(200) NOT NULL COMMENT '密码',
  `xueshengxingming` varchar(200) NOT NULL COMMENT '学生姓名',
  `xingbie` varchar(200) DEFAULT NULL COMMENT '性别',
  `shoujihaoma` varchar(200) DEFAULT NULL COMMENT '手机号码',
  `shenfenzhenghao` varchar(200) DEFAULT NULL COMMENT '身份证号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `xueshengzhanghao` (`xueshengzhanghao`)
) ENGINE=InnoDB AUTO_INCREMENT=1710727536362 DEFAULT CHARSET=utf8 COMMENT='学生';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xuesheng`
--

LOCK TABLES `xuesheng` WRITE;
/*!40000 ALTER TABLE `xuesheng` DISABLE KEYS */;
INSERT INTO `xuesheng` VALUES (31,'2024-03-18 02:01:20','file/xueshengTouxiang1.jpg','学生账号1','123456','学生姓名1','男','19819881111','441622200101010001'),(32,'2024-03-18 02:01:20','file/xueshengTouxiang2.jpg','学生账号2','123456','学生姓名2','男','19819881112','441622200202020002'),(33,'2024-03-18 02:01:20','file/xueshengTouxiang3.jpg','学生账号3','123456','学生姓名3','男','19819881113','441622200303030003'),(34,'2024-03-18 02:01:20','file/xueshengTouxiang4.jpg','学生账号4','123456','学生姓名4','男','19819881114','441622200404040004'),(35,'2024-03-18 02:01:20','file/xueshengTouxiang5.jpg','学生账号5','123456','学生姓名5','男','19819881115','441622200505050005'),(1710727536361,'2024-03-18 02:05:36','file/1710727535398.jpg','11','11','李玉','男','13201201201','441201200120120021');
/*!40000 ALTER TABLE `xuesheng` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `yuyuejieguo`
--

DROP TABLE IF EXISTS `yuyuejieguo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yuyuejieguo` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `luxianmingcheng` varchar(200) NOT NULL COMMENT '路线名称',
  `qidian` varchar(200) NOT NULL COMMENT '起点',
  `tingkaozhandian` varchar(200) DEFAULT NULL COMMENT '停靠站点',
  `zhongdian` varchar(200) NOT NULL COMMENT '终点',
  `xueshengzhanghao` varchar(200) DEFAULT NULL COMMENT '学生账号',
  `xueshengxingming` varchar(200) DEFAULT NULL COMMENT '学生姓名',
  `cheliangbianhao` varchar(200) DEFAULT NULL COMMENT '车辆编号',
  `chepaihao` varchar(200) DEFAULT NULL COMMENT '车牌号',
  `jiashiyuanzhanghao` varchar(200) DEFAULT NULL COMMENT '驾驶员账号',
  `jiashiyuanxingming` varchar(200) DEFAULT NULL COMMENT '驾驶员姓名',
  `jiashiyuanquerenzhuangtai` varchar(200) DEFAULT NULL COMMENT '驾驶员确认状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1710727610365 DEFAULT CHARSET=utf8 COMMENT='预约结果';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `yuyuejieguo`
--

LOCK TABLES `yuyuejieguo` WRITE;
/*!40000 ALTER TABLE `yuyuejieguo` DISABLE KEYS */;
INSERT INTO `yuyuejieguo` VALUES (91,'2024-03-18 02:01:20','路线名称1','起点1','停靠站点1','终点1','学生账号1','学生姓名1','车辆编号1','车牌号1','驾驶员账号1','驾驶员姓名1','已确认'),(92,'2024-03-18 02:01:20','路线名称2','起点2','停靠站点2','终点2','学生账号2','学生姓名2','车辆编号2','车牌号2','驾驶员账号2','驾驶员姓名2','已确认'),(93,'2024-03-18 02:01:20','路线名称3','起点3','停靠站点3','终点3','学生账号3','学生姓名3','车辆编号3','车牌号3','驾驶员账号3','驾驶员姓名3','已确认'),(94,'2024-03-18 02:01:20','路线名称4','起点4','停靠站点4','终点4','学生账号4','学生姓名4','车辆编号4','车牌号4','驾驶员账号4','驾驶员姓名4','已确认'),(95,'2024-03-18 02:01:20','路线名称5','起点5','停靠站点5','终点5','学生账号5','学生姓名5','车辆编号5','车牌号5','驾驶员账号5','驾驶员姓名5','已确认'),(96,'2024-03-18 02:01:20','路线名称6','起点6','停靠站点6','终点6','学生账号6','学生姓名6','车辆编号6','车牌号6','驾驶员账号6','驾驶员姓名6','已确认'),(1710727610364,'2024-03-18 02:06:50','线路1','学校','订单,ddd','学校','11','李玉','2号车','02301','111','司机','已确认');
/*!40000 ALTER TABLE `yuyuejieguo` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-20  7:48:46
