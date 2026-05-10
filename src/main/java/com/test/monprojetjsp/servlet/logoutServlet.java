/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.test.monprojetjsp.servlet;

/**
 *
 * @author ME-PC
 */
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class logoutServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
    throws IOException {

        HttpSession session = req.getSession();
        session.invalidate();

        res.sendRedirect(req.getContextPath() + "/login.jsp");
    }
}