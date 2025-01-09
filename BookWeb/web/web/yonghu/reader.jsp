<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Dao.ReaderDao" %>
<%@ page import="Entity.Reader" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <title>冠军小队读者信息维护</title>
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

            font-size: 23px; /* 编目管理和帮助字体变大 */
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

        /*改*/
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
        /*改*/
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
            display: inline-flex;
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
            z-index: 10;
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
            table-layout: auto;
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
        /*td:last-child {*/
        /*    width: 100px; !* 设置操作列宽度，确保只占用必要的空间 *!*/
        /*}*/
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

        /* 弹框 */
        .modal {
            display: none; /* 默认不显示 */
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0); /* 背景半透明 */
        }

        .modal-content {
            background-color: white;
            margin: 15% auto;
            padding: 20px;
            width: 80%;
            max-width: 800px;
            border-radius: 5px;
            position: relative;
            box-shadow: none; /* 移除阴影 */
            cursor: move; /* 让鼠标呈现可以拖动的状态 */
        }

        .modal-header {
            color: white;
            padding: 10px;
            font-size: 18px;
            font-weight: bold;
            text-align: center;
            background-color: #3498db;
            border-radius: 5px;
            position: relative;
        }

        .close {
            position: absolute;
            top: 5px;
            right: 5px;
            font-size: 30px;
            color: #e74c3c; /* 红色，突出 */
            cursor: pointer;
            z-index: 100;
        }

        .close:hover {
            color: #c0392b; /* 更深的红色 */
        }

        .modal-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .modal-table th, .modal-table td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: left;
        }

        .modal-table th {
            background-color: #f4f4f4;
        }

        .modal-table td {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .modal-table td input, .modal-table td select {
            width: 48%; /* 使输入框/选择框分布在一行中 */
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .modal-table td select {
            height: 30px;
        }

        .modal-table td input[type="text"] {
            width: 50%; /* 调整输入框宽度 */
        }

    </style>


</head>
<body>
<div class="sidebar">
    <div>
        <h3>冠军小队</h3>
        <a  onclick="location.href='${pageContext.request.contextPath}/ReaderServlet'">读者信息维护</a>
        <a  onclick="location.href='${pageContext.request.contextPath}/RlevelServlet'">读者级别维护</a>

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
        冠军小队用户管理系统
    </div>

    <!-- 管理列表框 -->
    <div class="content-box">
        <div class="header">
            读者信息维护列表
        </div>
        <div class="toolbar">
            <div class="tools">
                <button id="addButton">
                    <img src="${pageContext.request.contextPath}/image/add-icon.png" alt="添加">
                    <div class="tooltip">添加</div>
                </button>
<%--                <button>--%>
<%--                    <img src="${pageContext.request.contextPath}/image/edit-icon.png" alt="编辑">--%>
<%--                    <div class="tooltip">编辑</div>--%>
<%--                </button>--%>
<%--                <button>--%>
<%--                    <img src="${pageContext.request.contextPath}/image/delete-icon.png" alt="删除">--%>
<%--                    <div class="tooltip">删除</div>--%>
<%--                </button>--%>
<%--                <button>--%>
<%--                    <img src="${pageContext.request.contextPath}/image/refresh-icon.png" alt="刷新">--%>
<%--                    <div class="tooltip">刷新</div>--%>
<%--                </button>--%>
<%--                <button>--%>
<%--                    <img src="${pageContext.request.contextPath}/image/ru.png" alt="导入">--%>
<%--                    <div class="tooltip">导入</div>--%>
<%--                </button>--%>
<%--                <button>--%>
<%--                    <img src="${pageContext.request.contextPath}/image/chu.png" alt="导出">--%>
<%--                    <div class="tooltip">导出</div>--%>
<%--                </button>--%>
            </div>

            <div class="search">
                <form action="${pageContext.request.contextPath}/ReaderServlet" method="get">
                    <select name="searchField">
                        <option value="readID">读者编号</option>
                        <option value="name">姓名</option>
                        <option value="readerLevel">读者级别</option>
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
                <th style="width: 50px;">序号</th>
                <th>读者编号</th>
                <th>姓名</th>
                <th>性别</th>
                <th>电话号码</th>
                <th>读者级别</th>
                <th style="width: 80px;">操作</th>
            </tr>
            </thead>
            <tbody>
            <%
                int currentPage = request.getAttribute("currentPage")==null?1:(int) request.getAttribute("currentPage");
                int totalPages = request.getAttribute("totalPage")==null?1:(int) request.getAttribute("totalPage");
                List<Reader> readerList= (List<Reader>) request.getAttribute("readerList");
                int count = 1; // 初始化计数器
                if (readerList != null) { // 判断数据是否为空
                    for (Reader reader : readerList) {
            %>
            <tr >
                <td><%= count++ %></td>
                <td><%= reader.getReadID() %></td>
                <td><%= reader.getName() %></td>
                <td><%= reader.getGender() %></td>
                <td><%= reader.getPhoneNum() %></td>
                <td><%= reader.getReaderLevel() %></td>

                <td>
                    <div class="tools">
                        <button id="lookButton">
                            <img src="${pageContext.request.contextPath}/image/look-icon.png" alt="查看">
                            <div class="tooltip">查看</div>
                        </button>
                        <button id="editButton">
                            <img src="${pageContext.request.contextPath}/image/edit-icon.png" alt="编辑">
                            <div class="tooltip">编辑</div>
                        </button>
                        <button id="deleteButton">
                            <img src="${pageContext.request.contextPath}/image/delete-icon.png" alt="删除">
                            <div class="tooltip">删除</div>
                        </button>
                    </div>
                </td>

            </tr>
            <%
                    }
                }
            %>

            </tbody>
        </table>





        <div class="pagination">
            <div class="pagination">
                <!-- 上一页 -->
                <button onclick="location.href='${pageContext.request.contextPath}/ReaderServlet?currentPage=<%= currentPage - 1 %>'">&laquo; 上一页</button>
                <!-- 当前页信息 -->
                <span>第 <%= currentPage %> / <%= totalPages %> 页，每页显示 16 条</span>
                <!-- 下一页 -->
                <button onclick="location.href='${pageContext.request.contextPath}/ReaderServlet?currentPage=<%= currentPage + 1 %>'">下一页 &raquo;</button>
            </div>

        </div>
    </div>
</div>

<%--添加框--%>
<div id="myModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            读者信息
            <span class="close" id="closeModal">&times;</span>
        </div>
        <form id="readerForm_add">
            <table class="modal-table">
                <tr>
                    <th>读者编号</th>
                    <td><input type="text" id="readID" name="readID"><span style="color: red;">*</span></td>
                    <th>姓名</th>
                    <td><input type="text" id="name" name="name"><span style="color: red;">*</span></td>
                </tr>
                <tr>
                    <th>性别</th>
                    <td><select id="gender" name="gender">
                        <option value="女">女</option>
                        <option value="男">男</option>
                    </select><span style="color: red;">*</span></td>
                    <th>出生日期</th>
                    <td><input type="date" id="birthDay" name="birthDay"><span style="color: red;">*</span></td> <!-- 更改为日期选择器 -->
                </tr>
                <tr>
                    <th>单位</th>
                    <td><input type="text" id="unit" name="unit"><span style="color: red;">*</span></td>
                    <th>家庭地址</th>
                    <td><input type="text" id="homeAdd" name="homeAdd"><span style="color: red;">*</span></td>
                </tr>
                <tr>
                    <th>电话号码</th>
                    <td><input type="text" id="phoneNum" name="phoneNum"><span style="color: red;">*</span></td>
                    <th>电子邮箱</th>
                    <td><input type="email" id="emailAdd" name="emailAdd"></td> <!-- 使用 email 类型来验证邮箱 -->
                </tr>
                <tr>
                    <th>读者级别名称</th>
                    <td><select id="readerLevel" name="readerLevel">
                        <option value="高级读者">高级读者</option>
                        <option value="中级读者">中级读者</option>
                        <option value="低级读者">低级读者</option>
                        <option value="黑名单读者">黑名单读者</option>
                    </select><span style="color: red;">*</span></td>
                    <th>信用分</th>
                    <td><input type="text" id="creditPoint" name="creditPoint"><span style="color: red;">*</span></td>
                </tr>
            </table>
            <button type="button" id="submitForm">提交</button>
        </form>
    </div>
</div>

<%--查看框--%>
<div id="myModal1" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            读者信息
            <span class="close" id="closeModal1">&times;</span>
        </div>
        <form id="readerForm_look">
            <table class="modal-table">
                <tr>
                    <th>读者编号</th>
                    <td><input type="text" id="readID1" name="readID" readonly></td>
                    <th>姓名</th>
                    <td><input type="text" id="name1" name="name" readonly></td>
                </tr>
                <tr>
                    <th>性别</th>
                    <td><input type="text" id="gender1" name="gender" readonly></td>
                    <th>出生日期</th>
                    <td><input type="text" id="birthDay1" name="birthDay" readonly></td>
                </tr>
                <tr>
                    <th>单位</th>
                    <td><input type="text" id="unit1" name="unit" readonly></td>
                    <th>家庭地址</th>
                    <td><input type="text" id="homeAdd1" name="homeAdd" readonly></td>
                </tr>
                <tr>
                    <th>电话号码</th>
                    <td><input type="text" id="phoneNum1" name="phoneNum" readonly></td>
                    <th>电子邮箱</th>
                    <td><input type="text" id="emailAdd1" name="emailAdd" readonly></td>
                </tr>
                <tr>
                    <th>读者级别名称</th>
                    <td><input type="text" id="readerLevel1" name="readerLevel" readonly></td>
                    <th>信用分</th>
                    <td><input type="text" id="creditPoint1" name="creditPoint" readonly></td>
                </tr>
            </table>
        </form>
    </div>
</div>

<%--编辑框--%>
<div id="myModal2" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            读者信息
            <span class="close" id="closeModal2">&times;</span>
        </div>
        <form id="readerForm_edit">
            <table class="modal-table">
                <tr>
                    <th>读者编号</th>
                    <td><input type="text" id="readID2" name="readID" readonly></td>
                    <th>姓名</th>
                    <td><input type="text" id="name2" name="name"></td>
                </tr>
                <tr>
                    <th>性别</th>
                    <td><select id="gender2" name="gender">
                        <option value="女">女</option>
                        <option value="男">男</option>
                    </select></td>
                    <th>出生日期</th>
                    <td><input type="date" id="birthDay2" name="birthDay"></td>
                </tr>
                <tr>
                    <th>单位</th>
                    <td><input type="text" id="unit2" name="unit"></td>
                    <th>家庭地址</th>
                    <td><input type="text" id="homeAdd2" name="homeAdd"></td>
                </tr>
                <tr>
                    <th>电话号码</th>
                    <td><input type="text" id="phoneNum2" name="phoneNum"></td>
                    <th>电子邮箱</th>
                    <td><input type="text" id="emailAdd2" name="emailAdd"></td>
                </tr>
                <tr>
                    <th>读者级别名称</th>
                    <td><select id="readerLevel2" name="readerLevel">
                        <option value="高级读者">高级读者</option>
                        <option value="中级读者">中级读者</option>
                        <option value="低级读者">低级读者</option>
                        <option value="黑名单读者">黑名单读者</option>
                    </select></td>
                    <th>信用分</th>
                    <td><input type="text" id="creditPoint2" name="creditPoint"></td>
                </tr>
            </table>
            <button type="button" id="submitForm2">提交</button>
        </form>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        // 获取模态框元素
        var modal = document.getElementById("myModal");
        var addButton = document.getElementById("addButton");
        var closeModal = document.getElementById("closeModal");

        // 获取模态框元素
        var modal1 = document.getElementById("myModal1");
        var closeModal1 = document.getElementById("closeModal1");
        // 获取所有的“查看”按钮
        var lookButtons = document.querySelectorAll("#lookButton");

        // 获取模态框元素
        var modal2 = document.getElementById("myModal2");
        var closeModal2 = document.getElementById("closeModal2");
        // 获取所有的“编辑”按钮
        var editButtons = document.querySelectorAll("#editButton");



        // 打开模态框
        addButton.onclick = function () {
            modal.style.display = "block";
            // 在点击时向后端请求相关数据
            // fetchInitData();  // 获取并展示现有数据
        }


        // 遍历所有“查看”按钮并绑定点击事件
        lookButtons.forEach(function(button) {
            button.addEventListener("click", function(event) {
                modal1.style.display = "block";
                // 获取点击按钮所在行的读者信息
                var readID = event.target.closest("tr").querySelector("td:nth-child(2)").innerText;

                // 发送请求获取该读者的详细信息
                fetchReaderDetails(readID);
            });
        });

        // 遍历所有“编辑”按钮并绑定点击事件
        editButtons.forEach(function(button) {
            button.addEventListener("click", function(event) {
                modal2.style.display = "block";
                // 获取点击按钮所在行的读者信息
                var readID = event.target.closest("tr").querySelector("td:nth-child(2)").innerText;

                // 发送请求获取该读者的详细信息
                fetchReaderDetails(readID);
            });
        });


        // 关闭模态框
        closeModal.onclick = function () {
            modal.style.display = "none";
        }
        closeModal1.onclick = function () {
            modal1.style.display = "none";
        }
        closeModal2.onclick = function () {
            modal2.style.display = "none";
        }

        // 点击模态框外部关闭模态框
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
            if (event.target == modal1) {
                modal1.style.display = "none";
            }
            if (event.target == modal2) {
                modal2.style.display = "none";
            }
        }


        // 关闭弹框
        $('.close').click(function() {
            $('#myModal').hide();
        });


    });

    document.addEventListener("DOMContentLoaded", function() {
        // 获取模态框元素
        var submitForm = document.getElementById("submitForm");
        var submitForm2 = document.getElementById("submitForm2");

        // 提交表单时验证
        submitForm.onclick = function () {
            var readID = document.getElementById("readID").value;
            var name = document.getElementById("name").value;
            var unit = document.getElementById("unit").value;
            var homeAdd = document.getElementById("homeAdd").value;
            var phoneNum = document.getElementById("phoneNum").value;
            var emailAdd = document.getElementById("emailAdd").value;
            var creditPoint = document.getElementById("creditPoint").value;
            var birthDay = document.getElementById("birthDay").value;

            // 检查必填项
            if (!readID || !name || !unit || !homeAdd || !phoneNum || !creditPoint || !birthDay) {
                alert("所有必填项不能为空！");
                return;
            }

            // 验证读者编号（12位数字）
            if (!/^\d{12}$/.test(readID)) {
                alert("读者编号必须为12位数字！");
                return;
            }

            // 验证姓名（不能超过20个字符）
            if (name.length > 20) {
                alert("姓名不能超过20个字符！");
                return;
            }

            // 验证单位和家庭地址（不能超过100个字符）
            if (unit.length > 100) {
                alert("单位不能超过100个字符！");
                return;
            }
            if (homeAdd.length > 100) {
                alert("家庭地址不能超过100个字符！");
                return;
            }

            // 验证电话号码（必须为11位且以1开头）
            if (!/^1\d{10}$/.test(phoneNum)) {
                alert("电话号码必须是11位且以1开头！");
                return;
            }

            // 验证邮箱格式
            if (emailAdd && !/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(emailAdd)) {
                alert("电子邮箱格式不正确！");
                return;
            }

            // 验证信用分（必须为整数）
            if (!/^\d+$/.test(creditPoint)) {
                alert("信用分必须是整数！");
                return;
            }

            // **出生日期验证**：出生日期不能大于等于今天
            var today = new Date();
            var birthDate = new Date(birthDay);
            if (birthDate >= today) {
                alert("出生日期不能大于等于今天！");
                return;
            }

            // **读者级别与信用分匹配验证**
            creditPoint = parseInt(creditPoint, 10);
            if (readerLevel === "高级读者" && (creditPoint < 81 || creditPoint > 100)) {
                alert("高级读者的信用分必须在81到100之间！");
                return;
            } else if (readerLevel === "中级读者" && (creditPoint < 51 || creditPoint > 80)) {
                alert("中级读者的信用分必须在51到80之间！");
                return;
            } else if (readerLevel === "低级读者" && (creditPoint < 11 || creditPoint > 50)) {
                alert("低级读者的信用分必须在11到50之间！");
                return;
            } else if (readerLevel === "黑名单读者" && (creditPoint < 0 || creditPoint > 10)) {
                alert("黑名单读者的信用分必须在0到10之间！");
                return;
            } else if (creditPoint < 0) {
                alert("信用分不能为负数！");
                return;
            }

            // 弹出确认框
            var confirmSubmit = confirm("是否确定提交？");
            if (confirmSubmit) {

                var formData=$('#readerForm_add').serialize();
                // console.log("即将开始Ajax");
                // console.log(formData );
                // 使用 AJAX 发送数据到后端
                $.ajax({
                    url: '${pageContext.request.contextPath}/AddReaderServlet',  // 后端接口，用于提交数据
                    method: 'POST',
                    data: formData,  // 发送的表单数据
                    dataType: 'json',  // 期待返回的数据格式
                    success: function(response) {
                        if (response.resultInfo.flag) {
                            alert("提交成功！");
                            $('#myModal').hide();  // 关闭弹窗
                            location.reload(true);  // 刷新页面，显示新数据
                        } else {
                            alert("提交失败，错误信息: " + response.resultInfo.message);
                        }
                    },
                    error: function(xhr, status, error) {
                        alert("提交失败，错误代码: " + xhr.status + "\n" + xhr.statusText);
                    }
                });

            } else {
                // 如果用户点击"否"，则不提交
                alert("提交已取消！");
            }
        }

        // 提交表单2时验证
        submitForm2.onclick = function () {
            var readID = document.getElementById("readID2").value;
            var name = document.getElementById("name2").value;
            var unit = document.getElementById("unit2").value;
            var homeAdd = document.getElementById("homeAdd2").value;
            var phoneNum = document.getElementById("phoneNum2").value;
            var emailAdd = document.getElementById("emailAdd2").value;
            var creditPoint = document.getElementById("creditPoint2").value;
            var birthDay = document.getElementById("birthDay2").value;

            // 检查必填项
            if (!readID || !name || !unit || !homeAdd || !phoneNum || !creditPoint || !birthDay) {
                alert("所有必填项不能为空！");
                return;
            }

            // 验证读者编号（12位数字）
            if (!/^\d{12}$/.test(readID)) {
                alert("读者编号必须为12位数字！");
                return;
            }

            // 验证姓名（不能超过20个字符）
            if (name.length > 20) {
                alert("姓名不能超过20个字符！");
                return;
            }

            // 验证单位和家庭地址（不能超过100个字符）
            if (unit.length > 100) {
                alert("单位不能超过100个字符！");
                return;
            }
            if (homeAdd.length > 100) {
                alert("家庭地址不能超过100个字符！");
                return;
            }

            // 验证电话号码（必须为11位且以1开头）
            if (!/^1\d{10}$/.test(phoneNum)) {
                alert("电话号码必须是11位且以1开头！");
                return;
            }

            // 验证邮箱格式
            if (emailAdd && !/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(emailAdd)) {
                alert("电子邮箱格式不正确！");
                return;
            }

            // 验证信用分（必须为整数）
            if (!/^\d+$/.test(creditPoint)) {
                alert("信用分必须是整数！");
                return;
            }

            // **出生日期验证**：出生日期不能大于等于今天
            var today = new Date();
            var birthDate = new Date(birthDay);
            if (birthDate >= today) {
                alert("出生日期不能大于等于今天！");
                return;
            }

            // **读者级别与信用分匹配验证**
            creditPoint = parseInt(creditPoint, 10);
            if (readerLevel === "高级读者" && (creditPoint < 81 || creditPoint > 100)) {
                alert("高级读者的信用分必须在81到100之间！");
                return;
            } else if (readerLevel === "中级读者" && (creditPoint < 51 || creditPoint > 80)) {
                alert("中级读者的信用分必须在51到80之间！");
                return;
            } else if (readerLevel === "低级读者" && (creditPoint < 11 || creditPoint > 50)) {
                alert("低级读者的信用分必须在11到50之间！");
                return;
            } else if (readerLevel === "黑名单读者" && (creditPoint < 0 || creditPoint > 10)) {
                alert("黑名单读者的信用分必须在0到10之间！");
                return;
            } else if (creditPoint < 0) {
                alert("信用分不能为负数！");
                return;
            }

            // 弹出确认框
            var confirmSubmit = confirm("是否确定提交？");
            if (confirmSubmit) {

                var formData=$('#readerForm_edit').serialize();
                // console.log("即将开始Ajax");
                // console.log(formData );
                // 使用 AJAX 发送数据到后端
                $.ajax({
                    url: '${pageContext.request.contextPath}/EditReaderServlet',  // 后端接口，用于提交数据
                    method: 'POST',
                    data: formData,  // 发送的表单数据
                    dataType: 'json',  // 期待返回的数据格式
                    success: function(response) {
                        if (response.resultInfo.flag) {
                            alert("提交成功！");
                            $('#myModal').hide();  // 关闭弹窗
                            location.reload(true);  // 刷新页面，显示新数据
                        } else {
                            alert("提交失败，错误信息: " + response.resultInfo.message);
                        }
                    },
                    error: function(xhr, status, error) {
                        alert("提交失败，错误代码: " + xhr.status + "\n" + xhr.statusText);
                    }
                });

            } else {
                // 如果用户点击"否"，则不提交
                alert("提交已取消！");
            }
        }
    });

    // 获取并填充读者详细信息
    function fetchReaderDetails(readID) {
        // 假设我们通过后端接口 `/LookReaderServlet` 获取数据
        $.ajax({
            url: '${pageContext.request.contextPath}/LookReaderServlet', // 你的后端接口
            method: 'GET',
            data: { readID: readID }, // 发送读者编号（或其他唯一标识符）到后端
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    // 将返回的读者信息填充到弹框中的对应字段
                    document.getElementById("readID1").value = response.data.readID;
                    document.getElementById("name1").value = response.data.name;
                    document.getElementById('gender1').value = response.data.gender;
                    document.getElementById("birthDay1").value = response.data.birthDay;
                    document.getElementById("unit1").value = response.data.unit;
                    document.getElementById("homeAdd1").value = response.data.homeAdd;
                    document.getElementById("phoneNum1").value = response.data.phoneNum;
                    document.getElementById("emailAdd1").value = response.data.emailAdd;
                    document.getElementById("readerLevel1").value = response.data.readerLevel;
                    document.getElementById("creditPoint1").value = response.data.creditPoint;


                    document.getElementById("readID2").value = response.data.readID;
                    document.getElementById("name2").value = response.data.name;
                    document.getElementById('gender2').value = response.data.gender;
                    document.getElementById("birthDay2").value = response.data.birthDay;
                    document.getElementById("unit2").value = response.data.unit;
                    document.getElementById("homeAdd2").value = response.data.homeAdd;
                    document.getElementById("phoneNum2").value = response.data.phoneNum;
                    document.getElementById("emailAdd2").value = response.data.emailAdd;
                    document.getElementById("readerLevel2").value = response.data.readerLevel;
                    document.getElementById("creditPoint2").value = response.data.creditPoint;

                    // 显示弹框
                    // modal1.style.display = "block";
                } else {
                    alert("无法获取读者信息！");
                }
            },
            error: function(xhr, status, error) {
                alert("获取读者信息失败，错误代码: " + xhr.status + "\n" + xhr.statusText);
            }
        });
    }

    document.addEventListener("DOMContentLoaded", function() {
        // 获取模态框元素
        var deleteButtons = document.querySelectorAll("#deleteButton");

        // 遍历所有“删除”按钮并绑定点击事件
        deleteButtons.forEach(function(button) {
            button.addEventListener("click", function(event) {
                // 获取点击按钮所在行的读者信息
                var readID = event.target.closest("tr").querySelector("td:nth-child(2)").innerText;

                // 弹出确认框
                var confirmSubmit = confirm("是否确定删除？");
                if (confirmSubmit) {

                    $.ajax({
                        url: '${pageContext.request.contextPath}/DeleteReaderServlet2',  // 后端接口，用于提交数据
                        method: 'POST',
                        data:  { readID: readID },   // 发送的读者编号
                        dataType: 'json',  // 期待返回的数据格式
                        success: function(response) {
                            if (response.resultInfo.flag) {
                                alert("删除成功！");
                                $('#myModal').hide();  // 关闭弹窗
                                location.reload(true);  // 刷新页面，显示新数据
                            } else {
                                alert("删除失败，错误信息: " + response.resultInfo.message);
                            }
                        },
                        error: function(xhr, status, error) {
                            alert("删除失败，错误代码: " + xhr.status + "\n" + xhr.statusText);
                        }
                    });

                } else {
                    // 如果用户点击"否"，则不提交
                    alert("删除已取消！");
                }
            });
        });

    });
</script>


</body>
</html>