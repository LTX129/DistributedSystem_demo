<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Product, DAO.ProductDAO" %>

<%
  model.User user = (model.User) session.getAttribute("user");  // 获取用户信息
  boolean isLoggedIn = (user != null);  // 检查用户是否已登录
  String query = request.getParameter("query");  // 获取搜索关键词

  if (query == null || query.isEmpty()) {
    // 如果搜索关键词为空，重定向到主页
    response.sendRedirect("index.jsp");
    return;
  }
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

<div class="category-bar my-3 d-flex justify-content-between align-items-center">
  <div class="title-container text-center flex-grow-1">
    <h2>Search Results for "<%= query %>"</h2>
  </div>
  <div class="action-buttons d-flex justify-content-end">
    <a href="OrderServlet" class="btn btn-secondary me-2">All Orders</a>
    <a href="cart.jsp" class="btn btn-outline-success" onclick="return checkLoginForCart();">Cart</a>
  </div>
</div>

<div class="container my-4">
  <div class="row">
    <%
      // 使用 ProductDAO 根据搜索关键词进行模糊匹配查找产品
      ProductDAO productDAO = new ProductDAO();
      List<Product> products = productDAO.searchProducts(query);  // 模糊匹配搜索产品

      if (products != null && !products.isEmpty()) {
        for (Product product : products) {
    %>

    <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
      <div class="product bg-white p-3 rounded shadow-sm h-100 d-flex flex-column justify-content-between">
        <img src="img/product_<%= product.getId() %>.jpeg" class="img-fluid mb-3" alt="<%= product.getName() %>">
        <h5 class="text-dark"><%= product.getName() %></h5>
        <p class="description text-muted"><%= product.getDescription() %></p>
        <p class="fw-bold">Price: $<%= product.getPrice() %></p>
        <a href="<%= isLoggedIn ? "product.jsp?id=" + product.getId() : "login.jsp" %>" class="btn btn-primary mt-3">View Details</a>
      </div>
    </div>


    <%
      }
    } else {
    %>
    <p>No products found for "<%= query %>". Please try another search term.</p>
    <%
      }
    %>
  </div>
</div>

<footer>
  <p>京东 © 2024 All Rights Reserved</p>
</footer>

<button class="back-to-top" onclick="window.scrollTo({ top: 0, behavior: 'smooth' });">
  <i class="fas fa-chevron-up"></i>
</button>

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

  window.addEventListener('scroll', function() {
    const backToTopButton = document.querySelector('.back-to-top');
    if (window.scrollY > 300) {
      backToTopButton.style.display = 'block';
    } else {
      backToTopButton.style.display = 'none';
    }
  });
</script>

</body>
</html>
