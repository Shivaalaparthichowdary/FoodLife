<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="model.User" %>
        <% User loggedInUser=(User) session.getAttribute("loggedInUser"); if (loggedInUser==null ||
            !"restaurantowner".equalsIgnoreCase(loggedInUser.getRole())) {
            response.sendRedirect("login.jsp?error=Unauthorized access"); return; } %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Restaurant Owner Dashboard - FoodLife</title>
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
                    <a href="#" class="navbar-brand">FoodLife Owner</a>
                    <ul class="navbar-nav">
                        <li><span style="color: white; margin-right: 15px;">Welcome, <%= loggedInUser.getName() %>
                                    </span></li>
                        <li><a href="logout" class="btn btn-outline">Logout</a></li>
                    </ul>
                </nav>

                <div class="dashboard-container">
                    <div class="dashboard-header">
                        <h2>Restaurant Dashboard</h2>
                    </div>

                    <div class="dashboard-cards">
                        <div class="card">
                            <h3>Manage Menu</h3>
                            <p>Add, update, or remove items from your menu.</p>
                            <a href="#" class="btn btn-primary" style="margin-top: 1rem; display: inline-block;">View
                                Menu</a>
                        </div>
                        <div class="card">
                            <h3>View Orders</h3>
                            <p>Check incoming orders from customers.</p>
                            <a href="#" class="btn btn-primary" style="margin-top: 1rem; display: inline-block;">View
                                Orders</a>
                        </div>
                    </div>
                </div>
            </body>

            </html>