/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.test.monprojetjsp.dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    public static Connection getConnection() {
        Connection con = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/taptapsend",
                "root",
                ""
            );

        } catch (Exception e) {
            e.printStackTrace();
        }

        return con;
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