package daoImpl;

import dao.UserDao;
import model.User;
import util.DBConnection;

import java.sql.*;
import java.time.LocalDateTime;

public class UserDaoImpl implements UserDao {
    
    @Override
    public boolean registerUser(User user) {
        String query = "INSERT INTO user (username, password, email, address, role, createdate, phoneno, name) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getEmail());
            pstmt.setString(4, user.getAddress());
            pstmt.setString(5, user.getRole());
            pstmt.setTimestamp(6, java.sql.Timestamp.valueOf(LocalDateTime.now()));
            pstmt.setLong(7, user.getPhoneno());
            pstmt.setString(8, user.getName());
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public User loginUser(String username, String password) {
        String query = "SELECT * FROM user WHERE username = ? AND password = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                updateLastLogin(rs.getInt("userid"));
                return extractUserFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    private void updateLastLogin(int userId) {
        String updateQuery = "UPDATE user SET lastlogindate = ? WHERE userid = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(updateQuery)) {
            pstmt.setTimestamp(1, java.sql.Timestamp.valueOf(LocalDateTime.now()));
            pstmt.setInt(2, userId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public User getUserByEmail(String email) {
        String query = "SELECT * FROM user WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean updateUser(User user) {
        String query = "UPDATE user SET password=?, email=?, address=?, phoneno=?, name=? WHERE userid=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, user.getPassword());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getAddress());
            pstmt.setLong(4, user.getPhoneno());
            pstmt.setString(5, user.getName());
            pstmt.setInt(6, user.getUserid());
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean deleteUser(int userid) {
        String query = "DELETE FROM user WHERE userid = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, userid);
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private User extractUserFromResultSet(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserid(rs.getInt("userid"));
        user.setUsername(rs.getString("username"));
        user.setPassword(rs.getString("password"));
        user.setEmail(rs.getString("email"));
        user.setAddress(rs.getString("address"));
        user.setRole(rs.getString("role"));
        
        Timestamp created = rs.getTimestamp("createdate");
        if (created != null) {
            user.setCreatedate(created.toLocalDateTime());
        }
        Timestamp lastLogin = rs.getTimestamp("lastlogindate");
        if (lastLogin != null) {
            user.setLastlogindate(lastLogin.toLocalDateTime());
        }
        user.setPhoneno(rs.getLong("phoneno"));
        user.setName(rs.getString("name"));
        
        return user;
    }
}
