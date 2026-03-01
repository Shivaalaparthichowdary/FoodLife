<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List" %>
        <%@ page import="model.Menu" %>
            <%@ page import="model.User" %>
                <% User loggedInUser=(User) session.getAttribute("loggedInUser"); if (loggedInUser==null) {
                    response.sendRedirect("login.jsp"); return; } List<Menu> menuList = (List<Menu>)
                        request.getAttribute("menuList");
                        %>
                        <!DOCTYPE html>
                        <html lang="en">

                        <head>
                            <meta charset="UTF-8">
                            <meta name="viewport" content="width=device-width, initial-scale=1.0">
                            <title>Menu - FoodLife</title>
                            <link
                                href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
                                rel="stylesheet">
                            <link rel="stylesheet" href="css/style.css">
                            <style>
                                .menu-grid {
                                    display: grid;
                                    grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
                                    gap: 2rem;
                                    margin-top: 2rem;
                                }

                                .menu-item {
                                    background: var(--surface);
                                    border-radius: var(--radius);
                                    box-shadow: var(--shadow);
                                    display: flex;
                                    overflow: hidden;
                                    transition: transform 0.3s;
                                }

                                .menu-item:hover {
                                    transform: translateY(-3px);
                                    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.08);
                                }

                                .menu-img {
                                    width: 120px;
                                    height: 100%;
                                    object-fit: cover;
                                    background: #eee;
                                }

                                .menu-content {
                                    padding: 1rem;
                                    flex-grow: 1;
                                    display: flex;
                                    flex-direction: column;
                                    justify-content: space-between;
                                }

                                .menu-name {
                                    font-size: 1.1rem;
                                    font-weight: 700;
                                    margin-bottom: 0.3rem;
                                    color: var(--text-dark);
                                }

                                .menu-desc {
                                    font-size: 0.85rem;
                                    color: var(--text-light);
                                    margin-bottom: 0.8rem;
                                    line-height: 1.4;
                                }

                                .menu-price {
                                    font-weight: 700;
                                    color: var(--primary);
                                    font-size: 1.1rem;
                                }

                                .add-to-cart-form {
                                    display: flex;
                                    align-items: center;
                                    gap: 0.5rem;
                                    margin-top: 0.5rem;
                                }

                                .qty-input {
                                    width: 60px;
                                    padding: 0.4rem;
                                    border: 1px solid var(--border);
                                    border-radius: 4px;
                                    text-align: center;
                                }

                                .unavailable {
                                    opacity: 0.6;
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
                                <div
                                    style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
                                    <h1 class="section-title" style="margin: 0;">Restaurant Menu</h1>
                                    <a href="restaurants" class="btn btn-outline">← Back to Restaurants</a>
                                </div>

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

                                                <div class="menu-grid">
                                                    <% if (menuList !=null && !menuList.isEmpty()) { for (Menu m :
                                                        menuList) { %>
                                                        <div
                                                            class='menu-item <%= !m.isAvailable() ? "unavailable" : "" %>'>
                                                            <img src='<%= m.getImagePath() != null && !m.getImagePath().isEmpty() ? m.getImagePath() : "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=500&q=80" %>'
                                                                alt="<%= m.getItemName() %>" class="menu-img">
                                                            <div class="menu-content">
                                                                <div>
                                                                    <h3 class="menu-name">
                                                                        <%= m.getItemName() %>
                                                                    </h3>
                                                                    <p class="menu-desc">
                                                                        <%= m.getItemDescription() !=null ?
                                                                            m.getItemDescription() : "" %>
                                                                    </p>
                                                                    <div class="menu-price">₹<%= m.getPrice() %>
                                                                    </div>
                                                                </div>
                                                                <% if (m.isAvailable()) { %>
                                                                    <form action="cart" method="post"
                                                                        class="add-to-cart-form">
                                                                        <input type="hidden" name="action" value="add">
                                                                        <input type="hidden" name="menuId"
                                                                            value="<%= m.getMenuId() %>">
                                                                        <input type="hidden" name="restaurantId"
                                                                            value="<%= m.getRestaurantId() %>">
                                                                        <input type="number" name="quantity" value="1"
                                                                            min="1" max="20" class="qty-input">
                                                                        <button type="submit" class="btn btn-primary"
                                                                            style="padding: 0.4rem 0.8rem; font-size: 0.9rem;">Add</button>
                                                                    </form>
                                                                    <% } else { %>
                                                                        <span
                                                                            style="color: #d11a2a; font-weight: 600; font-size: 0.9rem;">Out
                                                                            of Stock</span>
                                                                        <% } %>
                                                            </div>
                                                        </div>
                                                        <% } } else { %>
                                                            <div
                                                                style="grid-column: 1 / -1; text-align: center; padding: 3rem; color: var(--text-light);">
                                                                <h3>No items available for this restaurant.</h3>
                                                            </div>
                                                            <% } %>
                                                </div>
                            </div>
                        </body>

                        </html>