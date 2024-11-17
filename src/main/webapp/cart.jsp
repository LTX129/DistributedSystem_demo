<%@ page import="model.Cart" %>
<%@ page import="model.CartItem" %>
<%@ page import="model.User" %> <!-- 引入 User 类 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Shopping Cart</title>
    <!-- 引入 Bootstrap 和 FontAwesome -->
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
        header .search-bar {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 100%;
            max-width: 600px;
            margin: 0 auto;
        }
        .search-bar input {
            flex: 1;
            border-radius: 20px 0 0 20px;
            border: 1px solid #ddd;
            padding: 10px;
            height: 40px;
            box-sizing: border-box;
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
        footer {
            background-color: #333;
            color: white;
            padding: 10px 0;
            text-align: center;
            font-size: 0.875rem;
            margin-top: 40px;
        }
        .cart-table {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
        }
        .cart-table th, .cart-table td {
            text-align: center;
            padding: 15px;
        }
    </style>
</head>
<body>
<header class="d-flex justify-content-between align-items-center">
    <div class="logo">
        <a href="index.jsp">
            <img src="https://www.jd.com/favicon.ico" alt="logo">
            <span style="color: #ffffff; font-weight: bold; margin-left: 10px;">G3 Shopping</span>
        </a>
    </div>
    <div class="search-bar">
        <form id="searchForm" action="cart.jsp" method="get">
            <input type="text" name="searchQuery" placeholder="Search in cart..." required>
            <button type="submit">
                <i class="fas fa-search"></i>
            </button>
        </form>
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

<div class="container">
    <h2 class="text-center my-4">Your Shopping Cart</h2>
    <%
        Cart cart = (Cart) session.getAttribute("cart");
        String searchQuery = request.getParameter("searchQuery");
        double totalPrice = 0.0;

        if (cart != null && !cart.getItems().isEmpty()) {
            java.util.List<CartItem> cartItems = cart.getItems();

            if (searchQuery != null && !searchQuery.isEmpty()) {
                cartItems = cartItems.stream()
                        .filter(item -> item.getProduct().getName().toLowerCase().contains(searchQuery.toLowerCase()))
                        .collect(java.util.stream.Collectors.toList());
            }
    %>
    <div class="cart-table">
        <table class="table">
            <thead>
            <tr>
                <th>Product Image</th>
                <th>Product Name</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Total</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                for (CartItem item : cartItems) {
                    double itemTotal = item.getProduct().getPrice().doubleValue() * item.getQuantity();
                    totalPrice += itemTotal;
            %>
            <tr>
                <td><img src="img/product_<%= item.getProduct().getId() %>.jpeg" alt="<%= item.getProduct().getName() %>" style="width: 80px;"></td>
                <td><%= item.getProduct().getName() %></td>
                <td>$<%= String.format("%.2f", item.getProduct().getPrice()) %></td>
                <td><%= item.getQuantity() %></td>
                <td>$<%= String.format("%.2f", itemTotal) %></td>
                <td>
                    <a href="CartServlet?action=remove&productId=<%= item.getProduct().getId() %>" class="btn btn-danger">Remove</a>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <div class="text-end">
            <strong>Total Price: $<%= String.format("%.2f", totalPrice) %></strong>
        </div>
    </div>
    <div class="text-end mt-3">
        <a href="order_confirmation.jsp" class="btn btn-success">Proceed to Checkout</a>
        <a href="index.jsp" class="btn btn-secondary">Continue Shopping</a>
    </div>
    <% } else { %>
    <div class="empty-cart text-center">
        <p>Your cart is empty. <a href="index.jsp">Continue Shopping</a></p>
    </div>
    <% } %>
</div>

<footer>
    <p>G3 Shopping © 2024 All Rights Reserved</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
