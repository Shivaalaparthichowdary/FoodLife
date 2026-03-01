package model;

public class Menu {
    private int menuId;
    private String itemName;
    private String itemDescription;
    private double price;
    private String imagePath;
    private boolean isAvailable;
    private int restaurantId;

    public Menu() {
    }

    public Menu(int menuId, String itemName, String itemDescription, double price, String imagePath,
            boolean isAvailable, int restaurantId) {
        this.menuId = menuId;
        this.itemName = itemName;
        this.itemDescription = itemDescription;
        this.price = price;
        this.imagePath = imagePath;
        this.isAvailable = isAvailable;
        this.restaurantId = restaurantId;
    }

    public int getMenuId() {
        return menuId;
    }

    public void setMenuId(int menuId) {
        this.menuId = menuId;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getItemDescription() {
        return itemDescription;
    }

    public void setItemDescription(String itemDescription) {
        this.itemDescription = itemDescription;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public boolean isAvailable() {
        return isAvailable;
    }

    public void setAvailable(boolean isAvailable) {
        this.isAvailable = isAvailable;
    }

    public int getRestaurantId() {
        return restaurantId;
    }

    public void setRestaurantId(int restaurantId) {
        this.restaurantId = restaurantId;
    }
}
