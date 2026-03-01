package dao;

import model.Order;
import model.OrderItem;
import java.util.List;

public interface OrderDao {
    boolean placeOrder(Order order, List<OrderItem> orderItems);
    List<Order> getOrdersByUser(int userId);
    List<OrderItem> getOrderItemsByOrder(int orderId);
    
    // RBAC Delivery features
    List<Order> getPendingOrders();
    List<Order> getOrdersByDeliveryBoy(int deliveryboyId);
    boolean assignDeliveryBoy(int orderId, int deliveryboyId);
    boolean updateDeliveryStatus(int orderId, String status);
}
