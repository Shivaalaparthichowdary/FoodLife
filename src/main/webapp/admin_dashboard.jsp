<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="model.User" %>
        <% User loggedInUser=(User) session.getAttribute("loggedInUser"); if (loggedInUser==null ||
            !"systemadmin".equalsIgnoreCase(loggedInUser.getRole())) { response.sendRedirect("login.jsp"); return; } %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <title>Admin Dashboard - FoodLife</title>
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
                    rel="stylesheet">
                <link rel="stylesheet" href="css/style.css">
                <style>
                    .admin-grid {
                        display: grid;
                        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                        gap: 2rem;
                        margin-top: 2rem;
                    }

                    .admin-card {
                        background: var(--surface);
                        border-radius: var(--radius);
                        box-shadow: var(--shadow);
                        padding: 2rem;
                    }
                </style>
            </head>

            <body>
                <nav class="navbar">
                    <a href="adminDashboard" class="navbar-brand">FoodLife Admin</a>
                    <ul class="navbar-nav">
                        <li><span class="nav-link">Admin: <%= loggedInUser.getName() %></span></li>
                        <li><a href="logout" class="btn btn-outline" style="padding: 0.4rem 1rem;">Logout</a></li>
                    </ul>
                </nav>

                <div class="grid-container">
                    <h1 class="section-title">Admin Dashboard</h1>

                    <% String success=request.getParameter("success"); if (success !=null) { %>
                        <div class="alert alert-success">
                            <%= success %>
                        </div>
                        <% } %>
                            <% String error=request.getParameter("error"); if (error !=null) { %>
                                <div class="alert alert-error">
                                    <%= error %>
                                </div>
                                <% } %>

                                    <div class="admin-grid">
                                        <div class="admin-card">
                                            <h3 style="margin-bottom: 1rem;">Add Restaurant</h3>
                                            <form action="manageRestaurant" method="post">
                                                <div class="form-group">
                                                    <label class="form-label">Restaurant Name</label>
                                                    <input type="text" name="name" class="form-control" required>
                                                </div>
                                                <div class="form-group">
                                                    <label class="form-label">Cuisine Type</label>
                                                    <input type="text" name="cuisineType" class="form-control" required>
                                                </div>
                                                <div class="form-group">
                                                    <label class="form-label">Address</label>
                                                    <input type="text" name="address" class="form-control" required>
                                                </div>
                                                <button type="submit" class="btn btn-primary" style="width:100%">Add
                                                    Restaurant</button>
                                            </form>
                                        </div>

                                        <div class="admin-card">
                                            <h3 style="margin-bottom: 1rem;">Add Menu Item</h3>
                                            <form action="manageMenu" method="post">
                                                <div class="form-group">
                                                    <label class="form-label">Restaurant ID</label>
                                                    <input type="number" name="restaurantId" class="form-control"
                                                        required>
                                                </div>
                                                <div class="form-group">
                                                    <label class="form-label">Item Name</label>
                                                    <input type="text" name="itemName" class="form-control" required>
                                                </div>
                                                <div class="form-group">
                                                    <label class="form-label">Price</label>
                                                    <input type="number" step="0.01" name="price" class="form-control"
                                                        required>
                                                </div>
                                                <button type="submit" class="btn btn-primary" style="width:100%">Add
                                                    Menu Item</button>
                                            </form>
                                        </div>

                                        <div class="admin-card">
                                            <h3 style="margin-bottom: 1rem;">Add Employee</h3>
                                            <form action="manageEmployee" method="post">
                                                <div class="form-group">
                                                    <label class="form-label">Employee ID</label>
                                                    <input type="number" name="empId" class="form-control" required>
                                                </div>
                                                <div class="form-group">
                                                    <label class="form-label">Name</label>
                                                    <input type="text" name="empName" class="form-control" required>
                                                </div>
                                                <div class="form-group">
                                                    <label class="form-label">Salary</label>
                                                    <input type="number" step="0.01" name="salary" class="form-control"
                                                        required>
                                                </div>
                                                <button type="submit" class="btn btn-primary" style="width:100%">Add
                                                    Employee</button>
                                            </form>
                                        </div>
                                    </div>
                </div>
            </body>

            </html>