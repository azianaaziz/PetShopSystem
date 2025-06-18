package com.petshop.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    private String jdbcURL;
    private String jdbcUsername;
    private String jdbcPassword;

    // Constructor for environment-based (Railway) or local connection
    public UserDAO() {
        String envUrl = System.getenv("MYSQL_URL");
        String envUser = System.getenv("MYSQL_USER");
        String envPass = System.getenv("MYSQL_PASSWORD");

        if (envUrl != null && !envUrl.isEmpty()) {
            jdbcURL = envUrl;
            jdbcUsername = envUser;
            jdbcPassword = envPass;
        } else {
            jdbcURL = "jdbc:mysql://switchback.proxy.rlwy.net:49496/railway";
            jdbcUsername = "root";
            jdbcPassword = "CaxLOWsGEHcaUIMpeUqtCmLucuHVTNGS";
        }
    }

    protected Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            if (jdbcUsername.isEmpty()) {
                connection = DriverManager.getConnection(jdbcURL); // Railway
            } else {
                connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword); // Local
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return connection;
    }

    // For PET table (used in PetServlet)
    private static final String INSERT_PET_SQL = "INSERT INTO Pets (name, title, details, image) VALUES (?, ?, ?, ?)";
    private static final String SELECT_ALL_PETS = "SELECT * FROM Pets";

    // For USER table (used in Registration/Login)
    private static final String INSERT_USERS_SQL = "INSERT INTO Users (fullName, phoneNumber, username, password, email) VALUES (?, ?, ?, ?, ?)";
    private static final String SELECT_ALL_USERS = "SELECT * FROM Users";
    private static final String SELECT_USER_BY_USERNAME = "SELECT * FROM Users WHERE username = ?";
    private static final String UPDATE_USER_SQL = "UPDATE Users SET fullName = ?, phoneNumber = ?, username = ?, password = ?, email = ? WHERE id = ?";
    private static final String DELETE_USER_SQL = "DELETE FROM Users WHERE username = ?";

    // ========== PET METHODS (for PetServlet) ==========

    public void insertUser(User user) { // For Pets
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_PET_SQL)) {
            preparedStatement.setString(1, user.getName());
            preparedStatement.setString(2, user.getTitle());
            preparedStatement.setString(3, user.getDetails());
            preparedStatement.setString(4, user.getImage());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<User> selectAllUsers() { // For Pets
        List<User> users = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_PETS)) {
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String title = rs.getString("title");
                String details = rs.getString("details");
                String image = rs.getString("image");
                users.add(new User(id, name, title, details, image));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    // ========== USER METHODS (for Registration/Login) ==========

    public int saveUser(RegistrationUser user) { // Used by RegistrationServlet
        int result = 0;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USERS_SQL)) {
            preparedStatement.setString(1, user.getFullName());
            preparedStatement.setString(2, user.getPhoneNumber());
            preparedStatement.setString(3, user.getUsername());
            preparedStatement.setString(4, user.getPassword());
            preparedStatement.setString(5, user.getEmail());
            result = preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public List<RegistrationUser> selectAllUsersForRegistration() { // Optional if needed
        List<RegistrationUser> users = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_USERS)) {
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String fullName = rs.getString("fullName");
                String phoneNumber = rs.getString("phoneNumber");
                String username = rs.getString("username");
                String password = rs.getString("password");
                String email = rs.getString("email");
                users.add(new RegistrationUser(id, fullName, phoneNumber, username, password, email));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    public RegistrationUser getUserByUsername(String username) { // Used by LoginServlet
        RegistrationUser user = null;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_USER_BY_USERNAME)) {
            preparedStatement.setString(1, username);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("id");
                String fullName = rs.getString("fullName");
                String phoneNumber = rs.getString("phoneNumber");
                String password = rs.getString("password");
                String email = rs.getString("email");
                user = new RegistrationUser(id, fullName, phoneNumber, username, password, email);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    public int updateUser(RegistrationUser user) { // Optional
        int result = 0;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_USER_SQL)) {
            preparedStatement.setString(1, user.getFullName());
            preparedStatement.setString(2, user.getPhoneNumber());
            preparedStatement.setString(3, user.getUsername());
            preparedStatement.setString(4, user.getPassword());
            preparedStatement.setString(5, user.getEmail());
            preparedStatement.setInt(6, user.getId());
            result = preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public int deleteUserByUsername(String username) { // Optional
        int result = 0;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_USER_SQL)) {
            preparedStatement.setString(1, username);
            result = preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
}
