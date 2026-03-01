package dao;

import model.Menu;
import java.util.List;

public interface MenuDao {
    boolean addMenu(Menu menu);
    Menu getMenu(int menuId);
    boolean updateMenu(Menu menu);
    boolean deleteMenu(int menuId);
    List<Menu> getMenuByRestaurant(int restaurantId);
}
