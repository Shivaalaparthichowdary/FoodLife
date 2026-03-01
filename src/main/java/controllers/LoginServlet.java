package controllers;

import dao.UserDao;
import daoImpl.UserDaoImpl;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDao userDao;

    @Override
    public void init() {
        userDao = new UserDaoImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        User user = userDao.loginUser(username, password);

        if (user != null) {
            // Check if the role matches
            if (user.getRole() != null && user.getRole().equalsIgnoreCase(role)) {
                HttpSession session = request.getSession();
                session.setAttribute("loggedInUser", user);
                
                // Route to appropriate dashboard
                switch (role.toLowerCase()) {
                    case "customer":
                        response.sendRedirect("restaurants");
                        break;
                    case "restaurantowner":
                        response.sendRedirect("ownerDashboard.jsp");
                        break;
                    case "deliveryboy":
                        response.sendRedirect("delivery");
                        break;
                    case "systemadmin":
                        response.sendRedirect("admin");
                        break;
                    default:
                        response.sendRedirect("login.jsp?error=Invalid role specified");
                        break;
                }
            } else {
                response.sendRedirect("login.jsp?error=Invalid role for this user");
            }
        } else {
            response.sendRedirect("login.jsp?error=Invalid username or password");
        }
    }
}
