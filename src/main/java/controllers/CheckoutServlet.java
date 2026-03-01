package controllers;

import dao.OrderDao;
import daoImpl.OrderDaoImpl;
import model.CartItem;
import model.Order;
import model.OrderItem;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("loggedInUser");
        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart.jsp?error=Cart is empty");
            return;
        }

        String paymentMode = request.getParameter("paymentMode");

        int restaurantId = cart.values().iterator().next().getRestaurantId();
        double totalAmount = 0.0;
        List<OrderItem> orderItems = new ArrayList<>();

        for (CartItem ci : cart.values()) {
            OrderItem oi = new OrderItem();
            oi.setMenuItemId(ci.getItemId());
            oi.setQuantity(ci.getQuantity());
            oi.setPrice(ci.getPrice());
            orderItems.add(oi);
            
            totalAmount += (ci.getPrice() * ci.getQuantity());
        }

        Order order = new Order();
        order.setUserId(user.getUserid());
        order.setRestaurantId(restaurantId);
        order.setTotalAmount(totalAmount);
        order.setModeOfPayment(paymentMode != null ? paymentMode : "Cash on Delivery");
        order.setStatus("Pending");

        OrderDao orderDao = new OrderDaoImpl();
        boolean success = orderDao.placeOrder(order, orderItems);

        if (success) {
            session.removeAttribute("cart");
            request.setAttribute("order", order);
            request.getRequestDispatcher("order_confirmation.jsp").forward(request, response);
        } else {
            response.sendRedirect("checkout.jsp?error=Order placement failed. Please try again.");
        }
    }
}
