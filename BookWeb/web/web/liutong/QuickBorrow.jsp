<%@ page import="Dao.YanshouDao" %>
<%@ page import="Entity.Yanshou" %>
<%@ page import="java.util.List" %>
<%@ page import="Entity.Appointment" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <meta charset="UTF-8">
  <title>冠军小队流通系统——借书</title>
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
    .review-icon {
      width: 16px; /* 调整为你需要的宽度 */
      height: 16px; /* 调整为你需要的高度 */
    }
    /*//借书*/
    .borrow-options {
      display: flex;
      flex-direction: column; /* 垂直排列按钮 */
      align-items: center; /* 水平居中对齐 */
      gap: 10px; /* 按钮之间的间距 */
      margin-top: 20px; /* 与上方内容的间距 */
    }

    .borrow-option {

      padding: 10px 20px; /* 内边距 */
      border: none; /* 无边框 */
      border-radius: 5px; /* 圆角 */
      background: linear-gradient(to right, #51669c, #266acf); /* 渐变背景 */
      font-family: '楷体';
      color: white; /* 文字颜色 */
      font-size: 16px; /* 字体大小 */
      cursor: pointer; /* 鼠标指针样式 */
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2); /* 阴影 */
      transition: background-color 0.3s, transform 0.3s; /* 过渡效果 */
    }

    .borrow-option:hover {
      background: linear-gradient(to right, #516693, #2e4d9f); /* 鼠标悬停时的渐变背景 */
      font-family: '楷体';
      transform: translateY(-2px); /* 向上移动 */
    }

    .borrow-option:active {
      transform: translateY(0); /* 按钮按下时的位置 */
    }

  </style>
</head>
<body>

<div class="sidebar">
  <div>
    <h3>冠军小队</h3>

    <%--        <a  onclick="location.href='${pageContext.request.contextPath}/BorrowBookServlet'">借书</a>--%>
    <a onclick="showBorrowOptions()">借书</a>
    <a  onclick="location.href='${pageContext.request.contextPath}/ReturnBookServlet'">还书</a>
    <%--        <a  onclick="location.href='${pageContext.request.contextPath}/damageServlet'">罚款</a>--%>
  </div>

  <div id="borrowOptions" style="display: none;" class="borrow-options">
    <button  class="borrow-option" onclick="location.href='${pageContext.request.contextPath}/QuickBorrowServlet'">快速通道</button><p/>
<%--    <button class="borrow-option" onclick="location.href='${pageContext.request.contextPath}/DirBorrowServlet'">读者亲自借书</button>--%>
    <button class="borrow-option" onclick="location.href='${pageContext.request.contextPath}/liutong/DirBorrow.jsp'">读者亲自借书</button>
  </div>
  <%--      改--%>
  <!-- 底部横杠和关于我们按钮 -->
  <div class="sidebar-footer">
    <div class="divider"></div>
    <a href="#" class="about-btn">关于我们</a>
    <a href="#" class="about-btn">帮助</a>
  </div>
</div>


<div class="container">
  <!-- 冠军小队编目系统框 -->
  <div class="system-title-box">
    冠军小队流通系统
  </div>

  <!-- 编目管理列表框 -->
  <div class="content-box">
    <div class="header">
      流通管理列表
    </div>
    <div class="toolbar">
      <div class="tools">

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
        <form action="${pageContext.request.contextPath}/QuickBorrowServlet" method="get">
          <select name="searchField">
            <%--                        <option value="isbn">ISBN</option>--%>
            <option value="title">书名</option>
            <option value="bookID">图书编号</option>
            <option value="name">借书人</option>
            <option value="readID">读者编号</option>
          </select>
          <input type="text" name="searchValue" placeholder="请输入关键词" />
          <input type="text" name="seach" value="" hidden="hidden"/>
          <button type="submit">搜索</button>
        </form>
      </div>

    </div>
    <table>
      <thead>
      <tr>
        <th>序号</th>
        <th>预约号</th>
        <th>书名</th>
        <th>读者姓名</th>
        <th>电话号码</th>
        <th>图书编号</th>
        <th>预约开始时间</th>
        <th>预约结束时间</th>
        <th>操作</th>

      </tr>
      </thead>
      <tbody>
      <%
        int currentPage = request.getAttribute("currentPage")==null?1:(int) request.getAttribute("currentPage");
        int totalPages = request.getAttribute("totalPage")==null?1:(int) request.getAttribute("totalPage");
        List<Appointment> appointmentList= (List<Appointment>) request.getAttribute("appointmentList");
        int count = 1; // 初始化计数器
        if (appointmentList != null) { // 判断数据是否为空
          for (Appointment appointment : appointmentList) {
      %>
      <tr >
        <td><%= count++ %></td>
        <td><%= appointment.getApID() %></td>
        <td><%= appointment.getTitle() %></td>
        <td><%= appointment.getName() %></td>
        <td><%= appointment.getPhoneNum() %></td>
        <td><%= appointment.getBookID() %></td>
        <td><%= appointment.getAppointmentStart() %></td>
        <td><%= appointment.getAppointmentEnd() %></td>
        <td>

          <button class="reviewButton">
            <img src="${pageContext.request.contextPath}/image/Shenhe.png" alt="审核" class="review-icon">
            <div class="tooltip">审核</div>
          </button>


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
        <button onclick="location.href='${pageContext.request.contextPath}/QuickBorrowServlet?currentPage=<%= currentPage - 1 %>'">&laquo; 上一页</button>
        <!-- 当前页信息 -->
        <span>第 <%= currentPage %> / <%= totalPages %> 页，每页显示 16 条</span>
        <!-- 下一页 -->
        <button onclick="location.href='${pageContext.request.contextPath}/QuickBorrowServlet?currentPage=<%= currentPage + 1 %>'">下一页 &raquo;</button>

      </div>
    </div>
    <script>
      document.addEventListener("DOMContentLoaded", function() {
        // 获取所有的“审核”按钮
        var reviewButtons = document.querySelectorAll(".reviewButton");

        // 遍历所有“审核”按钮并绑定点击事件
        reviewButtons.forEach(function(button) {
          button.addEventListener("click", function(event) {
            // 获取点击按钮所在行的预约号
            var apID = event.target.closest("tr").querySelector("td:nth-child(2)").innerText;

            // 发送 AJAX 请求到后端进行审核
            reviewAppointment(apID);
          });
        });
      });

      function reviewAppointment(apID) {
        $.ajax({
          url: '${pageContext.request.contextPath}/CheckAppointmentServlet',  // 后端接口，用于提交数据
          method: 'POST',
          data: { apID: apID },  // 发送的表单数据
          dataType: 'json',  // 期待返回的数据格式
          success: function(response) {
            if (response.resultInfo.flag) {
              alert("审核成功！");
              location.reload(true);  // 刷新页面，显示新数据
            } else {
              alert("提交失败，错误信息: " + response.resultInfo.errorMsg);
            }
          },
          error: function(xhr, status, error) {
            alert("提交失败，错误代码: " + xhr.status + "\n" + xhr.statusText);
          }
        });
      }

      function showBorrowOptions() {
        var borrowOptions = document.getElementById("borrowOptions");
        if (borrowOptions.style.display === "none") {
          borrowOptions.style.display = "block";
        } else {
          borrowOptions.style.display = "none";
        }
      }
    </script>
  </div>
</div>

</body>
</html>

