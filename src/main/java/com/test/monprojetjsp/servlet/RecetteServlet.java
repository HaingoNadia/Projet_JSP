/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.test.monprojetjsp.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.test.monprojetjsp.dao.envoyerDao;
import com.test.monprojetjsp.dao.fraisEnvoiDao;
import com.test.monprojetjsp.model.fraisEnvoi;

import java.util.List;

@WebServlet("/RecetteServlet")
public class RecetteServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {

        envoyerDao edao = new envoyerDao();
        fraisEnvoiDao fdao = new fraisEnvoiDao();

        // recette totale
        float recette = edao.getRecetteTotale();

        // liste taux
        List<fraisEnvoi> liste = fdao.liste();

        req.setAttribute("recette", recette);
        req.setAttribute("liste", liste);

        req.getRequestDispatcher("recette.jsp").forward(req, res);
    }
}