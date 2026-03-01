<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List" %>
        <%@ page import="model.Restaurant" %>
            <%@ page import="model.User" %>
                <% User loggedInUser=(User) session.getAttribute("loggedInUser"); if (loggedInUser==null) {
                    response.sendRedirect("login.jsp"); return; } List<Restaurant> restaurantList = (List<Restaurant>)
                        request.getAttribute("restaurantList");
                        %>
                        <!DOCTYPE html>
                        <html lang="en">

                        <head>
                            <meta charset="UTF-8">
                            <meta name="viewport" content="width=device-width, initial-scale=1.0">
                            <title>Restaurants - FoodLife</title>
                            <link
                                href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
                                rel="stylesheet">
                            <link rel="stylesheet" href="css/style.css">
                            <style>
                                .restaurant-grid {
                                    display: grid;
                                    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
                                    gap: 2rem;
                                    margin-top: 2rem;
                                }

                                .restaurant-card {
                                    background: var(--surface);
                                    border-radius: var(--radius);
                                    overflow: hidden;
                                    box-shadow: var(--shadow);
                                    transition: transform 0.3s ease, box-shadow 0.3s ease;
                                    text-decoration: none;
                                    color: var(--text-dark);
                                    display: flex;
                                    flex-direction: column;
                                }

                                .restaurant-card:hover {
                                    transform: translateY(-5px);
                                    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
                                }

                                .restaurant-img {
                                    width: 100%;
                                    height: 200px;
                                    object-fit: cover;
                                    background-color: #eee;
                                }

                                .restaurant-info {
                                    padding: 1.5rem;
                                    flex-grow: 1;
                                }

                                .restaurant-name {
                                    font-size: 1.4rem;
                                    font-weight: 700;
                                    margin-bottom: 0.5rem;
                                }

                                .restaurant-meta {
                                    display: flex;
                                    justify-content: space-between;
                                    color: var(--text-light);
                                    font-size: 0.9rem;
                                    margin-bottom: 0.5rem;
                                }

                                .cuisine-type {
                                    display: inline-block;
                                    background: rgba(0, 166, 153, 0.1);
                                    color: var(--secondary);
                                    padding: 0.2rem 0.6rem;
                                    border-radius: 4px;
                                    font-size: 0.8rem;
                                    font-weight: 600;
                                    margin-bottom: 1rem;
                                }

                                .rating-badge {
                                    background: #FFB800;
                                    color: white;
                                    padding: 0.2rem 0.6rem;
                                    border-radius: 6px;
                                    font-weight: bold;
                                    display: inline-flex;
                                    align-items: center;
                                    gap: 4px;
                                }
                            </style>
                        </head>

                        <body>
                            <nav class="navbar">
                                <a href="restaurants" class="navbar-brand">FoodLife</a>
                                <ul class="navbar-nav">
                                    <li><span class="nav-link">Welcome, <%= loggedInUser.getName() %></span></li>
                                    <li><a href="cart.jsp" class="nav-link">Cart</a></li>
                                    <li><a href="orderHistory" class="nav-link">Orders</a></li>
                                    <li><a href="logout" class="btn btn-outline"
                                            style="padding: 0.4rem 1rem;">Logout</a></li>
                                </ul>
                            </nav>

                            <div class="grid-container">
                                <h1 class="section-title">Top Restaurants Near You</h1>

                                <div class="restaurant-grid">
                                    <% if (restaurantList !=null && !restaurantList.isEmpty()) { for (Restaurant r :
                                        restaurantList) { %>
                                        <a href="menu?restaurantId=<%= r.getRestaurantId() %>" class="restaurant-card">
                                            <img src='<%= r.getImagepath() != null && !r.getImagepath().isEmpty() ? r.getImagepath() : "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=500&q=80" %>'
                                                alt="<%= r.getName() %>" class="restaurant-img">
                                            <div class="restaurant-info">
                                                <h3 class="restaurant-name">
                                                    <%= r.getName() %>
                                                </h3>
                                                <span class="cuisine-type">
                                                    <%= r.getCuisineType() %>
                                                </span>
                                                <div class="restaurant-meta">
                                                    <span><span class="rating-badge">★ <%= r.getRatings() %>
                                                        </span></span>
                                                    <span>⏱ <%= r.getEtArrival() %></span>
                                                </div>
                                                <p style="color: var(--text-light); font-size: 0.9rem;">
                                                    <%= r.getAddress() %>
                                                </p>
                                            </div>
                                        </a>
                                        <% } } else { %>
                                            <div
                                                style="grid-column: 1 / -1; text-align: center; padding: 3rem; color: var(--text-light);">
                                                <h3>No restaurants found at the moment.</h3>
                                            </div>
                                            <% } %>
                                </div>
                            </div>
                        </body>

                        </html>