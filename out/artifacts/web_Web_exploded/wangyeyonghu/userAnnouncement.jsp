<%@ page import="Entity.Announcement" %>
<%@ page import="java.util.List" %><%--



  Created by IntelliJ IDEA.
  User: 19404
  Date: 2025/1/7
  Time: 15:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>图书馆用户界面</title>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        #history-announcement {
            margin-left: 220px; /* 调整左边距以适应侧边栏宽度 */
            width: calc(100% - 220px); /* 容器宽度为屏幕宽度减去侧边栏宽度 */
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
        /* 表格样式 */
        table {
            width: 100%; /* 表格宽度占满其父容器 */
            border-collapse: collapse; /* 合并边框 */
        }
        th, td {
            border: 1px solid #ccc; /* 设置边框颜色 */
            padding: 8px; /* 设置单元格内边距 */
            text-align: left; /* 文本左对齐 */
        }
        th {
            background-color: #f4f4f4; /* 表头背景颜色 */
        }
        tr:nth-child(even) {
            background-color: #f9f9f9; /* 偶数行背景颜色 */
        }
        tr:hover {
            background-color: #fffbcc; /* 鼠标悬停时的背景颜色 */
        }
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
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-group input, .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        table {
            width: 100%;
            border-collapse: collapse; /* 合并边框 */
        }
        th, td {
            border: 1px solid #ccc; /* 设置边框颜色 */
            padding: 8px; /* 设置单元格内边距 */
            text-align: left; /* 文本左对齐 */
        }
        th {
            background-color: #f4f4f4; /* 表头背景颜色 */
        }
        tr:nth-child(even) {
            background-color: #f9f9f9; /* 偶数行背景颜色 */
        }
        tr:hover {
            background-color: #fffbcc; /* 鼠标悬停时的背景颜色 */
        }

        .return-button {
            padding: 10px 15px;
            margin-top: 20px;
            border: none;
            background-color: #3498db;
            color: white;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            font-family: '楷体';
        }
        .return-button:hover {
            background-color: #2980b9;
        }




        /*弹框*/
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

        <a href="${pageContext.request.contextPath}/SearchServlet">搜索书目</a>
        <a href="${pageContext.request.contextPath}/NetAppointmentServlet">预约借书</a>
        <a href="${pageContext.request.contextPath}/wangyeyonghu/message.jsp">留言</a>
        <a href="${pageContext.request.contextPath}/UserAnnouncementServlet">查看公告</a>
        <a href="${pageContext.request.contextPath}/UserTongbaoServlet">违规通报</a>
        <a href="${pageContext.request.contextPath}/wangyeyonghu/userweb.jsp">返回主页</a>
    </div>
</div>


<div class="container">
    <div class="system-title-box">
        图书馆用户界面
    </div>
</div>

<form action="${pageContext.request.contextPath}/UserAnnouncementServlet" method="get">
    <div id="history-announcement" class="content-box" >
        <h4>历史公告</h4>
        <button type="submit" class="return-button">刷新</button>

        <table>
            <thead>
            <tr>
                <th>序号</th>
                <th>发布人</th>
                <th>主题</th>
                <th>内容</th>
            </tr>
            </thead>
            <tbody>
            <!-- 假设这里用 Java 在后台动态填充数据 -->

            <%
                List<Announcement> announcementList= (List<Announcement>) request.getAttribute("list");
                if (announcementList != null) { // 判断数据是否为空
                    for (Announcement announcement : announcementList) {
            %>
            <tr >
                <td><%= announcement.getAnnouncementID() %></td>
                <td><%= announcement.getPublisher() %></td>
                <td><%= announcement.getAnnouncementKey() %></td>

                <td><%= announcement.getAnnouncementText() %>
                </td>
            </tr>
            <%
                    }
                }
            %>
            <!-- 更多数据行 -->
            </tbody>
        </table>
    </div>
</form>


