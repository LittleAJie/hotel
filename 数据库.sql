/*
SQLyog Ultimate v11.27 (32 bit)
MySQL - 5.5.40 : Database - db_ssm_hotel
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`db_ssm_hotel` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `db_ssm_hotel`;

/*Table structure for table `sys_dept` */

DROP TABLE IF EXISTS `sys_dept`;

CREATE TABLE `sys_dept` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '部门编号',
  `deptName` varchar(50) DEFAULT NULL COMMENT '部门名称',
  `address` varchar(255) DEFAULT NULL COMMENT '部门地址',
  `createDate` datetime DEFAULT NULL COMMENT '创建时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_dept` */

/*Table structure for table `sys_permisson` */

DROP TABLE IF EXISTS `sys_permisson`;

CREATE TABLE `sys_permisson` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '权限菜单编号',
  `pid` int(11) DEFAULT NULL COMMENT '父级菜单编号',
  `type` varchar(20) DEFAULT NULL COMMENT '菜单类型(菜单为menu，权限为permission)',
  `title` varchar(50) DEFAULT NULL COMMENT '菜单名称',
  `permissionCode` varchar(100) DEFAULT NULL COMMENT '权限编码',
  `icon` varchar(50) DEFAULT NULL COMMENT '菜单图标',
  `href` varchar(200) DEFAULT NULL COMMENT '菜单地址',
  `spread` int(11) DEFAULT NULL COMMENT '是否展开（1-展开 2-折叠）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_permisson` */

/*Table structure for table `sys_role` */

DROP TABLE IF EXISTS `sys_role`;

CREATE TABLE `sys_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色编号',
  `roleCode` varchar(50) DEFAULT NULL COMMENT '角色代码',
  `roleName` varchar(50) DEFAULT NULL COMMENT '角色名称',
  `roleDesc` varchar(255) DEFAULT NULL COMMENT '角色描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `sys_role` */

insert  into `sys_role`(`id`,`roleCode`,`roleName`,`roleDesc`) values (1,'ROLE_USER','系统用户','用户必须拥有该角色才能进入系统'),(2,'ROLE_SUPER','超级管理员','超级管理员角色，拥有所有操作权限');

/*Table structure for table `sys_role_permisson` */

DROP TABLE IF EXISTS `sys_role_permisson`;

CREATE TABLE `sys_role_permisson` (
  `rid` int(11) DEFAULT NULL COMMENT '角色编号',
  `pid` int(11) DEFAULT NULL COMMENT '菜单权限编号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_role_permisson` */

/*Table structure for table `sys_user` */

DROP TABLE IF EXISTS `sys_user`;

CREATE TABLE `sys_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户编号',
  `userName` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(200) NOT NULL COMMENT '密码',
  `realName` varchar(50) DEFAULT NULL COMMENT '真实姓名\r\n',
  `sex` int(11) DEFAULT NULL COMMENT '性别（1-男 2-女）',
  `deptId` int(11) DEFAULT NULL COMMENT '所属部门，对应部门表主键',
  `status` int(11) DEFAULT NULL COMMENT '状态（1-可用 2-禁用）',
  `email` varchar(200) DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(50) DEFAULT NULL COMMENT '电话',
  `userType` int(11) DEFAULT NULL COMMENT '用户类型（1-超级管理员 2-普通用户）',
  `hireDate` datetime DEFAULT NULL COMMENT '入职日期',
  `createdBy` int(11) DEFAULT NULL COMMENT '创建人',
  `createDate` datetime DEFAULT NULL COMMENT '创建时间',
  `modifyBy` int(11) DEFAULT NULL COMMENT '修改人',
  `modifyDate` datetime DEFAULT NULL COMMENT '修改时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `fk_deptid` (`deptId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `sys_user` */

insert  into `sys_user`(`id`,`userName`,`password`,`realName`,`sex`,`deptId`,`status`,`email`,`phone`,`userType`,`hireDate`,`createdBy`,`createDate`,`modifyBy`,`modifyDate`,`remark`) values (1,'admin','$2a$10$k7Yv6YqcTXb/mbCixpPM4egyKyZr4Kn2UiZFj4lfXI.wenhSEvLMq','超级管理员',1,1,1,'',NULL,1,'2020-11-13 09:21:40',1,'2020-11-13 09:21:44',1,'2020-11-13 09:21:46',NULL);

/*Table structure for table `sys_user_role` */

DROP TABLE IF EXISTS `sys_user_role`;

