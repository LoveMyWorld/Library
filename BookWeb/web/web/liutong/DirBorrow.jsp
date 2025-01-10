<%@ page import="Entity.Announcement" %>


<%@ page import="java.util.List" %>
<%@ page import="Entity.Message" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>


<html>
<head>
    <meta charset="UTF-8">
    <title>流通部借书登记</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
            font-size: 26px; /* 小赫字体变大 */
            font-family: '楷体';
            font-weight: bold;
            text-align: center;
            margin-bottom: 30px;
            padding: 30px;
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
            padding: 350px 0;   /*改变下方横线位置，就改这里*/

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
        /*加*/
        /*label:after {*/
        /*    content: "*";*/
        /*    color: red;*/
        /*    margin-left: 2px;*/
        /*}*/
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
        .display-button{
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
        .display-button:hover {
            background-color: #2980b9;
        }


    </style>
</head>
<body>
<div class="sidebar">
    <div>
        <h3>小赫</h3>

        <%--        <a  onclick="location.href='${pageContext.request.contextPath}/BorrowBookServlet'">借书</a>--%>
        <a onclick="showBorrowOptions()">借书</a>
        <a  onclick="location.href='${pageContext.request.contextPath}/ReturnBookServlet'">还书</a>
        <%--        <a  onclick="location.href='${pageContext.request.contextPath}/damageServlet'">罚款</a>--%>
        <a href="http://localhost:8080/web_Web_exploded/wangye/manageweb2.jsp">返回</a>
    </div>

    <div id="borrowOptions" style="display: none;" class="borrow-options">
        <button  class="borrow-option" onclick="location.href='${pageContext.request.contextPath}/QuickBorrowServlet'">快速通道</button><p/>
<%--        <button class="borrow-option" onclick="location.href='${pageContext.request.contextPath}/DirBorrowServlet'">读者亲自借书</button>--%>
        <button class="borrow-option" onclick="location.href='${pageContext.request.contextPath}/liutong/DirBorrow.jsp'">读者亲自借书</button>
    </div>
    <!-- 底部横杠和关于我们按钮 -->
    <div class="sidebar-footer">
        <div class="divider"></div>
        <a href="#" class="about-btn">关于我们</a>
        <a href="#" class="about-btn">帮助</a>
    </div>
</div>

<div class="container">
    <div class="system-title-box">
        小赫流通系统
    </div>
    <div class="content-box">
        <div class="header">
        读者借书登记
        </div>


        <%--    借书登记--%>
        <div id="DirBorrow-form">
            <form action="" method="get" >
                <div class="form-group" style="display: flex; align-items: center;">
                    <div style="margin-right: 10px;">
                        <label for="readID">读者编号*</label>
                        <input name="readID" type="text" id="readID" style="width: 150px;">
                    </div>
                    <div style="margin-right: 10px;">
                        <label for="bookID">书籍编号*</label>
                        <input name="bookID" type="text" id="bookID" style="width: 150px;">
                    </div>
                </div>
                <div class="form-group">
                    <label for="name">读者姓名</label>
                    <input name="name" type="text" id="name" readonly>
                </div>
                <div class="form-group">
                    <label for="gender">读者性别</label>
                    <input name="gender" type="text" id="gender" readonly>
                </div>
                <div class="form-group">
                    <label for="phoneNum">读者电话</label >
                    <input name="phoneNum" type="text" id="phoneNum" readonly>
                </div>
                <div class="form-group">
                    <label for="title">书名</label>
                    <input name="title" type="text" id="title" readonly>
                </div>
                <div class="form-group">
                    <label for="author">作者</label>
                    <input name="author" type="text" id="author" readonly>
                </div>
                <div class="form-group">
                    <label for="edition">版次</label>
                    <input name="edition" type="text" id="edition" readonly>
                </div>
                <button id="display-button" name="display-button" type="button" class="display-button">展示</button>
                <button id="return-button" name="return-button" type="button" class="return-button">确定</button>

            </form>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", function() {
                // 获取提交按钮
                var submitButton = document.getElementById("return-button");
                var displayButton = document.getElementById("display-button");

                // 为提交按钮绑定点击事件
                submitButton.addEventListener("click", function(event) {
                    // event.preventDefault(); // 阻止表单默认提交行为

                    // 获取表单数据
                    var readID = document.getElementById("readID").value;
                    var bookID = document.getElementById("bookID").value;

                    // 发送 AJAX 请求到后端进行处理
                    directBorrow(readID, bookID);
                });
                displayButton.addEventListener("click", function(event) {
                    event.preventDefault(); // 阻止表单默认提交行为

                    // 获取表单数据
                    var readID = document.getElementById("readID").value;
                    var bookID = document.getElementById("bookID").value;

                    // 发送 AJAX 请求到后端进行处理
                    displayMsg(readID, bookID);
                });

            });

            function directBorrow(readID, bookID) {
                validateForm();
                $.ajax({
                    url: '${pageContext.request.contextPath}/DirBorrowServlet', // 后端接口，用于提交数据
                    method: 'POST',
                    data: { readID: readID, bookID: bookID }, // 发送的表单数据
                    dataType: 'json', // 期待返回的数据格式
                    success: function(response) {
                        if (response.resultInfo.flag) {
                            // 填充表单中的其他字段
                            // document.getElementById("name").value = response.name;
                            // document.getElementById("gender").value = response.gender;
                            // document.getElementById("phoneNum").value = response.phoneNum;
                            // document.getElementById("title").value = response.title;
                            // document.getElementById("author").value = response.author;
                            // document.getElementById("edition").value = response.edition;

                            alert("借阅成功！");
                            location.reload(true);  // 刷新页面，显示新数据
                        } else {
                            alert("借阅失败，错误信息: " + response.resultInfo.errorMsg);
                        }
                    },
                    error: function(xhr, status, error) {
                        alert("借阅失败，错误代码: " + xhr.status + "\n" + xhr.statusText);
                    }
                });
            }
            function displayMsg(readID, bookID) {
                var flag=validateForm();
                if(flag){
                    $.ajax({
                        url: '${pageContext.request.contextPath}/DisplayMsgServlet', // 后端接口，用于提交数据
                        method: 'POST',
                        data: { readID: readID, bookID: bookID }, // 发送的表单数据
                        dataType: 'json', // 期待返回的数据格式
                        success: function(response) {
                            if (response.resultInfo.flag) {
                                // 填充表单中的其他字段
                                document.getElementById("name").value = response.name;
                                document.getElementById("gender").value = response.gender;
                                document.getElementById("phoneNum").value = response.phoneNum;
                                document.getElementById("title").value = response.title;
                                document.getElementById("author").value = response.author;
                                document.getElementById("edition").value = response.edition;

                                alert("展示成功，请现场核对读者和书籍信息！");
                                // location.reload(true);  // 刷新页面，显示新数据
                            } else {
                                alert("错误信息: " + response.resultInfo.errorMsg);
                            }
                        },
                        error: function(xhr, status, error) {
                            alert("查询信息失败: " + xhr.status + "\n" + xhr.statusText);
                        }
                    });
                }

            }

            function validateForm() {
                var readID = document.getElementById("readID").value;
                var bookID = document.getElementById("bookID").value;

                if (readID === "" || readID.length === 0) {
                    alert("读者编号不能为空");
                    return false;
                }
                if (bookID === "" || bookID.length === 0) {
                    alert("图书编号不能为空");
                    return false;
                }

                return true;
            }
        </script>
    </div>
</div>
</body>

</html>