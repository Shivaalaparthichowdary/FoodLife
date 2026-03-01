package daoImpl;

import dao.OrderDao;
import model.Order;
import model.OrderItem;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDaoImpl implements OrderDao {

    @Override
    public boolean placeOrder(Order order, List<OrderItem> orderItems) {
        Connection conn = null;
        String insertOrderStr = "INSERT INTO orders (userId, restaurantId, totalAmount, modeOfPayment, status) VALUES (?, ?, ?, ?, ?)";
        String insertItemStr = "INSERT INTO orderitems (orderId, menuItemId, quantity, price) VALUES (?, ?, ?, ?)";
        String insertHistoryStr = "INSERT INTO orderhistory (orderId, userId) VALUES (?, ?)";

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Begin transaction
            
            // 1. Insert Order
            int generatedOrderId = -1;
            try (PreparedStatement pstmtOrder = conn.prepareStatement(insertOrderStr, Statement.RETURN_GENERATED_KEYS)) {
                pstmtOrder.setInt(1, order.getUserId());
                pstmtOrder.setInt(2, order.getRestaurantId());
                pstmtOrder.setDouble(3, order.getTotalAmount());
                pstmtOrder.setString(4, order.getModeOfPayment());
                pstmtOrder.setString(5, order.getStatus());
                
                int rows = pstmtOrder.executeUpdate();
                if (rows > 0) {
                    try (ResultSet rs = pstmtOrder.getGeneratedKeys()) {
                        if (rs.next()) {
                            generatedOrderId = rs.getInt(1);
                            order.setOrderId(generatedOrderId);
                        }
                    }
                }
            }
            
            if (generatedOrderId == -1) {
                conn.rollback();
                return false;
            }
            
            // 2. Insert Order Items
            try (PreparedStatement pstmtItems = conn.prepareStatement(insertItemStr)) {
                for (OrderItem item : orderItems) {
                    pstmtItems.setInt(1, generatedOrderId);
                    pstmtItems.setInt(2, item.getMenuItemId());
                    pstmtItems.setInt(3, item.getQuantity());
                    pstmtItems.setDouble(4, item.getPrice());
                    pstmtItems.addBatch();
                }
                pstmtItems.executeBatch();
            }
            
            // 3. Insert Order History
            try (PreparedStatement pstmtHistory = conn.prepareStatement(insertHistoryStr)) {
                pstmtHistory.setInt(1, generatedOrderId);
                pstmtHistory.setInt(2, order.getUserId());
                pstmtHistory.executeUpdate();
            }
            
            conn.commit(); // Commit transaction
            return true;
            
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return false;
    }

    @Override
    public List<Order> getOrdersByUser(int userId) {
        List<Order> list = new ArrayList<>();
        String query = "SELECT o.orderId, o.totalAmount, o.status, r.name as restaurantName " +
                       "FROM orders o JOIN restaurant r ON o.restaurantId = r.restaurantId " +
                       "WHERE o.userId = ? ORDER BY o.orderId DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("orderId"));
                order.setTotalAmount(rs.getDouble("totalAmount"));
                order.setStatus(rs.getString("status"));
                order.setRestaurantName(rs.getString("restaurantName"));
                list.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<OrderItem> getOrderItemsByOrder(int orderId) {
        List<OrderItem> list = new ArrayList<>();
        String query = "SELECT oi.quantity, m.itemName, oi.price " +
                       "FROM orderitems oi JOIN menu m ON oi.menuItemId = m.menuId " +
                       "WHERE oi.orderId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, orderId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setQuantity(rs.getInt("quantity"));
                item.setItemName(rs.getString("itemName"));
                item.setPrice(rs.getDouble("price"));
                list.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<Order> getPendingOrders() {
        List<Order> list = new ArrayList<>();
        String query = "SELECT o.orderId, o.userId, o.restaurantId, o.totalAmount, o.status, o.modeOfPayment, o.deliveryboyId, o.deliveryStatus, r.name as restaurantName " +
                       "FROM orders o JOIN restaurant r ON o.restaurantId = r.restaurantId " +
                       "WHERE o.deliveryStatus = 'Pending' OR o.deliveryStatus IS NULL ORDER BY o.orderId DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("orderId"));
                order.setUserId(rs.getInt("userId"));
                order.setRestaurantId(rs.getInt("restaurantId"));
                order.setTotalAmount(rs.getDouble("totalAmount"));
                order.setStatus(rs.getString("status"));
                order.setModeOfPayment(rs.getString("modeOfPayment"));
                order.setDeliveryboyId(rs.getInt("deliveryboyId"));
                order.setDeliveryStatus(rs.getString("deliveryStatus"));
                order.setRestaurantName(rs.getString("restaurantName"));
                list.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<Order> getOrdersByDeliveryBoy(int deliveryboyId) {
        List<Order> list = new ArrayList<>();
        String query = "SELECT o.orderId, o.userId, o.restaurantId, o.totalAmount, o.status, o.modeOfPayment, o.deliveryboyId, o.deliveryStatus, r.name as restaurantName " +
                       "FROM orders o JOIN restaurant r ON o.restaurantId = r.restaurantId " +
                       "WHERE o.deliveryboyId = ? ORDER BY o.orderId DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, deliveryboyId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("orderId"));
                order.setUserId(rs.getInt("userId"));
                order.setRestaurantId(rs.getInt("restaurantId"));
                order.setTotalAmount(rs.getDouble("totalAmount"));
                order.setStatus(rs.getString("status"));
                order.setModeOfPayment(rs.getString("modeOfPayment"));
                order.setDeliveryboyId(rs.getInt("deliveryboyId"));
                order.setDeliveryStatus(rs.getString("deliveryStatus"));
                order.setRestaurantName(rs.getString("restaurantName"));
                list.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public boolean assignDeliveryBoy(int orderId, int deliveryboyId) {
        String query = "UPDATE orders SET deliveryboyId = ?, deliveryStatus = 'Assigned', status = 'Out for Delivery' WHERE orderId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, deliveryboyId);
            pstmt.setInt(2, orderId);
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean updateDeliveryStatus(int orderId, String status) {
        String query = "UPDATE orders SET deliveryStatus = ?, status = ? WHERE orderId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, status);
            pstmt.setString(2, status);
            pstmt.setInt(3, orderId);
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
