<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Dao.RlevelDao" %>
<%@ page import="Entity.Rlevel" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <title>冠军小队读者级别维护</title>
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
            读者级别维护列表
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
                <form action="${pageContext.request.contextPath}/RlevelServlet" method="get">
                    <select name="searchField">
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
                <th>读者级别</th>
                <th>信用分范围</th>
                <th>可借阅数</th>
                <th>可借天数</th>
                <th>可预约数</th>
                <th>预约天数</th>
                <th>超期罚款/天</th>
                <th style="width: 80px;">操作</th>
            </tr>
            </thead>
            <tbody>
            <%
                int currentPage = request.getAttribute("currentPage")==null?1:(int) request.getAttribute("currentPage");
                int totalPages = request.getAttribute("totalPage")==null?1:(int) request.getAttribute("totalPage");
                List<Rlevel> rlevelList= (List<Rlevel>) request.getAttribute("rlevelList");
                int count = 1; // 初始化计数器
                if (rlevelList != null) { // 判断数据是否为空
                    for (Rlevel rlevel : rlevelList) {
            %>
            <tr >
                <td><%= count++ %></td>
                <td><%= rlevel.getReaderLevel() %></td>
                <td><%= rlevel.getCreditPointRange() %></td>
                <td><%= rlevel.getBorrowNum() %></td>
                <td><%= rlevel.getBorrowDay() %></td>
                <td><%= rlevel.getOrderNum() %></td>
                <td><%= rlevel.getOrderDay() %></td>
                <td><%= rlevel.getFineEveryday() %></td>

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
                <button onclick="location.href='${pageContext.request.contextPath}/RlevelServlet?currentPage=<%= currentPage - 1 %>'">&laquo; 上一页</button>
                <!-- 当前页信息 -->
                <span>第 <%= currentPage %> / <%= totalPages %> 页，每页显示 16 条</span>
                <!-- 下一页 -->
                <button onclick="location.href='${pageContext.request.contextPath}/RlevelServlet?currentPage=<%= currentPage + 1 %>'">下一页 &raquo;</button>
            </div>

        </div>
    </div>
</div>

<%--添加框--%>
<div id="myModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            读者级别信息
            <span class="close" id="closeModal">&times;</span>
        </div>
        <form id="rlevelForm_add">
            <table class="modal-table">
                <tr>
                    <th>读者级别</th>
                    <td><select id="readerLevel" name="readerLevel">
                        <option value="高级读者">高级读者</option>
                        <option value="中级读者">中级读者</option>
                        <option value="低级读者">低级读者</option>
                        <option value="黑名单读者">黑名单读者</option>
                    </select><span style="color: red;">*</span></td>
                    <th>信用分范围</th>
                    <td><input type="text" id="creditPointRange" name="creditPointRange"><span style="color: red;">*</span></td>
                </tr>
                <tr>
                    <th>可借阅数</th>
                    <td><input type="text" id="borrowNum" name="borrowNum"><span style="color: red;">*</span></td>
                    <th>可借天数</th>
                    <td><input type="text" id="borrowDay" name="borrowDay"><span style="color: red;">*</span></td> <!-- 更改为日期选择器 -->
                </tr>
                <tr>
                    <th>可预约数</th>
                    <td><input type="text" id="orderNum" name="orderNum"><span style="color: red;">*</span></td>
                    <th>预约天数</th>
                    <td><input type="text" id="orderDay" name="orderDay"><span style="color: red;">*</span></td>
                </tr>
                <tr>
                    <th>超期罚款/天</th>
                    <td><input type="text" id="fineEveryday" name="fineEveryday"><span style="color: red;">*</span></td>
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
            读者级别信息
            <span class="close" id="closeModal1">&times;</span>
        </div>
        <form id="rlevelForm_look">
            <table class="modal-table">
                <tr>
                    <th>读者级别</th>
                    <td><input type="text" id="readerLevel1" name="readerLevel" readonly></td>
                    <th>信用分范围</th>
                    <td><input type="text" id="creditPointRange1" name="creditPointRange" readonly></td>
                </tr>
                <tr>
                    <th>可借阅数</th>
                    <td><input type="text" id="borrowNum1" name="borrowNum" readonly></td>
                    <th>可借天数</th>
                    <td><input type="text" id="borrowDay1" name="borrowDay" readonly></td> <!-- 更改为日期选择器 -->
                </tr>
                <tr>
                    <th>可预约数</th>
                    <td><input type="text" id="orderNum1" name="orderNum" readonly></td>
                    <th>预约天数</th>
                    <td><input type="text" id="orderDay1" name="orderDay" readonly></td>
                </tr>
                <tr>
                    <th>超期罚款/天</th>
                    <td><input type="text" id="fineEveryday1" name="fineEveryday" readonly></td>
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
        <form id="rlevelForm_edit">
            <table class="modal-table">
                <tr>
                    <th>读者级别</th>
                    <td><input type="text" id="readerLevel2" name="readerLevel" readonly></td>
                    <th>信用分范围</th>
                    <td><input type="text" id="creditPointRange2" name="creditPointRange"></td>
                </tr>
                <tr>
                    <th>可借阅数</th>
                    <td><input type="text" id="borrowNum2" name="borrowNum"></td>
                    <th>可借天数</th>
                    <td><input type="text" id="borrowDay2" name="borrowDay"></td> <!-- 更改为日期选择器 -->
                </tr>
                <tr>
                    <th>可预约数</th>
                    <td><input type="text" id="orderNum2" name="orderNum"></td>
                    <th>预约天数</th>
                    <td><input type="text" id="orderDay2" name="orderDay"></td>
                </tr>
                <tr>
                    <th>超期罚款/天</th>
                    <td><input type="text" id="fineEveryday2" name="fineEveryday"></td>
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
                var readerLevel = event.target.closest("tr").querySelector("td:nth-child(2)").innerText;

                // 发送请求获取该读者的详细信息
                fetchRlevelDetails(readerLevel);
            });
        });

        // 遍历所有“编辑”按钮并绑定点击事件
        editButtons.forEach(function(button) {
            button.addEventListener("click", function(event) {
                modal2.style.display = "block";
                // 获取点击按钮所在行的读者信息
                var readerLevel = event.target.closest("tr").querySelector("td:nth-child(2)").innerText;

                // 发送请求获取该读者的详细信息
                fetchRlevelDetails(readerLevel);
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
            var creditPointRange = document.getElementById("creditPointRange").value;
            var borrowNum = document.getElementById("borrowNum").value;
            var borrowDay = document.getElementById("borrowDay").value;
            var orderNum = document.getElementById("orderNum").value;
            var orderDay = document.getElementById("orderDay").value;
            var fineEveryday = document.getElementById("fineEveryday").value;

            // 检查必填项
            if (!creditPointRange  || !borrowNum || !borrowDay || !orderNum || !orderDay || !fineEveryday ) {
                alert("所有必填项不能为空！");
                return;
            }

            // **信用分范围验证**：格式应该为"数字1~数字2"，且数字1<=数字2
            var creditPointMatch = /^(\d+)~(\d+)$/.exec(creditPointRange);
            if (!creditPointMatch) {
                alert("信用分范围格式不正确！应为'数字1~数字2'的形式！");
                return;
            }
            var minCredit = parseInt(creditPointMatch[1], 10);
            var maxCredit = parseInt(creditPointMatch[2], 10);
            if (minCredit > maxCredit) {
                alert("信用分范围的数字1不能大于数字2！");
                return;
            }

            // **借阅数、借阅天数、预约数、预约天数验证**：必须是大于等于0的整数
            if (!/^\d+$/.test(borrowNum) || parseInt(borrowNum, 10) < 0) {
                alert("可借阅数必须为大于等于0的整数！");
                return;
            }
            if (!/^\d+$/.test(borrowDay) || parseInt(borrowDay, 10) < 0) {
                alert("借阅天数必须为大于等于0的整数！");
                return;
            }
            if (!/^\d+$/.test(orderNum) || parseInt(orderNum, 10) < 0) {
                alert("可预约数必须为大于等于0的整数！");
                return;
            }
            if (!/^\d+$/.test(orderDay) || parseInt(orderDay, 10) < 0) {
                alert("预约天数必须为大于等于0的整数！");
                return;
            }

            // **超期罚款/天验证**：必须大于0
            if (parseFloat(fineEveryday) <= 0) {
                alert("超期罚款/天不能小于等于0！");
                return;
            }

            // 弹出确认框
            var confirmSubmit = confirm("是否确定提交？");
            if (confirmSubmit) {

                var formData=$('#rlevelForm_add').serialize();
                // console.log("即将开始Ajax");
                // console.log(formData );
                // 使用 AJAX 发送数据到后端
                $.ajax({
                    url: '${pageContext.request.contextPath}/AddRlevelServlet',  // 后端接口，用于提交数据
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

        };


        // 提交表单2时验证
        submitForm2.onclick = function () {
            var creditPointRange = document.getElementById("creditPointRange2").value;
            var borrowNum = document.getElementById("borrowNum2").value;
            var borrowDay = document.getElementById("borrowDay2").value;
            var orderNum = document.getElementById("orderNum2").value;
            var orderDay = document.getElementById("orderDay2").value;
            var fineEveryday = document.getElementById("fineEveryday2").value;

            // 检查必填项
            if (!creditPointRange  || !borrowNum || !borrowDay || !orderNum || !orderDay || !fineEveryday ) {
                alert("所有必填项不能为空！");
                return;
            }

            // **信用分范围验证**：格式应该为"数字1~数字2"，且数字1<=数字2
            var creditPointMatch = /^(\d+)~(\d+)$/.exec(creditPointRange);
            if (!creditPointMatch) {
                alert("信用分范围格式不正确！应为'数字1~数字2'的形式！");
                return;
            }
            var minCredit = parseInt(creditPointMatch[1], 10);
            var maxCredit = parseInt(creditPointMatch[2], 10);
            if (minCredit > maxCredit) {
                alert("信用分范围的数字1不能大于数字2！");
                return;
            }

            // **借阅数、借阅天数、预约数、预约天数验证**：必须是大于等于0的整数
            if (!/^\d+$/.test(borrowNum) || parseInt(borrowNum, 10) < 0) {
                alert("可借阅数必须为大于等于0的整数！");
                return;
            }
            if (!/^\d+$/.test(borrowDay) || parseInt(borrowDay, 10) < 0) {
                alert("借阅天数必须为大于等于0的整数！");
                return;
            }
            if (!/^\d+$/.test(orderNum) || parseInt(orderNum, 10) < 0) {
                alert("可预约数必须为大于等于0的整数！");
                return;
            }
            if (!/^\d+$/.test(orderDay) || parseInt(orderDay, 10) < 0) {
                alert("预约天数必须为大于等于0的整数！");
                return;
            }

            // **超期罚款/天验证**：必须大于0
            if (parseFloat(fineEveryday) <= 0) {
                alert("超期罚款/天不能小于等于0！");
                return;
            }

            // 弹出确认框
            var confirmSubmit = confirm("是否确定提交？");
            if (confirmSubmit) {

                var formData=$('#rlevelForm_edit').serialize();
                // console.log("即将开始Ajax");
                // console.log(formData );
                // 使用 AJAX 发送数据到后端
                $.ajax({
                    url: '${pageContext.request.contextPath}/EditRlevelServlet',  // 后端接口，用于提交数据
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
    function fetchRlevelDetails(readerLevel) {
        // 假设我们通过后端接口 `/LookRlevelServlet` 获取数据
        $.ajax({
            url: '${pageContext.request.contextPath}/LookRlevelServlet', // 你的后端接口
            method: 'GET',
            data: { readerLevel: readerLevel }, // 发送读者编号（或其他唯一标识符）到后端
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    // 将返回的读者信息填充到弹框中的对应字段
                    document.getElementById("readerLevel1").value = response.data.readerLevel;
                    document.getElementById("creditPointRange1").value = response.data.creditPointRange;
                    document.getElementById('borrowNum1').value = response.data.borrowNum;
                    document.getElementById("borrowDay1").value = response.data.borrowDay;
                    document.getElementById("orderNum1").value = response.data.orderNum;
                    document.getElementById("orderDay1").value = response.data.orderDay;
                    document.getElementById("fineEveryday1").value = response.data.fineEveryday;

                    document.getElementById("readerLevel2").value = response.data.readerLevel;
                    document.getElementById("creditPointRange2").value = response.data.creditPointRange;
                    document.getElementById('borrowNum2').value = response.data.borrowNum;
                    document.getElementById("borrowDay2").value = response.data.borrowDay;
                    document.getElementById("orderNum2").value = response.data.orderNum;
                    document.getElementById("orderDay2").value = response.data.orderDay;
                    document.getElementById("fineEveryday2").value = response.data.fineEveryday;

                    // 显示弹框
                    // modal1.style.display = "block";
                } else {
                    alert("无法获取读者级别信息！");
                }
            },
            error: function(xhr, status, error) {
                alert("获取读者级别信息失败，错误代码: " + xhr.status + "\n" + xhr.statusText);
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
                var readerLevel = event.target.closest("tr").querySelector("td:nth-child(2)").innerText;

                // 弹出确认框
                var confirmSubmit = confirm("是否确定删除？");
                if (confirmSubmit) {

                    $.ajax({
                        url: '${pageContext.request.contextPath}/DeleteRlevelServlet',  // 后端接口，用于提交数据
                        method: 'POST',
                        data:  { readerLevel: readerLevel },   // 发送的读者编号
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