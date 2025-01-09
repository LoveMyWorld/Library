<%@ page import="Entity.Announcement" %>


<%@ page import="java.util.List" %>
<%@ page import="Entity.Message" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>管理员网络管理界面</title>
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
            display: none; /* 默认隐藏所有内容框 */
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


    </style>
</head>
<body>
<div class="sidebar">
    <div>
        <h3>冠军小队</h3>
        <a href="${pageContext.request.contextPath}/wangye/manageannouncement.jsp" >发布公告</a>

        <a  onclick="location.href='${pageContext.request.contextPath}/HistoryAnnouncementServlet'">历史公告</a>
        <a href="${pageContext.request.contextPath}/wangye/tongbao.jsp" >发布通报</a>

        <a  onclick="location.href='${pageContext.request.contextPath}/MessageServlet'">查看留言</a>
    </div>
</div>
<div class="container">
    <div class="system-title-box">
        管理员网络管理界面
    </div>


<%--    发布公告--%>
<%--    <div class="content-box" id="announcement-form">--%>
<%--        <h4>发布公告</h4>--%>
<%--        <form action="${pageContext.request.contextPath}/AnnouncementServlet" method="get">--%>
<%--            <div class="form-group" style="display: flex; align-items: center;">--%>
<%--                <div style="margin-right: 10px;">--%>
<%--                    <label for="publisher">发布人</label>--%>
<%--                    <input name="publisher" type="text" id="publisher" value="${sessionScope.username}" style="width: 150px;">--%>
<%--                </div>--%>
<%--                <div>--%>
<%--                    <label for="publishDate">发布日期</label>--%>
<%--                    <input name="announcementDate" type="date" id="publishDate" style="width: 150px;">--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="form-group">--%>
<%--                <label for="announcementTitle">公告主题</label>--%>
<%--                <input name="announcementKey" type="text" id="announcementTitle">--%>
<%--            </div>--%>
<%--            <div class="form-group">--%>
<%--                <label for="announcementContent">公告内容</label>--%>
<%--                <textarea name="announcementText" id="announcementContent" rows="5"></textarea>--%>
<%--            </div>--%>
<%--            <button type="submit" class="return-button">发布</button>--%>
<%--        </form>--%>
<%--        <!-- 添加历史公告按钮 -->--%>
<%--        <button id="showHistoryButton" class="return-button"  onclick="showHistoryAnnouncement()"  style="position: absolute; bottom: 700px; right: 10px;">历史公告</button>--%>
<%--    </div>--%>

    <!-- 历史公告界面 -->




<%--    <form action="${pageContext.request.contextPath}/HistoryAnnouncementServlet" method="get">--%>
<%--    <div id="history-announcement" class="content-box" style="display: none;">--%>
<%--        <h4>历史公告</h4>--%>
<%--        <button type="submit" class="return-button">导入</button>--%>

<%--        <table>--%>
<%--            <thead>--%>
<%--            <tr>--%>
<%--                <th>序号</th>--%>
<%--                <th>发布人</th>--%>
<%--                <th>主题</th>--%>
<%--            </tr>--%>
<%--            </thead>--%>
<%--            <tbody>--%>
<%--            <!-- 假设这里用 Java 在后台动态填充数据 -->--%>

<%--            <%--%>
<%--            List<Announcement> announcementList= (List<Announcement>) request.getAttribute("list");--%>
<%--            if (announcementList != null) { // 判断数据是否为空--%>
<%--            for (Announcement announcement : announcementList) {--%>
<%--            %>--%>
<%--            <tr >--%>
<%--                <td><%= announcement.getAnnouncementID() %></td>--%>
<%--                <td><%= announcement.getPublisher() %></td>--%>
<%--                <td><%= announcement.getAnnouncementKey() %></td>--%>


<%--            </tr>--%>
<%--                <%--%>
<%--                }--%>
<%--                    }--%>
<%--                %>--%>
<%--            <!-- 更多数据行 -->--%>
<%--            </tbody>--%>
<%--        </table>--%>
<%--    </div>--%>
<%--</form>--%>