<%--&lt;%&ndash;添加框&ndash;%&gt;--%>
<%--<div id="myModal" class="modal">--%>
<%--    <div class="modal-content">--%>
<%--        <div class="modal-header">--%>
<%--            读者信息--%>
<%--            <span class="close" id="closeModal">&times;</span>--%>
<%--        </div>--%>
<%--        <form id="readerForm_add">--%>
<%--            <table class="modal-table">--%>
<%--                <tr>--%>
<%--                    <th>读者编号</th>--%>
<%--                    <td><input type="text" id="readID" name="readID"><span style="color: red;">*</span></td>--%>
<%--                    <th>姓名</th>--%>
<%--                    <td><input type="text" id="name" name="name"><span style="color: red;">*</span></td>--%>
<%--                </tr>--%>
<%--                <tr>--%>
<%--                    <th>性别</th>--%>
<%--                    <td><select id="gender" name="gender">--%>
<%--                        <option value="女">女</option>--%>
<%--                        <option value="男">男</option>--%>
<%--                    </select><span style="color: red;">*</span></td>--%>
<%--                    <th>出生日期</th>--%>
<%--                    <td><input type="date" id="birthDay" name="birthDay"><span style="color: red;">*</span></td> <!-- 更改为日期选择器 -->--%>
<%--                </tr>--%>
<%--                <tr>--%>
<%--                    <th>单位</th>--%>
<%--                    <td><input type="text" id="unit" name="unit"><span style="color: red;">*</span></td>--%>
<%--                    <th>家庭地址</th>--%>
<%--                    <td><input type="text" id="homeAdd" name="homeAdd"><span style="color: red;">*</span></td>--%>
<%--                </tr>--%>
<%--                <tr>--%>
<%--                    <th>电话号码</th>--%>
<%--                    <td><input type="text" id="phoneNum" name="phoneNum"><span style="color: red;">*</span></td>--%>
<%--                    <th>电子邮箱</th>--%>
<%--                    <td><input type="email" id="emailAdd" name="emailAdd"></td> <!-- 使用 email 类型来验证邮箱 -->--%>
<%--                </tr>--%>
<%--                <tr>--%>
<%--                    <th>读者级别名称</th>--%>
<%--                    <td><select id="readerLevel" name="readerLevel">--%>
<%--                        <option value="高级读者">高级读者</option>--%>
<%--                        <option value="中级读者">中级读者</option>--%>
<%--                        <option value="低级读者">低级读者</option>--%>
<%--                        <option value="黑名单读者">黑名单读者</option>--%>
<%--                    </select><span style="color: red;">*</span></td>--%>
<%--                    <th>信用分</th>--%>
<%--                    <td><input type="text" id="creditPoint" name="creditPoint"><span style="color: red;">*</span></td>--%>
<%--                </tr>--%>
<%--            </table>--%>
<%--            <button type="button" id="submitForm">提交</button>--%>
<%--        </form>--%>
<%--    </div>--%>
<%--</div>--%>

<%--&lt;%&ndash;查看框&ndash;%&gt;--%>
<%--<div id="myModal1" class="modal">--%>
<%--    <div class="modal-content">--%>
<%--        <div class="modal-header">--%>
<%--            公告内容--%>
<%--            <span class="close" id="closeModal1">&times;</span>--%>
<%--        </div>--%>
<%--        <form id="readerForm_look">--%>
<%--            <table class="modal-table">--%>
<%--                <tr>--%>
<%--                    <th>编号</th>--%>
<%--                    <td><input type="text" id="announcementID1" name="announcementID" readonly></td>--%>
<%--                    <th>日期</th>--%>
<%--                    <td><input type="text" id="announcementDate1" name="announcementDate" readonly></td>--%>
<%--                </tr>--%>
<%--                <tr>--%>
<%--                    <th>发布人</th>--%>
<%--                    <td><input type="text" id="publisher1" name="publisher" readonly></td>--%>
<%--                    <th>公告主题</th>--%>
<%--                    <td><input type="text" id="announcementKey1" name="announcementKey" readonly></td>--%>
<%--                </tr>--%>
<%--                <tr>--%>
<%--                    <th>内容</th>--%>
<%--                    <td><input type="text" id="announcementText1" name="announcementText" readonly></td>--%>

<%--                </tr>--%>
<%--            </table>--%>

<%--        </form>--%>
<%--    </div>--%>
<%--</div>--%>

