<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <title>读者注册</title>
    <style>
        /* 简单的CSS样式，用于美化注册框 */
        .header {
            font-family: '楷体', sans-serif;
            background-color: #015999; /* 蓝色背景 */
            color: white;
            padding: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .header div {
            margin: 0 10px;
        }
        .register-box {
            width: 350px; /* 保持注册框宽度 */
            height: auto; /* 自动高度，根据内容调整 */
            margin: 100px auto; /* 往下放，靠近中部 */
            padding: 20px;
            border: 1px solid #015999; /* 使用主色调作为边框颜色 */
            border-radius: 5px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2); /* 增加阴影效果 */
            background-color: #F0F8FF; /* 浅蓝色背景，与主色调协调 */
        }
        .register-box h2 {
            text-align: center;
            margin-bottom: 20px; /* 增加与表单的间距 */
            color: #015999; /* 使用主色调 */
        }
        .register-box input[type="text"], .register-box input[type="password"] {
            width: calc(100% - 20px); /* 减去内边距，实现居中 */
            padding: 10px;
            margin: 0 auto 20px; /* 顶部和底部外边距，自动左右外边距，实现居中 */
            display: block; /* 使元素为块级元素，以便使用自动外边距居中 */
            border: 1px solid #015999; /* 使用主色调 */
            border-radius: 3px;
        }
        .register-box input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #015999; /* 使用主色调 */
            color: white;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            margin-top: 10px; /* 减少与密码框的间距 */
            font-size: 16px; /* 增加字体大小 */
            font-weight: bold; /* 加粗字体 */
        }
        .register-box input[type="submit"]:hover {
            background-color: #0c66ab; /* 深蓝色，悬停效果 */
        }
        .register-box label {
            font-size: 14px; /* 调整字体大小 */
            color: #333; /* 调整字体颜色 */
        }

        form div {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }

        form label {
            width: 70px;
            text-align: right;
            margin-right: 10px;
            font-weight: bold;
        }

        form input, form select {
            flex: 1;
            padding: 5px 10px;
            height: 35px; /* 设置统一高度 */
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box; /* 确保内边距不会影响高度 */
        }

        form span {
            margin-left: 10px;
            color: red;
        }

        form input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        form input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .error {
            color: red;
            text-align: center;
            margin-top: 10px; /* 增加与表单的间距 */
        }

    </style>
</head>
<body>
<div class="header">
    <div>小赫图书馆</div>
</div>

<div id="registerBox" class="register-box">
    <h2>欢迎注册</h2>
    <form id="registerForm" action="register2.jsp" method="get" >
        <div>
            <label for="name">姓名</label>
            <input type="text" id="name" name="name"><span style="color: red;">*</span>
        </div>

        <div>
            <label for="gender">性别</label>
            <select id="gender" name="gender">
                <option value="女">女</option>
                <option value="男">男</option>
            </select><span style="color: red;">*</span>
        </div>

        <div>
            <label for="birthDay">出生日期</label>
            <input type="date" id="birthDay" name="birthDay"><span style="color: red;">*</span>
        </div>

        <div>
            <label for="unit">单位</label>
            <input type="text" id="unit" name="unit"><span style="color: red;">*</span>
        </div>

        <div>
            <label for="homeAdd">家庭地址</label>
            <input type="text" id="homeAdd" name="homeAdd"><span style="color: red;">*</span>
        </div>

        <div>
            <label for="phoneNum">电话号码</label>
            <input type="text" id="phoneNum" name="phoneNum"><span style="color: red;">*</span>
        </div>

        <div>
            <label for="emailAdd">电子邮箱</label>
            <input type="email" id="emailAdd" name="emailAdd">
        </div>
        <input type="submit" value="注册">

    </form>
</div>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
%>

<script>
    document.getElementById('registerForm').onsubmit = function(event) {
        event.preventDefault(); // 阻止表单默认提交行为
        // 提交表单时验证
            var name = document.getElementById("name").value;
            var unit = document.getElementById("unit").value;
            var homeAdd = document.getElementById("homeAdd").value;
            var phoneNum = document.getElementById("phoneNum").value;
            var emailAdd = document.getElementById("emailAdd").value;
            var birthDay = document.getElementById("birthDay").value;

            // 检查必填项
            if (!name || !unit || !homeAdd || !phoneNum ||!birthDay) {
                alert("所有必填项不能为空！");
                return;
            }

            // 验证姓名（不能超过20个字符）
            if (name.length > 20) {
                alert("姓名不能超过20个字符！");
                return;
            }

            // 验证单位和家庭地址（不能超过100个字符）
            if (unit.length > 100) {
                alert("单位不能超过100个字符！");
                return;
            }
            if (homeAdd.length > 100) {
                alert("家庭地址不能超过100个字符！");
                return;
            }

            // 验证电话号码（必须为11位且以1开头）
            if (!/^1\d{10}$/.test(phoneNum)) {
                alert("电话号码必须是11位且以1开头！");
                return;
            }

            // 验证邮箱格式
            if (emailAdd && !/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(emailAdd)) {
                alert("电子邮箱格式不正确！");
                return;
            }

            // **出生日期验证**：出生日期不能大于等于今天
            var today = new Date();
            var birthDate = new Date(birthDay);
            if (birthDate >= today) {
                alert("出生日期不能大于等于今天！");
                return;
            }
            // 弹出确认框
            var confirmSubmit = confirm("是否确定注册？");
            if (confirmSubmit) {

                var formData=$('#registerForm').serialize();
                var extraData = {
                    readID: '<%= username %>',
                    readerLevel: '中级读者',
                    creditPoint:'60'
                };
                var extraDataStr = $.param(extraData);
                formData += '&' + extraDataStr;

                var formData2={
                    username: '<%= username %>',
                    userpwd:'<%= password %>'
                };
                // console.log("即将开始Ajax");
                // console.log(formData );
                // 使用 AJAX 发送数据到后端
                $.ajax({
                    url: '${pageContext.request.contextPath}/AddReaderServlet',  // 后端接口，用于提交数据
                    method: 'POST',
                    data: formData,  // 发送的表单数据
                    dataType: 'json',  // 期待返回的数据格式
                    success: function(response) {
                        if (response.resultInfo.flag) {
                            alert("注册成功！");

                            $.ajax({
                                url: '${pageContext.request.contextPath}/AddUserServlet', // 第二个后端接口
                                method: 'POST',
                                data: formData2,
                                dataType: 'json',
                                success: function(response2) {
                                    if (response2.resultInfo.flag) {
                                        // alert("第二步操作成功！");
                                        // 跳转到登录页面
                                        $('#myModal').hide();  // 关闭弹窗
                                        window.location.href = "reader_login.jsp";
                                    } else {
                                        alert("第二步操作失败，错误信息: " + response2.resultInfo.message);
                                    }
                                },
                                error: function(xhr, status, error) {
                                    alert("第二步操作失败，错误代码: " + xhr.status + "\n" + xhr.statusText);
                                }
                            });




                            // location.reload(true);  // 刷新页面，显示新数据
                        } else {
                            alert("注册失败，错误信息: " + response.resultInfo.message);
                        }
                    },
                    error: function(xhr, status, error) {
                        alert("注册失败，错误代码: " + xhr.status + "\n" + xhr.statusText);
                    }
                });

            } else {
                // 如果用户点击"否"，则不提交
                alert("注册已取消！");
            }
    };
</script>

</body>
</html>