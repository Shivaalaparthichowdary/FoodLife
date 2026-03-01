package daoImpl;

import dao.RestaurantDao;
import model.Restaurant;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RestaurantDaoImpl implements RestaurantDao {

    @Override
    public boolean addRestaurant(Restaurant restaurant) {
        String query = "INSERT INTO restaurant (name, imagepath, ratings, etArrival, cuisineType, address, isActive, restaurantOwnerId) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, restaurant.getName());
            pstmt.setString(2, restaurant.getImagepath());
            pstmt.setDouble(3, restaurant.getRatings());
            pstmt.setString(4, restaurant.getEtArrival());
            pstmt.setString(5, restaurant.getCuisineType());
            pstmt.setString(6, restaurant.getAddress());
            pstmt.setBoolean(7, restaurant.isActive());
            pstmt.setInt(8, restaurant.getRestaurantOwnerId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public Restaurant getRestaurant(int restaurantId) {
        String query = "SELECT * FROM restaurant WHERE restaurantId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, restaurantId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return extractRestaurantFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean updateRestaurant(Restaurant r) {
        String query = "UPDATE restaurant SET name=?, imagepath=?, ratings=?, etArrival=?, cuisineType=?, address=?, isActive=? WHERE restaurantId=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, r.getName());
            pstmt.setString(2, r.getImagepath());
            pstmt.setDouble(3, r.getRatings());
            pstmt.setString(4, r.getEtArrival());
            pstmt.setString(5, r.getCuisineType());
            pstmt.setString(6, r.getAddress());
            pstmt.setBoolean(7, r.isActive());
            pstmt.setInt(8, r.getRestaurantId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean deleteRestaurant(int restaurantId) {
        String query = "DELETE FROM restaurant WHERE restaurantId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, restaurantId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<Restaurant> getAllRestaurants() {
        List<Restaurant> list = new ArrayList<>();
        String query = "SELECT * FROM restaurant WHERE isActive = 1";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            while (rs.next()) {
                list.add(extractRestaurantFromResultSet(rs));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    private Restaurant extractRestaurantFromResultSet(ResultSet rs) throws SQLException {
        Restaurant r = new Restaurant();
        r.setRestaurantId(rs.getInt("restaurantId"));
        r.setName(rs.getString("name"));
        r.setImagepath(rs.getString("imagepath"));
        r.setRatings(rs.getDouble("ratings"));
        r.setEtArrival(rs.getString("etArrival"));
        r.setCuisineType(rs.getString("cuisineType"));
        r.setAddress(rs.getString("address"));
        r.setActive(rs.getBoolean("isActive"));
        r.setRestaurantOwnerId(rs.getInt("restaurantOwnerId"));
        return r;
    }
}
