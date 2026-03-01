package dao;

import model.Restaurant;
import java.util.List;

public interface RestaurantDao {
    boolean addRestaurant(Restaurant restaurant);
    Restaurant getRestaurant(int restaurantId);
    boolean updateRestaurant(Restaurant restaurant);
    boolean deleteRestaurant(int restaurantId);
    List<Restaurant> getAllRestaurants();
}
