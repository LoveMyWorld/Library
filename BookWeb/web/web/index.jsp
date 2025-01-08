<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>冠军小队图书馆</title>
  <style>
    body, html {
      font-family: '楷体', sans-serif;
      margin: 0;
      padding: 0;
      height: 100%;
      background-color: #f4f4f4;
      background-image: url('image/sky.jpg');
      background-size: cover;
      background-position: center center;
      background-repeat: no-repeat;
    }
    .header {
      background-color: transparent;
      color: black;
      padding: 10px 0;
      text-align: center;
      position: relative;
    }
    .nav {
      background-color: #015999;
      overflow: hidden;
    }
    .nav a, .nav button {
      float: left;
      display: block;
      color: white;
      text-align: center;
      padding: 14px 16px;
      text-decoration: none;
    }
    .nav a:hover, .nav button:hover {
      background-color: #ddd;
      color: black;
    }
    .login-button, .register-button {
      font-family: '楷体', sans-serif;
      background-color: #015999; /* 淡蓝色背景 */
      color: white;
      border: none;
      cursor: pointer;
      border-radius: 5px;
      font-size: 18px; /* 增加字体大小 */
    }
    .login-button:hover, .register-button:hover {
      background-color: #0c66ab; /* 鼠标悬停时的淡蓝色 */
    }
    /* 图片样式 */
    .title-image {
      width: 100%; /* 根据需要调整图片宽度 */
      max-width: 600px; /* 设置图片最大宽度 */
      margin: 0 auto; /* 水平居中 */
      display: block; /* 使图片独占一行 */
    }
    /* 新增的冠军小队图书馆标题样式 */
    .header h2 {
      font-family: '楷体', sans-serif;
      font-weight: bold;
      font-size: 90px;
    }
  </style>
</head>
<body>

<div class="nav">
  <button class="login-button" onclick="window.location.href='reader_login.jsp'">读者登录</button>
  <button class="login-button" onclick="window.location.href='adm_login.jsp'">管理员登录</button>
  <button class="register-button" onclick="window.location.href='http://localhost:8080/web_Web_exploded/register.jsp'">注册</button>
</div>
<div class="header">
  <h2>冠军小队图书馆</h2>
</div>

<!-- 搜索栏代码被注释，如果需要可以取消注释 -->
<!-- <div class="search-bar">
  <input type="text" placeholder="塔夫学术搜索">
  <button type="submit">搜索</button>
</div> -->

</body>
</html>