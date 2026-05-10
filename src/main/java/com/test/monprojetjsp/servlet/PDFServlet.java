package com.test.monprojetjsp.servlet;

import com.test.monprojetjsp.dao.envoyerDao;
import com.test.monprojetjsp.dao.clientDao;
import com.test.monprojetjsp.model.client;
import com.test.monprojetjsp.model.envoyer;

import java.io.IOException;
import java.io.OutputStream;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.time.LocalDate;
import java.time.Month;
import java.time.Period;
import java.time.format.DateTimeFormatter;
import java.time.format.TextStyle;
import java.util.List;
import java.util.Locale;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.RGBColor;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

/**
 * Relevé d'opérations PDF. Le mode headless évite de charger libawt_xawt (JDK headless / serveur sans X11).
 */
public class PDFServlet extends HttpServlet {

    static {
        System.setProperty("java.awt.headless", "true");
    }

    private static final DateTimeFormatter DATE_FR = DateTimeFormatter.ofPattern("dd/MM/yyyy");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String num = req.getParameter("numtel");
        String moisStr = req.getParameter("mois");
        String anneeStr = req.getParameter("annee");

        int mois = 1;
        if (moisStr != null && !moisStr.isEmpty()) {
            mois = Integer.parseInt(moisStr);
        }
        int annee = java.time.Year.now().getValue();
        if (anneeStr != null && !anneeStr.isEmpty()) {
            annee = Integer.parseInt(anneeStr);
        }

        String nomMois = Month.of(mois).getDisplayName(TextStyle.FULL_STANDALONE, Locale.FRENCH);
        nomMois = nomMois.substring(0, 1).toUpperCase(Locale.FRENCH) + nomMois.substring(1);

        envoyerDao edao = new envoyerDao();
        clientDao cdao = new clientDao();

        client c = num != null ? cdao.getByNum(num) : null;
        if (c == null) {
            res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Client introuvable (numtel manquant ou invalide).");
            return;
        }

        List<envoyer> liste = edao.getByClientAndMonth(num, mois, annee);

        res.setContentType("application/pdf");
        res.setHeader("Content-Disposition", "inline; filename=releve_" + nomMois + "_" + annee + ".pdf");

        DecimalFormatSymbols sym = new DecimalFormatSymbols(Locale.FRENCH);
        sym.setDecimalSeparator(',');
        DecimalFormat money = new DecimalFormat("#,##0.00", sym);

        try (OutputStream out = res.getOutputStream()) {
            Document document = new Document(PageSize.A4);
            PdfWriter.getInstance(document, out);
            document.open();

            Font titleFont = new Font(Font.HELVETICA, 18, Font.BOLD);
            Paragraph title = new Paragraph("Relevé des opérations — " + nomMois + " " + annee, titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            document.add(title);
            document.add(new Paragraph(" "));

            document.add(new Paragraph("Contact : " + c.getNumtel()));
            document.add(new Paragraph("Nom : " + c.getNom()));
            if (c.getDateNaissance() != null) {
                int age = Period.between(c.getDateNaissance(), LocalDate.now()).getYears();
                document.add(new Paragraph("Âge : " + age + " ans"));
            } else {
                document.add(new Paragraph("Âge : —"));
            }
            document.add(new Paragraph("Sexe : " + c.getSexe()));
            document.add(new Paragraph("Pays : " + c.getPays()));

            String devise = paysMadagascar(c.getPays()) ? "Ariary" : "Euro";
            document.add(new Paragraph("Solde actuel : " + money.format(c.getSolde()) + " " + devise));
            document.add(new Paragraph(" "));

            PdfPTable table = new PdfPTable(4);
            table.setWidthPercentage(100);

            Font headFont = new Font(Font.HELVETICA, 11, Font.BOLD);
            RGBColor headerBg = new RGBColor(220, 220, 220);
            String[] headers = {"Date", "Raison", "Nom du récepteur", "Montant"};
            for (String h : headers) {
                PdfPCell cell = new PdfPCell(new Phrase(h, headFont));
                cell.setBackgroundColor(headerBg);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);
            }

            Font cellFont = new Font(Font.HELVETICA, 10, Font.NORMAL);
            double total = 0;
            for (envoyer e : liste) {
                LocalDate d = e.getDate() != null ? e.getDate().toLocalDate() : null;
                table.addCell(new Phrase(d != null ? d.format(DATE_FR) : "-", cellFont));
                table.addCell(new Phrase(e.getRaison() != null ? e.getRaison() : "", cellFont));
                client dest = cdao.getByNum(e.getNumRecepteur());
                String nomDest = dest != null ? dest.getNom() : e.getNumRecepteur();
                table.addCell(new Phrase(nomDest, cellFont));
                table.addCell(new Phrase(money.format(e.getMontant()), cellFont));
                total += e.getMontant();
            }

            document.add(table);
            document.add(new Paragraph(" "));
            Paragraph tot = new Paragraph(
                    "Total débit : " + money.format(total) + " " + devise,
                    new Font(Font.HELVETICA, 12, Font.BOLD));
            document.add(tot);

            document.close();
        } catch (DocumentException e) {
            throw new ServletException("Erreur génération PDF", e);
        }
    }

    private static boolean paysMadagascar(String pays) {
        return pays != null && pays.toLowerCase(Locale.FRENCH).contains("madagascar");
    }
}
