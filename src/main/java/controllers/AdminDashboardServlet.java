package controllers;

import dao.OrderDao;
import dao.UserDao;
import daoImpl.OrderDaoImpl;
import daoImpl.UserDaoImpl;
import model.Order;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import util.DBConnection;

@WebServlet("/admin")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderDao orderDao;
    private UserDao userDao;

    @Override
    public void init() {
        orderDao = new OrderDaoImpl();
        userDao = new UserDaoImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        
        if (loggedInUser == null || !"systemadmin".equalsIgnoreCase(loggedInUser.getRole())) {
            response.sendRedirect("login.jsp?error=Unauthorized access");
            return;
        }

        List<Order> pendingOrders = orderDao.getPendingOrders();
        List<User> deliveryBoys = getDeliveryBoys();
        
        request.setAttribute("pendingOrders", pendingOrders);
        request.setAttribute("deliveryBoys", deliveryBoys);
        
        request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
    }
    
    private List<User> getDeliveryBoys() {
        List<User> list = new ArrayList<>();
        String query = "SELECT * FROM user WHERE role = 'deliveryboy'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                User u = new User();
                u.setUserid(rs.getInt("userid"));
                u.setUsername(rs.getString("username"));
                u.setName(rs.getString("name"));
                list.add(u);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
