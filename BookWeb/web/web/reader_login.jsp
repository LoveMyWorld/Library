<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>读者登录</title>
    <style>
        /* 简单的CSS样式，用于美化登录框 */
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
        .login-box {
            width: 300px; /* 保持登录框宽度 */
            height: auto; /* 自动高度，根据内容调整 */
            margin: 100px auto; /* 往下放，靠近中部 */
            padding: 20px;
            border: 1px solid #015999; /* 使用主色调作为边框颜色 */
            border-radius: 5px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2); /* 增加阴影效果 */
            background-color: #F0F8FF; /* 浅蓝色背景，与主色调协调 */
        }
        .login-box h2 {
            text-align: center;
            margin-bottom: 20px; /* 增加与表单的间距 */
            color: #015999; /* 使用主色调 */
        }
        .login-box input[type="text"], .login-box input[type="password"] {
            width: calc(100% - 20px); /* 减去内边距，实现居中 */
            padding: 10px;
            margin: 0 auto 20px; /* 顶部和底部外边距，自动左右外边距，实现居中 */
            display: block; /* 使元素为块级元素，以便使用自动外边距居中 */
            border: 1px solid #015999; /* 使用主色调 */
            border-radius: 3px;
        }
        .login-box input[type="submit"] {
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
        .login-box input[type="submit"]:hover {
            background-color: #0c66ab; /* 深蓝色，悬停效果 */
        }
        .login-box input[type="checkbox"] {
            margin-top: 10px; /* 减少与提交按钮的间距 */
            margin-right: 5px; /* 增加与文本的间距 */
        }
        .login-box label {
            font-size: 14px; /* 调整字体大小 */
            color: #333; /* 调整字体颜色 */
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
    <div>冠军小队图书馆</div>
</div>

<div id="loginBox" class="login-box">
    <h2>欢迎登录</h2>
    <form id="loginForm" action="${pageContext.request.contextPath}/ReaderLoginServlet" method="post">
        <input type="text" name="username" placeholder="账号" required>
        <input type="password" name="password" placeholder="密码" required>
        <div>
            <input type="checkbox" name="remember" id="remember"> 我已阅读并同意《隐私政策》
        </div>
        <input type="submit" value="登录">
        <!-- JSP代码块用于输出错误信息 -->
        <%
            String login_ret = (String) request.getAttribute("login_ret");
            if(login_ret != null && !login_ret.isEmpty()){
                out.print("<div class='error'> " + login_ret + "</div>");
            }
        %>
    </form>
</div>

<script>
    document.getElementById('loginForm').onsubmit = function(event) {
        var rememberCheckbox = document.getElementById('remember');
        if (!rememberCheckbox.checked) {
            alert('请勾选隐私政策');
            event.preventDefault(); // 阻止表单提交
            return false;
        }
    };
</script>

</body>
</html>