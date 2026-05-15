<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="java.time.Month" %>
<%@page import="java.time.format.TextStyle" %>
<%@page import="java.util.Locale" %>
<%@page import="com.test.monprojetjsp.model.client" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Clients</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/app.css">
</head>
<body class="app-body">
<%
    String msg = (String) session.getAttribute("msg");
    if (msg != null) {
%>
<div class="alert alert-success alert-dismissible fade show m-3 mb-0" role="alert">
    <%= msg %>
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
</div>
<% session.removeAttribute("msg"); } %>

<div class="app-toolbar m-3 mb-0 d-flex flex-wrap align-items-center justify-content-between gap-3">
    <div>
        <h1 class="app-page-title h5 mb-0">Clients</h1>
        <p class="app-subtitle mb-0 small">Recherche par nom, e-mail, pays…</p>
    </div>
    <form action="<%= request.getContextPath() %>/clientServlet" method="get" class="d-flex gap-2">
        <input type="text" name="keyword" class="form-control form-control-sm" placeholder="Rechercher…" style="min-width:200px;">
        <button type="submit" class="btn btn-sm btn-outline-secondary">Rechercher</button>
    </form>
    <a href="<%= request.getContextPath() %>/clientServlet?action=add" class="btn btn-sm btn-app-primary">+ Nouveau client</a>
</div>

<div class="p-3">
    <div class="app-card overflow-hidden">
        <div class="table-responsive">
        <table class="table table-hover table-app mb-0 align-middle">
            <thead class="table-light">
            <tr>
                <th>Téléphone</th>
                <th>Nom</th>
                <th>Sexe</th>
                <th>Pays</th>
                <th>Solde</th>
                <th>E-mail</th>
                <th>Actions</th>
                <th>Relevé PDF</th>
            </tr>
            </thead>
            <tbody>
            <%
                List<client> liste = (List<client>) request.getAttribute("liste");
                if (liste != null) {
                    for (client c : liste) {
            %>
            <tr>
                <td class="font-monospace small"><%= c.getNumtel() %></td>
                <td><%= c.getNom() %></td>
                <td><%= c.getSexe() %></td>
                <td><%= c.getPays() %></td>
                <td><%= new java.text.DecimalFormat("0.##").format(c.getSolde()) %></td>
                <td class="small"><%= c.getMail() %></td>
                <td>
                    <a class="btn btn-link btn-sm p-0 me-2" href="<%= request.getContextPath() %>/clientServlet?action=edit&numtel=<%= c.getNumtel() %>">Modifier</a>
                    <a class="btn btn-link btn-sm p-0 text-danger" href="<%= request.getContextPath() %>/clientServlet?action=delete&numtel=<%= c.getNumtel() %>"
                       onclick="return confirm('Supprimer ce client ?');">Supprimer</a>
                </td>
                <td>
                    <form action="<%= request.getContextPath() %>/pdf" method="get" class="d-flex flex-wrap gap-1 align-items-center">
                        <input type="hidden" name="numtel" value="<%= c.getNumtel() %>">
                        <select name="mois" class="form-select form-select-sm" style="width:auto;min-width:5.5rem;">
                            <%
                                int mCur = java.time.LocalDate.now().getMonthValue();
                                for (int m = 1; m <= 12; m++) {
                                    String mLabel = Month.of(m).getDisplayName(TextStyle.FULL_STANDALONE, Locale.FRENCH);
                                    mLabel = mLabel.substring(0, 1).toUpperCase(Locale.FRENCH) + mLabel.substring(1);
                            %>
                            <option value="<%= m %>" <%= m == mCur ? "selected" : "" %>><%= mLabel %></option>
                            <% } %>
                        </select>
                        <select name="annee" class="form-select form-select-sm" style="width:auto;min-width:4.5rem;">
                            <%
                                int yCur = java.time.Year.now().getValue();
                                for (int y = yCur - 2; y <= yCur + 1; y++) {
                            %>
                            <option value="<%= y %>" <%= y == yCur ? "selected" : "" %>><%= y %></option>
                            <% } %>
                        </select>
                        <button type="submit" class="btn btn-sm btn-outline-primary">PDF</button>
                    </form>
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
