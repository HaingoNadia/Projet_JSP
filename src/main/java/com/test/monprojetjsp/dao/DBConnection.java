/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.test.monprojetjsp.dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    /** Override with env MYSQL_URL, MYSQL_USER, MYSQL_PASSWORD (defaults suit setup-mysql-dev.sql). */
    public static Connection getConnection() {
        Connection con = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String url = firstNonBlank(
                System.getenv("MYSQL_URL"),
                "jdbc:mysql://localhost:3306/taptapsend?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC"
            );
            String user = firstNonBlank(System.getenv("MYSQL_USER"), "taptapsend");
            String password = firstNonBlank(System.getenv("MYSQL_PASSWORD"), "taptapsend");

            con = DriverManager.getConnection(url, user, password);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return con;
    }

    private static String firstNonBlank(String value, String fallback) {
        if (value == null || value.isBlank()) {
            return fallback;
        }
        return value;
    }
    
    public static void main(String[] args) {
    Connection con = getConnection();

    if (con != null) {
        System.out.println("Connexion MySQL réussie !");
    } else {
        System.out.println("Échec connexion !");
    }
}
}