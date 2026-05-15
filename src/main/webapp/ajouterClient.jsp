<%-- 
    Document   : ajouterClient
    Created on : 18 avr. 2026, 20:50:02
    Author     : ME-PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="com.test.monprojetjsp.model.client" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ajouter Client</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/app.css">
</head>

<body class="app-body">

<div class="container py-4">

    <div class="app-card shadow-sm">
        
        <%
            client cl = (client)request.getAttribute("client");
        %>

        <div class="card-header text-white text-center py-3" style="background: linear-gradient(135deg, #0d9488, #0f766e); border: none;">
            <h4 class="mb-0"><%= (cl != null) ? "Modifier le client" : "Nouveau client" %></h4>
        </div>

        <div class="card-body p-4"> 
            <!-- MESSAGE -->
            <%
                String msg = (String) session.getAttribute("msg");
                if(msg != null){
            %>
                <div class="alert alert-success alert-dismissible fade show">
                    <%= msg %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <%
                    session.removeAttribute("msg");
                }
            %>

            <form action="<%=request.getContextPath()%>/clientServlet" method="post">

                <input type="hidden" name="action" value="<%= (cl != null) ? "update" : "insert" %>">

                <div class="mb-3">
                    <label class="form-label">Numéro de téléphone (clé)</label>
                    <input type="tel" name="numtel" class="form-control"
                           value="<%= (cl != null) ? cl.getNumtel() : "" %>"
                           <%= (cl != null) ? "readonly" : "" %> required
                           autocomplete="tel"
                           placeholder="+261341234567">
                    <% if (cl != null) { %><div class="form-text">Identifiant non modifiable.</div><% } else { %><div class="form-text">Exemple: +261341234567</div><% } %>
                </div>

                <div class="mb-3">
                    <label class="form-label">Nom</label>
                    <input type="text" name="nom" class="form-control"
                           value="<%= (cl != null) ? cl.getNom() : "" %>" required
                           autocomplete="name"
                           placeholder="Nom complet du client">
                </div>

                <div class="mb-3">
                    <label class="form-label">Sexe</label>
                    <select name="sexe" class="form-select">
                        <option value="Homme" <%= (cl != null && "Homme".equals(cl.getSexe())) ? "selected" : "" %>>Homme</option>
                        <option value="Femme" <%= (cl != null && "Femme".equals(cl.getSexe())) ? "selected" : "" %>>Femme</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Pays</label>
                    <input type="text" name="pays" class="form-control"
                           value="<%= (cl != null) ? cl.getPays() : "" %>" required
                           list="paysList"
                           placeholder="Madagascar, France, ...">
                    <datalist id="paysList">
                        <option value="Madagascar"></option>
                        <option value="France"></option>
                        <option value="Comores"></option>
                        <option value="Maurice"></option>
                        <option value="Canada"></option>
                    </datalist>
                </div>

                <div class="mb-3">
                    <label class="form-label">Solde</label>
                    <input type="number" name="solde" class="form-control"
                           value="<%= (cl != null) ? String.format(java.util.Locale.US, "%.2f", cl.getSolde()) : "" %>"
                           min="0" step="0.01" placeholder="0">
                </div>

                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <input type="email" name="mail" class="form-control"
                           value="<%= (cl != null) ? cl.getMail() : "" %>" required
                           autocomplete="email"
                           placeholder="client@exemple.com">
                </div>

                <div class="mb-3">
                    <label class="form-label">Mot de passe (connexion)</label>
                    <input type="password" name="password" class="form-control" autocomplete="new-password"
                           <%= (cl != null) ? "" : "required" %>
                           placeholder="<%= (cl != null) ? "Laissez vide pour conserver le mot de passe actuel" : "" %>">
                    <% if (cl != null) { %>
                    <div class="form-text">Les autres champs sont préremplis depuis la base. Saisissez un nouveau mot de passe uniquement si vous souhaitez le modifier.</div>
                    <% } %>
                </div>

                <div class="mb-3">
                    <label class="form-label">Date de naissance (pour l'âge sur le relevé PDF)</label>
                    <input type="date" name="dateNaissance" class="form-control"
                           value="<%
                               if (cl != null && cl.getDateNaissance() != null) {
                                   out.print(cl.getDateNaissance().toString());
                               }
                           %>">
                </div>

                <div class="d-flex justify-content-between pt-2">
                    <a href="<%=request.getContextPath()%>/clientServlet" class="btn btn-outline-secondary">Retour</a>
                    <button type="submit" class="btn btn-app-primary">
                        <%= (cl != null) ? "Modifier" : "Ajouter" %>
                    </button>
                </div>

            </form>

        </div>
    </div>

</div>

<!-- Bootstrap JS (pour fermer alert) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
