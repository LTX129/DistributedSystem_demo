<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Product" %>
<%@ page import="model.ProductComment" %>
<%@ page import="java.util.List" %>

<%
    // 获取请求参数中的商品 ID
    String productIdStr = request.getParameter("id");

    // 如果没有通过 ProductServlet 加载数据，重定向到 ProductServlet 以加载数据
    if (request.getAttribute("product") == null) {
        if (productIdStr != null && !productIdStr.isEmpty()) {
            response.sendRedirect("ProductServlet?id=" + productIdStr);
            return; // 确保 JSP 不再继续执行
        } else {
            // 没有提供商品 ID，重定向到主页面
            response.sendRedirect("index.jsp");
            return; // 确保 JSP 不再继续执行
        }
    }

    Product product = (Product) request.getAttribute("product");
    List<ProductComment> comments = (List<ProductComment>) request.getAttribute("comments");
    model.User user = (model.User) session.getAttribute("user");  // 获取用户信息
    boolean isLoggedIn = (user != null);  // 检查用户是否已登录
%>

<!DOCTYPE html>
<html lang="en">
<head><head>
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

        .product {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
            text-align: center;
            transition: transform 0.3s;
            min-height: 400px;
            max-height: 400px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        .product:hover {
            transform: translateY(-10px);
        }
        .product img {
            max-width: 100%;
            max-height: 180px;
            margin-bottom: 10px;
            object-fit: cover;
        }
        .product h5 {
            font-size: 1.1rem;
            color: #333;
            margin-bottom: 5px;
            max-height: 40px;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }
        .product .description {
            font-size: 0.9rem;
            color: #666;
            margin-bottom: 15px;
            max-height: 50px;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }
        .product .btn {
            margin-top: auto;
        }
        .title-container {
            text-align: center;
            position: relative;
            margin-bottom: 30px;
        }
        .title-container h2 {
            font-size: 2.5rem;
            font-weight: bold;
            color: #e2231a;
            text-transform: uppercase;
            display: inline-block;
            position: relative;
            padding: 10px 30px;
            background: linear-gradient(90deg, #f8f9fa, #fff);
            border-radius: 8px;
        }
        .title-container h2::before,
        .title-container h2::after {
            content: '';
            position: absolute;
            height: 3px;
            width: 80px;
            background: linear-gradient(90deg, #e2231a, #c91a15);
            top: 50%;
            transform: translateY(-50%);
        }
        .title-container h2::before {
            left: -90px;
        }
        .title-container h2::after {
            right: -90px;
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
            <span style="color: #ffffff; font-weight: bold; margin-left: 10px;">G13 Shopping</span>
        </a>
    </div>
    <div class="d-flex align-items-center">
        <div class="search-bar me-3">
            <form id="searchForm" action="search.jsp" method="get" onsubmit="return checkLogin();">
                <input type="text" name="query" id="searchQuery" placeholder="Search for products" required>
                <button type="submit"><i class="fas fa-search"></i></button>
            </form>
        </div>
        <div class="category-buttons d-flex">
            <a href="category.jsp?category=Electronics" class="btn">Electronics</a>
            <a href="category.jsp?category=Fashion" class="btn">Fashion</a>
            <a href="category.jsp?category=Appliances" class="btn">Appliances</a>
            <a href="category.jsp?category=Books" class="btn">Books</a>
        </div>
    </div>
    <div class="d-flex align-items-center">
        <% if (isLoggedIn) { %>
        <span class="me-2">Hello, <%= user.getUsername() %>!</span>
        <a href="logout.jsp" class="btn-login">Logout</a>
        <% } else { %>
        <a href="login.jsp" class="btn-login">Login</a>
        <a href="register.jsp" class="btn-login">Register</a>
        <% } %>
    </div>
</header>

<div class="container">
    <h2 class="my-4 text-center">Product Details</h2>
    <div class="action-buttons d-flex justify-content-end">
        <a href="OrderServlet" class="btn btn-secondary me-2">All Orders</a>
        <a href="cart.jsp" class="btn btn-outline-success" onclick="return checkLoginForCart();">Cart</a>
    </div>
    <%
        if (product == null) {
    %>
    <p>Product not found. Please <a href="index.jsp">return to the main page</a> to continue shopping.</p>
    <%
            return;
        }
    %>

    <div class="card mb-4">
        <div class="row g-0">
            <div class="col-md-4">
                <img src="img/product_<%=product.getId()%>.jpeg">
            </div>
            <div class="col-md-8">
                <div class="card-body text-start">
                    <h5 class="card-title"><%= product.getName() %></h5>
                    <p class="card-text"><%= product.getDescription() %></p>
                    <p class="card-text"><strong>Price: $<%= product.getPrice() %></strong></p>
                    <form action="CartServlet" method="post">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="productId" value="<%= product.getId() %>">
                        <label for="quantity">Quantity:</label>
                        <input type="number" id="quantity" name="quantity" value="1" min="1">
                        <button type="submit" class="btn btn-primary mt-3">Add to Cart</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- 商品评论部分 -->
    <div class="card">
        <div class="card-body">
            <h4>Product Reviews</h4>
            <%
                if (comments != null && !comments.isEmpty()) {
                    for (ProductComment comment : comments) {
            %>
            <div class="comment mb-3">
                <p><strong>User ID <%= comment.getUserId() %>:</strong> <%= comment.getComment() %></p>
                <p>Rating: <%= comment.getRating() %> Stars</p>
                <p><small>Posted on: <%= comment.getCreatedAt() %></small></p>
            </div>
            <hr>
            <%
                }
            } else {
            %>
            <p>No reviews yet. Be the first to review this product!</p>
            <%
                }
            %>
        </div>
    </div>
</div>

<footer>
    <p>京东 © 2024 All Rights Reserved</p>
</footer>

<!-- 引入 Bootstrap JS 库 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function checkLogin() {
        alert("Please log in to use the search function.");
        window.location.href = "login.jsp";
        return false; // 阻止表单提交
    }
</script>

</body>
</html>