CREATE TABLE `sys_user_role` (
  `uid` int(11) DEFAULT NULL COMMENT '用户编号',
  `rid` int(11) DEFAULT NULL COMMENT '角色编号',
  KEY `fk_uid` (`uid`),
  KEY `fk_rid` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_user_role` */

insert  into `sys_user_role`(`uid`,`rid`) values (1,1),(1,2);

/*Table structure for table `t_account` */

DROP TABLE IF EXISTS `t_account`;

CREATE TABLE `t_account` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户编号',
  `loginName` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '登录账号',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '登录密码',
  `realName` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '真实姓名',
  `idCard` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '身份证号码',
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '电话号码',
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '邮箱',
  `status` int(11) DEFAULT NULL COMMENT '状态1-可用 2-异常',
  `registTime` datetime DEFAULT NULL COMMENT '注册时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_account` */

/*Table structure for table `t_checkin` */

DROP TABLE IF EXISTS `t_checkin`;

CREATE TABLE `t_checkin` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `roomTypeId` int(11) DEFAULT NULL COMMENT '所属房型',
  `roomId` bigint(20) DEFAULT NULL COMMENT '所属房间',
  `customerName` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '入住人姓名',
  `idCard` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '入住人身份证号',
  `phone` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '手机号',
  `arriveDate` date DEFAULT NULL COMMENT '入住日期',
  `leaveDate` date DEFAULT NULL COMMENT '离店日期',
  `payPrice` decimal(10,2) NOT NULL COMMENT '实付金额',
  `ordersId` bigint(20) DEFAULT NULL COMMENT '关联预订订单ID',
  `status` int(11) unsigned DEFAULT NULL COMMENT '状态（1-入住中  2-已离店）',
  `createDate` datetime DEFAULT NULL COMMENT '创建时间',
  `createdBy` int(11) DEFAULT NULL COMMENT '创建人',
  `modifyDate` datetime DEFAULT NULL COMMENT '修改时间',
  `modifyBy` int(11) DEFAULT NULL COMMENT '修改人',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`,`payPrice`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_checkin` */

/*Table structure for table `t_checkout` */

DROP TABLE IF EXISTS `t_checkout`;

CREATE TABLE `t_checkout` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `checkOutNumber` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '退房记录编号',
  `checkInId` bigint(20) DEFAULT NULL COMMENT '关联入住ID',
  `consumePrice` decimal(10,2) DEFAULT NULL COMMENT '消费金额',
  `createDate` datetime DEFAULT NULL COMMENT '创建时间',
  `createdBy` int(11) DEFAULT NULL COMMENT '操作人',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_checkout` */

/*Table structure for table `t_floor` */

DROP TABLE IF EXISTS `t_floor`;

CREATE TABLE `t_floor` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `floorName` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '楼层名称',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_floor` */

/*Table structure for table `t_orders` */

DROP TABLE IF EXISTS `t_orders`;

CREATE TABLE `t_orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '预订编号',
  `ordersNo` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '预订单号',
  `accountId` bigint(20) DEFAULT NULL COMMENT '预订人账号ID',
  `roomTypeId` int(11) DEFAULT NULL COMMENT '房型编号',
  `roomId` bigint(20) DEFAULT NULL COMMENT '房间ID',
  `reservationName` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '预订人姓名',
  `idCard` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '身份证号码',
  `phone` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '电话号码',
  `status` int(11) DEFAULT NULL COMMENT '状态1-待确认  2-已确认 3-已入住',
  `reserveDate` datetime DEFAULT NULL COMMENT '预定时间（创建时间）',
  `arriveDate` date DEFAULT NULL COMMENT '到店时间',
  `leaveDate` date DEFAULT NULL COMMENT '离店时间',
  `reservePrice` decimal(10,2) DEFAULT NULL COMMENT '预订价格',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_orders` */

/*Table structure for table `t_room` */

DROP TABLE IF EXISTS `t_room`;

CREATE TABLE `t_room` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '房间标题',
  `photo` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '房间图片',
  `roomNum` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '房间编号',
  `roomTypeId` int(11) DEFAULT NULL COMMENT '房型',
  `floorId` int(11) DEFAULT NULL COMMENT '所属楼层',
  `status` int(11) DEFAULT NULL COMMENT '状态(1-可预订 2-已预订 3-已入住)',
  `roomDesc` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT '房间描述',
  `roomRequirement` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '要求',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_room` */

/*Table structure for table `t_room_type` */

DROP TABLE IF EXISTS `t_room_type`;

CREATE TABLE `t_room_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '房型编号',
  `typeName` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '房型名称',
  `photo` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '房型图片',
  `price` decimal(8,2) DEFAULT NULL COMMENT '参考价格',
  `liveNum` int(11) DEFAULT NULL COMMENT '可入住人数',
  `bedNum` int(11) DEFAULT NULL COMMENT '床位数',
  `roomNum` int(11) DEFAULT NULL COMMENT '房间数量',
  `reservedNum` int(11) DEFAULT NULL COMMENT '已预定数量',
  `avilableNum` int(11) DEFAULT NULL COMMENT '可住房间数',
  `livedNum` int(11) DEFAULT NULL COMMENT '已入住数量',
  `status` int(11) DEFAULT NULL COMMENT '房型状态（1-可预订 2-房型已满）',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_room_type` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
