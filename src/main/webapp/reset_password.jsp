<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="model.User, DAO.UserDAO" %>
<%
    String email = request.getParameter("email");
    if (email == null || email.isEmpty()) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password</title>
    <!-- 引入 Bootstrap CSS 库 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .reset-container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 40px;
            width: 400px;
        }
        .reset-container h3 {
            color: #e2231a;
            text-align: center;
            margin-bottom: 20px;
        }
        .reset-container input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        .reset-container input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #e2231a;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }
        .reset-container input[type="submit"]:hover {
            background-color: #d11c12;
        }
        .error-message {
            color: #dc3545;
            font-size: 0.9em;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="reset-container">
    <h3>Reset Password</h3>
    <form id="resetForm" action="UserServlet" method="post">
        <input type="hidden" name="action" value="resetPassword">
        <input type="hidden" name="email" value="<%= email %>">

        <label for="newPassword">New Password</label>
        <input type="password" id="newPassword" name="newPassword" placeholder="Enter new password" required>

        <label for="confirmPassword">Confirm Password</label>
        <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm new password" required>

        <input type="submit" value="Reset Password">
    </form>

    <!-- 提示信息 -->
    <p class="error-message" id="error-message"></p>

    <!-- 重置状态提示 -->
    <p class="text-center text-danger"><%= request.getAttribute("message") != null ? request.getAttribute("message") : "" %></p>
</div>

<!-- 引入 Bootstrap JS 库 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jsencrypt/bin/jsencrypt.min.js"></script>

<script>
    // 提交表单前的验证和加密操作
    document.getElementById('resetForm').addEventListener('submit', function(event) {
        event.preventDefault(); // 阻止表单的默认提交行为

        const newPassword = document.getElementById('newPassword').value;
        const confirmPassword = document.getElementById('confirmPassword').value;

        // 密码匹配检查
        if (newPassword !== confirmPassword) {
            document.getElementById('error-message').textContent = "Passwords do not match!";
            return;
        } else {
            document.getElementById('error-message').textContent = ""; // 清空错误信息
        }

        // 获取公钥进行加密
        encryptPassword(newPassword);
    });

    // 使用公钥加密密码
    async function encryptPassword(password) {
        // 获取公钥
        const response = await fetch('/demo_war/api/users/publicKey');
        const publicKeyBase64 = await response.text();

        // 初始化 JSEncrypt 对象
        const encrypt = new JSEncrypt();
        encrypt.setPublicKey('-----BEGIN PUBLIC KEY-----\n' + publicKeyBase64 + '\n-----END PUBLIC KEY-----');

        // 加密密码
        const encryptedPassword = encrypt.encrypt(password);

        if (encryptedPassword) {
            // 将加密后的密码填入表单中并提交
            document.getElementById('newPassword').value = encryptedPassword;
            document.getElementById('confirmPassword').value = encryptedPassword;
            document.getElementById('resetForm').submit();
        } else {
            alert("Password encryption failed.");
        }
    }
</script>

</body>
</html>
