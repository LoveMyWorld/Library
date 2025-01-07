<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="Entity.BackupCycle" %>
<%@ page import="java.util.List" %>
<%@ page import="Entity.BackupInfo" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>冠军小队维护系统</title>
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
            background-color: #07598a;
            color: #ecf0f1;
            height: 100vh;
            position: fixed;
            padding: 20px;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
        }
        .sidebar h3 {
            font-size: 26px; /* 冠军小队字体变大 */
            font-family: '楷体';
            font-weight: bold;
            text-align: center;
            padding: 30px;
            margin-bottom: 30px;
        }
        .sidebar a {
            width: 100%; /* 按钮宽度与侧边栏一致 */
            box-sizing: border-box; /* 确保内边距和边框不会导致宽度超出 */
            display: block;
            color: #ecf0f1;
            text-decoration: none;
            margin-bottom: 20px;
            padding: 15px;
            font-size: 21px; /* 编目管理和帮助字体变大 */
            font-weight: bold;
            font-family: '楷体';
            text-align: center;
            border-radius: 0px;
        }
        .sidebar a:hover {
            background-color: #34495e;
            transform: scale(0.98); /* 按下时按钮稍微缩小 */
            background-color: #2c3e50; /* 按下时按钮背景颜色 */
        }
        .sidebar-submenu {
            display: none;
            position: relative;
            background-color: #07598a;
            color: #ecf0f1;
            width: 200px;
            padding-left: 20px;
            margin-top: 10px;
        }
        .sidebar-submenu a {
            display: block;
            color: #ecf0f1;
            text-decoration: none;
            padding: 10px;
            font-size: 18px;
            font-weight: bold;
            font-family: '楷体';
            text-align: center;
        }
        .sidebar-submenu a:hover {
            background-color: #34495e;
            transform: scale(0.98);
        }
        .menu-item.active .sidebar-submenu {
            display: block;
        }
        .sidebar-footer {
            text-align: center;
            padding: 350px 0;
        }
        .sidebar-footer .divider {
            height: 2px;
            width: 180px; /* 横杠宽度略小于侧边栏宽度 */
            background-color: #ecf0f1;
            margin: 0 auto 10px auto; /* 横杠居中并与按钮留出间距 */
        }
        .sidebar-footer .about-btn {
            display: block;
            width: 100%; /* 按钮宽度与侧边栏一致 */
            box-sizing: border-box; /* 确保内边距和边框不会导致宽度超出 */
            color: #ecf0f1;
            text-decoration: none;
            padding: 15px;
            font-size: 20px;
            font-weight: bold;
            font-family: '楷体';
            text-align: center;
            background-color: transparent;
            border-radius: 0;
            transition: all 0.3s;
        }
        .sidebar-footer .about-btn:hover {
            background-color: #34495e;
            transform: scale(1.01);
        }
        .container {
            margin-left: 220px; /* 调整左边距适应侧边栏宽度 */
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
            margin-left: 1%; /* 中心对齐，微微露出边框 */
        }

        .content-box1 {
            background-color: #ffffff;
            border: 1px solid #ccc;
            padding: 20px;
            margin: 20px 0;
            box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
            font-family: '楷体';
            font-size: 18px;
            line-height: 1.5;
        }
        .content-box1 input[type="text"],
        .content-box1 select,
        .content-box1 textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }
        .content-box1 textarea {
            resize: vertical; /* 允许高度调整 */
        }
        .content-box1 button {
            background-color: #3498db;
            color: #fff;
            padding: 10px 20px;
            font-size: 18px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .content-box1 button:hover {
            background-color: #0288d1;
        }

        .content-box {
            border: 1px solid #3498db;
            background-color: white;
            /*padding: 15px;*/
            padding: 0px 0px 10px 0px;
            width: 100%;
            margin-left: 1%; /* 边框微微露出 */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            position: relative;
        }

        .header {
            background-color: #3498db;
            color: white;
            padding: 10px;
            font-size: 18px;
            font-family: '楷体';
            font-weight: bold;
            text-transform: uppercase;
            border: 1px solid #444;
            margin-bottom: 10px;
        }
        .toolbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }
        .tools {
            display: flex;
            align-items: center;
            gap: 8px; /* 按钮间距微调 */
        }
        .tools button {
            position: relative;
            background-color: transparent;
            border: none;
            cursor: pointer;
        }
        .tools button img {
            width: 24px;
            height: 24px;
        }
        .tools button:hover img {
            filter: brightness(0.8);
        }
        .tools button:hover .tooltip {
            display: block;
        }
        .tools .tooltip {
            display: none;
            position: absolute;
            bottom: -30px;
            left: 50%;
            transform: translateX(-50%);
            background-color: #000;
            color: #fff;
            padding: 5px 10px;
            font-size: 12px;
            border-radius: 5px;
            white-space: nowrap;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }
        .search {
            padding: 0px 7px 0px 0px;
            display: flex;
            align-items: center;
            gap: 10px;

        }
        .search select {
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
            height: 34px;
        }
        .search input[type="text"] {
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
            width: 180px; /* 缩小输入框宽度 */
            height: 30px;
        }
        .search button {
            padding: 5px 10px;
            border: 1px solid #ccc;
            background-color: #f4f4f4;
            cursor: pointer;
            border-radius: 5px;
        }
        .search button:hover {
            background-color: #ddd;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f4f4f4;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #fffbcc; /* 悬停效果 */
        }
        .pagination {
            text-align: center;
            padding: 10px;
        }
        .pagination button {
            padding: 5px 10px;
            margin: 2px;
            border: 1px solid #ccc;
            background-color: #f4f4f4;
            cursor: pointer;
        }
        .pagination button:hover {
            background-color: #ddd;
        }

    </style>


    <script>
        function toggleSubmenu() {
            const submenu = document.getElementById('backup-submenu');
            submenu.style.display = submenu.style.display === 'block' ? 'none' : 'block';
        }

        function showBackupForm() {
            // 隐藏备份周期表和备份信息表
            document.getElementById('backup-cycle-table').style.display = 'none';
            document.getElementById('backup-info-table').style.display = 'none';

            // 显示主动备份表单
            document.getElementById('backup-form').style.display = 'block';
        }

        function getCurrentTime() {
            const now = new Date();
            const options = { timeZone: 'Asia/Beijing', hour12: false };
            return now.toLocaleString('zh-CN', options);
        }

        window.onload = function () {
            document.getElementById('backup-time').value = getCurrentTime();
        };


        function updateBackupTime() {
            // 获取当前时间
            const now = new Date();
            const options = { timeZone: 'Asia/Beijing', hour12: false };
            const currentTime = now.toLocaleString('zh-CN', options);

            // 更新备份时间输入框的值
            document.getElementById('backup-time').value = currentTime;

            // 提示用户备份操作已提交
            // alert('备份已提交！备份时间已更新为：' + currentTime);
        }

        function updateBackupPath() {
            return new Promise((resolve, reject) => {
                const tableName = document.getElementById("backupTable").value;

                const xhr = new XMLHttpRequest();
                xhr.open("GET", '${pageContext.request.contextPath}/BackupServlet?tableName=' + tableName, true);

                xhr.onload = function () {
                    if (xhr.status === 200) {
                        document.getElementById("backup-location").value = xhr.responseText;
                        resolve(xhr.responseText); // 返回备份路径
                    } else {
                        reject("无法生成备份路径，请稍后再试！");
                    }
                };

                xhr.send();
            });
        }

        function submitBackupForm(event) {
            event.preventDefault(); // 阻止默认的表单提交行为

            // 获取备份原因和操作员的值
            const backupReason = document.getElementById('backup-reason').value.trim();
            const operator = document.getElementById('operator').value.trim();

            // 验证备份原因和操作员是否为空
            if (backupReason === '' || operator === '') {
                alert('备份原因和操作员不能为空！');
                return; // 不继续执行，阻止表单提交
            }

            // 提交表单数据，触发备份操作
            const form = document.querySelector("form");
            updateBackupPath().then((backupPath) => {
                // 提交数据
                const xhr = new XMLHttpRequest();
                xhr.open("POST", form.action, true);
                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

                const formData = new FormData(form);
                xhr.onload = function () {
                    if (xhr.status === 200) {
                        // 获取备份路径和编号
                        const response = xhr.responseText.split("|");
                        const backupPath = response[0];
                        const backupId = response[1];

                        // 在 alert 中显示备份路径和备份编号
                        alert('备份成功！\n备份时间: ' + document.getElementById("backup-time").value +
                            '\n备份路径: ' + backupPath +
                            '\n备份编号: ' + backupId);
                    } else {
                        alert("备份失败，请稍后重试！");
                    }
                };
                xhr.send(new URLSearchParams(formData).toString());
            }).catch((error) => {
                alert(error); // 如果路径获取失败，显示错误信息
            });
        }

        // 添加 JavaScript 控制显示/隐藏内容框
        function toggleBackupCycle() {
            var backupCycleDiv = document.getElementById('backup-cycle-table');
            backupCycleDiv.style.display = (backupCycleDiv.style.display === 'none' || backupCycleDiv.style.display === '') ? 'block' : 'none';

            // 隐藏主动备份表单和备份信息表
            document.getElementById('backup-form').style.display = 'none';
            document.getElementById('backup-info-table').style.display = 'none';
        }

        function toggleBackupInfo() {
            var backupInfoDiv = document.getElementById('backup-info-table');
            backupInfoDiv.style.display = (backupInfoDiv.style.display === 'none' || backupInfoDiv.style.display === '') ? 'block' : 'none';

            // 隐藏主动备份表单和备份周期表
            document.getElementById('backup-form').style.display = 'none';
            document.getElementById('backup-cycle-table').style.display = 'none';
        }

    </script>


