/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.test.monprojetjsp.servlet;

/**
 *
 * @author ME-PC
 */
import com.test.monprojetjsp.dao.fraisEnvoiDao;
import com.test.monprojetjsp.model.fraisEnvoi;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class fraisEnvoiServlet extends HttpServlet{
    
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {

    String action = req.getParameter("action");
    String keyword = req.getParameter("keyword");
    fraisEnvoiDao dao = new fraisEnvoiDao();
    HttpSession session = req.getSession();

    // 🔴 SUPPRESSION
    if("delete".equals(action)) {
        String id = req.getParameter("idfrais");
        dao.supprimer(id);
        session.setAttribute("msg", "Frais suprimer avec succès");
        res.sendRedirect("fraisEnvoiServlet");
        return;
    }
    
    if("add".equals(action)){
        req.getRequestDispatcher("ajouterFraisEnvoi.jsp").forward(req, res);
        return;
    }
    
    if("edit".equals(action)){
        String id = req.getParameter("idfrais");
        
        fraisEnvoi f = dao.getByNum(id);
        req.setAttribute("fraisEnvoi", f);
        
        req.getRequestDispatcher("ajouterFraisEnvoi.jsp").forward(req, res);
        return;
    }
    
    List<fraisEnvoi> liste;
    
    if(keyword != null && !keyword.trim().isEmpty()){
        liste = dao.rechercher(keyword);
        System.out.println("recherche:" + keyword);
    }else{
        liste = dao.liste();
    }
  
    req.setAttribute("liste", liste);
    req.getRequestDispatcher("fraisEnvoi.jsp").forward(req, res);
}
    
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {

        System.out.println("🔥 doPost exécuté !");
        HttpSession session = req.getSession();
        String action = req.getParameter("action");
        if(action != null) action = action.trim();
        
        try {
            fraisEnvoi f = new fraisEnvoi();

            f.setIdfrais(req.getParameter("idfrais"));

        // 🔥 IMPORTANT : sécuriser solde
            String montant1Str = req.getParameter("montant1");
            if(montant1Str != null && !montant1Str.isEmpty()){
                f.setMontant1(Integer.parseInt(montant1Str));
            } else {
                f.setMontant1(0);
            }
            
            String montant2Str = req.getParameter("montant2");
            if(montant2Str != null && !montant2Str.isEmpty()){
                f.setMontant2(Integer.parseInt(montant2Str));
            } else {
                f.setMontant2(0);
            }
            
            String fraisStr = req.getParameter("frais");
            if(fraisStr != null && !fraisStr.isEmpty()){
                f.setFrais(Float.parseFloat(fraisStr));
            } else {
                f.setFrais(0);
            }

            fraisEnvoiDao dao = new fraisEnvoiDao();
            
            if("update".equals(action)){
                dao.modifier(f);
                session.setAttribute("msg", "Frais modifié avec succès");
            }else{
                dao.ajouter(f);
                session.setAttribute("msg", "Frais ajouté avec succès");
            }
            
        } catch(Exception e) {
            System.out.println("❌ Erreur dans doPost");
            e.printStackTrace();
        }

        res.sendRedirect("fraisEnvoiServlet");
    }
}
