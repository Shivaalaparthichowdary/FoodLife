# FoodLife 🍔🥗🍕

FoodLife is a dynamic food delivery web application built using Java Servlets, JSP, JDBC, and MySQL. It features role-based access control, allowing Customers, Admin, Restaurant Owners, and Delivery Personnel to manage their respective activities.

## 🌟 Features
- **Role-Based Authentication**: Distinct user roles for `Customer`, `Admin`, `Restaurant Owner`, and `Delivery Boy` with tailored dashboards.
- **Restaurant Listings**: Browse and discover registered restaurants.
- **Menu Display**: View complete menus with item details and pricing.
- **Cart Management**: Add items to the cart, adjust quantities, and checkout.
- **Order Management**: Track orders, calculate total bills, and checkout securely.
- **Delivery Tracking**: Real-time status updates (Pending, Delivered).

## 🚀 Tech Stack
- **Backend:** Java 8+, Servlets, JSP
- **Database:** MySQL via JDBC
- **Frontend:** HTML, CSS, JavaScript
- **Server:** Apache Tomcat (Runs on port 8081)

## � System Requirements
Before you begin, ensure you have the following installed on your machine:
- **Java Development Kit (JDK):** Version 8 or higher (Java 11/17 recommended)
- **IDE:** Eclipse IDE for Enterprise Java and Web Developers (or IntelliJ IDEA Ultimate)
- **Web Server:** Apache Tomcat v9.0 or higher
- **Database:** MySQL Server (v5.7 or higher)
- **Database Client:** MySQL Workbench (optional, for running queries easily)

## 🛠️ Local Setup Instructions

Follow these step-by-step instructions to get the project running on your local machine:

1. **Clone the Project:**
   - Clone or download this repository to your local machine.

2. **Import into IDE:**
   - Open your IDE (e.g., Eclipse).
   - Import the project as an **Existing Maven Project** or **Dynamic Web Project**.
   - Ensure the project facet is set to Dynamic Web Module.

3. **Database Setup:**
   - Open your MySQL command-line tool or MySQL Workbench.
   - Run the SQL scripts provided in the **Database Schema & Setup Scripts** section below to create the necessary tables.

4. **Configure Database Connection:**
   - Navigate to `src/main/java/utils/DBConnection.java`.
   - Update the database credentials (`user`, `password`, and `url`) to match your local MySQL configuration.
     ```java
     // Example DBConnection.java Update
     private static final String URL = "jdbc:mysql://localhost:3306/foodlife";
     private static final String USER = "your_mysql_username"; 
     private static final String PASSWORD = "your_mysql_password";
     ```

5. **Server Setup:**
   - Add your Apache Tomcat server to your IDE.
   - Configure the server to run on port `8081` (or update your project accordingly if you prefer a different port).
   - Add the `FoodLife` project to your configured Tomcat server.

6. **Run the Application:**
   - Start the Tomcat server from your IDE.
   - Open your web browser and navigate to:
     ```
     http://localhost:8081/FoodLife
     ```

---

## 🗄️ Database Schema & Setup Scripts

Below are the SQL queries required to set up the FoodLife database tables exactly matching the application's underlying Data Access Objects.

Run the following queries in your MySQL server:

```sql
-- 1. Create the Database
CREATE DATABASE IF NOT EXISTS foodlife;
USE foodlife;

-- 2. Create the User Table 
-- Handles Customers, Admins, Restaurant Owners, and Delivery personnel.
CREATE TABLE user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phoneno VARCHAR(15),
    address TEXT,
    role VARCHAR(20) DEFAULT 'Customer' COMMENT 'Roles: Customer, Admin, Restaurant Owner, Delivery Boy',
    createdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Create the Restaurant Table
CREATE TABLE restaurant (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address TEXT NOT NULL,
    cuisineType VARCHAR(100),
    ratings FLOAT DEFAULT 0.0,
    etArrival INT COMMENT 'Estimated Time of Arrival in minutes',
    isActive BOOLEAN DEFAULT TRUE,
    imagepath VARCHAR(255),
    restaurantOwnerId INT,
    FOREIGN KEY (restaurantOwnerId) REFERENCES user(id) ON DELETE SET NULL
);

-- 4. Create the Menu Table
CREATE TABLE menu (
    id INT AUTO_INCREMENT PRIMARY KEY,
    restaurantId INT NOT NULL,
    itemName VARCHAR(100) NOT NULL,
    itemDescription TEXT,
    price DECIMAL(10, 2) NOT NULL,
    isAvailable BOOLEAN DEFAULT TRUE,
    imagePath VARCHAR(255),
    FOREIGN KEY (restaurantId) REFERENCES restaurant(id) ON DELETE CASCADE
);

-- 5. Create the Orders Table
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    userId INT NOT NULL,
    restaurantId INT NOT NULL,
    totalAmount DECIMAL(10,2) NOT NULL,
    modeOfPayment VARCHAR(50) DEFAULT 'Cash on Delivery',
    status VARCHAR(50) DEFAULT 'Pending' COMMENT 'Statuses: Pending, Processing, Delivered, etc.',
    orderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (userId) REFERENCES user(id),
    FOREIGN KEY (restaurantId) REFERENCES restaurant(id)
);

-- 6. Create the OrderItems Table
CREATE TABLE orderitems (
    id INT AUTO_INCREMENT PRIMARY KEY,
    orderId INT NOT NULL,
    menuItemId INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (orderId) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (menuItemId) REFERENCES menu(id)
);

-- 7. Create the OrderHistory Table
CREATE TABLE orderhistory (
    id INT AUTO_INCREMENT PRIMARY KEY,
    orderId INT NOT NULL,
    userId INT NOT NULL,
    historyDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (orderId) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (userId) REFERENCES user(id)
);
```

Once the database is set up and the project is deployed on Tomcat, navigate to `http://localhost:8081/FoodLife` to access the application!
