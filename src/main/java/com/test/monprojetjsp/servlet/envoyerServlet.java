package com.test.monprojetjsp.servlet;

import com.test.monprojetjsp.dao.envoyerDao;
import com.test.monprojetjsp.dao.clientDao;
import com.test.monprojetjsp.dao.tauxDao;
import com.test.monprojetjsp.dao.fraisEnvoiDao;
import com.test.monprojetjsp.model.envoyer;
import com.test.monprojetjsp.model.client;
import com.test.monprojetjsp.util.EmailUtil;

import java.io.IOException;
import java.util.List;
import java.util.Locale;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.time.*;
import java.time.format.DateTimeParseException;

@WebServlet(name = "envoyerServlet", urlPatterns = {"/envoyerServlet"})
public class envoyerServlet extends HttpServlet {

    private static boolean paysMadagascar(String pays) {
        return pays != null && pays.toLowerCase(Locale.FRENCH).contains("madagascar");
    }

    private static String generateTransferId() {
        return "TR-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase(Locale.ROOT);
    }

    private static int maxTransferableForBalance(int solde, fraisEnvoiDao fdao) {
        if (solde <= 0) {
            return 0;
        }
        int low = 0;
        int high = solde;
        int best = 0;

        while (low <= high) {
            int mid = low + ((high - low) / 2);
            double totalDebit = mid + fdao.getFrais(mid);
            if (totalDebit <= solde) {
                best = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        while (best > 0 && (best + fdao.getFrais(best)) > solde) {
            best--;
        }
        while ((best + 1) <= solde && ((best + 1) + fdao.getFrais(best + 1)) <= solde) {
            best++;
        }
        return Math.max(best, 0);
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        String keyword = req.getParameter("keyword");
        envoyerDao dao = new envoyerDao();
        HttpSession session = req.getSession();

        if ("delete".equals(action)) {
            String num = req.getParameter("idEnv");
            dao.supprimer(num);
            session.setAttribute("msg", "Transfert supprimé avec succès");
            res.sendRedirect(req.getContextPath() + "/envoyerServlet");
            return;
        }

        if ("add".equals(action)) {
            clientDao cdao = new clientDao();
            req.setAttribute("clients", cdao.liste());
            req.getRequestDispatcher("ajouterEnvoyer.jsp").forward(req, res);
            return;
        }

        if ("edit".equals(action)) {
            String num = req.getParameter("idEnv");
            envoyer env = dao.getByNum(num);
            if (env == null) {
                session.setAttribute("msg", "Transfert introuvable ou identifiant manquant.");
                res.sendRedirect(req.getContextPath() + "/envoyerServlet");
                return;
            }
            clientDao cdao = new clientDao();
            req.setAttribute("clients", cdao.liste());
            req.setAttribute("envoyer", env);
            req.getRequestDispatcher("ajouterEnvoyer.jsp").forward(req, res);
            return;
        }

        List<envoyer> liste;

        if (keyword != null && !keyword.trim().isEmpty()) {
            try {
                LocalDate daterecherche = LocalDate.parse(keyword.trim());
                liste = dao.rechercher(daterecherche);
            } catch (DateTimeParseException e) {
                req.setAttribute("message", "Format date invalide (utilisez AAAA-MM-JJ)");
                liste = dao.liste();
            }
        } else {
            liste = dao.liste();
        }

        req.setAttribute("liste", liste);
        req.getRequestDispatcher("envoyer.jsp").forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        String action = req.getParameter("action");

        try {
            envoyer env = new envoyer();

            String idEnv = req.getParameter("idEnv");
            if ("update".equals(action)) {
                env.setIdEnv(idEnv);
            } else {
                env.setIdEnv(idEnv != null && !idEnv.trim().isEmpty() ? idEnv.trim() : generateTransferId());
            }
            env.setNumEnvoyeur(req.getParameter("numEnvoyeur"));
            env.setNumRecepteur(req.getParameter("numRecepteur"));
            String montantStr = req.getParameter("montant");
            if (montantStr != null && !montantStr.isEmpty()) {
                env.setMontant(Integer.parseInt(montantStr));
            } else {
                env.setMontant(0);
            }
            String dateStr = req.getParameter("date");
            if (dateStr != null && !dateStr.isEmpty()) {
                String s = dateStr.trim();
                // datetime-local envoie souvent "yyyy-MM-ddTHH:mm" sans secondes
                if (s.length() == 16) {
                    s = s + ":00";
                }
                env.setDate(LocalDateTime.parse(s));
            } else {
                env.setDate(LocalDateTime.now());
            }

            env.setRaison(req.getParameter("raison"));

            envoyerDao dao = new envoyerDao();

            if ("update".equals(action)) {
                dao.modifier(env);
                session.setAttribute("msg", "Transfert modifié avec succès");
            } else {
                clientDao cdao = new clientDao();
                tauxDao tdao = new tauxDao();
                fraisEnvoiDao fdao = new fraisEnvoiDao();
                envoyerDao edao = new envoyerDao();

                client envoyeur = cdao.getByNum(env.getNumEnvoyeur());
                client recepteur = cdao.getByNum(env.getNumRecepteur());

                if (envoyeur == null || recepteur == null) {
                    throw new IllegalArgumentException("Client introuvable (vérifiez les numéros).");
                }
                if (envoyeur.getNumtel() != null && envoyeur.getNumtel().equals(recepteur.getNumtel())) {
                    throw new IllegalArgumentException("Envoyeur et destinataire doivent être différents.");
                }

                if (envoyeur.getPays() != null && envoyeur.getPays().equalsIgnoreCase(recepteur.getPays())) {
                    throw new IllegalArgumentException(
                            "Transfert refusé : le destinataire doit être à l'étranger (pays différent de l'envoyeur).");
                }

                int montant = env.getMontant();
                if (montant <= 0) {
                    throw new IllegalArgumentException("Le montant doit être positif.");
                }

                float frais = fdao.getFrais(montant);
                double ratio = tdao.getConversionRatio();

                int montantFinal;
                if (paysMadagascar(envoyeur.getPays()) && !paysMadagascar(recepteur.getPays())) {
                    montantFinal = (int) Math.round(montant / ratio);
                } else if (!paysMadagascar(envoyeur.getPays()) && paysMadagascar(recepteur.getPays())) {
                    montantFinal = (int) Math.round(montant * ratio);
                } else {
                    montantFinal = (int) Math.round(montant * ratio);
                }

                double totalDebit = montant + frais;
                int montantMax = maxTransferableForBalance(envoyeur.getSolde(), fdao);
                if (montant > montantMax) {
                    throw new IllegalArgumentException(
                            "Montant trop élevé. Maximum autorisé pour cet envoyeur : " + montantMax + ".");
                }
                if (envoyeur.getSolde() < totalDebit) {
                    throw new IllegalArgumentException("Solde insuffisant (montant + frais).");
                }

                envoyeur.setSolde((int) Math.round(envoyeur.getSolde() - totalDebit));
                recepteur.setSolde(recepteur.getSolde() + montantFinal);

                cdao.modifier(envoyeur);
                cdao.modifier(recepteur);
                edao.ajouter(env);

                session.setAttribute("msg", "Transfert international enregistré avec succès.");

                String messageEnvoyeur = "Bonjour " + envoyeur.getNom() + ",\n\n"
                        + "Vous avez envoyé " + montant + " (frais : " + frais + ").\n"
                        + "Nouveau solde : " + envoyeur.getSolde() + ".\n"
                        + "Merci d'utiliser notre service.";

                EmailUtil.envoyerEmail(envoyeur.getMail(), "Confirmation d'envoi d'argent", messageEnvoyeur);

                String messageRecepteur = "Bonjour " + recepteur.getNom() + ",\n\n"
                        + "Vous avez reçu " + montantFinal + " de la part de " + envoyeur.getNom() + ".\n"
                        + "Nouveau solde : " + recepteur.getSolde() + ".";

                EmailUtil.envoyerEmail(recepteur.getMail(), "Réception d'argent", messageRecepteur);
            }

        } catch (IllegalArgumentException e) {
            session.setAttribute("msg", "Erreur : " + e.getMessage());
        } catch (Exception e) {
            session.setAttribute("msg", "Erreur : " + e.getMessage());
            e.printStackTrace();
        }

        res.sendRedirect(req.getContextPath() + "/envoyerServlet");
    }
}
