package dao;

import model.User;

public interface UserDao {
    boolean registerUser(User user);
    User loginUser(String username, String password);
    User getUserByEmail(String email);
    boolean updateUser(User user);
    boolean deleteUser(int userid);
}
