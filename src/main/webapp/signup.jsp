<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sign Up - FoodLife</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
            rel="stylesheet">
        <link rel="stylesheet" href="css/style.css">
    </head>

    <body>
        <nav class="navbar">
            <a href="index.jsp" class="navbar-brand">FoodLife</a>
            <ul class="navbar-nav">
                <li><a href="login.jsp" class="btn btn-outline">Login</a></li>
                <li><a href="signup.jsp" class="btn btn-primary">Sign Up</a></li>
            </ul>
        </nav>

        <div class="auth-wrapper">
            <div class="auth-card" style="max-width: 600px;">
                <h2 class="auth-title">Create an Account</h2>
                <p class="auth-subtitle">Join FoodLife to discover and order from the best restaurants</p>

                <% String error=request.getParameter("error"); if (error !=null) { %>
                    <div class="alert alert-error">
                        <%= error %>
                    </div>
                    <% } %>

                        <form action="register" method="post"
                            style="display: grid; grid-template-columns: 1fr 1fr; gap: 0 1rem;">
                            <div class="form-group">
                                <label class="form-label" for="username">Username</label>
                                <input type="text" id="username" name="username" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label" for="name">Full Name</label>
                                <input type="text" id="name" name="name" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label" for="email">Email</label>
                                <input type="email" id="email" name="email" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label" for="phoneno">Phone Number</label>
                                <input type="tel" id="phoneno" name="phoneno" class="form-control" required
                                    pattern="[0-9]{10}" title="10 digit phone number">
                            </div>
                            <div class="form-group">
                                <label class="form-label" for="password">Password</label>
                                <input type="password" id="password" name="password" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label" for="role">Role</label>
                                <select id="role" name="role" class="form-control" required>
                                    <option value="customer">Customer</option>
                                    <option value="restaurantowner">Restaurant Owner</option>
                                    <option value="deliveryboy">Delivery Boy</option>
                                </select>
                            </div>
                            <div class="form-group" style="grid-column: 1 / -1;">
                                <label class="form-label" for="address">Address</label>
                                <textarea id="address" name="address" class="form-control" rows="2" required></textarea>
                            </div>

                            <div style="grid-column: 1 / -1;">
                                <button type="submit" class="btn btn-primary auth-btn">Sign Up</button>
                            </div>
                        </form>

                        <div class="auth-link" style="grid-column: 1 / -1;">
                            Already have an account? <a href="login.jsp">Login</a>
                        </div>
            </div>
        </div>
    </body>

    </html>