/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.test.monprojetjsp.servlet;

import com.test.monprojetjsp.dao.envoyerDao;
import com.test.monprojetjsp.dao.clientDao;
import com.test.monprojetjsp.dao.tauxDao;
import com.test.monprojetjsp.dao.fraisEnvoiDao;
import com.test.monprojetjsp.dao.envoyerDao;
import com.test.monprojetjsp.model.envoyer;
import com.test.monprojetjsp.model.client;
import com.test.monprojetjsp.util.EmailUtil;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.time.*;
import java.time.format.DateTimeParseException;

/**
 *
 * @author ME-PC
 */
@WebServlet(name = "envoyerServlet", urlPatterns = {"/envoyerServlet"})
public class envoyerServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {

    String action = req.getParameter("action");
    String keyword = req.getParameter("keyword");
    envoyerDao dao = new envoyerDao();
    HttpSession session = req.getSession();

    // 🔴 SUPPRESSION
    if("delete".equals(action)) {
        String num = req.getParameter("idEnv");
        dao.supprimer(num);
        session.setAttribute("msg", "Historique d'envoyer suprimer avec succès");
        res.sendRedirect("envoyerServlet");
        return;
    }
    
    if("add".equals(action)){
        req.getRequestDispatcher("ajouterEnvoyer.jsp").forward(req, res);
        return;
    }
    
    if("edit".equals(action)){
        String num = req.getParameter("idEnv");
        
        envoyer env = dao.getByNum(num);
        req.setAttribute("envoyer", env);
        
        req.getRequestDispatcher("ajouterEnvoyer.jsp").forward(req, res);
        return;
    }
    
    List<envoyer> liste;
    
    if(keyword != null && !keyword.trim().isEmpty()){
        try {
            LocalDate daterecherche = LocalDate.parse(keyword.trim());
            liste = dao.rechercher(daterecherche);
        }catch (DateTimeParseException e) {
            req.setAttribute("message", "Format Date invalide");
            liste = dao.liste();
        }
    }else{
        liste = dao.liste();
    }
  
    req.setAttribute("liste", liste);
    req.getRequestDispatcher("envoyer.jsp").forward(req, res);
}
    
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {

        System.out.println("🔥 doPost exécuté !");
        HttpSession session = req.getSession();
        String action = req.getParameter("action");

        try {
            envoyer env = new envoyer();

            env.setIdEnv(req.getParameter("idEnv"));
            env.setNumEnvoyeur(req.getParameter("numEnvoyeur"));
            env.setNumRecepteur(req.getParameter("numRecepteur"));
            String montantStr = req.getParameter("montant");
            if(montantStr != null && !montantStr.isEmpty()){
                env.setMontant(Integer.parseInt(montantStr));
            } else {
                env.setMontant(0);
            }
            String dateStr = req.getParameter("date");
            if(dateStr != null && !dateStr.isEmpty()){
                env.setDate(LocalDateTime.parse(dateStr));
            } else {
                env.setDate(LocalDateTime.MIN);
            }

            env.setRaison(req.getParameter("raison"));

            envoyerDao dao = new envoyerDao();
            
            if("update".equals(action)){
                dao.modifier(env);
                System.out.println("envoyer modifier!");
            }else{
                clientDao cdao = new clientDao();
                tauxDao tdao = new tauxDao();
                fraisEnvoiDao fdao = new fraisEnvoiDao();
                envoyerDao edao = new envoyerDao();

// 1. récupérer clients
                client envoyeur = cdao.getByNum(env.getNumEnvoyeur());
                client recepteur = cdao.getByNum(env.getNumRecepteur());

                if(envoyeur == null || recepteur == null){
                    throw new Exception("Client introuvable");
                }

                int montant = env.getMontant();

// 2. frais auto
                float frais = fdao.getFrais(montant);

// 3. taux dynamique
                int taux = tdao.getTaux();

                int montantFinal = montant;

// 4. conversion si pays différent
                if(!envoyeur.getPays().equalsIgnoreCase(recepteur.getPays())){
                    montantFinal = montant * taux;
                }

// 5. vérification solde
                if(envoyeur.getSolde() < (montant + frais)){
                    throw new Exception("Solde insuffisant");
                }

// 6. mise à jour
                envoyeur.setSolde(envoyeur.getSolde() - (montant + (int)frais));
                recepteur.setSolde(recepteur.getSolde() + montantFinal);
// 7. sauvegarde
                cdao.modifier(envoyeur);
                cdao.modifier(recepteur);
                edao.ajouter(env);
                
                session.setAttribute("msg", "Transfert avec succès");
                
                EmailUtil.envoyerEmail(
    "ravelomananjarasoanadia@gmail.com",
    "TEST SMTP",
    "Si tu vois ce message → SMTP fonctionne"
);
                
// EMAIL ENVOYEUR
System.out.println("Email envoyeur: " + envoyeur.getMail());
System.out.println("Email recepteur: " + recepteur.getMail());
                String messageEnvoyeur = "Bonjour " + envoyeur.getNom() +
                    "\nVous avez envoyé " + montant + 
                    "\nFrais: " + frais +
                    "\nNouveau solde: " + envoyeur.getSolde();

                EmailUtil.envoyerEmail(
                    
                    envoyeur.getMail(),
                    "Confirmation d'envoi",
                    messageEnvoyeur
                );

// EMAIL RECEPTEUR
                String messageRecepteur = "Bonjour " + recepteur.getNom() +
                    "\nVous avez reçu " + montantFinal +
                    "\nDe: " + envoyeur.getNom() +
                    "\nNouveau solde: " + recepteur.getSolde();

                EmailUtil.envoyerEmail(
                    recepteur.getMail(),
                    "Réception d'argent",
                    messageRecepteur
                );
                
            }
            
        } catch(Exception e) {
            System.out.println("❌ Erreur dans doPost");
            e.printStackTrace();
        }

        res.sendRedirect("envoyerServlet");
    }
}

