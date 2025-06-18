package cn.techtutorial.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbCon {
    private static final String DB_URL = "jdbc:mysql://switchback.proxy.rlwy.net:49496/railway";
    private static final String DB_USER = "root"; 
    private static final String DB_PASS = "CaxLOWsGEHcaUIMpeUqtCmLucuHVTNGS"; 

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
    }
}

