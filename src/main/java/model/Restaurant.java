package model;

public class Restaurant {
    private int restaurantId;
    private String name;
    private String imagepath;
    private double ratings;
    private String etArrival;
    private String cuisineType;
    private String address;
    private boolean isActive;
    private int restaurantOwnerId;

    public Restaurant() {
    }

    public Restaurant(int restaurantId, String name, String imagepath, double ratings, String etArrival,
            String cuisineType, String address, boolean isActive, int restaurantOwnerId) {
        this.restaurantId = restaurantId;
        this.name = name;
        this.imagepath = imagepath;
        this.ratings = ratings;
        this.etArrival = etArrival;
        this.cuisineType = cuisineType;
        this.address = address;
        this.isActive = isActive;
        this.restaurantOwnerId = restaurantOwnerId;
    }

    public int getRestaurantId() {
        return restaurantId;
    }

    public void setRestaurantId(int restaurantId) {
        this.restaurantId = restaurantId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImagepath() {
        return imagepath;
    }

    public void setImagepath(String imagepath) {
        this.imagepath = imagepath;
    }

    public double getRatings() {
        return ratings;
    }

    public void setRatings(double ratings) {
        this.ratings = ratings;
    }

    public String getEtArrival() {
        return etArrival;
    }

    public void setEtArrival(String etArrival) {
        this.etArrival = etArrival;
    }

    public String getCuisineType() {
        return cuisineType;
    }

    public void setCuisineType(String cuisineType) {
        this.cuisineType = cuisineType;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean isActive) {
        this.isActive = isActive;
    }

    public int getRestaurantOwnerId() {
        return restaurantOwnerId;
    }

    public void setRestaurantOwnerId(int restaurantOwnerId) {
        this.restaurantOwnerId = restaurantOwnerId;
    }
}
