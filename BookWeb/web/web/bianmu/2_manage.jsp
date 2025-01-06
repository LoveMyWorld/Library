<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>冠军小队编目系统</title>
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
    </style>
</head>
<body>
<div class="sidebar">
    <div>
        <h3>冠军小队</h3>
        <a  onclick="location.href='${pageContext.request.contextPath}/CatalogMServlet'">编目管理</a>
        <a  onclick="location.href='${pageContext.request.contextPath}/YanshouServlet'">验收清单</a>
        <a  onclick="location.href='${pageContext.request.contextPath}/damageServlet'">报损</a>
    </div>

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
        冠军小队编目系统
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
                <select>
                    <option value="isbn">ISBN</option>
                    <option value="title">书名</option>
                    <option value="author">作者</option>
                    <option value="classification">分类号</option>
                </select>
                <input type="text" placeholder="请输入查询内容">
                <button>搜索</button>
            </div>
        </div>
        <table>
            <thead>
            <tr>
                <th>序号</th>
                <th>正题名</th>
                <th>ISBN</th>
                <th>副题名</th>
                <th>从编题名</th>
                <th>编著者</th>
                <th>分类号</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>1</td>
                <td>销售如何说...</td>
                <td>9787545606681</td>
                <td></td>
                <td></td>
                <td>陆汝香</td>
                <td>F713.3</td>
            </tr>
            <tr>
                <td>2</td>
                <td>蔡康永的说...</td>
                <td>9787544143158</td>
                <td></td>
                <td></td>
                <td>蔡康永</td>
                <td>H019-49</td>
            </tr>
            </tbody>
        </table>
        <div class="pagination">
            <button>&laquo; 上一页</button>
            <span>第 1/2 页，每页显示 55 条</span>
            <button>下一页 &raquo;</button>
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



<script>
    document.addEventListener("DOMContentLoaded", function() {
        // 获取模态框元素
        var modal = document.getElementById("myModal");
        var addButton = document.getElementById("addButton");
        var closeModal = document.getElementById("closeModal");
        var confirmButton = document.getElementById("confirmButton");
        var successModal = document.getElementById("successModal");
        var closeSuccessModal = document.getElementById("closeSuccessModal");


        // 打开模态框
        addButton.onclick = function () {
            modal.style.display = "block";
            // 在点击时向后端请求相关数据
            fetchInitData();  // 获取并展示现有数据
        }

        // 关闭模态框
        closeModal.onclick = function () {
            modal.style.display = "none";
        }

        // 点击模态框外部关闭模态框
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
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
                        $('#categoryName').val(response.resultInfo.data.categoryName);
                         console.log(response.resultInfo.data.isbn);
                         console.log(response.publicationDate);
                        console.log(response.resultInfo.data.supplier);
                        // console.log(dataString)
                        // 显示弹框

                        $('#myModal').show();
                    } else {
                        alert('初始化数据失败');
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
            if (document.getElementById("categoryName").value==null||document.getElementById("categoryName").value=='') {
                alert("目录不能为空！");
                return;
            }
            else{
                // // 弹出成功提示框
                // successModal.style.display = "block";
                //
                // // 提交表单（普通提交，跳转到后端处理URL）
                // document.getElementById("bookForm").submit();
                //
                // // 在点击时向后端请求相关数据
                // fetchNextData();  // 获取并展示现有数据
                // alert("编目成功！");
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
                            // // 在点击时向后端请求相关数据
                            // fetchNextData();  // 获取并展示现有数据
                            fetchNextData();
                        }
                        else{
                            alert(response.resultInfo.ErrorMsg);
                        }
                    }
                });



            }



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
                        $('#categoryName').val(response.resultInfo.data.categoryName);


                        // 显示弹框

                        // $('#myModal').show();
                    } else {
                        alert('初始化数据失败');
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
</script>

</body>
</html>

