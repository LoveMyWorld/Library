<%@ page import="Dao.YanshouDao" %>
<%@ page import="Entity.Yanshou" %>
<%@ page import="java.util.List" %>
<%@ page import="static Servlet.Catalog.YanshouServlet.PAGE_SIZE" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>小赫编目系统——验收</title>
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
  </style>
</head>
<body>
<%--<div class="sidebar">--%>
<%--  <div>--%>
<%--    <h3>小赫</h3>--%>

<%--    <a href="#" class="active">编目管理</a>--%>
<%--&lt;%&ndash;    <a href="#" class="active">验收清单</a>&ndash;%&gt;--%>
<%--      <a href="javascript:void(0);" class="active" id="yanshou-btn">验收清单</a>--%>


<%--      <a href="#" class="active">报损</a>--%>
<%--      改--%>
<div class="sidebar">
          <div>
              <h3>小赫</h3>

              <a  onclick="location.href='${pageContext.request.contextPath}/CatalogMServlet'">编目管理</a>
              <a  onclick="location.href='${pageContext.request.contextPath}/YanshouServlet'">验收清单</a>
              <a  onclick="location.href='${pageContext.request.contextPath}/DamageServlet'">报损</a>
              <a href="http://localhost:8080/web_Web_exploded/wangye/manageweb1.jsp">返回</a>
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
  <!-- 小赫编目系统框 -->
  <div class="system-title-box">
    小赫编目系统
  </div>

  <!-- 编目管理列表框 -->
  <div class="content-box">
    <div class="header">
      编目管理列表
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
<%--      <div class="search">--%>
<%--        <select>--%>
<%--&lt;%&ndash;          后端需要传回日期，在下拉框显示&ndash;%&gt;--%>
<%--          <option value="isbn">ISBN</option>--%>
<%--          <option value="title">书名</option>--%>
<%--          <option value="author">作者</option>--%>
<%--          <option value="classification">分类号</option>--%>
<%--        </select>--%>
<%--        <input type="text" placeholder="请输入书名">--%>
<%--        <button>搜索</button>--%>
<%--      </div>--%>
        <div class="search">
            <form action="${pageContext.request.contextPath}/YanshouServlet" method="get">
                <select name="searchField">
                    <option value="isbn">ISBN</option>
                    <option value="title">书名</option>
                    <option value="author">作者</option>
                    <option value="publisher">出版社</option>
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
        <th>书名</th>
        <th>ISBN</th>
        <th>作者</th>
        <th>出版社</th>
<%--        <th>编著者</th>--%>
<%--        <th>分类号</th>--%>
      </tr>
      </thead>
        <tbody>
        <%
            int currentPage = request.getAttribute("currentPage")==null?1:(int) request.getAttribute("currentPage");
            int totalPages = request.getAttribute("totalPage")==null?1:(int) request.getAttribute("totalPage");
            List<Yanshou> yanshouList= (List<Yanshou>) request.getAttribute("yanshouList");
            int count = 1; // 初始化计数器
            if (yanshouList != null) { // 判断数据是否为空
                for (Yanshou yanshou : yanshouList) {
        %>
        <tr >
            <td><%= count++ %></td>
            <td><%= yanshou.getTitle() %></td>
            <td><%= yanshou.getISBN() %></td>
            <td><%= yanshou.getAuthor() %></td>
            <td><%= yanshou.getPublisher() %></td>

        </tr>
        <%
                }

            }
        %>
        </tbody>
<%--      <tbody>--%>
<%--      <tr>--%>
<%--        <td>1</td>--%>
<%--        <td>销售如何说...</td>--%>
<%--        <td>9787545606681</td>--%>
<%--        <td>陆汝香</td>--%>
<%--        <td>新华书店</td>--%>
<%--      </tr>--%>
<%--      <tr>--%>
<%--        <td>2</td>--%>
<%--        <td>蔡康永的说...</td>--%>
<%--        <td>9787544143158</td>--%>
<%--        <td>蔡康永</td>--%>
<%--        <td>xinhau</td>--%>
<%--      </tr>--%>
<%--      </tbody>--%>
    </table>
    <div class="pagination">
        <div class="pagination">
            <!-- 上一页 -->
            <button onclick="location.href='${pageContext.request.contextPath}/YanshouServlet?currentPage=<%= currentPage - 1 %>'"<%= currentPage <= 1 ? "disabled" : "" %>>&laquo; 上一页</button>
            <!-- 当前页信息 -->
            <span>第 <%= currentPage %> / <%= totalPages %> 页，每页显示<%=PAGE_SIZE%>条</span>
            <!-- 下一页 -->
            <button onclick="location.href='${pageContext.request.contextPath}/YanshouServlet?currentPage=<%= currentPage + 1 %>'" <%= currentPage >= totalPages ? "disabled" : "" %>>下一页 &raquo;</button>
            <!-- 跳转到指定页 -->
            <span style="margin-left:10px;">
                跳转到第
                <input type="number" id="gotoPage" min="1" max="<%= totalPages %>" style="width:50px;" value="<%= currentPage %>">
                页
                <button onclick="gotoPageFunc()">跳转</button>
            </span>
        </div>
    </div>
    <script>
        function gotoPageFunc() {
            var page = document.getElementById('gotoPage').value;
            var total = Number('<%= totalPages %>');
            if(page < 1) page = 1;
            if(page > total) page = total;
            location.href = '${pageContext.request.contextPath}/YanshouServlet?currentPage=' + page;
        }
    </script>
  </div>
</div>
</body>
</html>

