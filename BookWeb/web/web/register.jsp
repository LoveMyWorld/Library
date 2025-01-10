<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
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
            width: 300px; /* 保持注册框宽度 */
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
    <form id="registerForm" action="${pageContext.request.contextPath}/RegisterServlet" method="post" action="${pageContext.request.contextPath}/register2.jsp" method="post">
        <input type="text" name="username" placeholder="账号" required>
        <input type="password" id="password" name="password" placeholder="密码" required>
        <div id="passwordStrength" style="margin-bottom: 10px; font-size: 14px;"></div>
        <input type="password" name="confirm_password" placeholder="确认密码" required>
        <input type="submit" value="下一步">
        <!-- JSP代码块用于输出错误信息 -->
        <%
            String register_ret = (String) request.getAttribute("register_ret");
            if(register_ret != null && !register_ret.isEmpty()){
                out.print("<div class='error'> " + register_ret + "</div>");
            }
        %>
    </form>
</div>

<script>
    document.getElementById('registerForm').onsubmit = function(event) {
        // 可以在这里添加额外的客户端验证逻辑，例如检查密码和确认密码是否一致
        var password = document.getElementById("registerForm").password.value;
        var confirmPassword = document.getElementById("registerForm").confirm_password.value;
        if (password !== confirmPassword) {
            alert('密码和确认密码不一致');
            event.preventDefault(); // 阻止表单提交
            return false;
        }
    };

    // 密码强度检测逻辑
    document.getElementById('password').addEventListener('input', function () {
        var password = this.value;
        var strength = checkPasswordStrength(password);
        var strengthText = document.getElementById('passwordStrength');

        if (password.length === 0) {
            strengthText.innerHTML = '';
            return;
        }

        switch (strength) {
            case 'weak':
                strengthText.style.color = 'red';
                strengthText.innerHTML = '密码强度：弱';
                break;
            case 'medium':
                strengthText.style.color = 'orange';
                strengthText.innerHTML = '密码强度：中';
                break;
            case 'strong':
                strengthText.style.color = 'green';
                strengthText.innerHTML = '密码强度：强';
                break;
        }
    });

    // 密码强度检测函数
    function checkPasswordStrength(password) {
        var strength = 'weak';
        if (password.length >= 6 && /[a-zA-Z]/.test(password) && /\d/.test(password)) {
            strength = 'medium';
        }
        if (password.length >= 8 && /[a-zA-Z]/.test(password) && /\d/.test(password) && /[^a-zA-Z\d]/.test(password)) {
            strength = 'strong';
        }
        return strength;
    }
</script>

</body>
</html>