<%--&lt;%&ndash;编辑框&ndash;%&gt;--%>
<%--<div id="myModal2" class="modal">--%>
<%--    <div class="modal-content">--%>
<%--        <div class="modal-header">--%>
<%--            读者信息--%>
<%--            <span class="close" id="closeModal2">&times;</span>--%>
<%--        </div>--%>
<%--        <form id="readerForm_edit">--%>
<%--            <table class="modal-table">--%>
<%--                <tr>--%>
<%--                    <th>读者编号</th>--%>
<%--                    <td><input type="text" id="readID2" name="readID" readonly></td>--%>
<%--                    <th>姓名</th>--%>
<%--                    <td><input type="text" id="name2" name="name"></td>--%>
<%--                </tr>--%>
<%--                <tr>--%>
<%--                    <th>性别</th>--%>
<%--                    <td><select id="gender2" name="gender">--%>
<%--                        <option value="女">女</option>--%>
<%--                        <option value="男">男</option>--%>
<%--                    </select></td>--%>
<%--                    <th>出生日期</th>--%>
<%--                    <td><input type="date" id="birthDay2" name="birthDay"></td>--%>
<%--                </tr>--%>
<%--                <tr>--%>
<%--                    <th>单位</th>--%>
<%--                    <td><input type="text" id="unit2" name="unit"></td>--%>
<%--                    <th>家庭地址</th>--%>
<%--                    <td><input type="text" id="homeAdd2" name="homeAdd"></td>--%>
<%--                </tr>--%>
<%--                <tr>--%>
<%--                    <th>电话号码</th>--%>
<%--                    <td><input type="text" id="phoneNum2" name="phoneNum"></td>--%>
<%--                    <th>电子邮箱</th>--%>
<%--                    <td><input type="text" id="emailAdd2" name="emailAdd"></td>--%>
<%--                </tr>--%>
<%--                <tr>--%>
<%--                    <th>读者级别名称</th>--%>
<%--                    <td><select id="readerLevel2" name="readerLevel">--%>
<%--                        <option value="高级读者">高级读者</option>--%>
<%--                        <option value="中级读者">中级读者</option>--%>
<%--                        <option value="低级读者">低级读者</option>--%>
<%--                        <option value="黑名单读者">黑名单读者</option>--%>
<%--                    </select></td>--%>
<%--                    <th>信用分</th>--%>
<%--                    <td><input type="text" id="creditPoint2" name="creditPoint"></td>--%>
<%--                </tr>--%>
<%--            </table>--%>
<%--            <button type="button" id="submitForm2">提交</button>--%>
<%--        </form>--%>
<%--    </div>--%>
<%--</div>--%>

<%--<script>--%>
<%--    document.addEventListener("DOMContentLoaded", function() {--%>
<%--        // 获取模态框元素--%>
<%--        var modal = document.getElementById("myModal");--%>
<%--        var addButton = document.getElementById("addButton");--%>
<%--        var closeModal = document.getElementById("closeModal");--%>

<%--        // 获取模态框元素--%>
<%--        var modal1 = document.getElementById("myModal1");--%>
<%--        var closeModal1 = document.getElementById("closeModal1");--%>
<%--        // 获取所有的“查看”按钮--%>
<%--        var lookButtons = document.querySelectorAll("#lookButton");--%>

<%--        // 获取模态框元素--%>
<%--        var modal2 = document.getElementById("myModal2");--%>
<%--        var closeModal2 = document.getElementById("closeModal2");--%>
<%--        // 获取所有的“编辑”按钮--%>
<%--        var editButtons = document.querySelectorAll("#editButton");--%>

<%--        // 遍历所有“查看”按钮并绑定点击事件--%>
<%--        lookButtons.forEach(function(button) {--%>
<%--                button.addEventListener("click", function(event) {--%>
<%--                    modal1.style.display = "block";--%>
<%--                    // 获取点击按钮所在行的读者信息--%>
<%--                    var readID = event.target.closest("tr").querySelector("td:nth-child(1)").innerText;--%>

<%--                    // 发送请求获取该读者的详细信息--%>
<%--                    fetchReaderDetails(readID);--%>
<%--                });--%>
<%--        });--%>

<%--        editButtons.forEach(function(button) {--%>
<%--            button.addEventListener("click", function(event) {--%>
<%--                modal2.style.display = "block";--%>
<%--                // 获取点击按钮所在行的读者信息--%>
<%--                var readID = event.target.closest("tr").querySelector("td:nth-child(1)").innerText;--%>

<%--                // 发送请求获取该读者的详细信息--%>
<%--                fetchReaderDetails(readID);--%>
<%--            });--%>
<%--        });--%>

<%--// 关闭模态框--%>
<%--        closeModal.onclick = function () {--%>
<%--            modal.style.display = "none";--%>
<%--        }--%>
<%--        closeModal1.onclick = function () {--%>
<%--            modal1.style.display = "none";--%>
<%--        }--%>
<%--        closeModal2.onclick = function () {--%>
<%--            modal2.style.display = "none";--%>
<%--        }--%>

<%--        // 点击模态框外部关闭模态框--%>
<%--        window.onclick = function (event) {--%>
<%--            if (event.target == modal) {--%>
<%--                modal.style.display = "none";--%>
<%--            }--%>
<%--            if (event.target == modal1) {--%>
<%--                modal1.style.display = "none";--%>
<%--            }--%>
<%--            if (event.target == modal1) {--%>
<%--                modal2.style.display = "none";--%>
<%--            }--%>
<%--        }--%>


<%--        // 关闭弹框--%>
<%--        $('.close').click(function() {--%>
<%--            $('#myModal').hide();--%>
<%--        });--%>


<%--    });--%>

