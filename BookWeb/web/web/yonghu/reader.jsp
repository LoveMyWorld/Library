<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Dao.ReaderDao" %>
<%@ page import="Entity.Reader" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
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
            background-color: #015999;
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
            padding: 280px 0;
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
            background-color: #015999;
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
            border: 1px solid #015999;
            background-color: white;
            /*padding: 15px;*/
            padding: 0px 0px 10px 0px;
            width: 100%;
            margin-left: 1%; /* 边框微微露出 */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            position: relative;
        }
        .header {
            background-color: #015999;
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

        /* 自定义弹窗样式 */
        .modal-dialog {
            max-width: 800px;
        }

        .modal-header {
            background-color: #007bff;
            color: #fff;
        }

        .modal-body {
            font-size: 16px;
        }

        .modal-footer {
            justify-content: center;
        }

        .modal-title {
            font-size: 1.5rem;
        }

        .form-group label {
            font-weight: bold;
        }

        .tooltip {
            display: none;
            position: absolute;
            top: 100%;  /* 紧贴图标下方 */
            left: 50%;
            transform: translateX(-50%);  /* 水平居中 */
            background-color: rgba(0, 0, 0, 0.75);
            color: #fff;
            padding: 5px;
            border-radius: 3px;
            z-index: 10;  /* 确保提示信息在其他元素之上 */
            white-space: nowrap;
        }

        .icon-container:hover .tooltip {
            display: block;
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
            读者信息维护列表
        </div>
        <div class="toolbar">
            <div class="tools">
                <button>
                    <img src="${pageContext.request.contextPath}/image/add-icon.png" alt="添加">
                    <div class="tooltip">添加</div>
                </button>
                <button>
                    <img src="${pageContext.request.contextPath}/image/edit-icon.png" alt="编辑">
                    <div class="tooltip">编辑</div>
                </button>
                <button>
                    <img src="${pageContext.request.contextPath}/image/delete-icon.png" alt="删除">
                    <div class="tooltip">删除</div>
                </button>
                <button>
                    <img src="${pageContext.request.contextPath}/image/refresh-icon.png" alt="刷新">
                    <div class="tooltip">刷新</div>
                </button>
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
                <form action="${pageContext.request.contextPath}/ReaderServlet" method="get">
                    <select name="searchField">
                        <option value="readID">读者编号</option>
                        <option value="name">姓名</option>
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
                <th>序号</th>
                <th>读者编号</th>
                <th>姓名</th>
                <th>性别</th>
                <th>电话号码</th>
                <th>读者级别</th>
            </tr>
            </thead>
            <tbody>
            <%
                int currentPage = request.getAttribute("currentPage")==null?1:(int) request.getAttribute("currentPage");
                int totalPages = request.getAttribute("totalPage")==null?1:(int) request.getAttribute("totalPage");
                List<Reader> readerList= (List<Reader>) request.getAttribute("readerList");
                int count = 1; // 初始化计数器
                if (readerList != null) { // 判断数据是否为空
                    for (Reader reader : readerList) {
            %>
            <tr >
                <td><%= count++ %></td>
                <td><%= reader.getReadID() %></td>
                <td><%= reader.getName() %></td>
                <td><%= reader.getGender() %></td>
                <td><%= reader.getPhoneNum() %></td>
                <td><%= reader.getReaderLevel() %></td>

            </tr>
            <%
                    }
                }
            %>

            </tbody>
        </table>



<%--        <!-- 弹窗 -->--%>
<%--        <div id="popup" class="modal" style="display: none;">--%>
<%--            <div id="popup-content"></div>--%>
<%--            <button id="close-popup">关闭</button>--%>
<%--        </div>--%>

<%--        <script>--%>
<%--            // 获取表格的所有行--%>
<%--            const rows = document.querySelectorAll("tbody tr");--%>

<%--            // 为每一行绑定双击事件--%>
<%--            rows.forEach(row => {--%>
<%--                row.addEventListener("dblclick", function () {--%>
<%--                    // 获取当前行的所有单元格数据--%>
<%--                    const cells = row.querySelectorAll("td");--%>
<%--                    const rowData = Array.from(cells).map(cell => cell.textContent);--%>

<%--                    // 需要显示的字段--%>
<%--                    const fields = [--%>
<%--                        { label: "读者编号", value: rowData[0] },  // 假设第0列是读者编号--%>
<%--                        { label: "姓名", value: rowData[1] },  // 假设第1列是姓名--%>
<%--                        { label: "性别", value: rowData[2] },  // 假设第2列是性别--%>
<%--                        { label: "出生日期", value: rowData[3] },  // 假设第3列是出生日期--%>
<%--                        { label: "单位", value: rowData[4] },  // 假设第4列是单位--%>
<%--                        { label: "家庭地址", value: rowData[5] },  // 假设第5列是地址--%>
<%--                        { label: "电话号码", value: rowData[6] },  // 假设第6列是电话号码--%>
<%--                        { label: "电子邮箱", value: rowData[7] },  // 假设第7列是电子邮箱--%>
<%--                        { label: "读者级别名称", value: rowData[8] },  // 假设第8列是读者级别名称--%>
<%--                        { label: "信用分", value: rowData[9] }  // 假设第9列是信用分--%>
<%--                    ];--%>

<%--                    // 获取弹窗内容容器--%>
<%--                    const popupContent = document.getElementById("popup-content");--%>
<%--                    popupContent.innerHTML = "";  // 清空之前的内容--%>

<%--                    // 动态添加字段和输入框--%>
<%--                    fields.forEach(field => {--%>
<%--                        const fieldContainer = document.createElement("div");--%>
<%--                        fieldContainer.classList.add("form-group");--%>

<%--                        const label = document.createElement("label");--%>
<%--                        label.textContent = field.label + ":";--%>
<%--                        label.setAttribute("for", field.label);  // 设置for属性关联到输入框--%>

<%--                        const input = document.createElement("input");--%>
<%--                        input.type = "text";--%>
<%--                        input.id = field.label;--%>
<%--                        input.value = field.value;--%>
<%--                        input.setAttribute("readonly", true); // 设置为只读，避免用户修改内容--%>

<%--                        fieldContainer.appendChild(label);--%>
<%--                        fieldContainer.appendChild(input);--%>
<%--                        popupContent.appendChild(fieldContainer);--%>
<%--                    });--%>

<%--                    // 显示弹窗--%>
<%--                    const popup = document.getElementById("popup");--%>
<%--                    popup.style.display = "block";--%>
<%--                });--%>
<%--            });--%>

<%--            // 关闭弹窗--%>
<%--            document.getElementById("close-popup").addEventListener("click", function () {--%>
<%--                document.getElementById("popup").style.display = "none";--%>
<%--            });--%>
<%--        </script>--%>


        <div class="pagination">
            <div class="pagination">
                <!-- 上一页 -->
                <button onclick="location.href='${pageContext.request.contextPath}/ReaderServlet?currentPage=<%= currentPage - 1 %>'">&laquo; 上一页</button>
                <!-- 当前页信息 -->
                <span>第 <%= currentPage %> / <%= totalPages %> 页，每页显示 16 条</span>
                <!-- 下一页 -->
                <button onclick="location.href='${pageContext.request.contextPath}/ReaderServlet?currentPage=<%= currentPage + 1 %>'">下一页 &raquo;</button>
            </div>

        </div>
    </div>
</div>
</body>
</html>