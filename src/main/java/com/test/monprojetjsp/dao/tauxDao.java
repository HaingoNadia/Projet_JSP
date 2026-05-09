/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.test.monprojetjsp.dao;

import com.test.monprojetjsp.model.taux;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.time.*;

public class tauxDao {
    
    public int getTaux(){
        int taux = 1;
        try{
            Connection con = DBConnection.getConnection();
            ResultSet rs = con.createStatement()
                .executeQuery("SELECT montant2 FROM taux LIMIT 1");

            if(rs.next()){
                taux = rs.getInt("montant2");
            }

        }catch(Exception e){
            e.printStackTrace();
        }
        return taux;
    }

    // ✅ Ajouter
    public void ajouter(taux t) {
    try {
        Connection con = DBConnection.getConnection();

        System.out.println("🔥 Connexion OK");

        String sql = "INSERT INTO taux(idtaux, montant1, montant2) VALUES (?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(sql);

        ps.setString(1, t.getIdtaux());
        ps.setInt(2, t.getMontant1());
        ps.setInt(3, t.getMontant2());

        System.out.println("🔥 Avant executeUpdate");

        ps.executeUpdate();

        System.out.println("✅ INSERT OK");

    } catch(Exception e) {
        System.out.println("❌ ERREUR INSERT");
        e.printStackTrace();
    }
    }


    // ✅ Lister
    public List<taux> liste() {
        List<taux> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            ResultSet rs = con.createStatement().executeQuery("SELECT * FROM taux");

            while(rs.next()) {
                taux t = new taux();
                t.setIdtaux(rs.getString("idtaux"));
                t.setMontant1(rs.getInt("montant1"));
                t.setMontant2(rs.getInt("montant2"));
                list.add(t);
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return list;
    }


    // ✅ Supprimer
    public void supprimer(String idtaux) {
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("DELETE FROM taux WHERE idtaux=?");
            ps.setString(1, idtaux);
            ps.executeUpdate();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    // ✅ Modifier
    public void modifier(taux t) {
        try {
            Connection con = DBConnection.getConnection();
            String sql = "UPDATE taux SET montant1=?, montant2=? WHERE idtaux=?"; 
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, t.getMontant1());
            ps.setInt(2, t.getMontant2());
            ps.setString(3, t.getIdtaux());

            ps.executeUpdate();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    // ✅ Recherche LIKE
    public List<taux> rechercher(String mot) {
        List<taux> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM taux WHERE montant1 LIKE ? OR montant2 LIKE ? OR idtaux Like ?"
            );
            ps.setString(1, "%" + mot + "%");
            ps.setString(2, "%" + mot + "%");
            ps.setString(3, "%" + mot + "%");

            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                taux t = new taux();
                t.setIdtaux(rs.getString("idtaux"));
                t.setMontant1(rs.getInt("montant1"));
                t.setMontant2(rs.getInt("montant2"));
                list.add(t);
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public taux getByNum(String idtaux){
        taux t= null;
        
        try{
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM taux WHERE idtaux=?");
            ps.setString(1, idtaux);
            
            ResultSet rs = ps.executeQuery();
            
            if(rs.next()){
                t = new taux();
                t.setIdtaux(rs.getString("idtaux"));
                t.setMontant1(rs.getInt("montant1"));
                t.setMontant2(rs.getInt("montant2"));
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return t;
    }
    
}
