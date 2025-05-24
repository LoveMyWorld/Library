<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>图书馆用户界面</title>
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
        .welcome-box {
            font-size: 32px;
            font-weight: bold;
            color: #015999;
            text-align: center;
            margin-top: 30px;
            margin-bottom: 10px;
            letter-spacing: 2px;
            font-family: '楷体', 'Arial', sans-serif;
        }
        .divider {
            width: 80%;
            height: 2px;
            background: #3498db;
            margin: 0 auto 20px auto;
            border-radius: 2px;
        }
        .library-info {
            font-size: 18px;
            color: #333;
            background: #f0f8ff;
            border-radius: 8px;
            padding: 18px 30px;
            width: 70%;
            margin: 0 auto 30px auto;
            box-shadow: 0 2px 8px rgba(52,152,219,0.08);
            line-height: 2.2;
        }
        .library-info strong {
            color: #015999;
        }
    </style>
</head>
<body>
<div class="sidebar">
    <div>
        <h3>小赫</h3>
        <a href="${pageContext.request.contextPath}/SearchServlet">搜索书目</a>
        <a href="${pageContext.request.contextPath}/liutong/NetAppointment.jsp">预约借书</a>
        <a href="${pageContext.request.contextPath}/wangyeyonghu/message.jsp">留言</a>
        <a href="${pageContext.request.contextPath}/UserAnnouncementServlet">查看公告</a>
        <a href="${pageContext.request.contextPath}/WeiguiServlet">违规通报</a>
        <a href="${pageContext.request.contextPath}/wangyeyonghu/userweb.jsp">返回主页</a>
    </div>
</div>
<div class="container">
    <div class="system-title-box">
        图书馆用户界面
    </div>
    <div class="welcome-box">
        欢迎读者进入小赫图书馆
    </div>
    <div class="divider"></div>
    <div class="library-info">
        <div><strong>地址：</strong> 河北省保定市莲池区华北电力大学（保定）二校区</div>
        <div><strong>联系电话：</strong> 15614481233</div>
        <div><strong>开放时间：</strong> 周一至周日 8:00-21:00</div>
        <div><strong>闭馆日：</strong> 法定节假日</div>
    </div>
    <!-- 其他功能的留白区域 -->
</div>
</body>
</html>