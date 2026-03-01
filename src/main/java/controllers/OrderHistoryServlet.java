package controllers;

import dao.OrderDao;
import daoImpl.OrderDaoImpl;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/orderHistory")
public class OrderHistoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("loggedInUser");
        OrderDao orderDao = new OrderDaoImpl();

        List<Order> orders = orderDao.getOrdersByUser(user.getUserid());
        Map<Integer, List<OrderItem>> orderItemsMap = new HashMap<>();

        for (Order order : orders) {
            List<OrderItem> items = orderDao.getOrderItemsByOrder(order.getOrderId());
            orderItemsMap.put(order.getOrderId(), items);
        }

        request.setAttribute("orders", orders);
        request.setAttribute("orderItemsMap", orderItemsMap);
        
        request.getRequestDispatcher("order_history.jsp").forward(request, response);
    }
}
