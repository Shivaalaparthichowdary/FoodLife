package model;

import java.time.LocalDateTime;

public class User {
    private int userid;
    private String username;
    private String password;
    private String email;
    private String address;
    private String role; // enum: 'customer', 'restaurantowner', 'deliveryboy', 'systemadmin'
    private LocalDateTime createdate;
    private LocalDateTime lastlogindate;
    private long phoneno;
    private String name;

    public User() {
    }

    public User(int userid, String username, String password, String email, String address, String role,
            LocalDateTime createdate, LocalDateTime lastlogindate, long phoneno, String name) {
        this.userid = userid;
        this.username = username;
        this.password = password;
        this.email = email;
        this.address = address;
        this.role = role;
        this.createdate = createdate;
        this.lastlogindate = lastlogindate;
        this.phoneno = phoneno;
        this.name = name;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public LocalDateTime getCreatedate() {
        return createdate;
    }

    public void setCreatedate(LocalDateTime createdate) {
        this.createdate = createdate;
    }

    public LocalDateTime getLastlogindate() {
        return lastlogindate;
    }

    public void setLastlogindate(LocalDateTime lastlogindate) {
        this.lastlogindate = lastlogindate;
    }

    public long getPhoneno() {
        return phoneno;
    }

    public void setPhoneno(long phoneno) {
        this.phoneno = phoneno;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