<%--    通告--%>
    <div class="content-box" id="notice-form">
        <h4>发布通告</h4>
        <form>
            <div class="form-group">
                <label for="noticePublisher">发布人</label>
                <input type="text" id="noticePublisher" value="${sessionScope.username}" readonly>
            </div>
            <div class="form-group">
                <label for="noticeDate">发布日期</label>
                <input type="date" id="noticeDate">
            </div>
            <div class="form-group">
                <label for="noticeTitle">通告主题</label>
                <input type="text" id="noticeTitle">
            </div>
            <div class="form-group">
                <label for="noticeContent">通告内容</label>
                <textarea id="noticeContent" rows="5"></textarea>
            </div>
            <button type="submit">发布</button>
        </form>
    </div>



<%--&lt;%&ndash;    留言&ndash;%&gt;--%>
<%--    <form action="${pageContext.request.contextPath}/MessageServlet" method="get">--%>
<%--        <div id="messages-form" class="content-box" style="display: none;">--%>
<%--            <h4>留言列表</h4>--%>
<%--       <button id ="messagebutton" type="submit" class="return-button">导入</button>--%>

<%--            <table>--%>
<%--                <thead>--%>
<%--                <tr>--%>
<%--                    <th>序号</th>--%>
<%--                    <th>留言人</th>--%>
<%--                    <th>留言内容</th>--%>
<%--                </tr>--%>
<%--                </thead>--%>
<%--                <tbody>--%>
<%--                <!-- 假设这里用 Java 在后台动态填充数据 -->--%>

<%--                <%--%>
<%--                   List<Message> messageList= (List<Message>) request.getAttribute("massagelist");--%>
<%--                    if (messageList != null) { // 判断数据是否为空--%>
<%--                        for (Message message : messageList) {--%>
<%--                %>--%>
<%--                <tr >--%>
<%--                    <td><%= message.getMessageID() %></td>--%>
<%--                    <td><%= message.getPublisher() %></td>--%>
<%--                    <td><%= message.getMessageText() %></td>--%>


<%--                </tr>--%>
<%--                <%--%>
<%--                        }--%>
<%--                    }--%>
<%--                %>--%>
<%--                <!-- 更多数据行 -->--%>
<%--                </tbody>--%>
<%--            </table>--%>
<%--        </div>--%>

<%--    </form>--%>

<script>
    function showAnnouncementForm() {
        hideAllForms();
        document.getElementById('announcement-form').style.display = 'block';
    }

    function showNoticeForm() {
        hideAllForms();
        document.getElementById('notice-form').style.display = 'block';
    }

    function showMessagesForm() {
        hideAllForms();
        document.getElementById('messages-form').style.display = 'block';
    }

    function hideAllForms() {
        const forms = document.querySelectorAll('.content-box');
        forms.forEach(form => {
            form.style.display = 'none';
        });
    }

    function  showHistoryAnnouncement(){
        hideAllForms();
        document.getElementById('history-announcement').style.display = 'block';
        <%--// 获取数据--%>
        <%--var text = document.getElementById('hhh');--%>
        <%--var formData = $('#bookForm').serialize();--%>

        <%--// 形成Ajax数据包--%>
        <%--$.ajax({--%>
        <%--      url: '${pageContext.request.contextPath}/initBookForm',--%>
        <%--        data:formData,--%>
        <%--        dataType:json,--%>
        <%--        method:GET,--%>
        <%--        success:function(response){--%>
        <%--            if(response.resultInfo.flag){--%>
        <%--                var username = response.username;--%>
        <%--                var book = response.resultInfo.data;--%>
        <%--                var bookname = response.resultInfo.data.bookname;--%>
        <%--                // 数据回填到界面中--%>
        <%--                $('#username').val(username);--%>
        <%--                $('#username').prop('readonly' , true);--%>
        <%--            }--%>
        <%--            else{--%>
        <%--                alter(response.resultInfo.errorMsg);--%>
        <%--            }--%>
        <%--        },--%>
        <%--        error:function (response){--%>
        <%--          --%>
        <%--        }--%>
        <%--});--%>
    }

    window.onload = function() {
        hideAllForms();
    };
</script>
</body>
</html>