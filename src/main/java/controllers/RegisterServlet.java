package controllers;

import dao.UserDao;
import daoImpl.UserDaoImpl;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDao userDao;

    @Override
    public void init() {
        userDao = new UserDaoImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String phonenoStr = request.getParameter("phoneno");
        String role = request.getParameter("role");

        User user = new User();
        user.setUsername(username);
        user.setName(name);
        user.setPassword(password);
        user.setEmail(email);
        user.setAddress(address);
        user.setRole(role == null || role.isEmpty() ? "customer" : role);
        try {
            user.setPhoneno(Long.parseLong(phonenoStr));
        } catch (NumberFormatException e) {
            user.setPhoneno(0);
        }

        boolean success = userDao.registerUser(user);

        if (success) {
            response.sendRedirect("login.jsp?success=Registration successful. Please login.");
        } else {
            response.sendRedirect("signup.jsp?error=Registration failed. Username or email may already exist.");
        }
    }
}
