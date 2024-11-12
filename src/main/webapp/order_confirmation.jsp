<%@ page import="model.Cart" %>
<%@ page import="model.CartItem" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Order Confirmation</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f5f5f5;
      font-family: Arial, sans-serif;
    }
    .container {
      margin-top: 50px;
    }
    .order-header, .order-summary, .payment-method {
      background-color: white;
      padding: 20px;
      border-radius: 10px;
      margin-bottom: 20px;
    }
    .order-header h2 {
      color: #e2231a;
    }
    .btn-confirm-order {
      background-color: #28a745;
      color: white;
      font-size: 16px;
      padding: 10px 20px;
      border-radius: 5px;
    }
    .btn-confirm-order:hover {
      background-color: #218838;
    }
  </style>
</head>
<body>

<div class="container">
  <div class="order-header">
    <h2>Order Confirmation</h2>
  </div>

  <%
    // 获取购物车对象（从 session 中获取）
    Cart cart = (Cart) session.getAttribute("cart");
    double totalPrice = 0.0;

    if (cart != null && !cart.getItems().isEmpty()) {
      java.util.List<CartItem> cartItems = cart.getItems();
  %>

  <form action="CheckoutServlet" method="post">
    <div class="order-summary">
      <h4>Order Summary</h4>
      <table class="table">
        <thead>
        <tr>
          <th>Product</th>
          <th>Price</th>
          <th>Quantity</th>
          <th>Total</th>
        </tr>
        </thead>
        <tbody>
        <%
          for (CartItem item : cartItems) {
            double itemTotal = item.getProduct().getPrice().doubleValue() * item.getQuantity();
            totalPrice += itemTotal;
        %>
        <tr>
          <td><%= item.getProduct().getName() %></td>
          <td>$<%= String.format("%.2f", item.getProduct().getPrice()) %></td>
          <td><%= item.getQuantity() %></td>
          <td>$<%= String.format("%.2f", itemTotal) %></td>
        </tr>
        <%
          }
        %>
        </tbody>
      </table>
      <div class="total-price">
        <strong>Total Price: $<%= String.format("%.2f", totalPrice) %></strong>
      </div>
    </div>

    <div class="payment-method">
      <h4>Payment Method</h4>
      <div class="form-group">
        <label for="payment-method">Select a payment method:</label>
        <select id="payment-method" name="paymentMethod" class="form-control" required>
          <option value="credit-card" selected>Credit Card</option>
          <option value="paypal">PayPal</option>
          <option value="cash-on-delivery">Cash on Delivery</option>
        </select>
      </div>
    </div>

    <div class="form-group mt-3">
      <label for="shipping-address">Shipping Address:</label>
      <textarea id="shipping-address" name="shippingAddress" class="form-control" rows="3" required></textarea>
    </div>

    <button type="submit" class="btn btn-confirm-order mt-3">Confirm Order</button>
  </form>

  <%
  } else {
  %>
  <div class="empty-cart">
    <p>Your cart is empty.</p>
    <a href="index.jsp" class="btn btn-secondary">Continue Shopping</a>
  </div>
  <%
    }
  %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
