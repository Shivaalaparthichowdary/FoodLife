package controllers;

import dao.MenuDao;
import daoImpl.MenuDaoImpl;
import model.CartItem;
import model.Menu;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
        }

        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect("cart.jsp");
            return;
        }

        try {
            if ("add".equals(action)) {
                int menuId = Integer.parseInt(request.getParameter("menuId"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                
                MenuDao menuDao = new MenuDaoImpl();
                Menu menu = menuDao.getMenu(menuId);
                
                if (menu != null) {
                    if (!cart.isEmpty()) {
                        int existingRestId = cart.values().iterator().next().getRestaurantId();
                        if (existingRestId != menu.getRestaurantId()) {
                            response.sendRedirect("menu?restaurantId=" + menu.getRestaurantId() + "&error=Cannot+add+items+from+a+different+restaurant.+Please+clear+cart+first.");
                            return;
                        }
                    }

                    if (cart.containsKey(menuId)) {
                        CartItem item = cart.get(menuId);
                        item.setQuantity(item.getQuantity() + quantity);
                    } else {
                        CartItem newItem = new CartItem(menu.getMenuId(), menu.getRestaurantId(), menu.getItemName(), quantity, menu.getPrice());
                        cart.put(menuId, newItem);
                    }
                }
                session.setAttribute("cart", cart);
                response.sendRedirect("menu?restaurantId=" + request.getParameter("restaurantId") + "&success=Item+added+to+cart");

            } else if ("update".equals(action)) {
                int itemId = Integer.parseInt(request.getParameter("itemId"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                if (cart.containsKey(itemId)) {
                    if (quantity <= 0) {
                        cart.remove(itemId);
                    } else {
                        cart.get(itemId).setQuantity(quantity);
                    }
                }
                session.setAttribute("cart", cart);
                response.sendRedirect("cart.jsp");

            } else if ("remove".equals(action)) {
                int itemId = Integer.parseInt(request.getParameter("itemId"));
                cart.remove(itemId);
                session.setAttribute("cart", cart);
                response.sendRedirect("cart.jsp");
                
            } else if ("clear".equals(action)) {
                cart.clear();
                session.setAttribute("cart", cart);
                response.sendRedirect("cart.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("cart.jsp?error=Invalid+action");
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("cart.jsp");
    }
}
