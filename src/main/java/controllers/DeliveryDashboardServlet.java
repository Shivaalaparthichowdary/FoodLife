package controllers;

import dao.OrderDao;
import daoImpl.OrderDaoImpl;
import model.Order;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/delivery")
public class DeliveryDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderDao orderDao;

    @Override
    public void init() {
        orderDao = new OrderDaoImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        
        if (loggedInUser == null || !"deliveryboy".equalsIgnoreCase(loggedInUser.getRole())) {
            response.sendRedirect("login.jsp?error=Unauthorized access");
            return;
        }

        List<Order> assignedOrders = orderDao.getOrdersByDeliveryBoy(loggedInUser.getUserid());
        request.setAttribute("assignedOrders", assignedOrders);
        
        request.getRequestDispatcher("deliveryDashboard.jsp").forward(request, response);
    }
}
