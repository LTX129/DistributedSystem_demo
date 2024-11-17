<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Order" %>
<%@ page import="model.OrderItem" %>
<%@ page import="model.User" %> <!-- 引入 User 类 -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Orders</title>
    <!-- 引入 Bootstrap CSS 和 FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
        }
        header {
            background-color: #e2231a;
            color: white;
            padding: 20px;
        }
        header .logo img {
            width: 50px;
        }
        header a {
            text-decoration: none;
            font-weight: bold;
        }
        header .btn-login {
            color: #fff;
            margin-left: 10px;
            font-size: 0.9rem;
            padding: 5px 10px;
            border-radius: 20px;
            background-color: #fff;
            color: #e2231a;
            text-decoration: none;
            transition: all 0.3s ease-in-out;
        }
        header .btn-login:hover {
            background-color: #c91a15;
            color: #fff;
        }
        .search-bar {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 100%;
            max-width: 600px;
            margin: 0 auto;
        }
        .search-bar input {
            flex: 1;
            border: 1px solid #ddd;
            border-right: none;
            padding: 10px;
            height: 40px;
            border-radius: 20px 0 0 20px;
        }
        .search-bar button {
            border-radius: 0 20px 20px 0;
            padding: 0 20px;
            height: 40px;
            border: none;
            background-color: #fff;
            color: #e2231a;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s ease-in-out, color 0.3s ease-in-out;
        }
        .search-bar button:hover {
            background-color: #f0f0f0;
            color: #c91a15;
        }
        .category-buttons .btn {
            font-size: 0.9rem;
            margin: 5px;
            font-weight: bold;
            color: #e2231a;
            background-color: #fff;
            border: 1px solid #e2231a;
            border-radius: 20px;
            transition: all 0.3s ease-in-out;
        }
        .category-buttons .btn:hover {
            background-color: #e2231a;
            color: #fff;
        }
        .container {
            margin: 40px auto;
            max-width: 1200px;
        }
        .title-container {
            text-align: center;
            position: relative;
            margin-bottom: 15px;
        }
        .title-container h2 {
            font-size: 2.5rem;
            font-weight: bold;
            color: #000;
            text-transform: uppercase;
            display: inline-block;
            position: relative;
            padding: 10px 30px;
            background: linear-gradient(90deg, #f8f9fa, #fff);
            border-radius: 8px;
        }
        .order-table {
            background-color: white;
            border-radius: 10px;
            padding: 20px;
        }
        .order-table th, .order-table td {
            text-align: center;
            padding: 15px;
        }
        footer {
            background: #333;
            color: white;
            padding: 20px;
            text-align: center;
            font-size: 0.875rem;
        }
    </style>
</head>
<body>
<header class="d-flex justify-content-between align-items-center">
    <div class="logo d-flex align-items-center">
        <a href="index.jsp" class="d-flex align-items-center">
            <img src="https://www.jd.com/favicon.ico" alt="logo">
            <span style="color: #ffffff; font-weight: bold; margin-left: 10px;">G3 Shopping</span>
        </a>
    </div>
    <div class="d-flex align-items-center">
        <div class="search-bar me-3">
            <form id="searchForm" action="search.jsp" method="get">
                <input type="text" name="query" id="searchQuery" placeholder="Search for orders" required>
                <button type="submit">
                    <i class="fas fa-search"></i>
                </button>
            </form>
        </div>
    </div>
    <div>
        <%
            User user = (User) session.getAttribute("user");
            if (user != null) {
        %>
        <span>Hello, <%= user.getUsername() %>!</span>
        <a href="logout.jsp" class="btn-login">Logout</a>
        <% } else { %>
        <a href="login.jsp" class="btn-login">Login</a>
        <a href="register.jsp" class="btn-login">Register</a>
        <% } %>
    </div>
</header>

<div class="category-bar d-flex justify-content-between align-items-center">
    <div class="title-container flex-grow-1 text-center">
        <h2>All Orders</h2>
    </div>
</div>

<div class="container">
    <div class="order-table">
        <%
            List<Order> orders = (List<Order>) request.getAttribute("orders");
            if (orders != null && !orders.isEmpty()) {
        %>
        <table class="table">
            <thead>
            <tr>
                <th>Order ID</th>
                <th>Order Date</th>
                <th>Product Name</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Shipping Address</th>
                <th>Payment Method</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                for (Order order : orders) {
                    for (OrderItem item : order.getItems()) {
            %>
            <tr>
                <td><%= order.getOrderId() %></td>
                <td><%= order.getOrderDate() %></td>
                <td><%= item.getProduct().getName() %></td>
                <td><%= item.getQuantity() %></td>
                <td>$<%= String.format("%.2f", item.getProduct().getPrice().doubleValue() * item.getQuantity()) %></td>
                <td><%= order.getShippingAddress() %></td>
                <td><%= order.getPaymentMethod() %></td>
                <td>
                    <a href="comment.jsp?productId=<%= item.getProduct().getId() %>&userId=<%= user.getId() %>" class="btn btn-primary">Leave a Review</a>
                </td>
            </tr>
            <%
                    }
                }
            %>
            </tbody>
        </table>
        <%
        } else {
        %>
        <p class="text-center">No orders found.</p>
        <%
            }
        %>
    </div>
</div>

<footer>
    <p>G3 Shopping © 2024 All Rights Reserved</p>
</footer>
</body>
</html>
