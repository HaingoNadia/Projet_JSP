/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.test.monprojetjsp.servlet;

import com.test.monprojetjsp.dao.envoyerDao;
import com.test.monprojetjsp.dao.clientDao;
import com.test.monprojetjsp.model.client;
import com.test.monprojetjsp.model.envoyer;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.OutputStream;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.*;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.Color;


import java.time.Month;
import java.time.format.TextStyle;
import java.util.Locale;

import com.lowagie.text.*;
import com.lowagie.text.pdf.*;
/**
 *
 * @author ME-PC
 */
public class PDFServlet extends HttpServlet {

   protected void doGet(HttpServletRequest req, HttpServletResponse res)
throws ServletException, IOException {

    String num = req.getParameter("numtel");
    String moisStr = req.getParameter("mois");
    int mois = 1; // par défaut janvier

    if(moisStr != null && !moisStr.isEmpty()){
    mois = Integer.parseInt(moisStr);
}    
    String nomMois = Month.of(mois).getDisplayName(TextStyle.FULL, Locale.FRENCH);

    envoyerDao edao = new envoyerDao();
    clientDao cdao = new clientDao();

    client c = cdao.getByNum(num);
    List<envoyer> liste = edao.getByClientAndMonth(num, mois);

    res.setContentType("application/pdf");
    res.setHeader("Content-Disposition", "inline; filename=releve.pdf");

    try {
        OutputStream out = res.getOutputStream();

        Document document = new Document(PageSize.A4);
        PdfWriter.getInstance(document, out);

        document.open();

        // 🔥 TITRE
        Font titleFont = new Font(Font.HELVETICA, 18, Font.BOLD);
        Paragraph title = new Paragraph("TRANSACTION " + nomMois, titleFont);
        title.setAlignment(Element.ALIGN_CENTER);
        document.add(title);

        document.add(new Paragraph(" "));

        // 🔥 INFOS CLIENT
        document.add(new Paragraph("Contact : " + c.getNumtel()));
        document.add(new Paragraph(" " + c.getNom()));
        document.add(new Paragraph(" " + c.getSexe()));
        document.add(new Paragraph(" " + c.getPays()));
        
        String devise;
        if(c.getPays().equalsIgnoreCase("Madagascar")){
            devise = "Ariary";
        }else{
            devise = "Euro";
        }
        
        document.add(new Paragraph("Solde actuel : " + c.getSolde() + " " + devise));
        document.add(new Paragraph(" "));

        // 🔥 TABLEAU
        PdfPTable table = new PdfPTable(4);
        table.setWidthPercentage(100);

        Font headFont = new Font(Font.HELVETICA, 12, Font.BOLD);

        String[] headers = {"Date", "Raison", "Recepteur", "Montant"};

        for(String h : headers){
            PdfPCell cell = new PdfPCell(new Phrase(h, headFont));
            cell.setBackgroundColor(Color.LIGHT_GRAY);
            table.addCell(cell);
        }

        float total = 0;
        
        for(envoyer e : liste){
            table.addCell(e.getDate().toLocalDate().toString());
            table.addCell(e.getRaison());
            table.addCell(e.getNumRecepteur());
            table.addCell(String.valueOf(e.getMontant()));
            //table.addCell(e.getMontant()+ " " + devise);
            total += e.getMontant();
        }

        document.add(table);
        document.add(new Paragraph(" "));
        document.add(new Paragraph("TOTAL DEBIT : " + total + " " + devise));

        document.close();
        out.close();

    } catch(Exception e){
        e.printStackTrace();
    }
}
}