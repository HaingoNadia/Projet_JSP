/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.test.monprojetjsp.servlet;

import com.test.monprojetjsp.dao.tauxDao;
import com.test.monprojetjsp.model.taux;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

public class tauxServlet extends HttpServlet{
    private static String generateTauxId() {
        return "TX-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
    }
    
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {

    String action = req.getParameter("action");
    String keyword = req.getParameter("keyword");
    tauxDao dao = new tauxDao();
    HttpSession session = req.getSession();

    // 🔴 SUPPRESSION
    if("delete".equals(action)) {
        String num = req.getParameter("idtaux");
        dao.supprimer(num);

        session.setAttribute("msg", "Taux d'echange suprimer avec succès");
        res.sendRedirect(req.getContextPath() + "/tauxServlet");
        return;
    }
    
    if("add".equals(action)){
        req.getRequestDispatcher("ajouterTaux.jsp").forward(req, res);
        return;
    }
    
    if("edit".equals(action)){
        String num = req.getParameter("idtaux");
        
        taux t= dao.getByNum(num);
        req.setAttribute("taux", t);
        
        req.getRequestDispatcher("ajouterTaux.jsp").forward(req, res);
        return;
    }
    
    List<taux> liste;
    
    if(keyword != null && !keyword.trim().isEmpty()){
        liste = dao.rechercher(keyword);
        System.out.println("recherche:" + keyword);
    }else{
        liste = dao.liste();
    }
  
    req.setAttribute("liste", liste);
    req.getRequestDispatcher("taux.jsp").forward(req, res);
}
    
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {

        System.out.println("🔥 doPost exécuté !");
        String action = req.getParameter("action");
        HttpSession session = req.getSession();

        try {
            taux t = new taux();

            String id = req.getParameter("idtaux");
            if ("update".equals(action)) {
                t.setIdtaux(id);
            } else {
                t.setIdtaux(id != null && !id.trim().isEmpty() ? id.trim() : generateTauxId());
            }
            String montant1Str = req.getParameter("montant1");
            if(montant1Str != null && !montant1Str.isEmpty()){
                t.setMontant1(Integer.parseInt(montant1Str));
            } else {
                t.setMontant1(0);
            }
            String montant2Str = req.getParameter("montant2");
            if(montant2Str != null && !montant2Str.isEmpty()){
                t.setMontant2(Integer.parseInt(montant2Str));
            } else {
                t.setMontant2(0);
            }
            if (t.getMontant1() <= 0 || t.getMontant2() <= 0) {
                throw new IllegalArgumentException("Les deux montants doivent être strictement positifs.");
            }

            tauxDao dao = new tauxDao();
            
            if("update".equals(action)){
                dao.modifier(t);
                session.setAttribute("msg", "Taux modifié avec succès");
            }else{
                dao.ajouter(t);
                session.setAttribute("msg", "Taux ajouté avec succès");
            }
            
        } catch(Exception e) {
            session.setAttribute("msg", "Erreur : " + e.getMessage());
        }

        res.sendRedirect(req.getContextPath() + "/tauxServlet");
    }
}

