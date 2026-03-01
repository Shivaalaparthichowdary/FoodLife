<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="model.User" %>
        <% User loggedInUser=(User) session.getAttribute("loggedInUser"); if (loggedInUser !=null) {
            response.sendRedirect("restaurants"); return; } %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>FoodLife - Delicious Food Delivered Fast</title>
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
                    rel="stylesheet">
                <link rel="stylesheet" href="css/style.css">
                <style>
                    .hero {
                        background: linear-gradient(135deg, #FF5A5F 0%, #E0484D 100%);
                        color: white;
                        padding: 6rem 5%;
                        text-align: center;
                        border-radius: 0 0 2rem 2rem;
                        margin-bottom: 3rem;
                        position: relative;
                        overflow: hidden;
                    }

                    .hero::after {
                        content: '';
                        position: absolute;
                        top: -50%;
                        left: -50%;
                        width: 200%;
                        height: 200%;
                        background: radial-gradient(circle, rgba(255, 255, 255, 0.1) 0%, transparent 60%);
                        animation: pulse 10s infinite;
                    }

                    @keyframes pulse {
                        0% {
                            transform: scale(1);
                        }

                        50% {
                            transform: scale(1.05);
                        }

                        100% {
                            transform: scale(1);
                        }
                    }

                    .hero h1 {
                        font-size: 3.5rem;
                        font-weight: 800;
                        margin-bottom: 1rem;
                        letter-spacing: -1px;
                        position: relative;
                        z-index: 1;
                    }

                    .hero p {
                        font-size: 1.25rem;
                        margin-bottom: 2rem;
                        opacity: 0.9;
                        max-width: 600px;
                        margin-left: auto;
                        margin-right: auto;
                        position: relative;
                        z-index: 1;
                    }

                    .hero-btn {
                        background-color: white;
                        color: var(--primary);
                        padding: 1rem 2.5rem;
                        font-size: 1.1rem;
                        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                        position: relative;
                        z-index: 1;
                    }

                    .hero-btn:hover {
                        background-color: #f8f8f8;
                        color: var(--primary-hover);
                    }
                </style>
            </head>

            <body>
                <nav class="navbar">
                    <a href="index.jsp" class="navbar-brand">FoodLife</a>
                    <ul class="navbar-nav">
                        <li><a href="login.jsp" class="btn btn-outline">Login</a></li>
                        <li><a href="signup.jsp" class="btn btn-primary">Sign Up</a></li>
                    </ul>
                </nav>

                <div class="hero">
                    <h1>Your Favorite Food, Delivered Fast.</h1>
                    <p>Discover the best restaurants in your city and get delicious meals delivered right to your
                        doorstep.</p>
                    <a href="signup.jsp" class="btn hero-btn">Explore Restaurants</a>
                </div>

            </body>

            </html>