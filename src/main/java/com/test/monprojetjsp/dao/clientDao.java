package com.test.monprojetjsp.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import com.test.monprojetjsp.model.client;

public class clientDao {

    private static void setDateNaissance(PreparedStatement ps, int idx, LocalDate d) throws SQLException {
        if (d == null) {
            ps.setNull(idx, Types.DATE);
        } else {
            ps.setDate(idx, java.sql.Date.valueOf(d));
        }
    }

    private static LocalDate readDateNaissance(ResultSet rs) throws SQLException {
        java.sql.Date d = rs.getDate("date_naissance");
        return d != null ? d.toLocalDate() : null;
    }

    public void ajouter(client c) {
        try {
            Connection con = DBConnection.getConnection();
            String sql = "INSERT INTO client(numtel, nom, sexe, pays, solde, mail, password, date_naissance) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, c.getNumtel());
            ps.setString(2, c.getNom());
            ps.setString(3, c.getSexe());
            ps.setString(4, c.getPays());
            ps.setInt(5, c.getSolde());
            ps.setString(6, c.getMail());
            ps.setString(7, c.getPassword());
            setDateNaissance(ps, 8, c.getDateNaissance());

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<client> liste() {
        List<client> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            ResultSet rs = con.createStatement().executeQuery("SELECT * FROM client");

            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void supprimer(String numtel) {
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("DELETE FROM client WHERE numtel=?");
            ps.setString(1, numtel);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void modifier(client c) {
        try {
            Connection con = DBConnection.getConnection();
            String sql = "UPDATE client SET nom=?, sexe=?, pays=?, solde=?, mail=?, password=?, date_naissance=? WHERE numtel=?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, c.getNom());
            ps.setString(2, c.getSexe());
            ps.setString(3, c.getPays());
            ps.setInt(4, c.getSolde());
            ps.setString(5, c.getMail());
            ps.setString(6, c.getPassword());
            setDateNaissance(ps, 7, c.getDateNaissance());
            ps.setString(8, c.getNumtel());

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<client> rechercher(String mot) {
        List<client> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM client WHERE nom LIKE ? OR sexe LIKE ? OR pays LIKE ? OR mail LIKE ? OR numtel LIKE?"
            );
            ps.setString(1, "%" + mot + "%");
            ps.setString(2, "%" + mot + "%");
            ps.setString(3, "%" + mot + "%");
            ps.setString(4, "%" + mot + "%");
            ps.setString(5, "%" + mot + "%");

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public client getByNum(String numtel) {
        client c = null;
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM client WHERE numtel=?");
            ps.setString(1, numtel);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                c = mapRow(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return c;
    }

    public client login(String mail, String password) {
        client c = null;
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM client WHERE mail=? AND password=?");
            ps.setString(1, mail);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                c = mapRow(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return c;
    }

    private static client mapRow(ResultSet rs) throws SQLException {
        client c = new client();
        c.setNumtel(rs.getString("numtel"));
        c.setNom(rs.getString("nom"));
        c.setSexe(rs.getString("sexe"));
        c.setPays(rs.getString("pays"));
        c.setSolde(rs.getInt("solde"));
        c.setMail(rs.getString("mail"));
        c.setPassword(rs.getString("password"));
        c.setDateNaissance(readDateNaissance(rs));
        return c;
    }
}
