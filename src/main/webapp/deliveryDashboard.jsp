<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="model.User" %>
        <% User loggedInUser=(User) session.getAttribute("loggedInUser"); if (loggedInUser==null ||
            !"deliveryboy".equalsIgnoreCase(loggedInUser.getRole())) {
            response.sendRedirect("login.jsp?error=Unauthorized access"); return; } %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Delivery Dashboard - FoodLife</title>
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap"
                    rel="stylesheet">
                <link rel="stylesheet" href="css/style.css">
                <style>
                    .dashboard-container {
                        max-width: 1200px;
                        margin: 2rem auto;
                        padding: 0 1rem;
                    }

                    .dashboard-header {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        margin-bottom: 2rem;
                    }

                    .dashboard-cards {
                        display: grid;
                        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                        gap: 1.5rem;
                    }

                    .card {
                        background: white;
                        border-radius: 8px;
                        padding: 1.5rem;
                        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                    }
                </style>
            </head>

            <body>
                <nav class="navbar">
                    <a href="#" class="navbar-brand">FoodLife Delivery</a>
                    <ul class="navbar-nav">
                        <li><span style="color: white; margin-right: 15px;">Welcome, <%= loggedInUser.getName() %>
                            </span></li>
                        <li><a href="logout" class="btn btn-outline">Logout</a></li>
                    </ul>
                </nav>

                <div class="dashboard-container">
                    <div class="dashboard-header">
                        <h2>Delivery Tasks</h2>
                    </div>

                    <%@ page import="java.util.List" %>
                        <%@ page import="model.Order" %>
                            <% List<Order> assignedOrders = (List<Order>) request.getAttribute("assignedOrders");
                                    String successMsg = request.getParameter("success");
                                    String errorMsg = request.getParameter("error");
                                    %>

                                    <% if (successMsg !=null) { %>
                                        <div class="alert alert-success" style="margin-bottom: 2rem;">
                                            <%= successMsg %>
                                        </div>
                                        <% } %>
                                            <% if (errorMsg !=null) { %>
                                                <div class="alert alert-error" style="margin-bottom: 2rem;">
                                                    <%= errorMsg %>
                                                </div>
                                                <% } %>

                                                    <div class="card" style="margin-bottom: 20px;">
                                                        <h3>My Active Deliveries</h3>
                                                        <p>Orders that are currently assigned to you for delivery.</p>

                                                        <% if (assignedOrders !=null && !assignedOrders.isEmpty()) { %>
                                                            <table
                                                                style="width: 100%; border-collapse: collapse; margin-top: 20px;">
                                                                <thead>
                                                                    <tr
                                                                        style="background-color: #f8f9fa; border-bottom: 2px solid #dee2e6;">
                                                                        <th style="padding: 12px; text-align: left;">
                                                                            Order ID</th>
                                                                        <th style="padding: 12px; text-align: left;">
                                                                            Restaurant</th>
                                                                        <th style="padding: 12px; text-align: left;">
                                                                            Amount</th>
                                                                        <th style="padding: 12px; text-align: left;">
                                                                            Payment</th>
                                                                        <th style="padding: 12px; text-align: left;">
                                                                            Status</th>
                                                                        <th style="padding: 12px; text-align: left;">
                                                                            Action</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <% for (Order o : assignedOrders) { %>
                                                                        <tr style="border-bottom: 1px solid #dee2e6;">
                                                                            <td style="padding: 12px;">#<%=
                                                                                    o.getOrderId() %>
                                                                            </td>
                                                                            <td style="padding: 12px;">
                                                                                <%= o.getRestaurantName() %>
                                                                            </td>
                                                                            <td style="padding: 12px;">$<%=
                                                                                    o.getTotalAmount() %>
                                                                            </td>
                                                                            <td style="padding: 12px;">
                                                                                <%= o.getModeOfPayment() %>
                                                                            </td>
                                                                            <td style="padding: 12px;">
                                                                                <span style="padding: 4px 8px; border-radius: 4px; font-size: 0.85rem; font-weight: 500; 
                                                <%= " Delivered".equals(o.getDeliveryStatus())
                                                                                    ? "background-color: #d1e7dd; color: #0f5132;"
                                                                                    : "background-color: #fff3cd; color: #856404;"
                                                                                    %>">
                                                                                    <%= o.getDeliveryStatus() %>
                                                                                </span>
                                                                            </td>
                                                                            <td style="padding: 12px;">
                                                                                <% if
                                                                                    (!"Delivered".equals(o.getDeliveryStatus()))
                                                                                    { %>
                                                                                    <form action="updateDeliveryStatus"
                                                                                        method="post"
                                                                                        style="display:inline;">
                                                                                        <input type="hidden"
                                                                                            name="orderId"
                                                                                            value="<%= o.getOrderId() %>">
                                                                                        <input type="hidden"
                                                                                            name="status"
                                                                                            value="Delivered">
                                                                                        <button type="submit"
                                                                                            class="btn btn-primary"
                                                                                            style="padding: 6px 12px; background-color: #198754;">Mark
                                                                                            Delivered</button>
                                                                                    </form>
                                                                                    <% } else { %>
                                                                                        <span
                                                                                            style="color: #6c757d; font-size: 0.9em;">Completed</span>
                                                                                        <% } %>
                                                                            </td>
                                                                        </tr>
                                                                        <% } %>
                                                                </tbody>
                                                            </table>
                                                            <% } else { %>
                                                                <p style="margin-top: 20px; color: #666;">You currently
                                                                    have no assigned deliveries.</p>
                                                                <% } %>
                                                    </div>
                </div>
            </body>

            </html>