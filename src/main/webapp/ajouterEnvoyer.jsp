<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.test.monprojetjsp.model.envoyer" %>
<%@page import="com.test.monprojetjsp.model.client" %>
<%@page import="java.util.List" %>
<%@page import="java.util.Locale" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Transfert</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/app.css">
</head>
<body class="app-body">
<div class="container py-4">
    <div class="app-card p-4">
        <h1 class="app-page-title h4">Transfert d'argent</h1>
        <p class="app-subtitle">Transfert international uniquement (pays différent). Débit : montant + frais. Crédit destinataire selon le taux.</p>

        <%
            envoyer cl = (envoyer) request.getAttribute("envoyer");
            List<client> clients = (List<client>) request.getAttribute("clients");
            String dateValue = "";
            if (cl != null && cl.getDate() != null) {
                java.time.LocalDateTime dt = cl.getDate();
                dateValue = String.format(Locale.ROOT, "%04d-%02d-%02dT%02d:%02d",
                        dt.getYear(), dt.getMonthValue(), dt.getDayOfMonth(),
                        dt.getHour(), dt.getMinute());
            }
        %>

        <form action="<%= request.getContextPath() %>/envoyerServlet" method="post" class="mt-4">
            <input type="hidden" name="action" value="<%= (cl != null) ? "update" : "insert" %>">

            <% if (cl != null) { %>
            <div class="mb-3">
                <label class="form-label">ID transaction</label>
                <input type="text" class="form-control" name="idEnv"
                       value="<%= cl.getIdEnv() %>" readonly>
                <div class="form-text">Non modifiable en édition.</div>
            </div>
            <% } %>

            <div class="row g-3">
                <div class="col-md-6">
                    <label class="form-label">Envoyeur</label>
                    <select class="form-select" name="numEnvoyeur" id="numEnvoyeur" required>
                        <option value="">Choisir un client envoyeur...</option>
                        <%
                            if (clients != null) {
                                for (client c : clients) {
                                    String selected = (cl != null && c.getNumtel() != null && c.getNumtel().equals(cl.getNumEnvoyeur())) ? "selected" : "";
                        %>
                            <option value="<%= c.getNumtel() %>" <%= selected %> data-solde="<%= c.getSolde() %>">
                                <%= c.getNom() %> - <%= c.getNumtel() %> (<%= c.getPays() %>, solde: <%= c.getSolde() %>)
                            </option>
                        <%
                                }
                            }
                        %>
                    </select>
                    <div class="form-text" id="senderHint">Sélectionnez un client pour afficher son solde et son montant maximum transférable.</div>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Destinataire</label>
                    <select class="form-select" name="numRecepteur" id="numRecepteur" required>
                        <option value="">Choisir un client destinataire...</option>
                        <%
                            if (clients != null) {
                                for (client c : clients) {
                                    String selected = (cl != null && c.getNumtel() != null && c.getNumtel().equals(cl.getNumRecepteur())) ? "selected" : "";
                        %>
                            <option value="<%= c.getNumtel() %>" <%= selected %>>
                                <%= c.getNom() %> - <%= c.getNumtel() %> (<%= c.getPays() %>)
                            </option>
                        <%
                                }
                            }
                        %>
                    </select>
                    <div class="form-text">Astuce: l'envoyeur et le destinataire doivent être différents et de pays différents.</div>
                </div>
            </div>

            <div class="mb-3 mt-3">
                <label class="form-label">Montant</label>
                <input type="number" class="form-control" id="montantInput" name="montant" required min="1" step="1"
                       value="<%= (cl != null) ? cl.getMontant() : "" %>">
                <div class="form-text">Le serveur vérifiera automatiquement le montant maximum autorisé selon le solde et les frais.</div>
            </div>

            <div class="mb-3">
                <label class="form-label">Date et heure</label>
                <input type="datetime-local" class="form-control" name="date" step="60"
                       value="<%= dateValue %>">
            </div>

            <div class="mb-4">
                <label class="form-label">Raison</label>
                <input type="text" class="form-control" name="raison"
                       value="<%= (cl != null && cl.getRaison() != null) ? cl.getRaison() : "" %>">
            </div>

            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-app-primary">
                    <%= (cl != null) ? "Enregistrer les modifications" : "Enregistrer le transfert" %>
                </button>
                <a href="<%= request.getContextPath() %>/envoyerServlet" class="btn btn-outline-secondary">Retour</a>
            </div>
        </form>
    </div>
</div>
<script>
    (function () {
        const senderSelect = document.getElementById("numEnvoyeur");
        const montantInput = document.getElementById("montantInput");
        const senderHint = document.getElementById("senderHint");

        function updateSenderHint() {
            if (!senderSelect || senderSelect.selectedIndex <= 0) {
                senderHint.textContent = "Sélectionnez un client pour afficher son solde et son montant maximum transférable.";
                montantInput.removeAttribute("max");
                return;
            }
            const selected = senderSelect.options[senderSelect.selectedIndex];
            const solde = Number(selected.getAttribute("data-solde") || "0");
            const maxApprox = Math.max(solde, 0);
            montantInput.setAttribute("max", String(maxApprox));
            senderHint.textContent = "Solde envoyeur: " + solde + ". Montant conseillé <= " + maxApprox + " (le maximum exact tient compte des frais).";
        }

        if (senderSelect) {
            senderSelect.addEventListener("change", updateSenderHint);
            updateSenderHint();
        }
    })();
</script>
</body>
</html>
