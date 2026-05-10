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

public class loginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {

        String mail = req.getParameter("mail");
        String password = req.getParameter("password");

        clientDao dao = new clientDao();
        client c = dao.login(mail, password);

        if(c != null){
            HttpSession session = req.getSession();
            session.setAttribute("user", c);

            res.sendRedirect(req.getContextPath() + "/Accueil.jsp");
        }else{
            req.setAttribute("error", "Email ou mot de passe incorrect");
            req.getRequestDispatcher("login.jsp").forward(req, res);
        }
    }
}