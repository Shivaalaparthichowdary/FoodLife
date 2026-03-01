<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.Map" %>
        <%@ page import="model.CartItem" %>
            <%@ page import="model.User" %>
                <% User loggedInUser=(User) session.getAttribute("loggedInUser"); if (loggedInUser==null) {
                    response.sendRedirect("login.jsp"); return; } Map<Integer, CartItem> cart = (Map<Integer, CartItem>)
                        session.getAttribute("cart");
                        double total = 0.0;
                        %>
                        <!DOCTYPE html>
                        <html lang="en">

                        <head>
                            <meta charset="UTF-8">
                            <meta name="viewport" content="width=device-width, initial-scale=1.0">
                            <title>Your Cart - FoodLife</title>
                            <link
                                href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
                                rel="stylesheet">
                            <link rel="stylesheet" href="css/style.css">
                            <style>
                                .cart-container {
                                    background: var(--surface);
                                    border-radius: var(--radius);
                                    box-shadow: var(--shadow);
                                    padding: 2rem;
                                    margin-top: 1rem;
                                }

                                .cart-table {
                                    width: 100%;
                                    border-collapse: collapse;
                                    margin-bottom: 2rem;
                                }

                                .cart-table th,
                                .cart-table td {
                                    padding: 1rem;
                                    text-align: left;
                                    border-bottom: 1px solid var(--border);
                                }

                                .cart-table th {
                                    color: var(--text-light);
                                    font-weight: 600;
                                }

                                .cart-table td {
                                    vertical-align: middle;
                                }

                                .qty-control {
                                    display: flex;
                                    align-items: center;
                                    gap: 0.5rem;
                                }

                                .qty-btn {
                                    background: #eee;
                                    border: none;
                                    width: 28px;
                                    height: 28px;
                                    border-radius: 4px;
                                    cursor: pointer;
                                    font-weight: bold;
                                }

                                .cart-summary {
                                    background: #f8f9fa;
                                    padding: 1.5rem;
                                    border-radius: var(--radius);
                                    text-align: right;
                                }

                                .summary-row {
                                    display: flex;
                                    justify-content: flex-end;
                                    gap: 2rem;
                                    margin-bottom: 0.5rem;
                                    font-size: 1.1rem;
                                }

                                .summary-total {
                                    font-size: 1.4rem;
                                    font-weight: 700;
                                    color: var(--primary);
                                    border-top: 2px solid var(--border);
                                    padding-top: 1rem;
                                    margin-top: 0.5rem;
                                }
                            </style>
                        </head>

                        <body>
                            <nav class="navbar">
                                <a href="restaurants" class="navbar-brand">FoodLife</a>
                                <ul class="navbar-nav">
                                    <li><span class="nav-link">Welcome, <%= loggedInUser.getName() %></span></li>
                                    <li><a href="cart.jsp" class="nav-link"
                                            style="color: var(--primary); font-weight: 700;">Cart</a></li>
                                    <li><a href="orderHistory" class="nav-link">Orders</a></li>
                                    <li><a href="logout" class="btn btn-outline"
                                            style="padding: 0.4rem 1rem;">Logout</a></li>
                                </ul>
                            </nav>

                            <div class="grid-container" style="max-width: 900px;">
                                <h1 class="section-title">Your Food Cart</h1>

                                <% if (cart==null || cart.isEmpty()) { %>
                                    <div class="cart-container" style="text-align: center; padding: 4rem 2rem;">
                                        <h2 style="color: var(--text-light); margin-bottom: 1.5rem;">Your cart is empty
                                        </h2>
                                        <a href="restaurants" class="btn btn-primary">Browse Restaurants</a>
                                    </div>
                                    <% } else { %>
                                        <div class="cart-container">
                                            <table class="cart-table">
                                                <thead>
                                                    <tr>
                                                        <th>Item Name</th>
                                                        <th>Price</th>
                                                        <th>Quantity</th>
                                                        <th>Subtotal</th>
                                                        <th>Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <% for (CartItem item : cart.values()) { double
                                                        subtotal=item.getPrice() * item.getQuantity(); total +=subtotal;
                                                        %>
                                                        <tr>
                                                            <td style="font-weight: 600;">
                                                                <%= item.getName() %>
                                                            </td>
                                                            <td>₹<%= String.format("%.2f", item.getPrice()) %>
                                                            </td>
                                                            <td>
                                                                <form action="cart" method="post" class="qty-control">
                                                                    <input type="hidden" name="action" value="update">
                                                                    <input type="hidden" name="itemId"
                                                                        value="<%= item.getItemId() %>">
                                                                    <button type="submit" name="quantity"
                                                                        value="<%= item.getQuantity() - 1 %>"
                                                                        class="qty-btn">-</button>
                                                                    <span
                                                                        style="font-weight: 600; width: 20px; text-align: center;">
                                                                        <%= item.getQuantity() %>
                                                                    </span>
                                                                    <button type="submit" name="quantity"
                                                                        value="<%= item.getQuantity() + 1 %>"
                                                                        class="qty-btn">+</button>
                                                                </form>
                                                            </td>
                                                            <td style="font-weight: 600;">₹<%= String.format("%.2f",
                                                                    subtotal) %>
                                                            </td>
                                                            <td>
                                                                <form action="cart" method="post">
                                                                    <input type="hidden" name="action" value="remove">
                                                                    <input type="hidden" name="itemId"
                                                                        value="<%= item.getItemId() %>">
                                                                    <button type="submit" class="btn"
                                                                        style="background: transparent; color: #d11a2a; padding: 0.2rem 0.5rem; text-decoration: underline;">Remove</button>
                                                                </form>
                                                            </td>
                                                        </tr>
                                                        <% } %>
                                                </tbody>
                                            </table>

                                            <div class="cart-summary">
                                                <div class="summary-row">
                                                    <span>Total Items:</span>
                                                    <span>
                                                        <%= cart.size() %>
                                                    </span>
                                                </div>
                                                <div class="summary-row summary-total">
                                                    <span>Grand Total:</span>
                                                    <span>₹<%= String.format("%.2f", total) %></span>
                                                </div>

                                                <div
                                                    style="display: flex; justify-content: flex-end; gap: 1rem; margin-top: 2rem;">
                                                    <a href="restaurants" class="btn btn-outline">Add More Food</a>
                                                    <form action="checkout.jsp" method="get">
                                                        <button type="submit" class="btn btn-primary"
                                                            style="padding: 1rem 2rem; font-size: 1.1rem;">Proceed to
                                                            Checkout</button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                        <% } %>
                            </div>
                        </body>

                        </html>