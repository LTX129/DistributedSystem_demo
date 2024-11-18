<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String username = org.apache.commons.text.StringEscapeUtils.escapeHtml4(request.getParameter("username")); %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login - Online Shopping Platform</title>
  <!-- Bootstrap CSS -->
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
  <!-- Login Form -->
  <div class="login-form">
    <h3>Password Login</h3>
    <form action="UserServlet" method="post" id="loginForm">
      <input type="hidden" name="action" value="login">
      <label for="username">Username/Email</label>
      <input type="text" id="username" name="username" placeholder="Enter your username or email" required>

      <label for="password">Password</label>
      <input type="password" id="password" name="password" placeholder="Enter your password" required>

      <input type="submit" value="Login">
    </form>

    <!-- Login Status Message -->
    <p class="text-center text-danger">${message}</p>

    <!-- Login Options -->
    <div class="login-options">
      <a href="forgot_password.jsp">Forgot Password?</a>
      <a href="register.jsp">Register Now</a>
    </div>
  </div>

  <!-- QR Code Login -->
  <div class="qr-login">
    <h3>Scan QR Code for Secure Login</h3>
    <img src="https://via.placeholder.com/180" alt="QR Code">
    <p>Open <a href="#">G3 Shopping App</a> and scan the QR code</p>
  </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jsencrypt/bin/jsencrypt.min.js"></script>
<script>
  // Get public key and encrypt password
  async function encryptPassword() {
    // Get public key
    const response = await fetch('/demo_war/api/users/publicKey');
    const publicKeyBase64 = await response.text();
    console.log(publicKeyBase64);
    // Initialize JSEncrypt object
    const encrypt = new JSEncrypt();
    encrypt.setPublicKey('-----BEGIN PUBLIC KEY-----\n' + publicKeyBase64 + '\n-----END PUBLIC KEY-----');

    // Get password and encrypt it
    const password = document.getElementById('password').value;
    const encryptedPassword = encrypt.encrypt(password);

    if (encryptedPassword) {
      // Set encrypted password to form and submit
      document.getElementById('password').value = encryptedPassword;
      document.getElementById('loginForm').submit();
    } else {
      alert("Password encryption failed");
    }
  }

  // Encrypt password before form submission
  document.getElementById('loginForm').addEventListener('submit', function(event) {
    event.preventDefault();
    encryptPassword();
  });
</script>

</body>
</html>
