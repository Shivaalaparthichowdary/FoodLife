<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - FoodLife</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
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
        <div class="auth-card">
            <h2 class="auth-title">Welcome Back</h2>
            <p class="auth-subtitle">Login to continue ordering delicious food</p>
            
            <% String error = request.getParameter("error");
               if (error != null) { %>
                <div class="alert alert-error"><%= error %></div>
            <% } %>
            
            <% String success = request.getParameter("success");
               if (success != null) { %>
                <div class="alert alert-success"><%= success %></div>
            <% } %>

            <form action="login" method="post">
                <div class="form-group">
                    <label class="form-label" for="username">Username</label>
                    <input type="text" id="username" name="username" class="form-control" required placeholder="Enter your username">
                </div>
                <div class="form-group">
                    <label class="form-label" for="password">Password</label>
                    <input type="password" id="password" name="password" class="form-control" required placeholder="Enter your password">
                </div>
                <button type="submit" class="btn btn-primary auth-btn">Login</button>
            </form>
            
            <div class="auth-link">
                Don't have an account? <a href="signup.jsp">Sign up</a>
            </div>
        </div>
    </div>
</body>
</html>
