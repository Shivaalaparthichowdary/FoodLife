<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List" %>
        <%@ page import="java.util.Map" %>
            <%@ page import="model.Order" %>
                <%@ page import="model.OrderItem" %>
                    <%@ page import="model.User" %>
                        <% User loggedInUser=(User) session.getAttribute("loggedInUser"); if (loggedInUser==null) {
                            response.sendRedirect("login.jsp"); return; } List<Order> orders = (List<Order>)
                                request.getAttribute("orders");
                                Map<Integer, List<OrderItem>> orderItemsMap = (Map<Integer, List<OrderItem>>)
                                        request.getAttribute("orderItemsMap");
                                        %>
                                        <!DOCTYPE html>
                                        <html lang="en">

                                        <head>
                                            <meta charset="UTF-8">
                                            <title>Order History - FoodLife</title>
                                            <link
                                                href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
                                                rel="stylesheet">
                                            <link rel="stylesheet" href="css/style.css">
                                            <style>
                                                .order-card {
                                                    background: var(--surface);
                                                    border-radius: var(--radius);
                                                    box-shadow: var(--shadow);
                                                    padding: 1.5rem;
                                                    margin-bottom: 2rem;
                                                    transition: transform 0.3s;
                                                }

                                                .order-card:hover {
                                                    transform: translateY(-3px);
                                                    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.06);
                                                }

                                                .order-header {
                                                    display: flex;
                                                    justify-content: space-between;
                                                    align-items: center;
                                                    border-bottom: 1px solid var(--border);
                                                    padding-bottom: 1rem;
                                                    margin-bottom: 1rem;
                                                }

                                                .order-status {
                                                    padding: 0.3rem 0.8rem;
                                                    border-radius: 20px;
                                                    font-size: 0.9rem;
                                                    font-weight: 600;
                                                }

                                                .status-pending {
                                                    background: #FEF3C7;
                                                    color: #D97706;
                                                }

                                                .status-delivered {
                                                    background: #D1FAE5;
                                                    color: #059669;
                                                }

                                                .order-items-list {
                                                    list-style: none;
                                                    padding: 0;
                                                    margin: 0 0 1rem 0;
                                                }

                                                .order-items-list li {
                                                    display: flex;
                                                    justify-content: space-between;
                                                    margin-bottom: 0.6rem;
                                                    color: var(--text-dark);
                                                    font-size: 1.05rem;
                                                }

                                                .order-total {
                                                    text-align: right;
                                                    font-size: 1.2rem;
                                                    font-weight: 700;
                                                    color: var(--primary);
                                                    border-top: 1px dashed var(--border);
                                                    padding-top: 1rem;
                                                }
                                            </style>
                                        </head>

                                        <body>
                                            <nav class="navbar">
                                                <a href="restaurants" class="navbar-brand">FoodLife</a>
                                                <ul class="navbar-nav">
                                                    <li><a href="cart.jsp" class="nav-link">Cart</a></li>
                                                    <li><a href="logout" class="btn btn-outline"
                                                            style="padding: 0.4rem 1rem;">Logout</a></li>
                                                </ul>
                                            </nav>

                                            <div class="grid-container" style="max-width: 800px;">
                                                <h1 class="section-title">Your Order History</h1>

                                                <% if (orders==null || orders.isEmpty()) { %>
                                                    <div
                                                        style="text-align: center; padding: 4rem 2rem; color: var(--text-light); background: var(--surface); border-radius: var(--radius);">
                                                        <h2 style="margin-bottom: 1rem;">You haven't placed any orders
                                                            yet.</h2>
                                                        <a href="restaurants" class="btn btn-primary">Let's find some
                                                            food</a>
                                                    </div>
                                                    <% } else { %>
                                                        <% for (Order order : orders) { String
                                                            statusClass="status-pending" ; if
                                                            ("Delivered".equalsIgnoreCase(order.getStatus())) {
                                                            statusClass="status-delivered" ; } %>
                                                            <div class="order-card">
                                                                <div class="order-header">
                                                                    <div>
                                                                        <h3 style="margin-bottom: 0.2rem;">
                                                                            <%= order.getRestaurantName() %>
                                                                        </h3>
                                                                        <span
                                                                            style="color: var(--text-light); font-size: 0.9rem;">Order
                                                                            ID: #<%= order.getOrderId() %></span>
                                                                    </div>
                                                                    <span class="order-status <%= statusClass %>">
                                                                        <%= order.getStatus() %>
                                                                    </span>
                                                                </div>

                                                                <ul class="order-items-list">
                                                                    <% List<OrderItem> items =
                                                                        orderItemsMap.get(order.getOrderId());
                                                                        if (items != null) {
                                                                        for (OrderItem item : items) {
                                                                        %>
                                                                        <li>
                                                                            <span><span
                                                                                    style="color: var(--text-light); margin-right: 0.5rem;">
                                                                                    <%= item.getQuantity() %>x
                                                                                </span>
                                                                                <%= item.getItemName() %>
                                                                            </span>
                                                                            <span style="font-weight: 500;">₹<%=
                                                                                    String.format("%.2f",
                                                                                    item.getPrice() *
                                                                                    item.getQuantity()) %></span>
                                                                        </li>
                                                                        <% } } %>
                                                                </ul>

                                                                <div class="order-total">
                                                                    Total Amount: ₹<%= String.format("%.2f",
                                                                        order.getTotalAmount()) %>
                                                                </div>
                                                            </div>
                                                            <% } %>
                                                                <% } %>
                                            </div>
                                        </body>

                                        </html>