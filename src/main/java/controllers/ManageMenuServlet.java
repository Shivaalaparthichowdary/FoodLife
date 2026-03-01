package controllers;

import dao.MenuDao;
import daoImpl.MenuDaoImpl;
import model.Menu;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/manageMenu")
public class ManageMenuServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int rId = Integer.parseInt(request.getParameter("restaurantId"));
        String name = request.getParameter("itemName");
        double price = Double.parseDouble(request.getParameter("price"));

        Menu m = new Menu();
        m.setItemName(name);
        m.setPrice(price);
        m.setRestaurantId(rId);
        m.setAvailable(true);

        MenuDao dao = new MenuDaoImpl();
        if (dao.addMenu(m)) {
            response.sendRedirect("adminDashboard?success=Menu+added+successfully");
        } else {
            response.sendRedirect("adminDashboard?error=Failed+to+add+menu");
        }
    }
}
