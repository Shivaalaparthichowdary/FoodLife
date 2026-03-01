package controllers;

import dao.RestaurantDao;
import daoImpl.RestaurantDaoImpl;
import model.Restaurant;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/restaurants")
public class RestaurantServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private RestaurantDao restaurantDao;

    @Override
    public void init() {
        restaurantDao = new RestaurantDaoImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("login.jsp?error=Please log in first to view restaurants");
            return;
        }

        List<Restaurant> restaurantList = restaurantDao.getAllRestaurants();
        request.setAttribute("restaurantList", restaurantList);
        
        request.getRequestDispatcher("restaurants.jsp").forward(request, response);
    }
}
