<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Dao.DingdanDao" %>
<%@ page import="Entity.Dingdan" %>
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
            table-layout: fixed;
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
        <a  onclick="location.href='${pageContext.request.contextPath}/DingdanServlet'">订单管理</a>
        <a  onclick="location.href='${pageContext.request.contextPath}/CYanshouServlet'">验收</a>
        <a  onclick="location.href='${pageContext.request.contextPath}/TuihuoServlet'">退货清单</a>
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
        冠军小队采访系统
    </div>

    <!-- 管理列表框 -->
    <div class="content-box">
        <div class="header">
            订单信息表
        </div>
    </div>

        <table>
            <thead>
            <tr>
                <th>订单号</th>
                <th>书名</th>
                <th>作者</th>
                <th>定价</th>
                <th>书商</th>
                <th>册数</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <%
                int currentPage = request.getAttribute("currentPage")==null?1:(int) request.getAttribute("currentPage");
                int totalPages = request.getAttribute("totalPage")==null?1:(int) request.getAttribute("totalPage");
                List<Dingdan> dingdanList= (List<Dingdan>) request.getAttribute("dingdanList");
                int count = 1; // 初始化计数器
                if (dingdanList != null) { // 判断数据是否为空
                    for (Dingdan dingdan : dingdanList) {
            %>
            <tr >
                <td><%= dingdan.getOrderName() %></td>
                <td><%= dingdan.getTitle() %></td>
                <td><%= dingdan.getAuthor() %></td>
                <td><%= dingdan.getPrice() %></td>
                <td><%= dingdan.getSupplier() %></td>
                <td><%= dingdan.getSubscribeNum() %></td>

                <td>
                    <div class="tools">
                        <button id="lookButton">
                            <img src="${pageContext.request.contextPath}/image/look-icon.png" alt="查看">
                            <div class="tooltip">验收通过</div>
                        </button>

                        <button id="deleteButton">
                            <img src="${pageContext.request.contextPath}/image/delete-icon.png" alt="删除">
                            <div class="tooltip">验收不通过</div>
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
                <button onclick="location.href='${pageContext.request.contextPath}/DingdanServlet?currentPage=<%= currentPage - 1 %>'">&laquo; 上一页</button>
                <!-- 当前页信息 -->
                <span>第 <%= currentPage %> / <%= totalPages %> 页，每页显示 16 条</span>
                <!-- 下一页 -->
                <button onclick="location.href='${pageContext.request.contextPath}/DingdanServlet?currentPage=<%= currentPage + 1 %>'">下一页 &raquo;</button>
            </div>

        </div>
    </div>
</div>


<script>



    document.addEventListener("DOMContentLoaded", function() {
        // 获取模态框元素
        var deleteButtons = document.querySelectorAll("#deleteButton");

        // 遍历所有“删除”按钮并绑定点击事件
        deleteButtons.forEach(function(button) {
            button.addEventListener("click", function(event) {
                // 获取点击按钮所在行的读者信息
                var orderName = event.target.closest("tr").querySelector("td:nth-child(1)").innerText;

                // 弹出确认框
                var confirmSubmit = confirm("验收不通过？");
                if (confirmSubmit) {

                    $.ajax({
                        url: '${pageContext.request.contextPath}/NoYanshouServlet',  // 后端接口，用于提交数据
                        method: 'POST',
                        data:  { orderName: orderName },   // 发送的读者编号
                        dataType: 'json',  // 期待返回的数据格式
                        success: function(response) {
                            if (response.resultInfo.flag) {
                                alert("已经加入退货清单！");
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


    document.addEventListener("DOMContentLoaded", function() {
        // 获取模态框元素
        var lookButtons = document.querySelectorAll("#lookButton");

        // 遍历所有“删除”按钮并绑定点击事件
        lookButtons.forEach(function(button) {
            button.addEventListener("click", function(event) {
                // 获取点击按钮所在行的读者信息
                var orderName = event.target.closest("tr").querySelector("td:nth-child(1)").innerText;

                // 弹出确认框
                var confirmSubmit = confirm("验收通过？");
                if (confirmSubmit) {

                    $.ajax({
                        url: '${pageContext.request.contextPath}/YesYanshouServlet',  // 后端接口，用于提交数据
                        method: 'POST',
                        data:  { orderName: orderName },   // 发送的读者编号
                        dataType: 'json',  // 期待返回的数据格式
                        success: function(response) {
                            if (response.resultInfo.flag) {
                                alert("已经加入验收清单！");
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