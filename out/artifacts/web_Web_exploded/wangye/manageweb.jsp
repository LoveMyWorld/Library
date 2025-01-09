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
        <a href="http://localhost:8080/web_Web_exploded/caifang/interview.jsp"'>采访管理</a>
        <a href="#">编目管理</a>
        <a href="#">流通管理</a>
        <a href="#">用户管理</a>
        <a href="#">系统维护</a>
        <a href="#">期刊管理</a>

        <a href="http://localhost:8080/web_Web_exploded/wangye/network.jsp">网页管理</a>
    </div>
</div>
<div class="container">
    <div class="system-title-box">
        图书馆管理员操作界面
    </div>
<%--    <div class="content-box">--%>
<%--        <div class="toolbar">--%>
<%--            <div class="search">--%>
<%--                <select id="search-type">--%>
<%--                    <option value="bookname">书名</option>--%>
<%--                    <option value="author">作者</option>--%>
<%--                    <option value="isbn">ISBN</option>--%>
<%--                </select>--%>
<%--                <input type="text" id="search-input" placeholder="请输入搜索关键词...">--%>
<%--            </div>--%>
<%--        </div>--%>

<%--        <!-- 采访管理 -->--%>
<%--        <div class="section-box">--%>
<%--            <h4>采访管理</h4>--%>
<%--            <button onclick="location.href='caifang/interview.jsp'">添加采访记录</button>--%>
<%--            <button onclick="location.href='caifang/interview.jsp'">查看采访记录</button>--%>
<%--        </div>--%>

<%--        <!-- 编目管理 -->--%>
<%--        <div class="section-box">--%>
<%--            <h4>编目管理</h4>--%>
<%--            <button>添加编目</button>--%>
<%--            <button>查看编目</button>--%>
<%--        </div>--%>

<%--        <!-- 流通管理 -->--%>
<%--        <div class="section-box">--%>
<%--            <h4>流通管理</h4>--%>
<%--            <button>借阅图书</button>--%>
<%--            <button>归还图书</button>--%>
<%--            <button>查询流通记录</button>--%>
<%--        </div>--%>

<%--        <!-- 用户管理 -->--%>
<%--        <div class="section-box">--%>
<%--            <h4>用户管理</h4>--%>
<%--            <button>查看用户列表</button>--%>
<%--            <button>修改用户信息</button>--%>
<%--            <button>删除用户</button>--%>
<%--        </div>--%>

<%--        <!-- 系统维护 -->--%>
<%--        <div class="section-box">--%>
<%--            <h4>系统维护</h4>--%>
<%--            <button>备份数据</button>--%>
<%--            <button>恢复数据</button>--%>
<%--            <button>清理缓存</button>--%>
<%--        </div>--%>

<%--        <!-- 期刊管理 -->--%>
<%--        <div class="section-box">--%>
<%--            <h4>期刊管理</h4>--%>
<%--            <button>添加期刊</button>--%>
<%--            <button>查看期刊</button>--%>
<%--        </div>--%>

<%--        <!-- 统计管理 -->--%>
<%--        <div class="section-box">--%>
<%--            <h4>统计管理</h4>--%>
<%--            <button>查看借阅统计</button>--%>
<%--            <button>查看期刊统计</button>--%>
<%--            <button>查看用户活跃度统计</button>--%>
<%--        </div>--%>

<%--        <!-- 网页管理 -->--%>
<%--        <div class="section-box">--%>
<%--            <h4>网页管理</h4>--%>
<%--            <button>更新首页内容</button>--%>
<%--            <button>修改公告</button>--%>
<%--            <button>修改网站设置</button>--%>
<%--        </div>--%>

<%--    </div>--%>
</div>
</body>
</html>