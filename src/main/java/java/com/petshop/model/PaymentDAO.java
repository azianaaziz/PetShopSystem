/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.petshop.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class PaymentDAO {
    private String jdbcURL = "jdbc:mysql://localhost:3306/petshop";
    private String jdbcUsername = "root";
    private String jdbcPassword = "admin";

    private static final String INSERT_PAYMENT_SQL = "INSERT INTO payments (card_number, expiry, card_name, same_address) VALUES (?, ?, ?, ?);";

    public void savePayment(PaymentModel payment) {
        try (Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_PAYMENT_SQL)) {
            preparedStatement.setString(1, payment.getCardNumber());
            preparedStatement.setString(2, payment.getExpiry());
            preparedStatement.setString(3, payment.getCardName());
            preparedStatement.setBoolean(4, payment.isSameAddress());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}