</head>
<body>
<div class="sidebar">
    <div>
        <h3>冠军小队</h3>
        <div class="menu-item">
            <a href="javascript:void(0);" onclick="toggleSubmenu()">备份</a>
            <div class="sidebar-submenu" id="backup-submenu" style="display: none;">
                <a href="javascript:void(0);" onclick="showBackupForm()">主动备份</a>
                <a href="javascript:void(0);" onclick="toggleBackupCycle(); location.href='${pageContext.request.contextPath}/BackupCycleServlet';">备份周期表</a>
                <a href="javascript:void(0);" onclick="toggleBackupInfo(); location.href='${pageContext.request.contextPath}/BackupInfoServlet';">备份信息表</a>
<%--                <a href="#">备份更新表</a>--%>
            </div>
        </div>
        <a onclick="location.href='${pageContext.request.contextPath}/RlevelServlet'">书商字典维护</a>
        <a onclick="location.href='${pageContext.request.contextPath}/RlevelServlet'">出版社字典维护</a>
        <a onclick="location.href='${pageContext.request.contextPath}/RlevelServlet'">收藏单位字典维护</a>
        <a onclick="location.href='${pageContext.request.contextPath}/RlevelServlet'">印刷厂字典维护</a>
        <a onclick="location.href='${pageContext.request.contextPath}/RlevelServlet'">术语字典</a>
    </div>

    <!-- 底部横杠和关于我们按钮 -->
    <div class="sidebar-footer">
        <div class="divider"></div>
        <a href="#" class="about-btn">关于我们</a>
        <a href="#" class="about-btn">帮助</a>
    </div>
