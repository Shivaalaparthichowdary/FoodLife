package controllers;

import dao.RestaurantDao;
import daoImpl.RestaurantDaoImpl;
import model.Restaurant;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/manageRestaurant")
public class ManageRestaurantServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String cuisine = request.getParameter("cuisineType");
        String address = request.getParameter("address");

        Restaurant r = new Restaurant();
        r.setName(name);
        r.setCuisineType(cuisine);
        r.setAddress(address);
        r.setActive(true);

        RestaurantDao dao = new RestaurantDaoImpl();
        if (dao.addRestaurant(r)) {
            response.sendRedirect("adminDashboard?success=Restaurant+added+successfully");
        } else {
            response.sendRedirect("adminDashboard?error=Failed+to+add+restaurant");
        }
    }
}
