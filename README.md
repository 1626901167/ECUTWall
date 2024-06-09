# ECUT墙

## 1.操作指南

### 1.配置MySql数据库

​	在`ECUTWall`中`src/main/resources/application.yaml`的`spring.datasource`配置MySql的用户名和密码。

### 2.配置Redis数据库

​	在`ECUTWall`中`src/main/resources/application.yaml`的`spring.data.redis`配置Redis的端口号及用户名和密码。

### 3.配置阿里OSS云对象存储

​	在`ECUTWall`中`src/main/java/com/wwey/utils/AliOssUtil.java`中配置静态属性`ACCESS_KEY_ID`，`ACCESS_KEY_SECRET`和`BUCKET_NAME`完成云对象存储，也可以在`src/main/java/com/wwey/controller/FileUploadController.java`使用本地存储，将文件上传至本地磁盘。

### 4.配置Vue组件

​	在ECUTWallVue中文件夹上方输入`cmd`回车进入命令行界面，再下载`Vue`，`ElementPlus`，`router`和`pinia`组件，最后输入`npm dev run`运行Vue文件。

## 2.效果展示

### 登录界面

![屏幕截图 2024-06-04 034156](E:\ECUTWall0\img\屏幕截图 2024-06-04 034156.png)

### 分类展示

![屏幕截图 2024-06-04 032723](E:\ECUTWall0\img\屏幕截图 2024-06-04 032723.png)

### 文章分页

![屏幕截图 2024-06-04 032551](E:\ECUTWall0\img\屏幕截图 2024-06-04 032551.png)

![屏幕截图 2024-06-04 032600](E:\ECUTWall0\img\屏幕截图 2024-06-04 032600.png)

![屏幕截图 2024-06-04 032608](E:\ECUTWall0\img\屏幕截图 2024-06-04 032608.png)

### 查询文章

![屏幕截图 2024-06-04 032640](E:\ECUTWall0\img\屏幕截图 2024-06-04 032640.png)

### 添加文章

![屏幕截图 2024-06-04 032106](E:\ECUTWall0\img\屏幕截图 2024-06-04 032106.png)

### 文件上传

![屏幕截图 2024-06-04 032134](E:\ECUTWall0\img\屏幕截图 2024-06-04 032134.png)







