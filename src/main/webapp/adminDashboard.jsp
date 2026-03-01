<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="model.User" %>
        <% User loggedInUser=(User) session.getAttribute("loggedInUser"); if (loggedInUser==null ||
            !"systemadmin".equalsIgnoreCase(loggedInUser.getRole())) {
            response.sendRedirect("login.jsp?error=Unauthorized access"); return; } %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Admin Dashboard - FoodLife</title>
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
                    <a href="#" class="navbar-brand">FoodLife Admin</a>
                    <ul class="navbar-nav">
                        <li><span style="color: white; margin-right: 15px;">Welcome, <%= loggedInUser.getName() %>
                            </span></li>
                        <li><a href="logout" class="btn btn-outline">Logout</a></li>
                    </ul>
                </nav>

                <div class="dashboard-container">
                    <div class="dashboard-header">
                        <h2>System Administration</h2>
                    </div>

                    <%@ page import="java.util.List" %>
                        <%@ page import="model.Order" %>
                            <% List<Order> pendingOrders = (List<Order>) request.getAttribute("pendingOrders");
                                    List<User> deliveryBoys = (List<User>) request.getAttribute("deliveryBoys");

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
                                                                <h3>Pending Orders</h3>
                                                                <p>Assign these orders to delivery boys for fulfillment.
                                                                </p>

                                                                <% if (pendingOrders !=null && !pendingOrders.isEmpty())
                                                                    { %>
                                                                    <table
                                                                        style="width: 100%; border-collapse: collapse; margin-top: 20px;">
                                                                        <thead>
                                                                            <tr
                                                                                style="background-color: #f8f9fa; border-bottom: 2px solid #dee2e6;">
                                                                                <th
                                                                                    style="padding: 12px; text-align: left;">
                                                                                    Order ID</th>
                                                                                <th
                                                                                    style="padding: 12px; text-align: left;">
                                                                                    Restaurant</th>
                                                                                <th
                                                                                    style="padding: 12px; text-align: left;">
                                                                                    Amount</th>
                                                                                <th
                                                                                    style="padding: 12px; text-align: left;">
                                                                                    Assign To</th>
                                                                                <th
                                                                                    style="padding: 12px; text-align: left;">
                                                                                    Action</th>
                                                                            </tr>
                                                                        </thead>
                                                                        <tbody>
                                                                            <% for (Order o : pendingOrders) { %>
                                                                                <tr
                                                                                    style="border-bottom: 1px solid #dee2e6;">
                                                                                    <td style="padding: 12px;">#<%=
                                                                                            o.getOrderId() %>
                                                                                    </td>
                                                                                    <td style="padding: 12px;">
                                                                                        <%= o.getRestaurantName() %>
                                                                                    </td>
                                                                                    <td style="padding: 12px;">$<%=
                                                                                            o.getTotalAmount() %>
                                                                                    </td>
                                                                                    <form action="assignDelivery"
                                                                                        method="post">
                                                                                        <td style="padding: 12px;">
                                                                                            <input type="hidden"
                                                                                                name="orderId"
                                                                                                value="<%= o.getOrderId() %>">
                                                                                            <select name="deliveryboyId"
                                                                                                class="form-control"
                                                                                                style="width: auto;"
                                                                                                required>
                                                                                                <option value="">--
                                                                                                    Select Delivery Boy
                                                                                                    --</option>
                                                                                                <% if (deliveryBoys
                                                                                                    !=null) { for (User
                                                                                                    db : deliveryBoys) {
                                                                                                    %>
                                                                                                    <option
                                                                                                        value="<%= db.getUserid() %>">
                                                                                                        <%= db.getName()
                                                                                                            %> (<%=
                                                                                                                db.getUsername()
                                                                                                                %>)
                                                                                                    </option>
                                                                                                    <% } } %>
                                                                                            </select>
                                                                                        </td>
                                                                                        <td style="padding: 12px;">
                                                                                            <button type="submit"
                                                                                                class="btn btn-primary"
                                                                                                style="padding: 6px 12px;">Assign</button>
                                                                                        </td>
                                                                                    </form>
                                                                                </tr>
                                                                                <% } %>
                                                                        </tbody>
                                                                    </table>
                                                                    <% } else { %>
                                                                        <p style="margin-top: 20px; color: #666;">No
                                                                            pending orders available.</p>
                                                                        <% } %>
                                                            </div>
                </div>
            </body>

            </html>