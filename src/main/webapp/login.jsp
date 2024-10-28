<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String username = org.apache.commons.text.StringEscapeUtils.escapeHtml4(request.getParameter("username")); %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login - Online Shopping Platform</title>
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
    .login-container {
      display: flex;
      background-color: white;
      border-radius: 10px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
      width: 900px;
      height: 500px;
    }
    .login-form {
      flex: 1;
      padding: 40px;
      border-right: 1px solid #e0e0e0;
    }
    .login-form h3 {
      color: #e2231a;
      text-align: center;
      margin-bottom: 20px;
    }
    .login-form input[type="text"],
    .login-form input[type="password"] {
      width: 100%;
      padding: 10px;
      margin-bottom: 15px;
      border: 1px solid #ddd;
      border-radius: 5px;
      font-size: 14px;
    }
    .login-form input[type="submit"] {
      width: 100%;
      padding: 10px;
      background-color: #e2231a;
      color: white;
      border: none;
      border-radius: 5px;
      font-size: 16px;
      cursor: pointer;
    }
    .login-form input[type="submit"]:hover {
      background-color: #d11c12;
    }
    .login-form .login-options {
      display: flex;
      justify-content: space-between;
      margin-top: 10px;
    }
    .login-form .login-options a {
      color: #666;
      font-size: 12px;
      text-decoration: none;
    }
    .login-form .login-options a:hover {
      text-decoration: underline;
    }
    .qr-login {
      flex: 1;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
    }
    .qr-login img {
      width: 180px;
      height: 180px;
    }
    .qr-login p {
      text-align: center;
      color: #666;
      margin-top: 10px;
    }
    .qr-login p a {
      color: #e2231a;
      text-decoration: none;
    }
    .qr-login p a:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>

<div class="login-container">
  <!-- 登录表单 -->
  <div class="login-form">
    <h3>密码登录</h3>
    <form action="UserServlet" method="post">
      <input type="hidden" name="action" value="login">
      <label for="username">账号名/邮箱</label>
      <input type="text" id="username" name="username" placeholder="请输入账号名或邮箱" required>

      <label for="password">密码</label>
      <input type="password" id="password" name="password" placeholder="请输入密码" required>

      <input type="submit" value="登录">
    </form>

    <!-- 登录状态提示 -->
    <p class="text-center text-danger">${message}</p>

    <!-- 登录选项 -->
    <div class="login-options">
      <a href="#">忘记密码</a>
      <a href="register.jsp">立即注册</a>
    </div>
  </div>

  <!-- 二维码登录 -->
  <div class="qr-login">
    <h3>手机扫码安全登录</h3>
    <img src="https://via.placeholder.com/180" alt="QR Code">
    <p>打开 <a href="#">手机京东</a> 扫描二维码</p>
  </div>
</div>

<!-- 引入 Bootstrap JS 库 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
