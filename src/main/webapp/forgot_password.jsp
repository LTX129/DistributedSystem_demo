<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password - Online Shopping Platform</title>
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
        .forgot-password-container {
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            width: 400px;
        }
        .forgot-password-container h3 {
            color: #e2231a;
            text-align: center;
            margin-bottom: 20px;
        }
        .forgot-password-container input[type="email"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        .forgot-password-container input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #e2231a;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }
        .forgot-password-container input[type="submit"]:hover {
            background-color: #d11c12;
        }
    </style>
</head>
<body>

<div class="forgot-password-container">
    <h3>Forgot Password</h3>
    <form action="UserServlet" method="post">
        <input type="hidden" name="action" value="forgotPassword">
        <label for="email">Enter your registered email address</label>
        <input type="email" id="email" name="email" placeholder="Enter your registered email" required>
        <input type="submit" value="Send Reset Link">
    </form>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