<%--    document.addEventListener("DOMContentLoaded", function() {--%>
<%--        // 获取模态框元素--%>
<%--        var submitForm = document.getElementById("submitForm");--%>
<%--        var submitForm2 = document.getElementById("submitForm2");--%>

<%--        // 提交表单时验证--%>
<%--        submitForm.onclick = function () {--%>
<%--            var readID = document.getElementById("readID").value;--%>
<%--            var name = document.getElementById("name").value;--%>
<%--            var unit = document.getElementById("unit").value;--%>
<%--            var homeAdd = document.getElementById("homeAdd").value;--%>
<%--            var phoneNum = document.getElementById("phoneNum").value;--%>
<%--            var emailAdd = document.getElementById("emailAdd").value;--%>
<%--            var creditPoint = document.getElementById("creditPoint").value;--%>
<%--            var birthDay = document.getElementById("birthDay").value;--%>



<%--            //数据检查环节--%>


<%--            // // 检查必填项--%>
<%--            // if (!readID || !name || !unit || !homeAdd || !phoneNum || !creditPoint || !birthDay) {--%>
<%--            //     alert("所有必填项不能为空！");--%>
<%--            //     return;--%>
<%--            // }--%>
<%--            //--%>
<%--            // // 验证读者编号（12位数字）--%>
<%--            // if (!/^\d{12}$/.test(readID)) {--%>
<%--            //     alert("读者编号必须为12位数字！");--%>
<%--            //     return;--%>
<%--            // }--%>
<%--            //--%>
<%--            // // 验证姓名（不能超过20个字符）--%>
<%--            // if (name.length > 20) {--%>
<%--            //     alert("姓名不能超过20个字符！");--%>
<%--            //     return;--%>
<%--            // }--%>
<%--            //--%>
<%--            // // 验证单位和家庭地址（不能超过100个字符）--%>
<%--            // if (unit.length > 100) {--%>
<%--            //     alert("单位不能超过100个字符！");--%>
<%--            //     return;--%>
<%--            // }--%>
<%--            // if (homeAdd.length > 100) {--%>
<%--            //     alert("家庭地址不能超过100个字符！");--%>
<%--            //     return;--%>
<%--            // }--%>
<%--            //--%>
<%--            // // 验证电话号码（必须为11位且以1开头）--%>
<%--            // if (!/^1\d{10}$/.test(phoneNum)) {--%>
<%--            //     alert("电话号码必须是11位且以1开头！");--%>
<%--            //     return;--%>
<%--            // }--%>
<%--            //--%>
<%--            // // 验证邮箱格式--%>
<%--            // if (emailAdd && !/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(emailAdd)) {--%>
<%--            //     alert("电子邮箱格式不正确！");--%>
<%--            //     return;--%>
<%--            // }--%>
<%--            //--%>
<%--            // // 验证信用分（必须为整数）--%>
<%--            // if (!/^\d+$/.test(creditPoint)) {--%>
<%--            //     alert("信用分必须是整数！");--%>
<%--            //     return;--%>
<%--            // }--%>
<%--            //--%>
<%--            // // **出生日期验证**：出生日期不能大于等于今天--%>
<%--            // var today = new Date();--%>
<%--            // var birthDate = new Date(birthDay);--%>
<%--            // if (birthDate >= today) {--%>
<%--            //     alert("出生日期不能大于等于今天！");--%>
<%--            //     return;--%>
<%--            // }--%>
<%--            //--%>
<%--            // // **读者级别与信用分匹配验证**--%>
<%--            // creditPoint = parseInt(creditPoint, 10);--%>
<%--            // if (readerLevel === "高级读者" && (creditPoint < 81 || creditPoint > 100)) {--%>
<%--            //     alert("高级读者的信用分必须在81到100之间！");--%>
<%--            //     return;--%>
<%--            // } else if (readerLevel === "中级读者" && (creditPoint < 51 || creditPoint > 80)) {--%>
<%--            //     alert("中级读者的信用分必须在51到80之间！");--%>
<%--            //     return;--%>
<%--            // } else if (readerLevel === "低级读者" && (creditPoint < 11 || creditPoint > 50)) {--%>
<%--            //     alert("低级读者的信用分必须在11到50之间！");--%>
<%--            //     return;--%>
<%--            // } else if (readerLevel === "黑名单读者" && (creditPoint < 0 || creditPoint > 10)) {--%>
<%--            //     alert("黑名单读者的信用分必须在0到10之间！");--%>
<%--            //     return;--%>
<%--            // } else if (creditPoint < 0) {--%>
<%--            //     alert("信用分不能为负数！");--%>
<%--            //     return;--%>
<%--            // }--%>


<%--            var confirmSubmit = confirm("是否确定提交？");--%>
<%--            if (confirmSubmit) {--%>

<%--                var formData=$('#readerForm_add').serialize();--%>
<%--                // console.log("即将开始Ajax");--%>
<%--                // console.log(formData );--%>
<%--                // 使用 AJAX 发送数据到后端--%>
<%--                $.ajax({--%>
<%--                    url: '${pageContext.request.contextPath}/AddReaderServlet',  // 后端接口，用于提交数据--%>
<%--                    method: 'POST',--%>
<%--                    data: formData,  // 发送的表单数据--%>
<%--                    dataType: 'json',  // 期待返回的数据格式--%>
<%--                    success: function(response) {--%>
<%--                        if (response.resultInfo.flag) {--%>
<%--                            alert("提交成功！");--%>
<%--                            $('#myModal').hide();  // 关闭弹窗--%>
<%--                            location.reload(true);  // 刷新页面，显示新数据--%>
<%--                        } else {--%>
<%--                            alert("提交失败，错误信息: " + response.resultInfo.message);--%>
<%--                        }--%>
<%--                    },--%>
<%--                    error: function(xhr, status, error) {--%>
<%--                        alert("提交失败，错误代码: " + xhr.status + "\n" + xhr.statusText);--%>
<%--                    }--%>
<%--                });--%>

<%--            } else {--%>
<%--                // 如果用户点击"否"，则不提交--%>
<%--                alert("提交已取消！");--%>
<%--            }--%>
<%--        }--%>


<%--        submitForm2.onclick = function () {--%>
<%--            var readID = document.getElementById("readID2").value;--%>
<%--            var name = document.getElementById("name2").value;--%>
<%--            var unit = document.getElementById("unit2").value;--%>
<%--            var homeAdd = document.getElementById("homeAdd2").value;--%>
<%--            var phoneNum = document.getElementById("phoneNum2").value;--%>
<%--            var emailAdd = document.getElementById("emailAdd2").value;--%>
<%--            var creditPoint = document.getElementById("creditPoint2").value;--%>
<%--            var birthDay = document.getElementById("birthDay2").value;--%>

<%--            // 检查必填项--%>
<%--            if (!readID || !name || !unit || !homeAdd || !phoneNum || !creditPoint || !birthDay) {--%>
<%--                alert("所有必填项不能为空！");--%>
<%--                return;--%>
<%--            }--%>

<%--            // 验证读者编号（12位数字）--%>
<%--            if (!/^\d{12}$/.test(readID)) {--%>
<%--                alert("读者编号必须为12位数字！");--%>
<%--                return;--%>
<%--            }--%>

<%--            // 验证姓名（不能超过20个字符）--%>
<%--            if (name.length > 20) {--%>
<%--                alert("姓名不能超过20个字符！");--%>
<%--                return;--%>
<%--            }--%>

<%--            // 验证单位和家庭地址（不能超过100个字符）--%>
<%--            if (unit.length > 100) {--%>
<%--                alert("单位不能超过100个字符！");--%>
<%--                return;--%>
<%--            }--%>
<%--            if (homeAdd.length > 100) {--%>
<%--                alert("家庭地址不能超过100个字符！");--%>
<%--                return;--%>
<%--            }--%>

<%--            // 验证电话号码（必须为11位且以1开头）--%>
<%--            if (!/^1\d{10}$/.test(phoneNum)) {--%>
<%--                alert("电话号码必须是11位且以1开头！");--%>
<%--                return;--%>
<%--            }--%>

<%--            // 验证邮箱格式--%>
<%--            if (emailAdd && !/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(emailAdd)) {--%>
<%--                alert("电子邮箱格式不正确！");--%>
<%--                return;--%>
<%--            }--%>

<%--            // 验证信用分（必须为整数）--%>
<%--            if (!/^\d+$/.test(creditPoint)) {--%>
<%--                alert("信用分必须是整数！");--%>
<%--                return;--%>
<%--            }--%>

<%--            // **出生日期验证**：出生日期不能大于等于今天--%>
<%--            var today = new Date();--%>
<%--            var birthDate = new Date(birthDay);--%>
<%--            if (birthDate >= today) {--%>
<%--                alert("出生日期不能大于等于今天！");--%>
<%--                return;--%>
<%--            }--%>



<%--            // 弹出确认框--%>
<%--            var confirmSubmit = confirm("是否确定提交？");--%>
<%--            if (confirmSubmit) {--%>

<%--                var formData=$('#readerForm_edit').serialize();--%>
<%--                // console.log("即将开始Ajax");--%>
<%--                // console.log(formData );--%>
<%--                // 使用 AJAX 发送数据到后端--%>
<%--                $.ajax({--%>
<%--                    url: '${pageContext.request.contextPath}/EditReaderServlet',  // 后端接口，用于提交数据--%>
<%--                    method: 'POST',--%>
<%--                    data: formData,  // 发送的表单数据--%>
<%--                    dataType: 'json',  // 期待返回的数据格式--%>
<%--                    success: function(response) {--%>
<%--                        if (response.resultInfo.flag) {--%>
<%--                            alert("提交成功！");--%>
<%--                            $('#myModal').hide();  // 关闭弹窗--%>
<%--                            location.reload(true);  // 刷新页面，显示新数据--%>
<%--                        } else {--%>
<%--                            alert("提交失败，错误信息: " + response.resultInfo.message);--%>
<%--                        }--%>
<%--                    },--%>
<%--                    error: function(xhr, status, error) {--%>
<%--                        alert("提交失败，错误代码: " + xhr.status + "\n" + xhr.statusText);--%>
<%--                    }--%>
<%--                });--%>

<%--            } else {--%>
<%--                // 如果用户点击"否"，则不提交--%>
<%--                alert("提交已取消！");--%>
<%--            }--%>
<%--        }--%>
<%--    });--%>


