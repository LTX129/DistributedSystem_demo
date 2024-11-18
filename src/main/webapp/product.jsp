<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Product" %>
<%@ page import="model.ProductComment" %>
<%@ page import="java.util.List" %>

<%
    String productIdStr = request.getParameter("id");

    if (request.getAttribute("product") == null) {
        if (productIdStr != null && !productIdStr.isEmpty()) {
            response.sendRedirect("ProductServlet?id=" + productIdStr);
            return;
        } else {
            response.sendRedirect("index.jsp");
            return;
        }
    }

    Product product = (Product) request.getAttribute("product");
    List<ProductComment> comments = (List<ProductComment>) request.getAttribute("comments");
    model.User user = (model.User) session.getAttribute("user");
    boolean isLoggedIn = (user != null);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Shopping Platform</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
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
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
            text-align: center;
        }
        .product img {
            max-width: 100%;
            max-height: 300px;
            margin-bottom: 20px;
            object-fit: cover;
        }
        .form-control {
            border-radius: 5px;
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
                <img src="img/product_<%= product.getId() %>.jpeg" class="img-fluid" alt="<%= product.getName() %>">
            </div>
            <div class="col-md-8">
                <div class="card-body">
                    <h5 class="card-title"><%= product.getName() %></h5>
                    <p class="card-text"><%= product.getDescription() %></p>
                    <p class="card-text"><strong>Price: $<%= product.getPrice() %></strong></p>
                    <!-- 表单部分 -->
                    <form action="CartServlet" method="post" class="d-flex align-items-center mt-3">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="productId" value="<%= product.getId() %>">
                        <label for="quantity" class="me-2">Quantity:</label>
                        <input type="number" id="quantity" name="quantity" value="1" min="1" class="form-control me-3" style="width: 100px;">
                        <button type="submit" class="btn btn-primary">Add to Cart</button>
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

<button id="backToTop" title="Back to Top"><i class="fas fa-arrow-up"></i></button>
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
</script>

<footer class="text-center mt-4">
    <p>G3 Shopping © 2024 All Rights Reserved</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
