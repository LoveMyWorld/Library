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


  </style>
</head>
<body>

<div class="sidebar">
  <div>
    <h3>小赫</h3>
    <a href="${pageContext.request.contextPath}/wangye/manageannouncement.jsp" >发布公告</a>

    <a  onclick="location.href='${pageContext.request.contextPath}/HistoryAnnouncementServlet'">历史公告</a>

    <a  onclick="location.href='${pageContext.request.contextPath}/MessageServlet'">查看留言</a>
      <a href="http://localhost:8080/web_Web_exploded/wangye/manageweb5.jsp">返回</a>
  </div>
</div>
<div class="container">
  <div class="system-title-box">
    管理员网络管理界面
  </div>
</div>




<%--    留言--%>
<form action="${pageContext.request.contextPath}/MessageServlet" method="get">
  <div id="history-announcement"  class="content-box" >
    <h4>留言列表</h4>
    <button id ="messagebutton" type="submit" class="return-button">刷新</button>

    <table>
      <thead>
      <tr>

        <th>留言人</th>
        <th>留言内容</th>
<%--        <th>操作</th>--%>
      </tr>
      </thead>
      <tbody>
      <!-- 假设这里用 Java 在后台动态填充数据 -->

      <%



        List<Message> messageList= (List<Message>) request.getAttribute("massagelist");



        if (messageList != null) { // 判断数据是否为空
          for (Message message : messageList) {
      %>
      <tr >

        <td><%= message.getPublisher() %></td>
        <td><%= message.getMessageText() %></td>


<%--        <td>--%>
<%--          <div class="tools">--%>
<%--            <button id="lookButton">--%>
<%--              <img src="${pageContext.request.contextPath}/image/look-icon.png" alt="查看">--%>
<%--              <div class="tooltip">已读</div>--%>
<%--            </button>--%>


<%--          </div>--%>
<%--        </td>--%>

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











</body>


</html>