<%--    function fetchReaderDetails(readID) {--%>
<%--        // 假设我们通过后端接口 `/LookReaderServlet` 获取数据--%>
<%--        $.ajax({--%>
<%--            url: '${pageContext.request.contextPath}/LookAnnouncementServlet', // 你的后端接口--%>
<%--            method: 'GET',--%>
<%--            data: { readID: readID }, // 发送读者编号（或其他唯一标识符）到后端--%>
<%--            dataType: 'json',--%>
<%--            success: function(response) {--%>
<%--                if (response.success) {--%>
<%--                    // 将返回的读者信息填充到弹框中的对应字段--%>
<%--                    document.getElementById("announcementID1").value = response.data.announcementID;--%>
<%--                    document.getElementById("announcementDate1").value = response.data.announcementDate;--%>
<%--                    document.getElementById("publisher1").value = response.data.publisher;--%>
<%--                    document.getElementById("announcementText1").value = response.data.announcementText;--%>
<%--                    document.getElementById("announcementKey1").value = response.data.announcementKey;--%>



<%--                    document.getElementById("announcementID2").value = response.data.announcementID;--%>
<%--                    document.getElementById("announcementDate2").value = response.data.announcementDate;--%>
<%--                    document.getElementById("publisher2").value = response.data.publisher;--%>
<%--                    document.getElementById("announcementText2").value = response.data.announcementText;--%>
<%--                    document.getElementById("announcementKey2").value = response.data.announcementKey;--%>

<%--                    console.log("respones.success");--%>
<%--                    // 显示弹框--%>
<%--                    // modal1.style.display = "block";--%>
<%--                } else {--%>
<%--                    alert("无法获取读者信息！");--%>
<%--                }--%>
<%--            },--%>
<%--            error: function(xhr, status, error) {--%>
<%--                alert("获取读者信息失败，错误代码: " + xhr.status + "\n" + xhr.statusText);--%>
<%--            }--%>
<%--        });--%>
<%--    }--%>


<%--</script>--%>



</body>
</html>
