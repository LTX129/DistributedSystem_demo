<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String username = org.apache.commons.text.StringEscapeUtils.escapeHtml4(request.getParameter("username")); %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Online Shopping Platform</title>
    <!-- 引入 Bootstrap CSS 库 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .register-container {
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            width: 100%;
        }
        .register-container h2 {
            text-align: center;
            color: #e2231a;
            margin-bottom: 30px;
        }
        .form-label {
            font-weight: bold;
        }
        .form-control:focus {
            border-color: #e2231a;
            box-shadow: 0 0 5px rgba(226, 35, 26, 0.5);
        }
        .btn-register {
            background-color: #e2231a;
            color: white;
            border: none;
        }
        .btn-register:hover {
            background-color: #d11c12;
        }
        .form-text {
            color: #6c757d;
        }
        .error {
            border-color: #dc3545 !important;
            box-shadow: 0 0 5px rgba(220, 53, 69, 0.5) !important;
        }
        .error-message {
            color: #dc3545;
            font-size: 0.9em;
            margin-top: 0.25em;
        }
    </style>
</head>
<body>

<div class="register-container">
    <h2>Register</h2>
    <form id="registerForm" action="UserServlet" method="post">
        <!-- 用户名输入框 -->
        <div class="mb-3">
            <label for="username" class="form-label">Username</label>
            <input type="text" class="form-control" id="username" name="username" required maxlength="20" minlength="4">
            <div class="form-text">Username must be 4-20 characters long and contain no special symbols.</div>
            <div class="error-message" id="usernameError"></div>
        </div>

        <!-- 密码输入框 -->
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" id="password" name="password" required minlength="8">
            <div class="form-text">Password should be at least 8 characters, with a mix of letters and numbers.</div>
            <div class="error-message" id="passwordError"></div>
        </div>

        <!-- 邮箱输入框 -->
        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" class="form-control" id="email" name="email" required maxlength="50">
            <div class="form-text">Please enter a valid email address, e.g., example@mail.com.</div>
            <div class="error-message" id="emailError"></div>
        </div>

        <!-- 隐藏的动作字段 -->
        <input type="hidden" name="action" value="register">

        <!-- 注册按钮 -->
        <button type="submit" class="btn btn-register w-100">Register</button>
    </form>
</div>

<!-- 引入 Bootstrap JS 库 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jsencrypt/bin/jsencrypt.min.js"></script>
<script>
    // 加密密码的函数
    async function encryptPassword() {
        // 获取公钥
        const response = await fetch('/demo_war/api/users/publicKey');
        const publicKeyBase64 = await response.text();

        // 初始化 JSEncrypt 对象
        const encrypt = new JSEncrypt();
        encrypt.setPublicKey('-----BEGIN PUBLIC KEY-----\n' + publicKeyBase64 + '\n-----END PUBLIC KEY-----');

        // 获取密码并加密
        const password = document.getElementById('password').value;
        const encryptedPassword = encrypt.encrypt(password);

        if (encryptedPassword) {
            // 将加密后的密码设置到表单中，并提交
            document.getElementById('password').value = encryptedPassword;
            document.getElementById('registerForm').submit();
        } else {
            alert("密码加密失败");
        }
    }

    // 在提交表单前加密密码
    document.getElementById('registerForm').addEventListener('submit', function(event) {
        event.preventDefault();
        encryptPassword();
    });
</script>

</body>
</html>