</div>

<div class="container">
    <!-- 冠军小队系统框 -->
    <div class="system-title-box">
        冠军小队维护系统
    </div>


    <!-- 主动备份内容框 -->
    <div id="backup-form" class="content-box1" style="display: none;">
        <h3>主动备份</h3>
        <form action="${pageContext.request.contextPath}/BackupServlet" method="post" onsubmit="submitBackupForm(event)">
            <!-- 选择要备份的表 -->
            <label for="backupTable">选择要备份的表</label>
            <select id="backupTable" name="backupTable" onchange="updateBackupPath()">
                <option value="图书流通库表">图书流通库表</option>
                <option value="读者信息表">读者信息表</option>
                <option value="读者级别规则表">读者级别规则表</option>
            </select>

            <label for="backup-location">备份路径</label>
            <input type="text" id="backup-location" name="backup-location" class="readonly" readonly placeholder="备份路径将自动生成">

            <label for="backup-reason">备份原因</label>
            <textarea id="backup-reason" name="backup-reason" placeholder="请输入备份原因" rows="3"></textarea>

            <label for="backup-time">备份时间</label>
            <input type="text" id="backup-time" name="backup-time" readonly placeholder="备份时间将自动生成">

            <label for="operator">操作员</label>
            <input type="text" id="operator" name="operator" placeholder="请输入操作员名称">

            <button type="submit" onclick="updateBackupTime()">备份</button>
        </form>
    </div>

    <!-- 备份周期表内容框，默认隐藏 -->
    <div id="backup-cycle-table" class="content-box" style="<%= request.getAttribute("showBackupCycleTable") != null && (boolean)request.getAttribute("showBackupCycleTable") ? "display: block;" : "display: none;" %>">
        <div class="header">备份周期表</div>
        <div class="toolbar">
            <div class="tools">
                <button>
                    <img src="${pageContext.request.contextPath}/image/add-icon.png" alt="添加">
                    <div class="tooltip">添加</div>
                </button>
                <button>
                    <img src="${pageContext.request.contextPath}/image/edit-icon.png" alt="编辑">
                    <div class="tooltip">编辑</div>
                </button>
                <button>
                    <img src="${pageContext.request.contextPath}/image/delete-icon.png" alt="删除">
                    <div class="tooltip">删除</div>
                </button>
                <button>
                    <img src="${pageContext.request.contextPath}/image/refresh-icon.png" alt="刷新">
                    <div class="tooltip">刷新</div>
                </button>
                <button>
                    <img src="${pageContext.request.contextPath}/image/ru.png" alt="导入">
                    <div class="tooltip">导入</div>
                </button>
                <button>
                    <img src="${pageContext.request.contextPath}/image/chu.png" alt="导出">
                    <div class="tooltip">导出</div>
                </button>
            </div>

            <div class="search">
                <form action="${pageContext.request.contextPath}/BackupCycleServlet" method="get">
                    <select name="searchField">
                        <option value="backupName">备份表名</option>
                    </select>
                    <input type="text" name="searchValue" placeholder="请输入关键词" />
                    <input type="text" name="search" value="" hidden="hidden"/>
                    <button type="submit">搜索</button>
                </form>
            </div>
        </div>

        <table>
            <thead>
            <tr>
                <th>序号</th>
                <th>备份表名</th>
                <th>备份周期</th>
                <th>备份位置</th>
                <th>操作员</th>
            </tr>
            </thead>
            <tbody>
            <!-- 这里用 Java 在后台动态填充数据 -->
            <%
                int currentPage = request.getAttribute("currentPage") == null ? 1 : (int) request.getAttribute("currentPage");
                int totalPages = request.getAttribute("totalPage") == null ? 1 : (int) request.getAttribute("totalPage");
                List<BackupCycle> backupCycleList = (List<BackupCycle>) request.getAttribute("backupCycleList");
                int count = 1;
                if (backupCycleList != null) {
                    for (BackupCycle backupCycle : backupCycleList) {
            %>
            <tr>
                <td><%= count++ %></td>
                <td><%= backupCycle.getBackupName() %></td>
                <td><%= backupCycle.getBackupCycle() %></td>
                <td><%= backupCycle.getBackupLoc() %></td>
                <td><%= backupCycle.getOperator() %></td>
            </tr>
            <%
                    }
                }
            %>
            </tbody>
        </table>

        <div class="pagination">
            <!-- 上一页 -->
            <button onclick="location.href='${pageContext.request.contextPath}/BackupCycleServlet?currentPage=<%= currentPage - 1 %>'">&laquo; 上一页</button>
            <!-- 当前页信息 -->
            <span>第 <%= currentPage %> / <%= totalPages %> 页，每页显示 16 条</span>
            <!-- 下一页 -->
            <button onclick="location.href='${pageContext.request.contextPath}/BackupCycleServlet?currentPage=<%= currentPage + 1 %>'">下一页 &raquo;</button>
        </div>
    </div>

    <!-- 备份信息表内容框，默认隐藏 -->
    <div id="backup-info-table" class="content-box" style="<%= request.getAttribute("showBackupInfoTable") != null && (boolean)request.getAttribute("showBackupInfoTable") ? "display: block;" : "display: none;" %>">
        <div class="header">备份信息表</div>
        <div class="toolbar">
            <div class="tools">
                <button>
                    <img src="${pageContext.request.contextPath}/image/add-icon.png" alt="添加">
                    <div class="tooltip">添加</div>
                </button>
                <button>
                    <img src="${pageContext.request.contextPath}/image/edit-icon.png" alt="编辑">
                    <div class="tooltip">编辑</div>
                </button>
                <button>
                    <img src="${pageContext.request.contextPath}/image/delete-icon.png" alt="删除">
                    <div class="tooltip">删除</div>
                </button>
                <button>
                    <img src="${pageContext.request.contextPath}/image/refresh-icon.png" alt="刷新">
                    <div class="tooltip">刷新</div>
                </button>
                <button>
                    <img src="${pageContext.request.contextPath}/image/ru.png" alt="导入">
                    <div class="tooltip">导入</div>
                </button>
                <button>
                    <img src="${pageContext.request.contextPath}/image/chu.png" alt="导出">
                    <div class="tooltip">导出</div>
                </button>
            </div>

            <div class="search">
                <form action="${pageContext.request.contextPath}/BackupInfoServlet" method="get">
                    <select name="searchField">
                        <option value="backupName">备份表名</option>
                        <option value="backupName">备份编号</option>
                    </select>
                    <input type="text" name="searchValue" placeholder="请输入关键词" />
                    <input type="text" name="search" value="" hidden="hidden"/>
                    <button type="submit">搜索</button>
                </form>
            </div>
        </div>

        <table>
            <thead>
            <tr>
                <th>序号</th>
                <th>备份编号</th>
                <th>备份表名</th>
                <th>备份位置</th>
                <th>备份原因</th>
                <th>备份时间</th>
                <th>操作员</th>
            </tr>
            </thead>
            <tbody>
            <!-- 这里用 Java 在后台动态填充数据 -->
            <%
                int currentPage1 = request.getAttribute("currentPage") == null ? 1 : (int) request.getAttribute("currentPage");
                int totalPages1 = request.getAttribute("totalPage") == null ? 1 : (int) request.getAttribute("totalPage");
                List<BackupInfo> backupInfoList = (List<BackupInfo>) request.getAttribute("backupInfoList");
                int count1 = 1;
                if (backupInfoList != null) {
                    for (BackupInfo backupInfo : backupInfoList) {
            %>
            <tr>
                <td><%= count1++ %></td>
                <td><%= backupInfo.getBackupID() %></td>
                <td><%= backupInfo.getBackupName() %></td>
                <td><%= backupInfo.getBackupLoc() %></td>
                <td><%= backupInfo.getBackupReason() %></td>
                <td><%= backupInfo.getBackupTime() %></td>
                <td><%= backupInfo.getOperator() %></td>
            </tr>
            <%
                    }
                }
            %>
            </tbody>
        </table>

        <div class="pagination">
            <!-- 上一页 -->
            <button onclick="location.href='${pageContext.request.contextPath}/BackupInfoServlet?currentPage=<%= currentPage1 - 1 %>'">&laquo; 上一页</button>
            <!-- 当前页信息 -->
            <span>第 <%= currentPage %> / <%= totalPages1 %> 页，每页显示 16 条</span>
            <!-- 下一页 -->
            <button onclick="location.href='${pageContext.request.contextPath}/BackupInfoServlet?currentPage=<%= currentPage1 + 1 %>'">下一页 &raquo;</button>
        </div>
    </div>


</div>
</body>
</html>