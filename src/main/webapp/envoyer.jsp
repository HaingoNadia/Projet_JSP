<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="com.test.monprojetjsp.model.envoyer" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Transferts</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/app.css">
</head>
<body class="app-body">
<%
    String msg = (String) session.getAttribute("msg");
    if (msg != null) {
        boolean err = msg.contains("Erreur");
%>
<div class="alert <%= err ? "alert-danger" : "alert-success" %> alert-dismissible fade show m-3 mb-0" role="alert">
    <%= msg %>
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
</div>
<% session.removeAttribute("msg"); } %>

<div class="app-toolbar m-3 mb-0 d-flex flex-wrap align-items-center justify-content-between gap-3">
    <div>
        <h1 class="app-page-title h5 mb-0">Transferts</h1>
        <p class="app-subtitle mb-0 small">Filtrer par date (AAAA-MM-JJ)</p>
    </div>
    <form action="<%= request.getContextPath() %>/envoyerServlet" method="get" class="d-flex gap-2 align-items-center">
        <input type="date" name="keyword" class="form-control form-control-sm">
        <button type="submit" class="btn btn-sm btn-outline-secondary">Filtrer</button>
    </form>
    <a href="<%= request.getContextPath() %>/envoyerServlet?action=add" class="btn btn-sm btn-app-primary">Nouveau transfert</a>
</div>

<div class="p-3">
    <div class="app-card overflow-hidden">
        <div class="table-responsive">
        <table class="table table-hover table-app mb-0 align-middle">
            <thead class="table-light">
            <tr>
                <th>ID</th>
                <th>Envoyeur</th>
                <th>Récepteur</th>
                <th>Montant</th>
                <th>Date</th>
                <th>Raison</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                List<envoyer> liste = (List<envoyer>) request.getAttribute("liste");
                if (liste != null) {
                    for (envoyer env : liste) {
            %>
            <tr>
                <td class="small font-monospace"><%= env.getIdEnv() %></td>
                <td><%= env.getNumEnvoyeur() %></td>
                <td><%= env.getNumRecepteur() %></td>
                <td><%= env.getMontant() %></td>
                <td class="small"><%= env.getDate() %></td>
                <td><%= env.getRaison() %></td>
                <td>
                    <a class="btn btn-link btn-sm p-0 me-2" href="<%= request.getContextPath() %>/envoyerServlet?action=edit&idEnv=<%= env.getIdEnv() %>">Modifier</a>
                    <a class="btn btn-link btn-sm p-0 text-danger" href="<%= request.getContextPath() %>/envoyerServlet?action=delete&idEnv=<%= env.getIdEnv() %>"
                       onclick="return confirm('Supprimer cette ligne ?');">Supprimer</a>
                </td>
            </tr>
            <% } } %>
            </tbody>
        </table>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
