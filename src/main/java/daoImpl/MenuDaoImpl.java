package daoImpl;

import dao.MenuDao;
import model.Menu;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MenuDaoImpl implements MenuDao {

    @Override
    public boolean addMenu(Menu menu) {
        String query = "INSERT INTO menu (itemName, itemDescription, price, imagePath, isAvailable, restaurantId) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, menu.getItemName());
            pstmt.setString(2, menu.getItemDescription());
            pstmt.setDouble(3, menu.getPrice());
            pstmt.setString(4, menu.getImagePath());
            pstmt.setBoolean(5, menu.isAvailable());
            pstmt.setInt(6, menu.getRestaurantId());
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public Menu getMenu(int menuId) {
        String query = "SELECT * FROM menu WHERE menuId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, menuId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return extractMenuFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean updateMenu(Menu menu) {
        String query = "UPDATE menu SET itemName=?, itemDescription=?, price=?, imagePath=?, isAvailable=? WHERE menuId=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, menu.getItemName());
            pstmt.setString(2, menu.getItemDescription());
            pstmt.setDouble(3, menu.getPrice());
            pstmt.setString(4, menu.getImagePath());
            pstmt.setBoolean(5, menu.isAvailable());
            pstmt.setInt(6, menu.getMenuId());
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean deleteMenu(int menuId) {
        String query = "DELETE FROM menu WHERE menuId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, menuId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<Menu> getMenuByRestaurant(int restaurantId) {
        List<Menu> list = new ArrayList<>();
        String query = "SELECT * FROM menu WHERE restaurantId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, restaurantId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                list.add(extractMenuFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    private Menu extractMenuFromResultSet(ResultSet rs) throws SQLException {
        Menu menu = new Menu();
        menu.setMenuId(rs.getInt("menuId"));
        menu.setItemName(rs.getString("itemName"));
        menu.setItemDescription(rs.getString("itemDescription"));
        menu.setPrice(rs.getDouble("price"));
        menu.setImagePath(rs.getString("imagePath"));
        menu.setAvailable(rs.getBoolean("isAvailable"));
        menu.setRestaurantId(rs.getInt("restaurantId"));
        return menu;
    }
}
