<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Registration Successful</title>
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
    .success-container {
      text-align: center;
      background-color: white;
      padding: 40px;
      border-radius: 10px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
      max-width: 500px;
      width: 100%;
    }
    .success-container h1 {
      color: #28a745;
      font-size: 2.5em;
      margin-bottom: 20px;
    }
    .success-container p {
      font-size: 1.2em;
      color: #6c757d;
    }
  </style>
  <script>
    // 自动跳转到登录页面
    setTimeout(function() {
      window.location.href = 'login.jsp';
    }, 1500); // 1 秒后跳转
  </script>
</head>
<body>

<div class="success-container">
  <h1>Registration Successful!</h1>
  <p>You will be redirected to the login page shortly...</p>
</div>

</body>
</html>
