package com.example.portal;

import java.sql.*;

public class DBUtil {
    private static Connection conn = null;

    public static Connection getConnection() {
        try {
            if (conn == null || conn.isClosed()) {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/campus_portal", 
                        "root",   // your MySQL username
                        "loot" // your MySQL password
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }

    public static void closeConnection() {
        try {
            if (conn != null) {
                conn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 🔹 NEW: Safe close method for ResultSet, PreparedStatement, Connection
    public static void close(ResultSet rs, PreparedStatement ps, Connection conn) {
        try {
            if (rs != null) rs.close();
        } catch (Exception e) { e.printStackTrace(); }

        try {
            if (ps != null) ps.close();
        } catch (Exception e) { e.printStackTrace(); }

        try {
            if (conn != null) conn.close();
        } catch (Exception e) { e.printStackTrace(); }
    }
}
