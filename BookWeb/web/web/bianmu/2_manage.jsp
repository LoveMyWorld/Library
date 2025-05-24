<%@ page import="Entity.Cataloglist" %>
<%@ page import="java.util.List" %>
<%@ page import="static Servlet.Catalog.YanshouServlet.PAGE_SIZE" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>小赫编目系统</title>
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
    </style>
</head>
<body>
<div class="sidebar">
    <div>
        <h3>小赫</h3>
        <a  onclick="location.href='${pageContext.request.contextPath}/CatalogMServlet'">编目管理</a>
        <a  onclick="location.href='${pageContext.request.contextPath}/YanshouServlet'">验收清单</a>
        <a  onclick="location.href='${pageContext.request.contextPath}/DamageServlet'">报损</a>
        <a href="http://localhost:8080/web_Web_exploded/wangye/manageweb1.jsp">返回</a>
    </div>

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
                <%--                <button>--%>
                <%--                    <img src="../image/add-icon.png" alt="添加">--%>
                <%--                    <div class="tooltip">添加</div>--%>
                <%--                </button>--%>
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
                <button id="daochuButton">
                    <img src="${pageContext.request.contextPath}/image/chu.png" alt="导出">
                    <div class="tooltip">导出</div>
                </button>
            </div>
            <div class="search">
                <form action="${pageContext.request.contextPath}/CatalogMServlet" method="get">
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
                <th style="width: 50px;">序号</th>
                <th>书名</th>
                <th>ISBN</th>
                <th>作者</th>
                <th>出版社</th>
                <th style="width: 30px;">操作</th>

            </tr>
            </thead>
            <tbody>
            <%
                int currentPage = request.getAttribute("currentPage")==null?1:(int) request.getAttribute("currentPage");
                int totalPages = request.getAttribute("totalPage")==null?1:(int) request.getAttribute("totalPage");
                List<Cataloglist> cataloglist= (List<Cataloglist>) request.getAttribute("Cataloglist");
                int count = 1; // 初始化计数器
                if (cataloglist != null) { // 判断数据是否为空
                    for (Cataloglist catalog : cataloglist) {
            %>
            <tr >
                <td><%= count++ %></td>
                <td><%= catalog.getTitle() %></td>
                <td><%= catalog.getISBN() %></td>
                <td><%= catalog.getAuthor() %></td>
                <td><%= catalog.getPublisher() %></td>
                <td>
                    <div class="tools">
                        <button id="editButton">
                            <img src="${pageContext.request.contextPath}/image/edit-icon.png" alt="编辑">
                            <div class="tooltip">编辑</div>
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
            <!-- 上一页 -->
            <button onclick="location.href='${pageContext.request.contextPath}/CatalogMServlet?currentPage=<%= currentPage - 1 %>'">&laquo; 上一页</button>
            <!-- 当前页信息 -->
            <span>第 <%= currentPage %> / <%= totalPages %> 页，每页显示 <%=PAGE_SIZE %> 条</span>
            <!-- 下一页 -->
            <button onclick="location.href='${pageContext.request.contextPath}/CatalogMServlet?currentPage=<%= currentPage + 1 %>'">下一页 &raquo;</button>
        </div>
    </div>
</div>

<div id="myModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            书籍编目
            <span class="close" id="closeModal">&times;</span>
        </div>
        <form id="bookForm" action="" method="get">
            <table class="modal-table">
                <tr>
                    <th>图书编号</th>
                    <td><input type="text" id="bookID" name="bookID" readonly ></td>
                    <th>书名</th>
                    <td><input type="text" id="title" name="title" readonly ></td>
                </tr>
                <tr>
                    <th>作者</th>
                    <td><input type="text" id="author" name="author" readonly ></td>
                    <th>出版日期</th>
                    <td><input type="text" id="publicationDate" name="publicationDate" readonly ></td>
                </tr>
                <tr>
                     <th>版次</th>
                    <td><input type="text" id="edition" name="edition" readonly ></td>
                    <th>文献类型</th>
                    <td><input type="text" id="documentType" name="documentType" readonly ></td>
<%--                    <th>币种编号</th>--%>
<%--                    <td><input type="text" id="currencyCode"></td>--%>
                </tr>
                 <tr>
                     <th>册数</th>
                     <td><input type="text" id="bookNum" name="bookNum" readonly ></td>
                     <th>图书分类号</th>
                     <td><select id="categoryName" name="categoryName">
                        <option value="A 马克思主义、列宁主义、毛泽东思想、邓小平理论">A 马克思主义、列宁主义、毛泽东思想、邓小平理论</option>
                        <option value="A1 马克思、恩格斯著作">&nbsp;&nbsp;&nbsp;&nbsp;A1 马克思、恩格斯著作</option>
                        <option value="A11 选集、文集">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A11 选集、文集</option>
                        <option value="A12 单行著作">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A12 单行著作</option>
                         <option value="A13 书信集、日记、函电、谈话">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A13 书信集、日记、函电、谈话</option>
                         <option value="A14 诗词">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A14 诗词</option>
                         <option value="A15 手迹">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A15 手迹</option>
                         <option value="A16 专题汇编">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A16 专题汇编</option>
                         <option value="A18 语录">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A18 语录</option>
                         <option value="A2 列宁著作">&nbsp;&nbsp;&nbsp;&nbsp;A2 列宁著作</option>
                         <option value="A3 斯大林著作">&nbsp;&nbsp;&nbsp;&nbsp;A3 斯大林著作</option>
                         <option value="A4 毛泽东著作">&nbsp;&nbsp;&nbsp;&nbsp;A4 毛泽东著作</option>

                         <option value="A5 马克思、恩格斯、列宁、斯大林、毛泽东、邓小平著作汇编">&nbsp;&nbsp;&nbsp;&nbsp;A5 马克思、恩格斯、列宁、斯大林、毛泽东、邓小平著作汇编</option>
                         <option value="A6 邓小平著作">&nbsp;&nbsp;&nbsp;&nbsp;A6 邓小平著作</option>
                         <option value="A7 马克思、恩格斯、列宁、斯大林、毛泽东、邓小平生平和传记">&nbsp;&nbsp;&nbsp;&nbsp;A7 马克思、恩格斯、列宁、斯大林、毛泽东、邓小平生平和传记</option>
                         <option value="A8 马克思主义、列宁主义、毛泽东思想、邓小平理论的学习和研究">&nbsp;&nbsp;&nbsp;&nbsp;A8 马克思主义、列宁主义、毛泽东思想、邓小平理论的学习和研究</option>
                         <option value="C 社会科学总论">C 社会科学总论</option>
                         <option value="C0 社会科学理论与方法论">&nbsp;&nbsp;&nbsp;&nbsp;C0 社会科学理论与方法论</option>
                         <option value="C1 社会科学现状及发展">&nbsp;&nbsp;&nbsp;&nbsp;C1 社会科学现状及发展</option>
                         <option value="C2 社会科学机构、团体、会议">&nbsp;&nbsp;&nbsp;&nbsp;C2 社会科学机构、团体、会议</option>
                         <option value="C3 社会科学研究方法">&nbsp;&nbsp;&nbsp;&nbsp;C3 社会科学研究方法</option>
                         <option value="C4 社会科学教育与普及">&nbsp;&nbsp;&nbsp;&nbsp;C4 社会科学教育与普及</option>
                         <option value="C5 社会科学丛书、文集、连续性出版物">&nbsp;&nbsp;&nbsp;&nbsp;C5 社会科学丛书、文集、连续性出版物</option>
                         <option value="C6 社会科学参考工具书">&nbsp;&nbsp;&nbsp;&nbsp;C6 社会科学参考工具书</option>
                         <option value="C7 社会科学文献检索工具书">&nbsp;&nbsp;&nbsp;&nbsp;C7 社会科学文献检索工具书</option>
                         <option value="C8 统计学">&nbsp;&nbsp;&nbsp;&nbsp;C8 统计学</option>
                         <option value="C91 社会学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C91 社会学</option>
                         <option value="C92 人口学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C92 人口学</option>
                         <option value="C93 管理学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C93 管理学</option>
                         <option value="C94 系统科学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C94 系统科学</option>
                         <option value="C95 民族学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C95 民族学</option>
                         <option value="C96 人才学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C96 人才学</option>
                         <option value="C97 劳动科学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C97 劳动科学</option>
                         <option value="D 政治、法律">D 政治、法律</option>
                         <option value="D0 政治理论">&nbsp;&nbsp;&nbsp;&nbsp;D0 政治理论</option>
                         <option value="D1 国际共产主义运动">&nbsp;&nbsp;&nbsp;&nbsp;D1 国际共产主义运动</option>
                         <option value="D2 中国共产党">&nbsp;&nbsp;&nbsp;&nbsp;D2 中国共产党</option>
                         <option value="D3 各国共产党">&nbsp;&nbsp;&nbsp;&nbsp;D3 各国共产党</option>
                         <option value="D4 工人、农民、青年、妇女运动与组织">&nbsp;&nbsp;&nbsp;&nbsp;D4 工人、农民、青年、妇女运动与组织</option>
                         <option value="D5 世界政治">&nbsp;&nbsp;&nbsp;&nbsp;D5 世界政治</option>
                         <option value="D6 中国政治">&nbsp;&nbsp;&nbsp;&nbsp;D6 中国政治</option>
                         <option value="D7 各国政治">&nbsp;&nbsp;&nbsp;&nbsp;D7 各国政治</option>
                         <option value="D8 外交、国际关系">&nbsp;&nbsp;&nbsp;&nbsp;D8 外交、国际关系</option>
                         <option value="D9 法律">&nbsp;&nbsp;&nbsp;&nbsp;D9 法律</option>
                         <option value="D90 法的理论（法学）">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D90 法的理论（法学）</option>
                         <option value="D91 法学各部门">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D91 法学各部门</option>
                         <option value="D92 中国法律">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D92 中国法律</option>
                         <option value="D93 各国法律">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D93 各国法律</option>
                         <option value="D99 国际法">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D99 国际法</option>
                         <option value="E 军事">E 军事</option>
                         <option value="E0 军事理论">&nbsp;&nbsp;&nbsp;&nbsp;E0 军事理论</option>
                         <option value="E1 世界军事">&nbsp;&nbsp;&nbsp;&nbsp;E1 世界军事</option>
                         <option value="E2 中国军事">&nbsp;&nbsp;&nbsp;&nbsp;E2 中国军事</option>
                         <option value="E3 各国军事">&nbsp;&nbsp;&nbsp;&nbsp;E3 各国军事</option>
                         <option value="E8 战略学、战役学、战术学">&nbsp;&nbsp;&nbsp;&nbsp;E8 战略学、战役学、战术学</option>
                         <option value="E9 军事技术">&nbsp;&nbsp;&nbsp;&nbsp;E9 军事技术</option>
                         <option value="E99 军事地形学、军事地理学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;E99 军事地形学、军事地理学</option>
                         <option value="F 经济"> F 经济</option>
                         <option value="F0 经济学">&nbsp;&nbsp;&nbsp;&nbsp;F0 经济学</option>
                         <option value="F00 马克思主义政治经济学（总论）">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F00 马克思主义政治经济学（总论）</option>
                         <option value="F01 经济学基本问题">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F01 经济学基本问题</option>
                         <option value="F02 前资本主义社会生产方式">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F02 前资本主义社会生产方式</option>
                         <option value="F03 资本主义社会生产方式">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F03 资本主义社会生产方式</option>
                         <option value="F04 社会主义社会生产方式">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F04 社会主义社会生产方式</option>
                         <option value="F05 共产主义社会生产方式">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F05 共产主义社会生产方式</option>
                         <option value="F06 经济学分支科学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F06 经济学分支科学</option>
                         <option value="F08 各科经济学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F08 各科经济学</option>
                         <option value="F09 经济思想史">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F09 经济思想史</option>
                         <option value="F1 世界各国经济概况、经济史、经济地理">&nbsp;&nbsp;&nbsp;&nbsp;F1 世界各国经济概况、经济史、经济地理</option>
                         <option value="F11 世界经济、国际经济关系">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F11 世界经济、国际经济关系</option>
                         <option value="F12 中国经济">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F12 中国经济</option>
                         <option value="F13 各国经济">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F13 各国经济</option>
                         <option value="F2 经济计划与管理">&nbsp;&nbsp;&nbsp;&nbsp;F2 经济计划与管理</option>
                         <option value="F20 国民经济管理">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F20 国民经济管理</option>
                         <option value="F21 经济计划">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F21 经济计划</option>
                         <option value="F22 经济计算、经济数学方法">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F22 经济计算、经济数学方法</option>
                         <option value="F23 会计">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F23 会计</option>
<%--                         <option value="F239 审计">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F239 审计</option>--%>
                         <option value="F24 劳动经济">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F24 劳动经济</option>
                         <option value="F25 物质经济">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F25 物质经济</option>
                         <option value="F27 企业经济">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F27 企业经济</option>
                         <option value="F28 基本建设经济">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F28 基本建设经济</option>
                         <option value="F29 城市与市政经济">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F29 城市与市政经济</option>
                         <option value="F3 农业经济">&nbsp;&nbsp;&nbsp;&nbsp;F3 农业经济</option>
                         <option value="F4 工业经济">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F4 工业经济</option>
                         <option value="F49 信息产业经济（总论）">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F49 信息产业经济（总论）</option>
                         <option value="F5 交通运输经济">&nbsp;&nbsp;&nbsp;&nbsp;F5 交通运输经济</option>
                         <option value="F59 旅游经济">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F59 旅游经济</option>
                         <option value="F6 邮电经济">&nbsp;&nbsp;&nbsp;&nbsp;F6 邮电经济</option>
                         <option value="F7 贸易经济">&nbsp;&nbsp;&nbsp;&nbsp;F7 贸易经济</option>
                         <option value="F71 国内贸易经济">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F71 国内贸易经济</option>
                         <option value="F72 中国国内贸易经济">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F72 中国国内贸易经济</option>
                         <option value="F73 世界各国国内贸易经济">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F73 世界各国国内贸易经济</option>
                         <option value="F74 世界贸易">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F74 世界贸易</option>
                         <option value="F75 各国对外贸易">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F75 各国对外贸易</option>
                         <option value="F76 商品学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F76 商品学</option>
                         <option value="F8 财政、金融">&nbsp;&nbsp;&nbsp;&nbsp;F8 财政、金融</option>
                         <option value="F81 财政、国家财政">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F81 财政、国家财政</option>
                         <option value="F82 货币">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F82 货币</option>
                         <option value="F83 金融、银行">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F83 金融、银行</option>
                         <option value="F84 保险">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F84 保险</option>
                         <option value="G 文化、科学、教育、体育">G 文化、科学、教育、体育</option>
                         <option value="G0 文化理论">&nbsp;&nbsp;&nbsp;&nbsp;G0 文化理论</option>
                         <option value="G1 世界各国文化与文化事业">&nbsp;&nbsp;&nbsp;&nbsp;G1 世界各国文化与文化事业</option>
                         <option value="G2 信息与知识传播">&nbsp;&nbsp;&nbsp;&nbsp;G2 信息与知识传播</option>
                         <option value="G3 科学、科学研究">&nbsp;&nbsp;&nbsp;&nbsp;G3 科学、科学研究</option>
                         <option value="G4 教育">&nbsp;&nbsp;&nbsp;&nbsp;;G4 教育</option>
<%--                         <option value="G64 高等教育">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;G64 高等教育</option>--%>
                         <option value="G8 体育">&nbsp;&nbsp;&nbsp;&nbsp;G8 体育</option>
                         <option value="H 语言、文字">H 语言、文字</option>
                         <option value="H0 语言学">&nbsp;&nbsp;&nbsp;&nbsp;H0 语言学</option>
                         <option value="H1 汉语">&nbsp;&nbsp;&nbsp;&nbsp;H1 汉语</option>
                         <option value="H11 语音">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H11 语音</option>
                         <option value="H12 文字学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H12 文字学</option>
                         <option value="H13 语义、词汇、词义（训诂学）">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H13 语义、词汇、词义（训诂学）</option>
                         <option value="H14 语法">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H14 语法</option>
<%--                         <option value="H15 写作、修辞">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H15 写作、修辞</option>--%>
<%--                         <option value="H159 翻译">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H159 翻译</option>--%>
<%--                         <option value="H16 字书、字典、词典">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H16 字书、字典、词典</option>--%>
<%--                         <option value="H17 方言">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H17 方言</option>--%>
<%--                         <option value="H19 汉语教学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H19 汉语教学</option>--%>
<%--                         <option value="H2 中国少数民族语言">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H2 中国少数民族语言</option>--%>
<%--                         <option value="H3 常用外国语">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H3 常用外国语</option>--%>
<%--                         <option value="H31 英语">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H31 英语</option>--%>
<%--                         <option value="H32 法语">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H32 法语</option>--%>
<%--                         <option value="H3 德语">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H3 德语</option>--%>
<%--                         <option value="H34 西班牙语">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H34 西班牙语</option>--%>
<%--                         <option value="H35 俄语">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H35 俄语</option>--%>
<%--                         <option value="H36 日语">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H36 日语</option>--%>
<%--                         <option value="H37 阿拉伯语">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H37 阿拉伯语</option>--%>
                         <option value="I 艺术">I 艺术</option>
                         <option value="I1 艺术理论">&nbsp;&nbsp;&nbsp;&nbsp;I1 艺术理论</option>
                         <option value="I2 音乐">&nbsp;&nbsp;&nbsp;&nbsp;I2 音乐</option>
                         <option value="I21 声乐">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I21 声乐</option>
                         <option value="I22 器乐">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I22 器乐</option>
                         <option value="I23 作曲与音乐创作">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I23 作曲与音乐创作</option>
                         <option value="I24 音乐教育">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I24 音乐教育</option>
                         <option value="I3 戏剧、影视、表演艺术">&nbsp;&nbsp;&nbsp;&nbsp;I3 戏剧、影视、表演艺术</option>
                         <option value="I31 戏剧、话剧">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I31 戏剧、话剧</option>
                         <option value="I32 电影">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I32 电影</option>
                         <option value="I33 电视艺术">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I33 电视艺术</option>
                         <option value="I34 表演艺术">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I34 表演艺术</option>
                         <option value="I35 戏曲">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I35 戏曲</option>
                         <option value="I4 美术">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I4 美术</option>
<%--                         <option value="I41 绘画">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I41 绘画</option>--%>
<%--                         <option value="I42 雕塑">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I42 雕塑</option>--%>
<%--                         <option value="I43 书法">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I43 书法</option>--%>
<%--                         <option value="I44 工艺美术">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I44 工艺美术</option>--%>
<%--                         <option value="I45 设计艺术">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I45 设计艺术</option>--%>
                         <option value="I5 舞蹈">&nbsp;&nbsp;&nbsp;&nbsp;I5 舞蹈</option>
                         <option value="I6 电影与电视">&nbsp;&nbsp;&nbsp;&nbsp;I6 电影与电视</option>
                         <option value="I7 摄影">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I7 摄影</option>
                         <option value="I8 其他艺术形式">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I8 其他艺术形式</option>
                         <option value="J 旅游、地理">J 旅游、地理</option>
                         <option value="J0 旅游理论与规划">&nbsp;&nbsp;&nbsp;&nbsp;J0 旅游理论与规划</option>
                         <option value="J1 旅游经济">&nbsp;&nbsp;&nbsp;&nbsp;J1 旅游经济</option>
<%--                         <option value="J2 旅游资源与景区管理">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;J2 旅游资源与景区管理</option>--%>
<%--                         <option value="J3 旅游服务与管理">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;J3 旅游服务与管理</option>--%>
<%--                         <option value="J4 旅游营销与推广">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;J4 旅游营销与推广</option>--%>
<%--                         <option value="J5 旅游文化与遗产">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;J5 旅游文化与遗产</option>--%>
<%--                         <option value="J6 旅游心理与消费者行为">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;J6 旅游心理与消费者行为</option>--%>
<%--                         <option value="J7 旅游教育与培训">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;J7 旅游教育与培训</option>--%>
<%--                         <option value="J8 旅游科技">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;J8 旅游科技</option>--%>
<%--                         <option value="J9 旅游管理与组织">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;J9 旅游管理与组织</option>--%>
                         <option value="K 历史、考古">K 历史、考古</option>
<%--                         <option value="K0 历史学理论与方法">&nbsp;&nbsp;&nbsp;&nbsp;K0 历史学理论与方法</option>--%>
                         <option value="K1 中国历史">&nbsp;&nbsp;&nbsp;&nbsp;K1 中国历史</option>
<%--                         <option value="K11 古代史">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K11 古代史</option>--%>
<%--                         <option value="K12 近现代史">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K12 近现代史</option>--%>
<%--                         <option value="K13 当代史">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K13 当代史</option>--%>
                         <option value="K2 世界历史">&nbsp;&nbsp;&nbsp;&nbsp;K2 世界历史</option>
                         <option value="K21 古代史">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K21 古代史</option>
                         <option value="K22 近现代史">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K22 近现代史</option>
                         <option value="K23 当代史">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K23 当代史</option>
                         <option value="K3 考古学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K3 考古学</option>
                         <option value="K4 历史文献与史学研究">&nbsp;&nbsp;&nbsp;&nbsp;K4 历史文献与史学研究</option>
                         <option value="K5 地理历史">&nbsp;&nbsp;&nbsp;&nbsp;K5 地理历史</option>
<%--                         <option value="K6 文化历史">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K6 文化历史</option>--%>
<%--                         <option value="K7 历史人物与事件">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K7 历史人物与事件</option>--%>
<%--                         <option value="K8 非物质文化遗产">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K8 非物质文化遗产</option>--%>
<%--                         <option value="K9 博物馆学与遗产保护">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K9 博物馆学与遗产保护</option>--%>
                         <option value="J 旅游、地理">J 旅游、地理</option>
                         <option value="J0 旅游理论与规划">&nbsp;&nbsp;&nbsp;&nbsp;J0 旅游理论与规划</option>
                         <option value="J1 旅游经济">&nbsp;&nbsp;&nbsp;&nbsp;J1 旅游经济</option>
                         <option value="J2 旅游资源与景区管理">&nbsp;&nbsp;&nbsp;&nbsp;J2 旅游资源与景区管理</option>
<%--                         <option value="J3 旅游服务与管理">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;J3 旅游服务与管理</option>--%>
<%--                         <option value="J4 旅游营销与推广">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;J4 旅游营销与推广</option>--%>
<%--                         <option value="J5 旅游文化与遗产">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;J5 旅游文化与遗产</option>--%>
<%--                         <option value="J6 旅游心理与消费者行为">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;J6 旅游心理与消费者行为</option>--%>
<%--                         <option value="J7 旅游教育与培训">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;J7 旅游教育与培训</option>--%>
<%--                         <option value="J8 旅游科技">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;J8 旅游科技</option>--%>
<%--                         <option value="J9 旅游管理与组织">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;J9 旅游管理与组织</option>--%>
                         <option value="K 历史、考古">K 历史、考古</option>
                         <option value="K0 历史学理论与方法">&nbsp;&nbsp;&nbsp;&nbsp;;K0 历史学理论与方法</option>
                         <option value="K1 中国历史">&nbsp;&nbsp;&nbsp;&nbsp;K1 中国历史</option>
                         <option value="K11 古代史">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K11 古代史</option>
<%--                         <option value="K12 近现代史">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K12 近现代史</option>--%>
<%--                         <option value="K13 当代史">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K13 当代史</option>--%>
<%--                         <option value="K2 世界历史">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K2 世界历史</option>--%>
<%--                         <option value="K21 古代史">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K21 古代史</option>--%>
<%--                         <option value="K22 近现代史">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K22 近现代史</option>--%>
<%--                         <option value="K23 当代史">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K23 当代史</option>--%>
<%--                         <option value="K3 考古学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K3 考古学</option>--%>
<%--                         <option value="K4 历史文献与史学研究">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K4 历史文献与史学研究</option>--%>
<%--                         <option value="K5 地理历史">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K5 地理历史</option>--%>
<%--                         <option value="K6 文化历史">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K6 文化历史</option>--%>
<%--                         <option value="K7 历史人物与事件">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K7 历史人物与事件</option>--%>
<%--                         <option value="K8 非物质文化遗产">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K8 非物质文化遗产</option>--%>
<%--                         <option value="K9 博物馆学与遗产保护">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K9 博物馆学与遗产保护</option>--%>
                         <option value="L 伦理学、宗教">L 伦理学、宗教</option>
                         <option value="L0 伦理学">&nbsp;&nbsp;&nbsp;&nbsp;L0 伦理学</option>
                         <option value="L1 德性伦理学">&nbsp;&nbsp;&nbsp;&nbsp;L1 德性伦理学</option>
                         <option value="L2 义务论伦理学">&nbsp;&nbsp;&nbsp;&nbsp;L2 义务论伦理学</option>
<%--                         <option value="L3 后果伦理学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;L3 后果伦理学</option>--%>
<%--                         <option value="L4 文化伦理学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;L4 文化伦理学</option>--%>
<%--                         <option value="L5 环境伦理学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;L5 环境伦理学</option>--%>
<%--                         <option value="L6 应用伦理学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;L6 应用伦理学</option>--%>
<%--                         <option value="L7 宗教与道德">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;L7 宗教与道德</option>--%>
<%--                         <option value="L8 宗教哲学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;L8 宗教哲学</option>--%>
<%--                         <option value="L9 宗教信仰与文化">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;L9 宗教信仰与文化</option>--%>
                         <option value="M 社会学">M 社会学</option>
                         <option value="M0 社会学理论">&nbsp;&nbsp;&nbsp;&nbsp;M0 社会学理论</option>
                         <option value="M1 社会结构与社会问题">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;M1 社会结构与社会问题</option>
                         <option value="M2 社会发展与社会变革">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;M2 社会发展与社会变革</option>
<%--                         <option value="M3 城市与社区">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;M3 城市与社区</option>--%>
<%--                         <option value="M4 教育与社会">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;M4 教育与社会</option>--%>
<%--                         <option value="M5 家庭与社会">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;M5 家庭与社会</option>--%>
<%--                         <option value="M6 劳动与就业">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;M6 劳动与就业</option>--%>
<%--                         <option value="M7 社会保障与福利">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;M7 社会保障与福利</option>--%>
<%--                         <option value="M8 公共服务与治理">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;M8 公共服务与治理</option>--%>
<%--                         <option value="M9 社会管理与社会工作">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;M9 社会管理与社会工作</option>--%>
                         <option value="N 法学">N 法学</option>
                         <option value="N0 法律理论">&nbsp;&nbsp;&nbsp;&nbsp;N0 法律理论</option>
                         <option value="N1 宪法学">&nbsp;&nbsp;&nbsp;&nbsp;N1 宪法学</option>
                         <option value="N2 民法学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;N2 民法学</option>
<%--                         <option value="N3 刑法学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;N3 刑法学</option>--%>
<%--                         <option value="N4 商法学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;N4 商法学</option>--%>
<%--                         <option value="N5 行政法学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;N5 行政法学</option>--%>
<%--                         <option value="N6 经济法学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;N6 经济法学</option>--%>
<%--                         <option value="N7 国际法学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;N7 国际法学</option>--%>
<%--                         <option value="N8 环境法学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;N8 环境法学</option>--%>
<%--                         <option value="N9 知识产权法">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;N9 知识产权法</option>--%>
                         <option value="O 政治学">O 政治学</option>
                         <option value="O0 政治理论">&nbsp;&nbsp;&nbsp;&nbsp;O0 政治理论</option>
                         <option value="O1 中外政治思想史">&nbsp;&nbsp;&nbsp;&nbsp;O1 中外政治思想史</option>
<%--                         <option value="O2 比较政治学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;O2 比较政治学</option>--%>
<%--                         <option value="O3 国际关系学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;O3 国际关系学</option>--%>
<%--                         <option value="O4 政策研究与分析">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;O4 政策研究与分析</option>--%>
<%--                         <option value="O5 公共行政学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;O5 公共行政学</option>--%>
<%--                         <option value="O6 行政管理与公共服务">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;O6 行政管理与公共服务</option>--%>
<%--                         <option value="O7 政治与经济学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;O7 政治与经济学</option>--%>
<%--                         <option value="O8 社会运动与政治变革">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;O8 社会运动与政治变革</option>--%>
                         <option value="P 经济学">P 经济学</option>
                         <option value="P0 经济学理论">&nbsp;&nbsp;&nbsp;&nbsp;P0 经济学理论</option>
                         <option value="P1 微观经济学">&nbsp;&nbsp;&nbsp;&nbsp;P1 微观经济学</option>
<%--                         <option value="P2 宏观经济学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;P2 宏观经济学</option>--%>
<%--                         <option value="P3 国际经济学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;P3 国际经济学</option>--%>
<%--                         <option value="P4 计量经济学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;P4 计量经济学</option>--%>
<%--                         <option value="P5 行为经济学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;P5 行为经济学</option>--%>
<%--                         <option value="P6 发展经济学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;P6 发展经济学</option>--%>
<%--                         <option value="P7 公共经济学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;P7 公共经济学</option>--%>
<%--                         <option value="P8 劳动经济学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;P8 劳动经济学</option>--%>
<%--                         <option value="P9 财政学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;P9 财政学</option>--%>
                         <option value="Q 金融学">Q 金融学</option>
                         <option value="Q0 金融理论">&nbsp;&nbsp;&nbsp;&nbsp;Q0 金融理论</option>
                         <option value="Q1 金融市场">&nbsp;&nbsp;&nbsp;&nbsp;Q1 金融市场</option>
<%--                         <option value="Q2 金融机构">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Q2 金融机构</option>--%>
<%--                         <option value="Q3 银行学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Q3 银行学</option>--%>
<%--                         <option value="Q4 保险学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Q4 保险学</option>--%>
<%--                         <option value="Q5 投资学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Q5 投资学</option>--%>
<%--                         <option value="Q6 资本市场">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Q6 资本市场</option>--%>
<%--                         <option value="Q7 货币与银行学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Q7 货币与银行学</option>--%>
<%--                         <option value="Q8 公司金融">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Q8 公司金融</option>--%>
<%--                         <option value="Q9 金融工程">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Q9 金融工程</option>--%>
                         <option value="R 会计学">R 会计学</option>
                         <option value="R0 会计理论">&nbsp;&nbsp;&nbsp;&nbsp;R0 会计理论</option>
                         <option value="R1 财务会计">&nbsp;&nbsp;&nbsp;&nbsp;R1 财务会计</option>
<%--                         <option value="R2 成本会计">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;R2 成本会计</option>--%>
<%--                         <option value="R3 管理会计">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;R3 管理会计</option>--%>
<%--                         <option value="R4 审计学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;R4 审计学</option>--%>
<%--                         <option value="R5 税务会计">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;R5 税务会计</option>--%>
<%--                         <option value="R6 会计信息化">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;R6 会计信息化</option>--%>
<%--                         <option value="R7 会计政策与管理">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;R7 会计政策与管理</option>--%>
<%--                         <option value="R8 国际会计">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;R8 国际会计</option>--%>
<%--                         <option value="R9 会计研究方法">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;R9 会计研究方法</option>--%>
                         <option value="S 商务与管理学">S 商务与管理学</option>
                         <option value="S0 管理理论与方法">&nbsp;&nbsp;&nbsp;&nbsp;S0 管理理论与方法</option>
                         <option value="S1 人力资源管理">&nbsp;&nbsp;&nbsp;&nbsp;S1 人力资源管理</option>
                         <option value="S2 市场营销">&nbsp;&nbsp;&nbsp;&nbsp;S2 市场营销</option>
<%--                         <option value="S3 企业管理">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;S3 企业管理</option>--%>
<%--                         <option value="S4 创业与创新管理">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;S4 创业与创新管理</option>--%>
<%--                         <option value="S5 战略管理">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;S5 战略管理</option>--%>
<%--                         <option value="S6 项目管理">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;S6 项目管理</option>--%>
<%--                         <option value="S7 供应链与物流管理">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;S7 供应链与物流管理</option>--%>
<%--                         <option value="S8 财务管理">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;S8 财务管理</option>--%>
<%--                         <option value="S9 商业分析与决策支持">&nbsp;&nbsp;&nbsp;--%>
                         <option value="T 工业技术">T 工业技术</option>
                         <option value="T0 工业基础理论">&nbsp;&nbsp;&nbsp;&nbsp;T0 工业基础理论</option>
                         <option value="T1 机械工程">&nbsp;&nbsp;&nbsp;&nbsp;T1 机械工程</option>
<%--                         <option value="T2">&nbsp;&nbsp;&nbsp;&nbsp;T2 电气工程</option>--%>
<%--                         <option value="T3">&nbsp;&nbsp;&nbsp;&nbsp;T3 自动化与控制工程</option>--%>
<%--                         <option value="T4">&nbsp;&nbsp;&nbsp;&nbsp;T4 土木工程</option>--%>
<%--                         <option value="T5">&nbsp;&nbsp;&nbsp;&nbsp;T5 建筑工程</option>--%>
<%--                         <option value="T6">&nbsp;&nbsp;&nbsp;&nbsp;T6 化学工程与技术</option>--%>
<%--                         <option value="T7">&nbsp;&nbsp;&nbsp;&nbsp;T7 计算机科学与技术</option>--%>
<%--                         <option value="T8">&nbsp;&nbsp;&nbsp;&nbsp;T8 环境工程</option>--%>
<%--                         <option value="T9">&nbsp;&nbsp;&nbsp;&nbsp;T9 物流与运输工程</option>--%>
                         <option value="U 农业技术">U 农业技术</option>
                         <option value="U0 农业基础科学">&nbsp;&nbsp;&nbsp;&nbsp;U0 农业基础科学</option>
                         <option value="U1 农学">&nbsp;&nbsp;&nbsp;&nbsp;U1 农学</option>
<%--                         <option value="U2">&nbsp;&nbsp;&nbsp;&nbsp;U2 林学</option>--%>
<%--                         <option value="U3">&nbsp;&nbsp;&nbsp;&nbsp;U3 动物科学</option>--%>
<%--                         <option value="U4">&nbsp;&nbsp;&nbsp;&nbsp;U4 水产养殖学</option>--%>
<%--                         <option value="U5">&nbsp;&nbsp;&nbsp;&nbsp;U5 生态学</option>--%>
<%--                         <option value="U6">&nbsp;&nbsp;&nbsp;&nbsp;U6 农业工程</option>--%>
<%--                         <option value="U7">&nbsp;&nbsp;&nbsp;&nbsp;U7 农村发展与管理</option>--%>
<%--                         <option value="U8">&nbsp;&nbsp;&nbsp;&nbsp;U8 农业资源与环境</option>--%>
<%--                         <option value="U9">&nbsp;&nbsp;&nbsp;&nbsp;U9 食品科学与工程</option>--%>
                         <option value="V 医学">V 医学</option>
                         <option value="V0 基础医学">&nbsp;&nbsp;&nbsp;&nbsp;V0 基础医学</option>
                         <option value="V1 临床医学">&nbsp;&nbsp;&nbsp;&nbsp;V1 临床医学</option>
<%--                         <option value="V2">&nbsp;&nbsp;&nbsp;&nbsp;V2 口腔医学</option>--%>
<%--                         <option value="V3">&nbsp;&nbsp;&nbsp;&nbsp;V3 公共卫生与预防医学</option>--%>
<%--                         <option value="V4">&nbsp;&nbsp;&nbsp;&nbsp;V4 中医学</option>--%>
<%--                         <option value="V5">&nbsp;&nbsp;&nbsp;&nbsp;V5 药学</option>--%>
<%--                         <option value="V6">&nbsp;&nbsp;&nbsp;&nbsp;V6 护理学</option>--%>
<%--                         <option value="V7">&nbsp;&nbsp;&nbsp;&nbsp;V7 医学技术</option>--%>
<%--                         <option value="V8">&nbsp;&nbsp;&nbsp;&nbsp;V8 医学影像学</option>--%>
<%--                         <option value="V9">&nbsp;&nbsp;&nbsp;&nbsp;V9 健康管理</option>--%>
                         <option value="W 工程技术">W 工程技术</option>
                         <option value="W0 工程管理与工程造价">&nbsp;&nbsp;&nbsp;&nbsp;W0 工程管理与工程造价</option>
                         <option value="W1 水利工程">&nbsp;&nbsp;&nbsp;&nbsp;W1 水利工程</option>
<%--                         <option value="W2">&nbsp;&nbsp;&nbsp;&nbsp;W2 矿业工程</option>--%>
<%--                         <option value="W3">&nbsp;&nbsp;&nbsp;&nbsp;W3 航空航天工程</option>--%>
<%--                         <option value="W4">&nbsp;&nbsp;&nbsp;&nbsp;W4 核工程</option>--%>
<%--                         <option value="W5">&nbsp;&nbsp;&nbsp;&nbsp;W5 农业工程技术</option>--%>
<%--                         <option value="W6">&nbsp;&nbsp;&nbsp;&nbsp;W6 土木工程管理</option>--%>
<%--                         <option value="W7">&nbsp;&nbsp;&nbsp;&nbsp;W7 环境工程技术</option>--%>
<%--                         <option value="W8">&nbsp;&nbsp;&nbsp;&nbsp;W8 化学工程与工艺</option>--%>
<%--                         <option value="W9">&nbsp;&nbsp;&nbsp;&nbsp;W9 机电工程技术</option>--%>
                         <option value="X 艺术">X 艺术</option>
                         <option value="X0 艺术学理论">&nbsp;&nbsp;&nbsp;&nbsp;X0 艺术学理论</option>
                         <option value="X1 视觉传达设计">&nbsp;&nbsp;&nbsp;&nbsp;X1 视觉传达设计</option>
                         <option value="X2 产品设计">&nbsp;&nbsp;&nbsp;&nbsp;X2 产品设计</option>
<%--                         <option value="X3">&nbsp;&nbsp;&nbsp;&nbsp;X3 环境设计</option>--%>
<%--                         <option value="X4">&nbsp;&nbsp;&nbsp;&nbsp;X4 服装设计与工程</option>--%>
<%--                         <option value="X5">&nbsp;&nbsp;&nbsp;&nbsp;X5 动画</option>--%>
<%--                         <option value="X6">&nbsp;&nbsp;&nbsp;&nbsp;X6 音乐学</option>--%>
<%--                         <option value="X7">&nbsp;&nbsp;&nbsp;&nbsp;X7 舞蹈学</option>--%>
<%--                         <option value="X8">&nbsp;&nbsp;&nbsp;&nbsp;X8 戏剧与影视学</option>--%>
<%--                         <option value="X9">&nbsp;&nbsp;&nbsp;&nbsp;X9 电影与电视制作</option>--%>
                         <option value="Y 体育">Y 体育</option>
                         <option value="Y0 体育学理论">&nbsp;&nbsp;&nbsp;&nbsp;Y0 体育学理论</option>
                         <option value="Y1 运动训练">&nbsp;&nbsp;&nbsp;&nbsp;Y1 运动训练</option>
<%--                         <option value="Y2">&nbsp;&nbsp;&nbsp;&nbsp;Y2 运动康复</option>--%>
<%--                         <option value="Y3">&nbsp;&nbsp;&nbsp;&nbsp;Y3 体育教育</option>--%>
<%--                         <option value="Y4">&nbsp;&nbsp;&nbsp;&nbsp;Y4 社会体育</option>--%>
<%--                         <option value="Y5">&nbsp;&nbsp;&nbsp;&nbsp;Y5 体育管理</option>--%>
<%--                         <option value="Y6">&nbsp;&nbsp;&nbsp;&nbsp;Y6 体育传媒与文化</option>--%>
<%--                         <option value="Y7">&nbsp;&nbsp;&nbsp;&nbsp;Y7 竞技体育</option>--%>
<%--                         <option value="Y8">&nbsp;&nbsp;&nbsp;&nbsp;Y8 体育设施与建设</option>--%>
<%--                         <option value="Y9">&nbsp;&nbsp;&nbsp;&nbsp;Y9 体育健康与营养</option>--%>
                         <option value="Z 军事学">Z 军事学</option>
                         <option value="Z0 军事学理论">&nbsp;&nbsp;&nbsp;&nbsp;Z0 军事学理论</option>
                         <option value="Z1 战略学">&nbsp;&nbsp;&nbsp;&nbsp;Z1 战略学</option>
<%--                         <option value="Z2">&nbsp;&nbsp;&nbsp;&nbsp;Z2 战术学</option>--%>
<%--                         <option value="Z3">&nbsp;&nbsp;&nbsp;&nbsp;Z3 后勤与装备学</option>--%>
<%--                         <option value="Z4">&nbsp;&nbsp;&nbsp;&nbsp;Z4 军事指挥与领导学</option>--%>
<%--                         <option value="Z5">&nbsp;&nbsp;&nbsp;&nbsp;Z5 国防科技</option>--%>
<%--                         <option value="Z6">&nbsp;&nbsp;&nbsp;&nbsp;Z6 军事心理学</option>--%>
<%--                         <option value="Z7">&nbsp;&nbsp;&nbsp;&nbsp;Z7 军事法学</option>--%>
<%--                         <option value="Z8">&nbsp;&nbsp;&nbsp;&nbsp;Z8 国防安全学</option>--%>
<%--                         <option value="Z9">&nbsp;&nbsp;&nbsp;&nbsp;Z9 军事史</option>--%>

                         <!-- ... 其他选项 ... -->
                         <!-- ... 其他选项 ... -->
                         <!-- ... 其他选项 ... -->
                         <!-- ... 其他选项 ... -->
                         <!-- ... 其他选项 ... -->
                         <!-- ... 其他选项 ... -->
                         <!-- ... 其他选项 ... -->
                         <!-- ... 其他选项 ... -->
                         <!-- ... 其他选项 ... -->

                         <!-- ... 其他选项 ... -->



                     </select></td>
                </tr>
                <tr>
                    <th>ISBN</th>
                    <td><input type="text" id="isbn" name="isbn" readonly ></td>
                    <th>出版社</th>
                    <td><input type="text" id="publisher" name="publisher" readonly ></td>
                </tr>
                <tr>
                    <th>书商</th>
                    <td><input type="text" id="supplier" name="supplier" readonly ></td>
                    <th>定价</th>
                    <td><input type="text" id="price" name="price" readonly ></td>
                </tr>

             </table>
            <button type="button" id="confirmButton" name="confirmButton">确定</button>
        </form>
        <!-- 成功提示框 -->
        <div id="successModal" style="display: none;">
            <div class="modal-content">
                <p>编目成功！</p>
                <button id="closeSuccessModal">关闭</button>
            </div>
        </div>
    </div>
</div>

<%--编辑框--%>
<div id="myModal2" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            书籍编目
            <span class="close" id="closeModal2">&times;</span>
        </div>
        <form id="bookForm_edit2" action="" method="get">
            <table class="modal-table">
                <tr>
                    <th>图书编号</th>
                    <td><input type="text" id="bookID2" name="bookID" readonly ></td>
                    <th>书名</th>
                    <td><input type="text" id="title2" name="title" readonly ></td>
                </tr>
                <tr>
                    <th>作者</th>
                    <td><input type="text" id="author2" name="author" readonly ></td>
                    <th>出版日期</th>
                    <td><input type="text" id="publicationDate2" name="publicationDate" readonly ></td>
                </tr>
                <tr>
                    <th>版次</th>
                    <td><input type="text" id="edition2" name="edition" readonly ></td>
                    <th>文献类型</th>
                    <td><input type="text" id="documentType2" name="documentType" readonly ></td>
                    <%--                    <th>币种编号</th>--%>
                    <%--                    <td><input type="text" id="currencyCode"></td>--%>
                </tr>
                <tr>
                    <th>册数</th>
                    <td><input type="text" id="bookNum2" name="bookNum" readonly ></td>
                    <th>图书分类号</th>
                    <td><select id="categoryName2" name="categoryName">

                        <option value="A 马克思主义、列宁主义、毛泽东思想、邓小平理论">A 马克思主义、列宁主义、毛泽东思想、邓小平理论</option>
                        <option value="A1 马克思、恩格斯著作">&nbsp;&nbsp;&nbsp;&nbsp;A1 马克思、恩格斯著作</option>
                        <option value="A11 选集、文集">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A11 选集、文集</option>
                        <option value="A12 单行著作">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A12 单行著作</option>
                        <option value="A13 书信集、日记、函电、谈话">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A13 书信集、日记、函电、谈话</option>
                        <option value="A14 诗词">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A14 诗词</option>
                        <option value="A15 手迹">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A15 手迹</option>
                        <option value="A16 专题汇编">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A16 专题汇编</option>
                        <option value="A18 语录">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A18 语录</option>
                        <option value="A2 列宁著作">&nbsp;&nbsp;&nbsp;&nbsp;A2 列宁著作</option>
                        <option value="A3 斯大林著作">&nbsp;&nbsp;&nbsp;&nbsp;A3 斯大林著作</option>
                        <option value="A4 毛泽东著作">&nbsp;&nbsp;&nbsp;&nbsp;A4 毛泽东著作</option>

                        <option value="A5 马克思、恩格斯、列宁、斯大林、毛泽东、邓小平著作汇编">&nbsp;&nbsp;&nbsp;&nbsp;A5 马克思、恩格斯、列宁、斯大林、毛泽东、邓小平著作汇编</option>
                        <option value="A6 邓小平著作">&nbsp;&nbsp;&nbsp;&nbsp;A6 邓小平著作</option>
                        <option value="A7 马克思、恩格斯、列宁、斯大林、毛泽东、邓小平生平和传记">&nbsp;&nbsp;&nbsp;&nbsp;A7 马克思、恩格斯、列宁、斯大林、毛泽东、邓小平生平和传记</option>
                        <option value="A8 马克思主义、列宁主义、毛泽东思想、邓小平理论的学习和研究">&nbsp;&nbsp;&nbsp;&nbsp;A8 马克思主义、列宁主义、毛泽东思想、邓小平理论的学习和研究</option>
                        <option value="C 社会科学总论">C 社会科学总论</option>
                        <option value="C0 社会科学理论与方法论">&nbsp;&nbsp;&nbsp;&nbsp;C0 社会科学理论与方法论</option>
                        <option value="C1 社会科学现状及发展">&nbsp;&nbsp;&nbsp;&nbsp;C1 社会科学现状及发展</option>
                        <option value="C2 社会科学机构、团体、会议">&nbsp;&nbsp;&nbsp;&nbsp;C2 社会科学机构、团体、会议</option>
                        <option value="C3 社会科学研究方法">&nbsp;&nbsp;&nbsp;&nbsp;C3 社会科学研究方法</option>
                        <option value="C4 社会科学教育与普及">&nbsp;&nbsp;&nbsp;&nbsp;C4 社会科学教育与普及</option>
                        <option value="C5 社会科学丛书、文集、连续性出版物">&nbsp;&nbsp;&nbsp;&nbsp;C5 社会科学丛书、文集、连续性出版物</option>
                        <option value="C6 社会科学参考工具书">&nbsp;&nbsp;&nbsp;&nbsp;C6 社会科学参考工具书</option>
                        <option value="C7 社会科学文献检索工具书">&nbsp;&nbsp;&nbsp;&nbsp;C7 社会科学文献检索工具书</option>
                        <option value="C8 统计学">&nbsp;&nbsp;&nbsp;&nbsp;C8 统计学</option>
                        <option value="C91 社会学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C91 社会学</option>
                        <option value="C92 人口学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C92 人口学</option>
                        <option value="C93 管理学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C93 管理学</option>
                        <option value="C94 系统科学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C94 系统科学</option>
                        <option value="C95 民族学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C95 民族学</option>
                        <option value="C96 人才学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C96 人才学</option>
                        <option value="C97 劳动科学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C97 劳动科学</option>
                        <option value="D 政治、法律">D 政治、法律</option>
                        <option value="D0 政治理论">&nbsp;&nbsp;&nbsp;&nbsp;D0 政治理论</option>
                        <option value="D1 国际共产主义运动">&nbsp;&nbsp;&nbsp;&nbsp;D1 国际共产主义运动</option>
                        <option value="D2 中国共产党">&nbsp;&nbsp;&nbsp;&nbsp;D2 中国共产党</option>
                        <option value="D3 各国共产党">&nbsp;&nbsp;&nbsp;&nbsp;D3 各国共产党</option>
                        <option value="D4 工人、农民、青年、妇女运动与组织">&nbsp;&nbsp;&nbsp;&nbsp;D4 工人、农民、青年、妇女运动与组织</option>
                        <option value="D5 世界政治">&nbsp;&nbsp;&nbsp;&nbsp;D5 世界政治</option>
                        <option value="D6 中国政治">&nbsp;&nbsp;&nbsp;&nbsp;D6 中国政治</option>
                        <option value="D7 各国政治">&nbsp;&nbsp;&nbsp;&nbsp;D7 各国政治</option>
                        <option value="D8 外交、国际关系">&nbsp;&nbsp;&nbsp;&nbsp;D8 外交、国际关系</option>
                        <option value="D9 法律">&nbsp;&nbsp;&nbsp;&nbsp;D9 法律</option>
                        <option value="D90 法的理论（法学）">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D90 法的理论（法学）</option>
                        <option value="D91 法学各部门">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D91 法学各部门</option>
                        <option value="D92 中国法律">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D92 中国法律</option>
                        <option value="D93 各国法律">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D93 各国法律</option>
                        <option value="D99 国际法">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D99 国际法</option>
                        <option value="E 军事">E 军事</option>
                        <option value="E0 军事理论">&nbsp;&nbsp;&nbsp;&nbsp;E0 军事理论</option>
                        <option value="E1 世界军事">&nbsp;&nbsp;&nbsp;&nbsp;E1 世界军事</option>
                        <option value="E2 中国军事">&nbsp;&nbsp;&nbsp;&nbsp;E2 中国军事</option>
                        <option value="E3 各国军事">&nbsp;&nbsp;&nbsp;&nbsp;E3 各国军事</option>
                        <option value="E8 战略学、战役学、战术学">&nbsp;&nbsp;&nbsp;&nbsp;E8 战略学、战役学、战术学</option>
                        <option value="E9 军事技术">&nbsp;&nbsp;&nbsp;&nbsp;E9 军事技术</option>
                        <option value="E99 军事地形学、军事地理学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;E99 军事地形学、军事地理学</option>
                        <option value="F 经济"> F 经济</option>
                        <option value="F0 经济学">&nbsp;&nbsp;&nbsp;&nbsp;F0 经济学</option>
                        <option value="F00 马克思主义政治经济学（总论）">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F00 马克思主义政治经济学（总论）</option>
                        <option value="F01 经济学基本问题">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F01 经济学基本问题</option>
                        <option value="F02 前资本主义社会生产方式">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F02 前资本主义社会生产方式</option>
                        <option value="F03 资本主义社会生产方式">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F03 资本主义社会生产方式</option>
                        <option value="F04 社会主义社会生产方式">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F04 社会主义社会生产方式</option>
                        <option value="F05 共产主义社会生产方式">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F05 共产主义社会生产方式</option>
                        <option value="F06 经济学分支科学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F06 经济学分支科学</option>
                        <option value="F08 各科经济学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F08 各科经济学</option>
                        <option value="F09 经济思想史">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F09 经济思想史</option>
                        <option value="F1 世界各国经济概况、经济史、经济地理">&nbsp;&nbsp;&nbsp;&nbsp;F1 世界各国经济概况、经济史、经济地理</option>
                        <option value="F11 世界经济、国际经济关系">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F11 世界经济、国际经济关系</option>
                        <option value="F12 中国经济">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F12 中国经济</option>
                        <option value="F13 各国经济">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F13 各国经济</option>
                        <option value="F2 经济计划与管理">&nbsp;&nbsp;&nbsp;&nbsp;F2 经济计划与管理</option>
                        <option value="F20 国民经济管理">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F20 国民经济管理</option>
                        <option value="F21 经济计划">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F21 经济计划</option>
                        <option value="F22 经济计算、经济数学方法">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F22 经济计算、经济数学方法</option>
                        <option value="F23 会计">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F23 会计</option>
                        <%--                         <option value="F239 审计">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F239 审计</option>--%>
                        <option value="F24 劳动经济">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F24 劳动经济</option>
                        <option value="F25 物质经济">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F25 物质经济</option>
                        <option value="F27 企业经济">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F27 企业经济</option>
                        <option value="F28 基本建设经济">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F28 基本建设经济</option>
                        <option value="F29 城市与市政经济">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F29 城市与市政经济</option>
                        <option value="F3 农业经济">&nbsp;&nbsp;&nbsp;&nbsp;F3 农业经济</option>
                        <option value="F4 工业经济">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F4 工业经济</option>
                        <option value="F49 信息产业经济（总论）">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F49 信息产业经济（总论）</option>
                        <option value="F5 交通运输经济">&nbsp;&nbsp;&nbsp;&nbsp;F5 交通运输经济</option>
                        <option value="F59 旅游经济">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F59 旅游经济</option>
                        <option value="F6 邮电经济">&nbsp;&nbsp;&nbsp;&nbsp;F6 邮电经济</option>
                        <option value="F7 贸易经济">&nbsp;&nbsp;&nbsp;&nbsp;F7 贸易经济</option>
                        <option value="F71 国内贸易经济">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F71 国内贸易经济</option>
                        <option value="F72 中国国内贸易经济">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F72 中国国内贸易经济</option>
                        <option value="F73 世界各国国内贸易经济">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F73 世界各国国内贸易经济</option>
                        <option value="F74 世界贸易">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F74 世界贸易</option>
                        <option value="F75 各国对外贸易">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F75 各国对外贸易</option>
                        <option value="F76 商品学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F76 商品学</option>
                        <option value="F8 财政、金融">&nbsp;&nbsp;&nbsp;&nbsp;F8 财政、金融</option>
                        <option value="F81 财政、国家财政">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F81 财政、国家财政</option>
                        <option value="F82 货币">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F82 货币</option>
                        <option value="F83 金融、银行">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F83 金融、银行</option>
                        <option value="F84 保险">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F84 保险</option>
                        <option value="G 文化、科学、教育、体育">G 文化、科学、教育、体育</option>
                        <option value="G0 文化理论">&nbsp;&nbsp;&nbsp;&nbsp;G0 文化理论</option>
                        <option value="G1 世界各国文化与文化事业">&nbsp;&nbsp;&nbsp;&nbsp;G1 世界各国文化与文化事业</option>
                        <option value="G2 信息与知识传播">&nbsp;&nbsp;&nbsp;&nbsp;G2 信息与知识传播</option>
                        <option value="G3 科学、科学研究">&nbsp;&nbsp;&nbsp;&nbsp;G3 科学、科学研究</option>
                        <option value="G4 教育">&nbsp;&nbsp;&nbsp;&nbsp;G4 教育</option>
                        <%--                         <option value="G64 高等教育">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;G64 高等教育</option>--%>
                        <option value="G8 体育">&nbsp;&nbsp;&nbsp;&nbsp;G8 体育</option>
                        <option value="H 语言、文字">H 语言、文字</option>
                        <option value="H0 语言学">&nbsp;&nbsp;&nbsp;&nbsp;H0 语言学</option>
                        <option value="H1 汉语">&nbsp;&nbsp;&nbsp;&nbsp;H1 汉语</option>
                        <option value="H11 语音">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H11 语音</option>
                        <option value="H12 文字学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H12 文字学</option>
                        <option value="H13 语义、词汇、词义（训诂学）">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H13 语义、词汇、词义（训诂学）</option>
                        <option value="H14 语法">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H14 语法</option>
                        <%--                         <option value="H15 写作、修辞">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H15 写作、修辞</option>--%>
                        <%--                         <option value="H159 翻译">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H159 翻译</option>--%>
                        <%--                         <option value="H16 字书、字典、词典">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H16 字书、字典、词典</option>--%>
                        <%--                         <option value="H17 方言">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H17 方言</option>--%>
                        <%--                         <option value="H19 汉语教学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H19 汉语教学</option>--%>
                        <%--                         <option value="H2 中国少数民族语言">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H2 中国少数民族语言</option>--%>
                        <%--                         <option value="H3 常用外国语">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H3 常用外国语</option>--%>
                        <%--                         <option value="H31 英语">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H31 英语</option>--%>
                        <%--                         <option value="H32 法语">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H32 法语</option>--%>
                        <%--                         <option value="H3 德语">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H3 德语</option>--%>
                        <%--                         <option value="H34 西班牙语">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H34 西班牙语</option>--%>
                        <%--                         <option value="H35 俄语">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H35 俄语</option>--%>
                        <%--                         <option value="H36 日语">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H36 日语</option>--%>
                        <%--                         <option value="H37 阿拉伯语">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H37 阿拉伯语</option>--%>
                        <option value="I 艺术">I 艺术</option>
                        <option value="I1 艺术理论">&nbsp;&nbsp;&nbsp;&nbsp;I1 艺术理论</option>
                        <option value="I2 音乐">&nbsp;&nbsp;&nbsp;&nbsp;I2 音乐</option>
                        <option value="I21 声乐">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I21 声乐</option>
                        <option value="I22 器乐">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I22 器乐</option>
                        <option value="I23 作曲与音乐创作">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I23 作曲与音乐创作</option>
                        <option value="I24 音乐教育">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I24 音乐教育</option>
                        <option value="I3 戏剧、影视、表演艺术">&nbsp;&nbsp;&nbsp;&nbsp;I3 戏剧、影视、表演艺术</option>
                        <option value="I31 戏剧、话剧">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I31 戏剧、话剧</option>
                        <option value="I32 电影">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I32 电影</option>
                        <option value="I33 电视艺术">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I33 电视艺术</option>
                        <option value="I34 表演艺术">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I34 表演艺术</option>
                        <option value="I35 戏曲">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I35 戏曲</option>
                        <option value="I4 美术">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I4 美术</option>
                        <%--                         <option value="I41 绘画">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I41 绘画</option>--%>
                        <%--                         <option value="I42 雕塑">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I42 雕塑</option>--%>
                        <%--                         <option value="I43 书法">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I43 书法</option>--%>
                        <%--                         <option value="I44 工艺美术">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I44 工艺美术</option>--%>
                        <%--                         <option value="I45 设计艺术">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I45 设计艺术</option>--%>
                        <option value="I5 舞蹈">&nbsp;&nbsp;&nbsp;&nbsp;I5 舞蹈</option>
                        <option value="I6 电影与电视">&nbsp;&nbsp;&nbsp;&nbsp;I6 电影与电视</option>
                        <option value="I7 摄影">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I7 摄影</option>
                        <option value="I8 其他艺术形式">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I8 其他艺术形式</option>
                        <option value="J 旅游、地理">J 旅游、地理</option>
                        <option value="J0 旅游理论与规划">&nbsp;&nbsp;&nbsp;&nbsp;J0 旅游理论与规划</option>
                        <option value="J1 旅游经济">&nbsp;&nbsp;&nbsp;&nbsp;J1 旅游经济</option>
                        <%--                         <option value="J2 旅游资源与景区管理">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;J2 旅游资源与景区管理</option>--%>
                        <%--                         <option value="J3 旅游服务与管理">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;J3 旅游服务与管理</option>--%>
                        <%--                         <option value="J4 旅游营销与推广">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;J4 旅游营销与推广</option>--%>
                        <%--                         <option value="J5 旅游文化与遗产">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;J5 旅游文化与遗产</option>--%>
                        <%--                         <option value="J6 旅游心理与消费者行为">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;J6 旅游心理与消费者行为</option>--%>
                        <%--                         <option value="J7 旅游教育与培训">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;J7 旅游教育与培训</option>--%>
                        <%--                         <option value="J8 旅游科技">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;J8 旅游科技</option>--%>
                        <%--                         <option value="J9 旅游管理与组织">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;J9 旅游管理与组织</option>--%>
                        <option value="K 历史、考古">K 历史、考古</option>
                        <%--                         <option value="K0 历史学理论与方法">&nbsp;&nbsp;&nbsp;&nbsp;K0 历史学理论与方法</option>--%>
                        <option value="K1 中国历史">&nbsp;&nbsp;&nbsp;&nbsp;K1 中国历史</option>
                        <%--                         <option value="K11 古代史">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K11 古代史</option>--%>
                        <%--                         <option value="K12 近现代史">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K12 近现代史</option>--%>
                        <%--                         <option value="K13 当代史">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K13 当代史</option>--%>
                        <option value="K2 世界历史">&nbsp;&nbsp;&nbsp;&nbsp;K2 世界历史</option>
                        <option value="K21 古代史">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K21 古代史</option>
                        <option value="K22 近现代史">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K22 近现代史</option>
                        <option value="K23 当代史">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K23 当代史</option>
                        <option value="K3 考古学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K3 考古学</option>
                        <option value="K4 历史文献与史学研究">&nbsp;&nbsp;&nbsp;&nbsp;K4 历史文献与史学研究</option>
                        <option value="K5 地理历史">&nbsp;&nbsp;&nbsp;&nbsp;K5 地理历史</option>
                        <%--                         <option value="K6 文化历史">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K6 文化历史</option>--%>
                        <%--                         <option value="K7 历史人物与事件">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K7 历史人物与事件</option>--%>
                        <%--                         <option value="K8 非物质文化遗产">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K8 非物质文化遗产</option>--%>
                        <%--                         <option value="K9 博物馆学与遗产保护">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K9 博物馆学与遗产保护</option>--%>
                        <option value="J 旅游、地理">J 旅游、地理</option>
                        <option value="J0 旅游理论与规划">&nbsp;&nbsp;&nbsp;&nbsp;J0 旅游理论与规划</option>
                        <option value="J1 旅游经济">&nbsp;&nbsp;&nbsp;&nbsp;J1 旅游经济</option>
                        <option value="J2 旅游资源与景区管理">&nbsp;&nbsp;&nbsp;&nbsp;J2 旅游资源与景区管理</option>
                        <%--                         <option value="J3 旅游服务与管理">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;J3 旅游服务与管理</option>--%>
                        <%--                         <option value="J4 旅游营销与推广">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;J4 旅游营销与推广</option>--%>
                        <%--                         <option value="J5 旅游文化与遗产">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;J5 旅游文化与遗产</option>--%>
                        <%--                         <option value="J6 旅游心理与消费者行为">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;J6 旅游心理与消费者行为</option>--%>
                        <%--                         <option value="J7 旅游教育与培训">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;J7 旅游教育与培训</option>--%>
                        <%--                         <option value="J8 旅游科技">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;J8 旅游科技</option>--%>
                        <%--                         <option value="J9 旅游管理与组织">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;J9 旅游管理与组织</option>--%>
                        <option value="K 历史、考古">K 历史、考古</option>
                        <option value="K0 历史学理论与方法">&nbsp;&nbsp;&nbsp;&nbsp;;K0 历史学理论与方法</option>
                        <option value="K1 中国历史">&nbsp;&nbsp;&nbsp;&nbsp;K1 中国历史</option>
                        <option value="K11 古代史">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K11 古代史</option>
                        <%--                         <option value="K12 近现代史">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K12 近现代史</option>--%>
                        <%--                         <option value="K13 当代史">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K13 当代史</option>--%>
                        <%--                         <option value="K2 世界历史">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K2 世界历史</option>--%>
                        <%--                         <option value="K21 古代史">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K21 古代史</option>--%>
                        <%--                         <option value="K22 近现代史">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K22 近现代史</option>--%>
                        <%--                         <option value="K23 当代史">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K23 当代史</option>--%>
                        <%--                         <option value="K3 考古学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K3 考古学</option>--%>
                        <%--                         <option value="K4 历史文献与史学研究">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K4 历史文献与史学研究</option>--%>
                        <%--                         <option value="K5 地理历史">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K5 地理历史</option>--%>
                        <%--                         <option value="K6 文化历史">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K6 文化历史</option>--%>
                        <%--                         <option value="K7 历史人物与事件">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K7 历史人物与事件</option>--%>
                        <%--                         <option value="K8 非物质文化遗产">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K8 非物质文化遗产</option>--%>
                        <%--                         <option value="K9 博物馆学与遗产保护">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K9 博物馆学与遗产保护</option>--%>
                        <option value="L 伦理学、宗教">L 伦理学、宗教</option>
                        <option value="L0 伦理学">&nbsp;&nbsp;&nbsp;&nbsp;L0 伦理学</option>
                        <option value="L1 德性伦理学">&nbsp;&nbsp;&nbsp;&nbsp;L1 德性伦理学</option>
                        <option value="L2 义务论伦理学">&nbsp;&nbsp;&nbsp;&nbsp;L2 义务论伦理学</option>
                        <%--                         <option value="L3 后果伦理学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;L3 后果伦理学</option>--%>
                        <%--                         <option value="L4 文化伦理学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;L4 文化伦理学</option>--%>
                        <%--                         <option value="L5 环境伦理学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;L5 环境伦理学</option>--%>
                        <%--                         <option value="L6 应用伦理学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;L6 应用伦理学</option>--%>
                        <%--                         <option value="L7 宗教与道德">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;L7 宗教与道德</option>--%>
                        <%--                         <option value="L8 宗教哲学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;L8 宗教哲学</option>--%>
                        <%--                         <option value="L9 宗教信仰与文化">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;L9 宗教信仰与文化</option>--%>
                        <option value="M 社会学">M 社会学</option>
                        <option value="M0 社会学理论">&nbsp;&nbsp;&nbsp;&nbsp;M0 社会学理论</option>
                        <option value="M1 社会结构与社会问题">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;M1 社会结构与社会问题</option>
                        <option value="M2 社会发展与社会变革">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;M2 社会发展与社会变革</option>
                        <%--                         <option value="M3 城市与社区">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;M3 城市与社区</option>--%>
                        <%--                         <option value="M4 教育与社会">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;M4 教育与社会</option>--%>
                        <%--                         <option value="M5 家庭与社会">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;M5 家庭与社会</option>--%>
                        <%--                         <option value="M6 劳动与就业">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;M6 劳动与就业</option>--%>
                        <%--                         <option value="M7 社会保障与福利">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;M7 社会保障与福利</option>--%>
                        <%--                         <option value="M8 公共服务与治理">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;M8 公共服务与治理</option>--%>
                        <%--                         <option value="M9 社会管理与社会工作">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;M9 社会管理与社会工作</option>--%>
                        <option value="N 法学">N 法学</option>
                        <option value="N0 法律理论">&nbsp;&nbsp;&nbsp;&nbsp;N0 法律理论</option>
                        <option value="N1 宪法学">&nbsp;&nbsp;&nbsp;&nbsp;N1 宪法学</option>
                        <option value="N2 民法学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;N2 民法学</option>
                        <%--                         <option value="N3 刑法学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;N3 刑法学</option>--%>
                        <%--                         <option value="N4 商法学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;N4 商法学</option>--%>
                        <%--                         <option value="N5 行政法学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;N5 行政法学</option>--%>
                        <%--                         <option value="N6 经济法学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;N6 经济法学</option>--%>
                        <%--                         <option value="N7 国际法学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;N7 国际法学</option>--%>
                        <%--                         <option value="N8 环境法学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;N8 环境法学</option>--%>
                        <%--                         <option value="N9 知识产权法">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;N9 知识产权法</option>--%>
                        <option value="O 政治学">O 政治学</option>
                        <option value="O0 政治理论">&nbsp;&nbsp;&nbsp;&nbsp;O0 政治理论</option>
                        <option value="O1 中外政治思想史">&nbsp;&nbsp;&nbsp;&nbsp;O1 中外政治思想史</option>
                        <%--                         <option value="O2 比较政治学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;O2 比较政治学</option>--%>
                        <%--                         <option value="O3 国际关系学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;O3 国际关系学</option>--%>
                        <%--                         <option value="O4 政策研究与分析">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;O4 政策研究与分析</option>--%>
                        <%--                         <option value="O5 公共行政学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;O5 公共行政学</option>--%>
                        <%--                         <option value="O6 行政管理与公共服务">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;O6 行政管理与公共服务</option>--%>
                        <%--                         <option value="O7 政治与经济学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;O7 政治与经济学</option>--%>
                        <%--                         <option value="O8 社会运动与政治变革">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;O8 社会运动与政治变革</option>--%>
                        <option value="P 经济学">P 经济学</option>
                        <option value="P0 经济学理论">&nbsp;&nbsp;&nbsp;&nbsp;P0 经济学理论</option>
                        <option value="P1 微观经济学">&nbsp;&nbsp;&nbsp;&nbsp;P1 微观经济学</option>
                        <%--                         <option value="P2 宏观经济学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;P2 宏观经济学</option>--%>
                        <%--                         <option value="P3 国际经济学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;P3 国际经济学</option>--%>
                        <%--                         <option value="P4 计量经济学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;P4 计量经济学</option>--%>
                        <%--                         <option value="P5 行为经济学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;P5 行为经济学</option>--%>
                        <%--                         <option value="P6 发展经济学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;P6 发展经济学</option>--%>
                        <%--                         <option value="P7 公共经济学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;P7 公共经济学</option>--%>
                        <%--                         <option value="P8 劳动经济学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;P8 劳动经济学</option>--%>
                        <%--                         <option value="P9 财政学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;P9 财政学</option>--%>
                        <option value="Q 金融学">Q 金融学</option>
                        <option value="Q0 金融理论">&nbsp;&nbsp;&nbsp;&nbsp;Q0 金融理论</option>
                        <option value="Q1 金融市场">&nbsp;&nbsp;&nbsp;&nbsp;Q1 金融市场</option>
                        <%--                         <option value="Q2 金融机构">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Q2 金融机构</option>--%>
                        <%--                         <option value="Q3 银行学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Q3 银行学</option>--%>
                        <%--                         <option value="Q4 保险学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Q4 保险学</option>--%>
                        <%--                         <option value="Q5 投资学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Q5 投资学</option>--%>
                        <%--                         <option value="Q6 资本市场">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Q6 资本市场</option>--%>
                        <%--                         <option value="Q7 货币与银行学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Q7 货币与银行学</option>--%>
                        <%--                         <option value="Q8 公司金融">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Q8 公司金融</option>--%>
                        <%--                         <option value="Q9 金融工程">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Q9 金融工程</option>--%>
                        <option value="R 会计学">R 会计学</option>
                        <option value="R0 会计理论">&nbsp;&nbsp;&nbsp;&nbsp;R0 会计理论</option>
                        <option value="R1 财务会计">&nbsp;&nbsp;&nbsp;&nbsp;R1 财务会计</option>
                        <%--                         <option value="R2 成本会计">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;R2 成本会计</option>--%>
                        <%--                         <option value="R3 管理会计">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;R3 管理会计</option>--%>
                        <%--                         <option value="R4 审计学">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;R4 审计学</option>--%>
                        <%--                         <option value="R5 税务会计">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;R5 税务会计</option>--%>
                        <%--                         <option value="R6 会计信息化">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;R6 会计信息化</option>--%>
                        <%--                         <option value="R7 会计政策与管理">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;R7 会计政策与管理</option>--%>
                        <%--                         <option value="R8 国际会计">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;R8 国际会计</option>--%>
                        <%--                         <option value="R9 会计研究方法">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;R9 会计研究方法</option>--%>
                        <option value="S 商务与管理学">S 商务与管理学</option>
                        <option value="S0 管理理论与方法">&nbsp;&nbsp;&nbsp;&nbsp;S0 管理理论与方法</option>
                        <option value="S1 人力资源管理">&nbsp;&nbsp;&nbsp;&nbsp;S1 人力资源管理</option>
                        <option value="S2 市场营销">&nbsp;&nbsp;&nbsp;&nbsp;S2 市场营销</option>
                        <%--                         <option value="S3 企业管理">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;S3 企业管理</option>--%>
                        <%--                         <option value="S4 创业与创新管理">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;S4 创业与创新管理</option>--%>
                        <%--                         <option value="S5 战略管理">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;S5 战略管理</option>--%>
                        <%--                         <option value="S6 项目管理">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;S6 项目管理</option>--%>
                        <%--                         <option value="S7 供应链与物流管理">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;S7 供应链与物流管理</option>--%>
                        <%--                         <option value="S8 财务管理">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;S8 财务管理</option>--%>
                        <%--                         <option value="S9 商业分析与决策支持">&nbsp;&nbsp;&nbsp;--%>
                        <option value="T 工业技术">T 工业技术</option>
                        <option value="T0 工业基础理论">&nbsp;&nbsp;&nbsp;&nbsp;T0 工业基础理论</option>
                        <option value="T1 机械工程">&nbsp;&nbsp;&nbsp;&nbsp;T1 机械工程</option>
                        <%--                         <option value="T2">&nbsp;&nbsp;&nbsp;&nbsp;T2 电气工程</option>--%>
                        <%--                         <option value="T3">&nbsp;&nbsp;&nbsp;&nbsp;T3 自动化与控制工程</option>--%>
                        <%--                         <option value="T4">&nbsp;&nbsp;&nbsp;&nbsp;T4 土木工程</option>--%>
                        <%--                         <option value="T5">&nbsp;&nbsp;&nbsp;&nbsp;T5 建筑工程</option>--%>
                        <%--                         <option value="T6">&nbsp;&nbsp;&nbsp;&nbsp;T6 化学工程与技术</option>--%>
                        <%--                         <option value="T7">&nbsp;&nbsp;&nbsp;&nbsp;T7 计算机科学与技术</option>--%>
                        <%--                         <option value="T8">&nbsp;&nbsp;&nbsp;&nbsp;T8 环境工程</option>--%>
                        <%--                         <option value="T9">&nbsp;&nbsp;&nbsp;&nbsp;T9 物流与运输工程</option>--%>
                        <option value="U 农业技术">U 农业技术</option>
                        <option value="U0 农业基础科学">&nbsp;&nbsp;&nbsp;&nbsp;U0 农业基础科学</option>
                        <option value="U1 农学">&nbsp;&nbsp;&nbsp;&nbsp;U1 农学</option>
                        <%--                         <option value="U2">&nbsp;&nbsp;&nbsp;&nbsp;U2 林学</option>--%>
                        <%--                         <option value="U3">&nbsp;&nbsp;&nbsp;&nbsp;U3 动物科学</option>--%>
                        <%--                         <option value="U4">&nbsp;&nbsp;&nbsp;&nbsp;U4 水产养殖学</option>--%>
                        <%--                         <option value="U5">&nbsp;&nbsp;&nbsp;&nbsp;U5 生态学</option>--%>
                        <%--                         <option value="U6">&nbsp;&nbsp;&nbsp;&nbsp;U6 农业工程</option>--%>
                        <%--                         <option value="U7">&nbsp;&nbsp;&nbsp;&nbsp;U7 农村发展与管理</option>--%>
                        <%--                         <option value="U8">&nbsp;&nbsp;&nbsp;&nbsp;U8 农业资源与环境</option>--%>
                        <%--                         <option value="U9">&nbsp;&nbsp;&nbsp;&nbsp;U9 食品科学与工程</option>--%>
                        <option value="V 医学">V 医学</option>
                        <option value="V0 基础医学">&nbsp;&nbsp;&nbsp;&nbsp;V0 基础医学</option>
                        <option value="V1 临床医学">&nbsp;&nbsp;&nbsp;&nbsp;V1 临床医学</option>
                        <%--                         <option value="V2">&nbsp;&nbsp;&nbsp;&nbsp;V2 口腔医学</option>--%>
                        <%--                         <option value="V3">&nbsp;&nbsp;&nbsp;&nbsp;V3 公共卫生与预防医学</option>--%>
                        <%--                         <option value="V4">&nbsp;&nbsp;&nbsp;&nbsp;V4 中医学</option>--%>
                        <%--                         <option value="V5">&nbsp;&nbsp;&nbsp;&nbsp;V5 药学</option>--%>
                        <%--                         <option value="V6">&nbsp;&nbsp;&nbsp;&nbsp;V6 护理学</option>--%>
                        <%--                         <option value="V7">&nbsp;&nbsp;&nbsp;&nbsp;V7 医学技术</option>--%>
                        <%--                         <option value="V8">&nbsp;&nbsp;&nbsp;&nbsp;V8 医学影像学</option>--%>
                        <%--                         <option value="V9">&nbsp;&nbsp;&nbsp;&nbsp;V9 健康管理</option>--%>
                        <option value="W 工程技术">W 工程技术</option>
                        <option value="W0 工程管理与工程造价">&nbsp;&nbsp;&nbsp;&nbsp;W0 工程管理与工程造价</option>
                        <option value="W1 水利工程">&nbsp;&nbsp;&nbsp;&nbsp;W1 水利工程</option>
                        <%--                         <option value="W2">&nbsp;&nbsp;&nbsp;&nbsp;W2 矿业工程</option>--%>
                        <%--                         <option value="W3">&nbsp;&nbsp;&nbsp;&nbsp;W3 航空航天工程</option>--%>
                        <%--                         <option value="W4">&nbsp;&nbsp;&nbsp;&nbsp;W4 核工程</option>--%>
                        <%--                         <option value="W5">&nbsp;&nbsp;&nbsp;&nbsp;W5 农业工程技术</option>--%>
                        <%--                         <option value="W6">&nbsp;&nbsp;&nbsp;&nbsp;W6 土木工程管理</option>--%>
                        <%--                         <option value="W7">&nbsp;&nbsp;&nbsp;&nbsp;W7 环境工程技术</option>--%>
                        <%--                         <option value="W8">&nbsp;&nbsp;&nbsp;&nbsp;W8 化学工程与工艺</option>--%>
                        <%--                         <option value="W9">&nbsp;&nbsp;&nbsp;&nbsp;W9 机电工程技术</option>--%>
                        <option value="X 艺术">X 艺术</option>
                        <option value="X0 艺术学理论">&nbsp;&nbsp;&nbsp;&nbsp;X0 艺术学理论</option>
                        <option value="X1 视觉传达设计">&nbsp;&nbsp;&nbsp;&nbsp;X1 视觉传达设计</option>
                        <option value="X2 产品设计">&nbsp;&nbsp;&nbsp;&nbsp;X2 产品设计</option>
                        <%--                         <option value="X3">&nbsp;&nbsp;&nbsp;&nbsp;X3 环境设计</option>--%>
                        <%--                         <option value="X4">&nbsp;&nbsp;&nbsp;&nbsp;X4 服装设计与工程</option>--%>
                        <%--                         <option value="X5">&nbsp;&nbsp;&nbsp;&nbsp;X5 动画</option>--%>
                        <%--                         <option value="X6">&nbsp;&nbsp;&nbsp;&nbsp;X6 音乐学</option>--%>
                        <%--                         <option value="X7">&nbsp;&nbsp;&nbsp;&nbsp;X7 舞蹈学</option>--%>
                        <%--                         <option value="X8">&nbsp;&nbsp;&nbsp;&nbsp;X8 戏剧与影视学</option>--%>
                        <%--                         <option value="X9">&nbsp;&nbsp;&nbsp;&nbsp;X9 电影与电视制作</option>--%>
                        <option value="Y 体育">Y 体育</option>
                        <option value="Y0 体育学理论">&nbsp;&nbsp;&nbsp;&nbsp;Y0 体育学理论</option>
                        <option value="Y1 运动训练">&nbsp;&nbsp;&nbsp;&nbsp;Y1 运动训练</option>
                        <%--                         <option value="Y2">&nbsp;&nbsp;&nbsp;&nbsp;Y2 运动康复</option>--%>
                        <%--                         <option value="Y3">&nbsp;&nbsp;&nbsp;&nbsp;Y3 体育教育</option>--%>
                        <%--                         <option value="Y4">&nbsp;&nbsp;&nbsp;&nbsp;Y4 社会体育</option>--%>
                        <%--                         <option value="Y5">&nbsp;&nbsp;&nbsp;&nbsp;Y5 体育管理</option>--%>
                        <%--                         <option value="Y6">&nbsp;&nbsp;&nbsp;&nbsp;Y6 体育传媒与文化</option>--%>
                        <%--                         <option value="Y7">&nbsp;&nbsp;&nbsp;&nbsp;Y7 竞技体育</option>--%>
                        <%--                         <option value="Y8">&nbsp;&nbsp;&nbsp;&nbsp;Y8 体育设施与建设</option>--%>
                        <%--                         <option value="Y9">&nbsp;&nbsp;&nbsp;&nbsp;Y9 体育健康与营养</option>--%>
                        <option value="Z 军事学">Z 军事学</option>
                        <option value="Z0 军事学理论">&nbsp;&nbsp;&nbsp;&nbsp;Z0 军事学理论</option>
                        <option value="Z1 战略学">&nbsp;&nbsp;&nbsp;&nbsp;Z1 战略学</option>
                        <%--                         <option value="Z2">&nbsp;&nbsp;&nbsp;&nbsp;Z2 战术学</option>--%>
                        <%--                         <option value="Z3">&nbsp;&nbsp;&nbsp;&nbsp;Z3 后勤与装备学</option>--%>
                        <%--                         <option value="Z4">&nbsp;&nbsp;&nbsp;&nbsp;Z4 军事指挥与领导学</option>--%>
                        <%--                         <option value="Z5">&nbsp;&nbsp;&nbsp;&nbsp;Z5 国防科技</option>--%>
                        <%--                         <option value="Z6">&nbsp;&nbsp;&nbsp;&nbsp;Z6 军事心理学</option>--%>
                        <%--                         <option value="Z7">&nbsp;&nbsp;&nbsp;&nbsp;Z7 军事法学</option>--%>
                        <%--                         <option value="Z8">&nbsp;&nbsp;&nbsp;&nbsp;Z8 国防安全学</option>--%>
                        <%--                         <option value="Z9">&nbsp;&nbsp;&nbsp;&nbsp;Z9 军事史</option>--%>

                        <!-- ... 其他选项 ... -->
                        <!-- ... 其他选项 ... -->
                        <!-- ... 其他选项 ... -->
                        <!-- ... 其他选项 ... -->
                        <!-- ... 其他选项 ... -->
                        <!-- ... 其他选项 ... -->
                        <!-- ... 其他选项 ... -->
                        <!-- ... 其他选项 ... -->
                        <!-- ... 其他选项 ... -->


                    </select></td>
                </tr>
                <tr>
                    <th>ISBN</th>
                    <td><input type="text" id="isbn2" name="isbn" readonly ></td>
                    <th>出版社</th>
                    <td><input type="text" id="publisher2" name="publisher" readonly ></td>
                </tr>
                <tr>
                    <th>书商</th>
                    <td><input type="text" id="supplier2" name="supplier" readonly ></td>
                    <th>定价</th>
                    <td><input type="text" id="price2" name="price" readonly ></td>
                </tr>

            </table>
            <button type="button" id="confirmButton2" name="confirmButton" >确定</button>
        </form>
    </div>
</div>



<script>
    // 获取导出按钮元素
    var daochuButton = document.getElementById("daochuButton");

    // 为导出按钮添加点击事件监听器
    daochuButton.onclick = function() {
        // 使用 AJAX 发送请求到后端的 CatalogToLiutongServlet
        $.ajax({
            url: '${pageContext.request.contextPath}/CatalogToLiutongServlet', // 后端 Servlet 路径
            method: 'POST', // 请求方法
            dataType: 'json', // 期待返回的数据格式
            success: function(response) {
                // 检查后端返回的 errorMsg 是否为空，如果为空则表示成功
                // console.log(response.resultInfo.flag);
                if (response.resultInfo.flag) {
                    alert("导出成功！");
                    // 可能需要刷新页面或者更新列表
                   location.reload(true); // 或者使用其他方法更新页面
                } else {
                    alert("导出失败，错误信息: " + response.resultInfo.errorMsg);
                }
            },
            error: function(xhr, status, error) {
                // 处理 AJAX 请求失败的情况
                alert("导出失败，错误代码: " + xhr.status + "\n" + xhr.statusText);
            }
        });
    };
    document.addEventListener("DOMContentLoaded", function() {
        // 获取模态框元素
        var modal = document.getElementById("myModal");
        var addButton = document.getElementById("addButton");
        var closeModal = document.getElementById("closeModal");
        var confirmButton = document.getElementById("confirmButton");
        var successModal = document.getElementById("successModal");
        var closeSuccessModal = document.getElementById("closeSuccessModal");


        // 获取模态框元素
        var modal2 = document.getElementById("myModal2");
        var closeModal2 = document.getElementById("closeModal2");
        // 获取所有的“编辑”按钮
        var editButtons = document.querySelectorAll("#editButton");

        // 打开模态框
        addButton.onclick = function () {
            modal.style.display = "block";
            // 在点击时向后端请求相关数据
            fetchInitData();  // 获取并展示现有数据
        }

        // 编辑显示
        editButtons.forEach(function(button) {
            button.addEventListener("click", function(event) {
                modal2.style.display = "block";
                // 获取点击按钮所在行的读者信息
                var ISBN = event.target.closest("tr").querySelector("td:nth-child(3)").innerText;

                // 发送请求获取该读者的详细信息
                fetchCataloglistDetails(ISBN);
            });
        });

        // 关闭模态框
        closeModal.onclick = function () {
            modal.style.display = "none";
        }
        closeModal2.onclick = function () {
            modal2.style.display = "none";
        }

        // 点击模态框外部关闭模态框
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
            if (event.target == modal2) {
                modal2.style.display = "none";
            }
        }

        // 向后端请求初始化弹框数据
        function fetchInitData() {
            console.log("I an fetchInitData function");
            $.ajax({
                url: '${pageContext.request.contextPath}/initBookForm',  // 后端接口，初始化表单数据
                method: 'GET',
                dataType: 'json' ,
                success: function (response) {
                    if (response.resultInfo.flag) {
                        // 假设后端返回的数据包含初始化的书籍信息
                        // $('#bookID').val(response.resultInfo.data.bookID);
                        // $('#title').val(response.resultInfo.data.title);
                        // $('#author').val(response.resultInfo.data.author);
                        // $('#publicationDate').val(response.publicationDate);
                        // console.log(response.flag);
                        // console.log(response.data);
                        // console.log(response.errorMessage);
                        // console.log(dataString)
                        $('#bookID').val(response.resultInfo.data.bookID);
                        $('#title').val(response.resultInfo.data.title);
                        $('#author').val(response.resultInfo.data.author);
                        $('#isbn').val(response.resultInfo.data.isbn);
                        $('#publicationDate').val(response.publicationDate);
                        $('#publisher').val(response.resultInfo.data.publisher);
                        $('#edition').val(response.resultInfo.data.edition);
                        $('#supplier').val(response.resultInfo.data.supplier);
                        $('#currencyID').val(response.resultInfo.data.currencyID);
                        $('#price').val(response.resultInfo.data.price);
                        $('#bookNum').val(response.resultInfo.data.bookNum);
                        $('#documentType').val(response.resultInfo.data.documentType);
                        if(response.resultInfo.data.categoryName){
                            var categoryIndex = response.categoryIndex;
                            $('#categoryName').prop('selectedIndex' , categoryIndex);
                            $('#categoryName').prop('disabled' , true);
                        }
                        else{
                            $('#categoryName').prop('selectedIndex' , 0);
                            $('#categoryName').prop('disabled' , false);
                        }

                         console.log(response.resultInfo.data.isbn);
                         console.log(response.publicationDate);
                        console.log(response.resultInfo.data.supplier);
                        // console.log(dataString)
                        // 显示弹框

                        $('#myModal').show();
                    } else {
                        alert(response.resultInfo.errorMsg);
                        $('#myModal').hide();
                    }
                    <%
                        System.out.println("success");
                    %>
                },
                error: function () {
                    alert('请求失败，请稍后重试');
                }
            });
        }
        // 确认按钮点击事件
        confirmButton.onclick = function () {
            console.log("I am confirmButton onclick");
            // 获取目录字段的值
            var categoryName = document.getElementById("categoryName").value;
            var isbn = document.getElementById("isbn").value;
            // 如果目录字段为空，则提醒用户并返回
            // if (document.getElementById("categoryName").value==null||document.getElementById("categoryName").value=='') {
            //     alert("目录不能为空！");
            //     return;
            // }
            // else{
                var formData = $('#bookForm').serialize();
                $.ajax({
                    url:'${pageContext.request.contextPath}/CatalogOneBook' ,
                    method :'GET',
                    data : formData,
                    dataType : 'json',
                    success : function (response) {

                        if(response.resultInfo.flag){

                            console.log(response.resultInfo.date);
                            var BianmuBookID=response.BianmuBookID;
                            alert("编目成功,图书编号为："+BianmuBookID);
                            location.reload(true);
                            // // 在点击时向后端请求相关数据
                            fetchNextData();  // 获取并展示现有数据

                        }
                        else{
                            alert(response.resultInfo.ErrorMsg);
                        }
                    }
                });
            // }
        }
        function fetchNextData() {
            console.log("I an fetchNextData function");
            $.ajax({
                url: '${pageContext.request.contextPath}/initBookForm',  // 后端接口，初始化表单数据
                method: 'GET',
                dataType: 'json' ,
                success: function (response) {
                    if (response.resultInfo.flag) {
                        // 假设后端返回的数据包含初始化的书籍信息

                        console.log(response.resultInfo.data);
                        $('#bookID').val(response.resultInfo.data.bookID);
                        $('#title').val(response.resultInfo.data.title);
                        $('#author').val(response.resultInfo.data.author);
                        $('#isbn').val(response.resultInfo.data.isbn);
                        $('#publicationDate').val(response.publicationDate);
                        $('#publisher').val(response.resultInfo.data.publisher);
                        $('#edition').val(response.resultInfo.data.edition);
                        $('#supplier').val(response.resultInfo.data.supplier);
                        $('#currencyID').val(response.resultInfo.data.currencyID);
                        $('#price').val(response.resultInfo.data.price);
                        $('#bookNum').val(response.resultInfo.data.bookNum);
                        $('#documentType').val(response.resultInfo.data.documentType);
                        if(response.resultInfo.data.categoryName){
                            var categoryIndex = response.categoryIndex;
                            $('#categoryName').prop('selectedIndex' , categoryIndex);
                            $('#categoryName').prop('disabled' , true);
                        }
                        else{
                            $('#categoryName').prop('selectedIndex' , 0);
                            $('#categoryName').prop('disabled' , false);
                        }



                        // 显示弹框

                        // $('#myModal').show();
                    } else {
                        alert(response.resultInfo.errorMsg);
                        $('#myModal').hide();
                    }
                    <%
                        System.out.println("success");
                    %>
                },
                error: function () {
                    alert('请求失败，请稍后重试');
                }
            });
        }


        // 关闭成功提示框
        closeSuccessModal.onclick = function () {
            successModal.style.display = "none";
        }
        // 关闭弹框
        $('.close').click(function() {
            $('#myModal').hide();
        });
    });

    // 获取并填充读者详细信息
    function fetchCataloglistDetails(ISBN)  {
        // 假设我们通过后端接口 `/lookBookForm` 获取数据
        $.ajax({
            url: '${pageContext.request.contextPath}/lookBookForm', // 你的后端接口
            method: 'GET',
            data: { ISBN: ISBN}, // 发送读者编号（或其他唯一标识符）到后端
            dataType: 'json',
            success: function(response) {
                if (response.resultInfo.flag) {
                    document.getElementById("bookID2").value = response.resultInfo.data.bookID;
                    document.getElementById("title2").value = response.resultInfo.data.title;
                    document.getElementById("author2").value = response.resultInfo.data.author;
                    document.getElementById("publicationDate2").value = response.publicationDate;
                    document.getElementById("edition2").value = response.resultInfo.data.edition;
                    document.getElementById("documentType2").value = response.resultInfo.data.documentType;
                    document.getElementById("bookNum2").value = response.resultInfo.data.bookNum;
                    document.getElementById("categoryName2").value = response.resultInfo.data.categoryName;
                    var catevalue = document.getElementById("categoryName2").value;
                    document.getElementById("isbn2").value = response.resultInfo.data.isbn;
                    document.getElementById("publisher2").value = response.resultInfo.data.publisher;
                    document.getElementById("supplier2").value = response.resultInfo.data.supplier;
                    document.getElementById("price2").value = response.resultInfo.data.price;

                    if(response.resultInfo.data.categoryName){
                        var categoryIndex = response.categoryIndex;
                        $('#categoryName2').prop('selectedIndex' , categoryIndex);
                        $('#categoryName2').prop('disabled' , false);
                    }
                    else{
                        $('#categoryName2').prop('selectedIndex' , 0);
                        $('#categoryName2').prop('disabled' , false);
                    }
                    // 显示弹框
                    // modal1.style.display = "block";
                    alert(response.resultInfo.errorMsg);
                } else {
                    alert(response.resultInfo.errorMsg);
                }
            },
            error: function(xhr, status, error) {
                alert("获取书目信息失败，错误代码: " + xhr.status + "\n" + xhr.statusText);
            }
        });
    }

    document.addEventListener("DOMContentLoaded", function() {
        // 获取模态框元素
        var submitForm2 = document.getElementById("submitForm2");

        // 提交表单2时验证
        confirmButton2.onclick = function () {

            // 弹出确认框
            var confirmSubmit = confirm("是否确定提交？");
            if (confirmSubmit) {

                var formData=$('#bookForm_edit2').serialize();

                // console.log("即将开始Ajax");
                // console.log(formData );
                // 使用 AJAX 发送数据到后端
                $.ajax({
                    url: '${pageContext.request.contextPath}/editBookForm',  // 后端接口，用于提交数据
                    method: 'POST',
                    data: formData,  // 发送的表单数据
                    dataType: 'json',  // 期待返回的数据格式
                    success: function(response) {
                        if (response.resultInfo.flag) {
                            var BianmuBookID=response.BianmuBookID;
                            alert("修改成功,图书编号为："+BianmuBookID);
                            $('#myModal').hide();  // 关闭弹窗
                            location.reload(true);  // 刷新页面，显示新数据
                        } else {
                            alert("提交失败，错误信息: " + response.resultInfo.errorMsg);
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

</script>

</body>
</html>

