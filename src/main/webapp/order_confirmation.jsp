<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="model.Order" %>
        <% Order order=(Order) request.getAttribute("order"); if (order==null) { response.sendRedirect("restaurants");
            return; } %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <title>Order Confirmation - FoodLife</title>
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
                    rel="stylesheet">
                <link rel="stylesheet" href="css/style.css">
            </head>

            <body style="background: var(--surface);">
                <nav class="navbar">
                    <a href="restaurants" class="navbar-brand">FoodLife</a>
                </nav>

                <div
                    style="display: flex; flex-direction: column; align-items: center; justify-content: center; min-height: 70vh; text-align: center; padding: 2rem;">
                    <div
                        style="background: #D1FAE5; color: #047857; width: 80px; height: 80px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 2.5rem; margin-bottom: 1.5rem;">
                        ✓
                    </div>
                    <h1 style="font-size: 2.5rem; color: var(--text-dark); margin-bottom: 1rem;">Order Placed
                        Successfully!</h1>
                    <p style="font-size: 1.2rem; color: var(--text-light); margin-bottom: 2rem;">
                        Your order <strong>#<%= order.getOrderId() %></strong> has been placed.<br>
                        Total Amount: <strong>₹<%= String.format("%.2f", order.getTotalAmount()) %></strong>
                    </p>
                    <div style="display: flex; gap: 1rem;">
                        <a href="orderHistory" class="btn btn-outline">Track Order</a>
                        <a href="restaurants" class="btn btn-primary">Back to Home</a>
                    </div>
                </div>
            </body>

            </html>