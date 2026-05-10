/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.test.monprojetjsp.dao;

import com.test.monprojetjsp.model.envoyer;
import com.test.monprojetjsp.dao.fraisEnvoiDao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.time.*;

public class envoyerDao {

    /** MySQL TIMESTAMP: préférer Timestamp pour éviter les dates nulles selon le driver. */
    private static LocalDateTime readDate(ResultSet rs) throws java.sql.SQLException {
        Timestamp ts = rs.getTimestamp("date");
        return ts != null ? ts.toLocalDateTime() : null;
    }

    // Ajouter
    public void ajouter(envoyer env) {
    try {
        Connection con = DBConnection.getConnection();

        System.out.println("🔥 Connexion OK");

        String sql = "INSERT INTO envoyer(idEnv, numEnvoyeur, numRecepteur, montant, date, raison) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(sql);

        ps.setString(1, env.getIdEnv());
        ps.setString(2, env.getNumEnvoyeur());
        ps.setString(3, env.getNumRecepteur());
        ps.setInt(4, env.getMontant());
        ps.setObject(5, env.getDate());
        ps.setString(6, env.getRaison());

        System.out.println("🔥 Avant executeUpdate");

        ps.executeUpdate();

        System.out.println("✅ INSERT OK");

    } catch(Exception e) {
        System.out.println("❌ ERREUR INSERT");
        e.printStackTrace();
    }
    }


    // Lister
    public List<envoyer> liste() {
        List<envoyer> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            ResultSet rs = con.createStatement().executeQuery("SELECT * FROM envoyer");

            while(rs.next()) {
                envoyer env = new envoyer();
                env.setIdEnv(rs.getString("idEnv"));
                env.setNumEnvoyeur(rs.getString("numEnvoyeur"));
                env.setNumRecepteur(rs.getString("numRecepteur"));
                env.setMontant(rs.getInt("montant"));
                env.setDate(readDate(rs));
                env.setRaison(rs.getString("raison"));
                list.add(env);
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
            PreparedStatement ps = con.prepareStatement("DELETE FROM envoyer WHERE idEnv=?");
            ps.setString(1, numtel);
            ps.executeUpdate();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    //Modifier
    public void modifier(envoyer env) {
        try {
            Connection con = DBConnection.getConnection();
            String sql = "UPDATE envoyer SET numEnvoyeur=?, numRecepteur=?, montant=?, date=?, raison=? WHERE idEnv=?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, env.getNumEnvoyeur());
            ps.setString(2, env.getNumRecepteur());
            ps.setInt(3, env.getMontant());
            ps.setObject(4, env.getDate());
            ps.setString(5, env.getRaison());
            ps.setString(6, env.getIdEnv());

            ps.executeUpdate();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    //Recherche LIKE par date
    public List<envoyer> rechercher(LocalDate date) {
        List<envoyer> list = new ArrayList<>();
        String sql = "SELECT * FROM envoyer WHERE DATE(date) = ?";
        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)){
                ps.setDate(1, java.sql.Date.valueOf(date));
                ResultSet rs = ps.executeQuery();
                while(rs.next()) {
                envoyer env = new envoyer();
                env.setIdEnv(rs.getString("idEnv"));
                env.setNumEnvoyeur(rs.getString("numEnvoyeur"));
                env.setNumRecepteur(rs.getString("numRecepteur"));
                env.setMontant(rs.getInt("montant"));
                env.setDate(readDate(rs));
                env.setRaison(rs.getString("raison"));
                list.add(env);
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
           
        return list;
    }
    
    public envoyer getByNum(String idEnv){
        envoyer env = null;
        
        try{
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM envoyer WHERE idEnv=?");
            ps.setString(1,idEnv);
            
            ResultSet rs = ps.executeQuery();
            
            if(rs.next()){
                env = new envoyer();
                env.setIdEnv(rs.getString("idEnv"));
                env.setNumEnvoyeur(rs.getString("numEnvoyeur"));
                env.setNumRecepteur(rs.getString("numRecepteur"));
                env.setMontant(rs.getInt("montant"));
                env.setDate(readDate(rs));
                env.setRaison(rs.getString("raison"));
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return env;
    }
    
    public List<envoyer> getByClient(String num){
    List<envoyer> list = new ArrayList<>();
    try{
        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement(
            "SELECT * FROM envoyer WHERE numEnvoyeur=?");
        ps.setString(1, num);

        ResultSet rs = ps.executeQuery();

        while(rs.next()){
            envoyer e = new envoyer();
            e.setIdEnv(rs.getString("idEnv"));
            e.setNumEnvoyeur(rs.getString("numEnvoyeur"));
            e.setNumRecepteur(rs.getString("numRecepteur"));
            e.setMontant(rs.getInt("montant"));
            e.setDate(readDate(rs));
            e.setRaison(rs.getString("raison"));
            list.add(e);
        }

    }catch(Exception e){
        e.printStackTrace();
    }
    return list;
}
    /** Relevé mensuel pour le PDF (mois 1–12 + année). */
    public List<envoyer> getByClientAndMonth(String num, int mois, int annee) {
    List<envoyer> list = new ArrayList<>();

    try{
        Connection con = DBConnection.getConnection();

        PreparedStatement ps = con.prepareStatement(
            "SELECT * FROM envoyer WHERE numEnvoyeur=? AND MONTH(date)=? AND YEAR(date)=?"
        );

        ps.setString(1, num);
        ps.setInt(2, mois);
        ps.setInt(3, annee);

        ResultSet rs = ps.executeQuery();

        while(rs.next()){
            envoyer e = new envoyer();
            e.setIdEnv(rs.getString("idEnv"));
            e.setNumEnvoyeur(rs.getString("numEnvoyeur"));
            e.setNumRecepteur(rs.getString("numRecepteur"));
            e.setMontant(rs.getInt("montant"));
            e.setDate(rs.getTimestamp("date").toLocalDateTime());
            e.setRaison(rs.getString("raison"));
            list.add(e);
        }

    }catch(Exception e){
        e.printStackTrace();
    }

    return list;
}
    
    public float getRecetteTotale() {

    float total = 0;

    try {

        Connection con = DBConnection.getConnection();

        String sql = "SELECT montant FROM envoyer";

        PreparedStatement ps = con.prepareStatement(sql);

        ResultSet rs = ps.executeQuery();

        fraisEnvoiDao fdao = new fraisEnvoiDao();

        while(rs.next()){

            int montant = rs.getInt("montant");

            // calcul frais automatique
            float frais = fdao.getFrais(montant);

            total += frais;
        }

    } catch(Exception e){
        e.printStackTrace();
    }

    return total;
}
}
