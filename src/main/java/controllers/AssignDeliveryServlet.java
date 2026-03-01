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

@WebServlet("/assignDelivery")
public class AssignDeliveryServlet extends HttpServlet {
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
        
        if (loggedInUser == null || !"systemadmin".equalsIgnoreCase(loggedInUser.getRole())) {
            response.sendRedirect("login.jsp?error=Unauthorized access");
            return;
        }

        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            int deliveryboyId = Integer.parseInt(request.getParameter("deliveryboyId"));
            
            boolean success = orderDao.assignDeliveryBoy(orderId, deliveryboyId);
            if (success) {
                response.sendRedirect("admin?success=Order assigned successfully");
            } else {
                response.sendRedirect("admin?error=Failed to assign order");
            }
        } catch (Exception e) {
            response.sendRedirect("admin?error=Invalid parameters");
        }
    }
}
