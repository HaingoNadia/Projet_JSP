<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="com.test.monprojetjsp.model.fraisEnvoi" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Frais</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/app.css">
</head>
<body class="app-body">
<%
    String msg = (String) session.getAttribute("msg");
    if (msg != null) {
%>
<div class="alert alert-success alert-dismissible fade show m-3 mb-0" role="alert"><%= msg %><button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
<% session.removeAttribute("msg"); } %>

<div class="app-toolbar m-3 mb-0 d-flex flex-wrap align-items-center justify-content-between gap-3">
    <div>
        <h1 class="app-page-title h5 mb-0">Frais d'envoi</h1>
        <p class="app-subtitle mb-0 small">Tranches min / max → frais</p>
    </div>
    <form action="<%= request.getContextPath() %>/fraisEnvoiServlet" method="get" class="d-flex gap-2">
        <input type="text" name="keyword" class="form-control form-control-sm" placeholder="Rechercher…">
        <button type="submit" class="btn btn-sm btn-outline-secondary">OK</button>
    </form>
    <a href="<%= request.getContextPath() %>/fraisEnvoiServlet?action=add" class="btn btn-sm btn-app-primary">+ Frais</a>
</div>

<div class="p-3">
    <div class="app-card overflow-hidden">
        <div class="table-responsive">
        <table class="table table-hover mb-0 align-middle">
            <thead class="table-light">
            <tr>
                <th>ID</th>
                <th>Min (tranche)</th>
                <th>Max (tranche)</th>
                <th>Frais</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                List<fraisEnvoi> liste = (List<fraisEnvoi>) request.getAttribute("liste");
                if (liste != null) {
                    for (fraisEnvoi f : liste) {
            %>
            <tr>
                <td class="font-monospace small"><%= f.getIdfrais() %></td>
                <td><%= f.getMontant1() %></td>
                <td><%= f.getMontant2() %></td>
                <td><%= f.getFrais() %></td>
                <td>
                    <a class="btn btn-link btn-sm p-0 me-2" href="<%= request.getContextPath() %>/fraisEnvoiServlet?action=edit&idfrais=<%= f.getIdfrais() %>">Modifier</a>
                    <a class="btn btn-link btn-sm p-0 text-danger" href="<%= request.getContextPath() %>/fraisEnvoiServlet?action=delete&idfrais=<%= f.getIdfrais() %>"
                       onclick="return confirm('Supprimer cette tranche ?');">Supprimer</a>
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
