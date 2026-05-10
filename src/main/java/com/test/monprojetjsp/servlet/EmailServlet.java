package com.test.monprojetjsp.servlet;

import com.test.monprojetjsp.util.EmailUtil;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Page « Notifications e-mail » : envoi manuel (utilise mail.properties ou variables SMTP_*).
 */
public class EmailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.getRequestDispatcher("/email.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();

        String to = req.getParameter("to");
        String sujet = req.getParameter("sujet");
        String corps = req.getParameter("corps");

        if (to == null || to.isBlank() || sujet == null || corps == null) {
            session.setAttribute("msg", "Erreur : destinataire, sujet et message sont obligatoires.");
            res.sendRedirect(req.getContextPath() + "/emailServlet");
            return;
        }

        EmailUtil.envoyerEmail(to.trim(), sujet.trim(), corps.trim());
        session.setAttribute("msg", "Demande d'envoi effectuée vers « " + to.trim() + " ». Vérifiez la console serveur en cas d'échec SMTP.");
        res.sendRedirect(req.getContextPath() + "/emailServlet");
    }
}
