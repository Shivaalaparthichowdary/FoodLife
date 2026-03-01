package controllers;

import dao.OrderDao;
import daoImpl.OrderDaoImpl;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/updateDeliveryStatus")
public class UpdateDeliveryStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderDao orderDao;

    @Override
    public void init() {
        orderDao = new OrderDaoImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        
        if (loggedInUser == null || !"deliveryboy".equalsIgnoreCase(loggedInUser.getRole())) {
            response.sendRedirect("login.jsp?error=Unauthorized access");
            return;
        }

        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String status = request.getParameter("status"); // Expected: "Delivered"
            
            boolean success = orderDao.updateDeliveryStatus(orderId, status);
            if (success) {
                response.sendRedirect("delivery?success=Status updated successfully");
            } else {
                response.sendRedirect("delivery?error=Failed to update status");
            }
        } catch (Exception e) {
            response.sendRedirect("delivery?error=Invalid parameters");
        }
    }
}
