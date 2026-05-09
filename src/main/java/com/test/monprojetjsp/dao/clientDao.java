/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.test.monprojetjsp.dao;

/**
 *
 * @author ME-PC
 */
import java.sql.*;
import java.util.*;
import com.test.monprojetjsp.model.client;

public class clientDao {

    // Ajouter
    public void ajouter(client c) {
    try {
        Connection con = DBConnection.getConnection();

        System.out.println("🔥 Connexion OK");

        String sql = "INSERT INTO client(numtel, nom, sexe, pays, solde, mail) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(sql);

        ps.setString(1, c.getNumtel());
        ps.setString(2, c.getNom());
        ps.setString(3, c.getSexe());
        ps.setString(4, c.getPays());
        ps.setInt(5, c.getSolde());
        ps.setString(6, c.getMail());

        System.out.println("Avant executeUpdate");

        ps.executeUpdate();

        System.out.println("INSERT OK");

    } catch(Exception e) {
        System.out.println(" ERREUR INSERT");
        e.printStackTrace();
    }
    }

    // Lister
    public List<client> liste() {
        List<client> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            ResultSet rs = con.createStatement().executeQuery("SELECT * FROM client");

            while(rs.next()) {
                client c = new client();
                c.setNumtel(rs.getString("numtel"));
                c.setNom(rs.getString("nom"));
                c.setSexe(rs.getString("sexe"));
                c.setPays(rs.getString("pays"));
                c.setSolde(rs.getInt("solde"));
                c.setMail(rs.getString("mail"));
                list.add(c);
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return list;
    }


    //Supprimer
    public void supprimer(String numtel) {
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("DELETE FROM client WHERE numtel=?");
            ps.setString(1, numtel);
            ps.executeUpdate();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    //Modifier
    public void modifier(client c) {
        try {
            Connection con = DBConnection.getConnection();
            String sql = "UPDATE client SET nom=?, sexe=?, pays=?, solde=?, mail=?, WHERE numtel=?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, c.getNom());
            ps.setString(2, c.getSexe());
            ps.setString(3, c.getPays());
            ps.setInt(4, c.getSolde());
            ps.setString(5, c.getMail());
            ps.setString(6, c.getNumtel());

            ps.executeUpdate();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    //Recherche LIKE
    public List<client> rechercher(String mot) {
        List<client> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM client WHERE nom LIKE ? OR sexe LIKE ? OR pays LIKE ? OR mail LIKE ? OR numtel LIKE?"
            );
            ps.setString(1,"%" + mot + "%");
            ps.setString(2,"%" + mot + "%");
            ps.setString(3,"%" + mot + "%");
            ps.setString(4,"%" + mot + "%");
            ps.setString(5,"%" + mot + "%");
            
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                client c= new client();
                c.setNumtel(rs.getString("numtel"));
                c.setNom(rs.getString("nom"));
                c.setSexe(rs.getString("sexe"));
                c.setPays(rs.getString("pays"));
                c.setSolde(rs.getInt("solde"));
                c.setMail(rs.getString("mail"));
                list.add(c);
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public client getByNum(String numtel){
        client c = null;
        
        try{
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM client WHERE numtel=?");
            ps.setString(1, numtel);
            
            ResultSet rs = ps.executeQuery();
            
            if(rs.next()){
                c = new client();
                c.setNumtel(rs.getString("numtel"));
                c.setNom(rs.getString("nom"));
                c.setSexe(rs.getString("sexe"));
                c.setPays(rs.getString("pays"));
                c.setSolde(rs.getInt("solde"));
                c.setMail(rs.getString("mail"));
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return c;
    }
    
    //login
    public client login(String mail, String password){
    client c = null;

    try{
        Connection con = DBConnection.getConnection();

        String sql = "SELECT * FROM client WHERE mail=? AND password=?";
        PreparedStatement ps = con.prepareStatement(sql);

        ps.setString(1, mail);
        ps.setString(2, password);

        ResultSet rs = ps.executeQuery();

        if(rs.next()){
            c = new client();
            c.setNumtel(rs.getString("numtel"));
            c.setNom(rs.getString("nom"));
            c.setMail(rs.getString("mail"));
        }

    }catch(Exception e){
        e.printStackTrace();
    }

    return c;
}
    
}

