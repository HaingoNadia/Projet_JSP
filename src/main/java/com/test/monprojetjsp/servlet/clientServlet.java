/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.test.monprojetjsp.servlet;

/**
 *
 * @author ME-PC
 */
import com.test.monprojetjsp.dao.clientDao;
import com.test.monprojetjsp.model.client;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;

public class clientServlet extends HttpServlet{
    
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {

    String action = req.getParameter("action");
    String keyword = req.getParameter("keyword");
    clientDao dao = new clientDao();
    HttpSession session = req.getSession();

    // 🔴 SUPPRESSION
    if("delete".equals(action)) {
        String num = req.getParameter("numtel");
        dao.supprimer(num);
        session.setAttribute("msg", "Client supprimé");
        res.sendRedirect(req.getContextPath() + "/clientServlet");
        return;
    }
    
    if("add".equals(action)){
        req.getRequestDispatcher("ajouterClient.jsp").forward(req, res);
        return;
    }
    
    if("edit".equals(action)){
        String num = req.getParameter("numtel");
        
        client c = dao.getByNum(num);
        if (c == null) {
            session.setAttribute("msg", "Client introuvable ou numéro manquant.");
            res.sendRedirect(req.getContextPath() + "/clientServlet");
            return;
        }
        req.setAttribute("client", c);
        
        req.getRequestDispatcher("ajouterClient.jsp").forward(req, res);
        return;
    }
    
    List<client> liste;
    
    if(keyword != null && !keyword.trim().isEmpty()){
        liste = dao.rechercher(keyword);
        System.out.println("recherche:" + keyword);
    }else{
        liste = dao.liste();
    }
  
    req.setAttribute("liste", liste);
    req.getRequestDispatcher("client.jsp").forward(req, res);
}
    
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {

        System.out.println("🔥 doPost exécuté !");
        String action = req.getParameter("action");
        if(action != null) action = action.trim();
        
        try {
            client c = new client();

            c.setNumtel(req.getParameter("numtel"));
            c.setNom(req.getParameter("nom"));
            c.setSexe(req.getParameter("sexe"));
            c.setPays(req.getParameter("pays"));

        // 🔥 IMPORTANT : sécuriser solde
            String soldeStr = req.getParameter("solde");
            if(soldeStr != null && !soldeStr.isEmpty()){
                c.setSolde(Double.parseDouble(soldeStr.replace(',', '.')));
            } else {
                c.setSolde(0);
            }
            c.setMail(req.getParameter("mail"));
            clientDao dao = new clientDao();
            String pw = req.getParameter("password");
            if (pw != null) {
                pw = pw.trim();
            }
            if ("update".equals(action) && (pw == null || pw.isEmpty())) {
                client existing = dao.getByNum(c.getNumtel());
                if (existing != null && existing.getPassword() != null) {
                    c.setPassword(existing.getPassword());
                } else {
                    c.setPassword("");
                }
            } else {
                c.setPassword(pw != null ? pw : "");
            }

            String dn = req.getParameter("dateNaissance");
            if (dn != null && !dn.isBlank()) {
                try {
                    c.setDateNaissance(LocalDate.parse(dn));
                } catch (DateTimeParseException ex) {
                    c.setDateNaissance(null);
                }
            } else {
                c.setDateNaissance(null);
            }

            HttpSession session = req.getSession();

            if("update".equals(action)){
                dao.modifier(c);
                session.setAttribute("msg", "Client modifié avec succès");
                
                res.sendRedirect(req.getContextPath() + "/clientServlet");
                return;
            }else{
                dao.ajouter(c);
                session.setAttribute("msg", "Client ajouté avec succès");

                res.sendRedirect(req.getContextPath() + "/clientServlet");
                return;
            }
            
        } catch(Exception e) {
            e.printStackTrace();
            res.sendRedirect(req.getContextPath() + "/clientServlet?msg=error");
        }

        res.sendRedirect(req.getContextPath() + "/clientServlet");
    }
}
