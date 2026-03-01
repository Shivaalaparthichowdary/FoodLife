package dao;

import model.Order;
import model.OrderItem;
import java.util.List;

public interface OrderDao {
    boolean placeOrder(Order order, List<OrderItem> orderItems);
    List<Order> getOrdersByUser(int userId);
    List<OrderItem> getOrderItemsByOrder(int orderId);
}
