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
import com.test.monprojetjsp.model.fraisEnvoi;

public class fraisEnvoiDao {

    // ✅ Ajouter
    public void ajouter(fraisEnvoi f) {
    try {
        Connection con = DBConnection.getConnection();

        System.out.println("🔥 Connexion OK");

        String sql = "INSERT INTO frais_envoi(idfrais, montant1, montant2, frais) VALUES (?, ?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(sql);

        ps.setString(1, f.getIdfrais());
        ps.setInt(2, f.getMontant1());
        ps.setInt(3, f.getMontant2());
        ps.setFloat(4, f.getFrais());

        System.out.println("🔥 Avant executeUpdate");

        ps.executeUpdate();

        System.out.println("✅ INSERT OK");

    } catch(Exception e) {
        System.out.println("❌ ERREUR INSERT");
        e.printStackTrace();
    }
    }


    // ✅ Lister
    public List<fraisEnvoi> liste() {
        List<fraisEnvoi> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            ResultSet rs = con.createStatement().executeQuery("SELECT * FROM frais_envoi");

            while(rs.next()) {
                fraisEnvoi f = new fraisEnvoi();
                f.setIdfrais(rs.getString("idfrais"));
                f.setMontant1(rs.getInt("montant1"));
                f.setMontant2(rs.getInt("montant2"));
                f.setFrais(rs.getFloat("frais"));
                list.add(f);
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return list;
    }


    // ✅ Supprimer
    public void supprimer(String idfrais) {
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("DELETE FROM frais_envoi WHERE idfrais=?");
            ps.setString(1, idfrais);
            ps.executeUpdate();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    // ✅ Modifier
    public void modifier(fraisEnvoi f) {
        try {
            Connection con = DBConnection.getConnection();
            String sql = "UPDATE frais_envoi SET montant1=?, montant2=?, frais=? WHERE idfrais=?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, f.getMontant1());
            ps.setInt(2, f.getMontant2());
            ps.setFloat(3, f.getFrais());
            ps.setString(4, f.getIdfrais());

            ps.executeUpdate();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    // ✅ Recherche LIKE
    public List<fraisEnvoi> rechercher(String mot) {
        List<fraisEnvoi> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM frais_envoi WHERE idfrais LIKE? "
            );
            ps.setString(1,"%" + mot + "%");

            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                fraisEnvoi f = new fraisEnvoi();
                f.setIdfrais(rs.getString("idfrais"));
                f.setMontant1(rs.getInt("montant1"));
                f.setMontant2(rs.getInt("montant2"));
                f.setFrais(rs.getFloat("frais"));
                list.add(f);
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public fraisEnvoi getByNum(String idfrais){
        fraisEnvoi f = null;
        
        try{
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM frais_envoi WHERE idfrais=?");
            ps.setString(1, idfrais);
            
            ResultSet rs = ps.executeQuery();
            
            if(rs.next()){
                f = new fraisEnvoi();
                f.setIdfrais(rs.getString("idfrais"));
                f.setMontant1(rs.getInt("montant1"));
                f.setMontant2(rs.getInt("montant2"));
                f.setFrais(rs.getFloat("frais"));
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return f;
    }
    
    public float getFrais(int montant){
    float frais = 0;

    try{
        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement(
            "SELECT frais FROM frais_envoi WHERE montant1 <= ? AND montant2 >= ?"
        );

        ps.setInt(1, montant);
        ps.setInt(2, montant);

        ResultSet rs = ps.executeQuery();

        if(rs.next()){
            frais = rs.getFloat("frais");
        }

    }catch(Exception e){
        e.printStackTrace();
    }

    return frais;
}
}

