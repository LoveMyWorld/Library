<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Entity.Liutong" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>图书馆流通系统界面</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f7f9fc;
            overflow-x: hidden;
        }
        .sidebar {
            width: 200px;
            background-color: #015999;
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
            padding: 0px 0px 10px 0px;
            width: 100%;
            margin-left: 1%;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            position: relative;
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
            width: 180px;
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
            background-color: #fffbcc;
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
<div class="sidebar">
    <div>
        <h3>小赫</h3>
        <a href="http://localhost:8080/web_Web_exploded/caifang/interview.jsp"  style="color: gray; pointer-events: none;">采访管理</a>
        <a href="${pageContext.request.contextPath}/CatalogMServlet"  style="color: gray; pointer-events: none;">编目管理</a>
        <a href="${pageContext.request.contextPath}/QuickBorrowServlet">流通管理</a>
        <a href="${pageContext.request.contextPath}/ReaderServlet" style="color: gray; pointer-events: none;">用户管理</a>
        <a href="${pageContext.request.contextPath}/weihu/backup0.jsp" style="color: gray; pointer-events: none;">系统维护</a>
        <a href="${pageContext.request.contextPath}/wangye/network.jsp" style="color: gray; pointer-events: none;">网页管理</a>
    </div>
</div>
<div class="container">
    <div class="system-title-box">
        图书馆流通系统界面
    </div>
    <!-- 搜索框 -->
    <div class="search">
        <form action="${pageContext.request.contextPath}/Manage2Servlet" method="get">
            <select name="searchField">
                <option value="bookID">图书编号</option>
                <option value="title">书名</option>
                <option value="author">作者</option>
            </select>
            <input type="text" name="searchValue" placeholder="请输入关键词" />
            <input type="text" name="search" value="" hidden="hidden"/>
            <button type="submit">搜索</button>
        </form>
    </div>
    <div class="content-box">
        <table>
            <thead>
               <tr>
                    <th>序号</th>
                    <th>图书编号</th>
                    <th>书名</th>
                    <th>作者</th>
                    <th>图书类别</th>
               </tr>
            </thead>
            <tbody>
            <%
                int currentPage = request.getAttribute("currentPage")==null?1:(int) request.getAttribute("currentPage");
                int totalPages = request.getAttribute("totalPage")==null?1:(int) request.getAttribute("totalPage");
                List<Liutong> liutongList= (List<Liutong>) request.getAttribute("liutongList");
                int count = 1;
                if (liutongList != null) {
                    for (Liutong liutong : liutongList) {
            %>
            <tr>
                <td><%= count++ %></td>
                <td><%= liutong.getBookID() %></td>
                <td><%= liutong.getTitle() %></td>
                <td><%= liutong.getAuthor() %></td>
                <td><%= liutong.getDocumentType() %></td>
            </tr>
            <%
                    }
                }
            %>
            </tbody>
        </table>
        <div class="pagination">
            <button onclick="location.href='${pageContext.request.contextPath}/Manage2Servlet?currentPage=<%= currentPage - 1 %>'" <%= currentPage <= 1 ? "disabled" : "" %>>&laquo; 上一页</button>
            <span>第 <%= currentPage %> / <%= totalPages %> 页，每页显示 16 条</span>
            <button onclick="location.href='${pageContext.request.contextPath}/Manage2Servlet?currentPage=<%= currentPage + 1 %>'" <%= currentPage >= totalPages ? "disabled" : "" %>>下一页 &raquo;</button>
            <span style="margin-left:10px;">
                跳转到第
                <input type="number" id="gotoPage" min="1" max="<%= totalPages %>" style="width:50px;" value="<%= currentPage %>">
                页
                <button onclick="gotoPageFunc()">跳转</button>
            </span>
        </div>
        <script>
            function gotoPageFunc() {
                var page = document.getElementById('gotoPage').value;
                var total = Number('<%= totalPages %>');
                if(page < 1) page = 1;
                if(page > total) page = total;
                location.href = '${pageContext.request.contextPath}/Manage2Servlet?currentPage=' + page;
            }
        </script>
    </div>
</div>
</body>
</html>