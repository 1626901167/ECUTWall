/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80035
 Source Host           : localhost:3306
 Source Schema         : ecut_wall

 Target Server Type    : MySQL
 Target Server Version : 80035
 File Encoding         : 65001

 Date: 04/06/2024 03:48:55
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文章标题',
  `content` varchar(10000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文章内容',
  `cover_img` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文章封面',
  `state` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '草稿' COMMENT '文章状态: 只能是[已发布] 或者 [草稿]',
  `category_id` int UNSIGNED NULL DEFAULT NULL COMMENT '文章分类ID',
  `create_user` int UNSIGNED NOT NULL COMMENT '创建人ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_article_category`(`category_id` ASC) USING BTREE,
  INDEX `fk_article_user`(`create_user` ASC) USING BTREE,
  CONSTRAINT `fk_article_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_article_user` FOREIGN KEY (`create_user`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES (13, '调休通知', '<p> 又调休？！</p>', 'https://wwey.oss-cn-hangzhou.aliyuncs.com/6aebd50a-6565-4b9a-b378-1e76aa252d96.png?Expires=1717446048&OSSAccessKeyId=LTAI5tBR3LBMzr38qzmwJob6&Signature=aYFTzUCB2dttWEMm95ju8G%2Fj%2FeI%3D', '已发布', 8, 5, '2024-06-04 03:20:52', '2024-06-04 03:20:52');
INSERT INTO `article` VALUES (14, '调课通知', '<p> 调课通知</p>', 'https://wwey.oss-cn-hangzhou.aliyuncs.com/3d2ed172-2bca-42a7-ab67-be004d93a38d.jpg?Expires=1717446131&OSSAccessKeyId=LTAI5tBR3LBMzr38qzmwJob6&Signature=HQp53AjIMvEl76JFVlGmUulPeyU%3D', '已发布', 8, 5, '2024-06-04 03:22:26', '2024-06-04 03:22:26');
INSERT INTO `article` VALUES (15, '期末通知', '<p> 期末通知</p>', 'https://wwey.oss-cn-hangzhou.aliyuncs.com/26d63c05-9011-407a-887e-30e9bfc1acd4.jpg?Expires=1717446176&OSSAccessKeyId=LTAI5tBR3LBMzr38qzmwJob6&Signature=pEBsgmFojEeyiab3mtGath3N3Qg%3D', '草稿', 8, 5, '2024-06-04 03:22:57', '2024-06-04 03:22:57');
INSERT INTO `article` VALUES (16, 'RTX4090显卡，85新转卖', '<p> 4090显卡85新转卖</p>', 'https://wwey.oss-cn-hangzhou.aliyuncs.com/f8083b12-5c94-4290-a340-a878e7ff65bc.jpg?Expires=1717446260&OSSAccessKeyId=LTAI5tBR3LBMzr38qzmwJob6&Signature=iEJFonpO5%2FTmeJNWpJAMPo54wtk%3D', '已发布', 11, 5, '2024-06-04 03:24:30', '2024-06-04 03:24:30');
INSERT INTO `article` VALUES (17, '求购二手电风扇', '<p> 求购二手电风扇</p>', 'https://wwey.oss-cn-hangzhou.aliyuncs.com/fd13605e-f2cc-4259-b1ef-e9a4bf884ede.jpg?Expires=1717446327&OSSAccessKeyId=LTAI5tBR3LBMzr38qzmwJob6&Signature=%2F%2FlDRBB1MymSMgZZz6oftV0Kpcc%3D', '已发布', 11, 5, '2024-06-04 03:25:31', '2024-06-04 03:25:31');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `category_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类名称',
  `category_alias` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类别名',
  `create_user` int UNSIGNED NOT NULL COMMENT '创建人ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_category_user`(`create_user` ASC) USING BTREE,
  CONSTRAINT `fk_category_user` FOREIGN KEY (`create_user`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (7, '八卦', 'bg', 5, '2024-06-04 03:16:32', '2024-06-04 03:16:32');
INSERT INTO `category` VALUES (8, '通知', 'tz', 5, '2024-06-04 03:16:43', '2024-06-04 03:16:43');
INSERT INTO `category` VALUES (9, '新闻', 'xw', 5, '2024-06-04 03:16:53', '2024-06-04 03:16:53');
INSERT INTO `category` VALUES (10, '表白', 'bb', 5, '2024-06-04 03:17:06', '2024-06-04 03:19:14');
INSERT INTO `category` VALUES (11, '二手闲置', 'esxz', 5, '2024-06-04 03:19:34', '2024-06-04 03:19:34');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '密码',
  `nickname` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '昵称',
  `email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '邮箱',
  `user_pic` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '头像',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (5, 'wwey', 'e10adc3949ba59abbe56e057f20f883e', '温文尔雅', '123456@qq.com', 'https://wwey.oss-cn-hangzhou.aliyuncs.com/e3865f56-4d35-4ee1-9a05-e67c86206eca.jpg?Expires=1717446081&OSSAccessKeyId=LTAI5tBR3LBMzr38qzmwJob6&Signature=BuHouKW9YyLuy2QzbV9ijmikLkE%3D', '2024-06-04 03:15:21', '2024-06-04 03:21:24');

SET FOREIGN_KEY_CHECKS = 1;
