<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.Map" %>
        <%@ page import="model.CartItem" %>
            <%@ page import="model.User" %>
                <% User loggedInUser=(User) session.getAttribute("loggedInUser"); if (loggedInUser==null) {
                    response.sendRedirect("login.jsp"); return; } Map<Integer, CartItem> cart = (Map<Integer, CartItem>)
                        session.getAttribute("cart");
                        if (cart == null || cart.isEmpty()) {
                        response.sendRedirect("cart.jsp");
                        return;
                        }
                        double total = 0.0;
                        for (CartItem item : cart.values()) {
                        total += item.getPrice() * item.getQuantity();
                        }
                        %>
                        <!DOCTYPE html>
                        <html lang="en">

                        <head>
                            <meta charset="UTF-8">
                            <title>Checkout - FoodLife</title>
                            <link
                                href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
                                rel="stylesheet">
                            <link rel="stylesheet" href="css/style.css">
                            <style>
                                .checkout-grid {
                                    display: grid;
                                    grid-template-columns: 2fr 1fr;
                                    gap: 2rem;
                                    margin-top: 1rem;
                                }

                                .checkout-card {
                                    background: var(--surface);
                                    border-radius: var(--radius);
                                    box-shadow: var(--shadow);
                                    padding: 2rem;
                                }

                                .order-summary-item {
                                    display: flex;
                                    justify-content: space-between;
                                    margin-bottom: 0.8rem;
                                    padding-bottom: 0.8rem;
                                    border-bottom: 1px solid var(--border);
                                }

                                .order-total {
                                    font-size: 1.3rem;
                                    font-weight: 700;
                                    color: var(--primary);
                                    display: flex;
                                    justify-content: space-between;
                                    margin-top: 1rem;
                                }

                                @media (max-width: 768px) {
                                    .checkout-grid {
                                        grid-template-columns: 1fr;
                                    }
                                }
                            </style>
                        </head>

                        <body>
                            <nav class="navbar">
                                <a href="restaurants" class="navbar-brand">FoodLife</a>
                                <ul class="navbar-nav">
                                    <li><a href="cart.jsp" class="nav-link">Cart</a></li>
                                </ul>
                            </nav>

                            <div class="grid-container">
                                <h1 class="section-title">Checkout</h1>

                                <% String error=request.getParameter("error"); if (error !=null) { %>
                                    <div class="alert alert-error">
                                        <%= error %>
                                    </div>
                                    <% } %>

                                        <div class="checkout-grid">
                                            <div class="checkout-card">
                                                <h2 style="margin-bottom: 1.5rem;">Delivery Details</h2>
                                                <form action="checkout" method="post">
                                                    <div class="form-group">
                                                        <label class="form-label">Full Name</label>
                                                        <input type="text" class="form-control"
                                                            value="<%= loggedInUser.getName() %>" readonly>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="form-label" for="address">Delivery Address</label>
                                                        <textarea id="address" name="address" class="form-control"
                                                            rows="3"
                                                            required><%= loggedInUser.getAddress() != null ? loggedInUser.getAddress() : "" %></textarea>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="form-label" for="paymentMode">Payment Mode</label>
                                                        <select id="paymentMode" name="paymentMode" class="form-control"
                                                            required>
                                                            <option value="Cash on Delivery">Cash on Delivery</option>
                                                            <option value="Credit Card">Credit Card</option>
                                                            <option value="UPI">UPI / Net Banking</option>
                                                        </select>
                                                    </div>
                                                    <button type="submit" class="btn btn-primary auth-btn"
                                                        style="margin-top: 2rem;">Place Order</button>
                                                </form>
                                            </div>

                                            <div class="checkout-card">
                                                <h2 style="margin-bottom: 1.5rem;">Order Summary</h2>
                                                <% for (CartItem item : cart.values()) { %>
                                                    <div class="order-summary-item">
                                                        <span>
                                                            <%= item.getQuantity() %>x <%= item.getName() %>
                                                        </span>
                                                        <span style="font-weight: 600;">₹<%= String.format("%.2f",
                                                                item.getPrice() * item.getQuantity()) %></span>
                                                    </div>
                                                    <% } %>
                                                        <div class="order-total">
                                                            <span>Total:</span>
                                                            <span>₹<%= String.format("%.2f", total) %></span>
                                                        </div>
                                            </div>
                                        </div>
                            </div>
                        </body>

                        </html>