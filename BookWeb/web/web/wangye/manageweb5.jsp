<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>图书馆管理员操作界面</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f7f9fc;
            overflow-x: hidden; /* 禁用横向滚动条 */
        }
        .sidebar {
            width: 200px;
            background-color: #015999; /* 调整菜单栏背景颜色 */
            color: #ecf0f1;
            height: 100vh;
            position: fixed;
            padding: 20px;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
        }
        .sidebar h3 {
            font-size: 26px;
            font-family: '楷体';
            font-weight: bold;
            text-align: center;
            margin-bottom: 30px;
            padding: 30px;
        }
        .sidebar a {
            width: 100%;
            box-sizing: border-box;
            display: block;
            color: #ecf0f1;
            text-decoration: none;
            margin-bottom: 20px;
            padding: 15px;
            font-size: 23px;
            font-weight: bold;
            font-family: '楷体';
            text-align: center;
            border-radius: 0px;
        }
        .sidebar a:hover {
            background-color: #34495e;
            transform: scale(0.98);
            background-color: #2c3e50;
        }
        .container {
            margin-left: 220px;
            padding: 15px;
            width: calc(100% - 260px);
        }
        .system-title-box {
            background-color: #3498db;
            color: white;
            padding: 15px;
            text-align: left;
            font-size: 22px;
            font-family: '楷体';
            font-weight: bold;
            text-transform: uppercase;
            border: 1px solid #ccc;
            margin-bottom: 20px;
            width: 98%;
            margin-left: 1%;
        }
        .content-box {
            border: 1px solid #3498db;
            background-color: white;
            padding: 15px;
            width: 100%;
            margin-left: 1%;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .toolbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
            width: 100%; /* 确保toolbar占满整个容器宽度 */
        }
        .search {
            display: flex;
            align-items: center;
            width: 100%; /* 让搜索框占满剩余空间 */
        }
        .search select {
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
            height: 34px;
            width: 150px; /* 设置下拉框的宽度 */
        }
        .search input[type="text"] {
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
            height: 30px;
            flex-grow: 1; /* 让输入框占据剩余空间 */
        }
        .section-box {
            margin-bottom: 20px;
        }
        .section-box h4 {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .section-box button {
            padding: 10px 15px;
            margin-right: 10px;
            border: none;
            background-color: #3498db;
            color: white;
            border-radius: 5px;
            cursor: pointer;
        }
        .section-box button:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
<div class="sidebar">
    <div>
        <h3>冠军小队</h3>
        <a href="http://localhost:8080/web_Web_exploded/caifang/interview.jsp"  style="color: gray; pointer-events: none;">采访管理</a>
        <a href="${pageContext.request.contextPath}/CatalogMServlet"  style="color: gray; pointer-events: none;">编目管理</a>
        <a href="${pageContext.request.contextPath}/NetAppointmentServlet"  style="color: gray; pointer-events: none;">流通管理</a>
        <a href="${pageContext.request.contextPath}/ReaderServlet"  style="color: gray; pointer-events: none;">用户管理</a>
        <a href="${pageContext.request.contextPath}/weihu/backup0.jsp"  style="color: gray; pointer-events: none;">系统维护</a>
        <a href="http://localhost:8080/web_Web_exploded/wangye/network.jsp">网页管理</a>
    </div>
</div>
<div class="container">
    <div class="system-title-box">
        图书馆管理员操作界面
    </div>

</div>
</body>
</html>