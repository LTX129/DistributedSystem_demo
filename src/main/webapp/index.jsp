<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Collections" %>
<%@ page import="model.Product, DAO.ProductDAO" %>
<%@ page import="DAO.ImgDAO" %>
<%@ page import="java.util.Base64" %>

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
            max-width: 600px;
            width: 100%;
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
        footer {
            background: #333;
            color: white;
            padding: 20px;
            text-align: center;
            font-size: 0.875rem;
        }
        #backToTop {
            display: none;
            position: fixed;
            bottom: 40px;
            right: 40px;
            background-color: #e2231a;
            color: white;
            border: none;
            border-radius: 50%;
            width: 50px;
            height: 50px;
            font-size: 1.5rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
            cursor: pointer;
            transition: opacity 0.3s, transform 0.3s;
        }
        #backToTop:hover {
            background-color: #c91a15;
            transform: scale(1.1);
        }
        .product {
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        .product img {
            max-height: 200px;
            object-fit: cover;
        }
        .action-buttons .btn {
            font-size: 1rem; /* 调整字体大小 */
            border-radius: 20px; /* 圆角按钮 */
            white-space: nowrap; /* 防止按钮内文字换行 */
            text-transform: uppercase; /* 将文字转换为大写（可选） */
        }
        .action-buttons .btn:hover {
            opacity: 0.9; /* 鼠标悬停时的效果 */
        }
    </style>
</head>
<body>
<header class="d-flex justify-content-between align-items-center">
    <div class="logo d-flex align-items-center">

        <%
            ImgDAO imgDAO = new ImgDAO();
            byte[] logoBytes = imgDAO.getLogoById(1); // 加载 id 为 1 的 logo 数据
            String base64Image = "";

            if (logoBytes != null) {
                // 将 BLOB 数据转换为 Base64 编码
                base64Image = Base64.getEncoder().encodeToString(logoBytes);
            }
        %>

        <a href="index.jsp" class="d-flex align-items-center">
            <img src="data:image/png;base64,<%= base64Image %>" alt="logo" style="width: 150px; height: auto;">
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
    <div class="d-flex align-items-center justify-content-between">
        <div class="action-buttons d-flex">
            <a href="OrderServlet" class="btn btn-primary me-2 px-4 py-2">All Orders</a>
            <a href="cart.jsp" class="btn btn-success px-4 py-2" onclick="return checkLoginForCart();">Cart</a>
        </div>
        <div class="ms-5"> <!-- 添加额外的左边距 -->
            <% if (isLoggedIn) { %>
            <span class="me-2">Hello, <%= user.getUsername() %>!</span>
            <a href="logout.jsp" class="btn-login">Logout</a>
            <% } else { %>
            <a href="login.jsp" class="btn-login">Login</a>
            <a href="register.jsp" class="btn-login">Register</a>
            <% } %>
        </div>
    </div>

</header>

<div class="category-bar my-3 d-flex justify-content-between align-items-center">
    <div class="title-container text-center flex-grow-1">
        <h2><strong style="font-size: 2.5rem; color: #e2231a;">All Products</strong></h2>
    </div>
</div>

<div class="container my-4">
    <div class="row">
        <%
            ProductDAO productDAO = new ProductDAO();
            List<Product> products = null;
            try {
                products = productDAO.getAllProducts();
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
            if (products != null && !products.isEmpty()) {
                Collections.shuffle(products);
                for (Product product : products) {
        %>
        <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
            <div class="product bg-white p-3 rounded shadow-sm h-100 d-flex flex-column justify-content-between">
                <img src="img/product_<%= product.getId() %>.jpeg" class="img-fluid mb-3" alt="<%= product.getName() %>">
                <h5 class="text-dark"><%= product.getName() %></h5>
                <p class="description text-muted"><%= product.getDescription() %></p>
                <p class="fw-bold">Price: $<%= product.getPrice() %></p>
                <div class="d-flex align-items-center justify-content-between mt-3">
                    <!-- View Details 按钮 -->
                    <a href="<%= isLoggedIn ? "product.jsp?id=" + product.getId() : "login.jsp" %>" class="btn btn-primary flex-grow-1 me-3">View Details</a>

                    <!-- 一键加入购物车按钮 -->
                    <form action="<%= isLoggedIn ? "CartServlet" : "login.jsp" %>" method="post" class="d-inline-block">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="productId" value="<%= product.getId() %>">
                        <input type="hidden" name="quantity" value="1"> <!-- 默认数量为 1 -->
                        <button type="submit" class="btn btn-danger btn-sm" style="padding: 0.5rem; border-radius: 50%;">
                            <i class="fas fa-shopping-cart"></i>
                        </button>
                    </form>
                </div>
            </div>
        </div>
        <%
            }
        } else {
        %>
        <p class="text-center">No products available at the moment. Please check back later.</p>
        <%
            }
        %>
    </div>
</div>

<footer>
    <p>G3 Shopping © 2024 All Rights Reserved</p>
</footer>

<!-- 返回顶部按钮 -->
<button id="backToTop" title="Back to Top"><i class="fas fa-arrow-up"></i></button>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const backToTopButton = document.getElementById("backToTop");

    window.onscroll = function() {
        if (document.body.scrollTop > 200 || document.documentElement.scrollTop > 200) {
            backToTopButton.style.display = "block";
        } else {
            backToTopButton.style.display = "none";
        }
    };

    backToTopButton.onclick = function() {
        window.scrollTo({ top: 0, behavior: 'smooth' });
    };

    function checkLogin() {
        if (!<%= isLoggedIn %>) {
            alert("Please log in to use the search function.");
            window.location.href = "login.jsp";
            return false;
        }
        return true;
    }

    function checkLoginForCart() {
        if (!<%= isLoggedIn %>) {
            alert("Please log in to view your cart.");
            window.location.href = "login.jsp";
            return false;
        }
        return true;
    }
</script>
</body>
</html>
