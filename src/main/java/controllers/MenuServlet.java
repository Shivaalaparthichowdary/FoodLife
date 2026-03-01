package controllers;

import dao.MenuDao;
import daoImpl.MenuDaoImpl;
import model.Menu;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/menu")
public class MenuServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MenuDao menuDao;

    @Override
    public void init() {
        menuDao = new MenuDaoImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("login.jsp?error=Please log in first.");
            return;
        }

        String restaurantIdStr = request.getParameter("restaurantId");
        if (restaurantIdStr != null && !restaurantIdStr.isEmpty()) {
            try {
                int restaurantId = Integer.parseInt(restaurantIdStr);
                List<Menu> menuList = menuDao.getMenuByRestaurant(restaurantId);
                request.setAttribute("menuList", menuList);
                
                request.getRequestDispatcher("menu.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                response.sendRedirect("restaurants");
            }
        } else {
            response.sendRedirect("restaurants");
        }
    }
}
