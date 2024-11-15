<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Collections" %>
<%@ page import="model.Product, model.ProductDAO" %>
<%
    model.User user = (model.User) session.getAttribute("user");  // 获取用户信息
    boolean isLoggedIn = (user != null);  // 检查用户是否已登录
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Shopping Platform</title>
    <!-- 引入 FontAwesome 图标库 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <!-- 引入 Bootstrap CSS 库 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        header {
            background-color: #e2231a;
            color: white;
            padding: 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        header .logo {
            display: flex;
            align-items: center;
            font-size: 1.5em;
            font-weight: bold;
        }
        header .logo img {
            width: 50px;
            margin-right: 10px;
        }
        header .logo a {
            color: white;
            text-decoration: none;
        }
        header .search-bar {
            width: 40%;
            display: flex;
            align-items: center;
        }
        header .search-bar input {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 4px 0 0 4px;
        }
        header .search-bar button {
            padding: 10px;
            background-color: white;
            color: #e2231a;
            border: none;
            border-radius: 0 4px 4px 0;
        }
        nav {
            background-color: #f5f5f5;
            padding: 10px;
        }
        nav ul {
            list-style: none;
            display: flex;
            justify-content: center;
            padding: 0;
            margin: 0;
        }
        nav ul li {
            margin: 0 15px;
        }
        nav ul li a {
            text-decoration: none;
            color: #333;
            font-weight: bold;
        }
        nav ul li a:hover {
            color: #e2231a;
        }
        .product-grid {
            margin: 20px 0;
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }
        .product {
            background-color: #fff;
            padding: 20px;
            text-align: center;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            flex: 1;
            max-width: 300px;
        }
        .product img {
            width: 100%;
            height: auto;
            margin-bottom: 10px;
        }
        .product h5 {
            font-size: 1.2em;
            color: #333;
        }
        footer {
            background-color: #333;
            color: #fff;
            padding: 20px;
            text-align: center;
            margin-top: 20px;
        }
        .button-group {
            margin-bottom: 20px;
        }
        .button-group .btn {
            margin-right: 10px;
        }
    </style>
</head>
<body>

<header>
    <div class="logo">
        <a href="index.jsp">
            <img src="https://www.jd.com/favicon.ico" alt="logo"> 京东
        </a>
    </div>
    <div class="search-bar">
        <form id="searchForm" action="search.jsp" method="get" onsubmit="return checkLogin()">
            <input type="text" name="query" id="searchQuery" placeholder="Search for products" required>
            <button type="submit" id="searchButton"><i class="fas fa-search"></i></button>
        </form>
    </div>
    <div>
        <%
            if (isLoggedIn) {  // 如果用户已登录
        %>
        <span class="text-white">Hello, <%= user.getUsername() %>!</span>
        <a href="logout.jsp" class="text-white">Logout</a>
        <%
        } else {  // 如果用户未登录
        %>
        <a href="login.jsp" class="text-white">Login</a> / <a href="register.jsp" class="text-white">Register</a>
        <%
            }
        %>
    </div>
</header>

<nav>
    <ul>
        <li><a href="category.jsp?category=Electronics">Electronics</a></li>
        <li><a href="category.jsp?category=Fashion">Fashion</a></li>
        <li><a href="category.jsp?category=Appliances">Appliances</a></li>
        <li><a href="category.jsp?category=Books">Books</a></li>
    </ul>
</nav>

<div class="container">
    <!-- 添加“All Orders”和“Cart”按钮 -->
    <div class="button-group text-center">
        <a href="OrderServlet" class="btn btn-secondary">All Orders</a>
        <a href="cart.jsp" class="btn btn-outline-success" onclick="return checkLoginForCart();">Cart</a>
    </div>

    <h2 class="my-4 text-center">All Products</h2>
    <div class="product-grid">
        <%
            // 获取所有产品并随机排列
            ProductDAO productDAO = new ProductDAO();
            List<Product> products = null;  // 获取所有产品
            try {
                products = productDAO.getAllProducts();
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
            if (products != null && !products.isEmpty()) {
                // 随机打乱产品列表
                Collections.shuffle(products);

                for (Product product : products) {
        %>
        <div class="product">
            <img src="https://via.placeholder.com/150" alt="<%= product.getName() %>">
            <h5><%= product.getName() %></h5>
            <p><%= product.getDescription() %></p>
            <p><strong>Price: $<%= product.getPrice() %></strong></p>
            <%
                if (isLoggedIn) {
            %>
            <a href="product.jsp?id=<%= product.getId() %>" class="btn btn-primary">View Details</a>
            <%
            } else {
            %>
            <a href="login.jsp" class="btn btn-primary">View Details</a>
            <%
                }
            %>
        </div>
        <%
            }
        } else {
        %>
        <p>No products available at the moment. Please check back later.</p>
        <%
            }
        %>
    </div>
</div>

<footer>
    <p>京东 © 2024 All Rights Reserved</p>
</footer>

<!-- 引入 Bootstrap JS 库 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function checkLogin() {
        const isLoggedIn = <%= isLoggedIn %>;  // 获取用户登录状态
        if (!isLoggedIn) {
            alert("Please log in to use the search function.");
            window.location.href = "login.jsp";
            return false; // 阻止表单提交
        }
        return true;
    }

    function checkLoginForCart() {
        const isLoggedIn = <%= isLoggedIn %>;  // 获取用户登录状态
        if (!isLoggedIn) {
            alert("Please log in to view your cart.");
            window.location.href = "login.jsp";
            return false; // 阻止导航到cart页面
        }
        return true;
    }
</script>

</body>
</html>
