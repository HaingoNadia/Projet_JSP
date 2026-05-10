<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.test.monprojetjsp.model.fraisEnvoi"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Recette</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/app.css">
</head>
<body class="app-body">
<div class="p-3">
    <div class="app-card p-4 mb-3 text-white" style="background: linear-gradient(135deg, #0f766e, #0d9488); border: none;">
        <h2 class="h5 mb-2 opacity-90">Recette totale opérateur</h2>
        <p class="display-6 mb-0 fw-bold"><%= request.getAttribute("recette") %> €</p>
        <p class="small mb-0 mt-2 opacity-75">Somme des frais sur l'historique des transferts</p>
    </div>

    <div class="app-card p-4">
        <h3 class="h6 fw-bold text-uppercase text-muted mb-3">Barème des frais (référence)</h3>
        <div class="table-responsive">
        <table class="table table-hover mb-0">
            <thead class="table-light">
            <tr>
                <th>Id</th>
                <th>Montant min</th>
                <th>Montant max</th>
                <th>Frais</th>
            </tr>
            </thead>
            <tbody>
            <%
                List<fraisEnvoi> liste = (List<fraisEnvoi>) request.getAttribute("liste");
                if (liste != null) {
                    for (fraisEnvoi f : liste) {
            %>
            <tr>
                <td><%= f.getIdfrais() %></td>
                <td><%= f.getMontant1() %></td>
                <td><%= f.getMontant2() %></td>
                <td><%= f.getFrais() %></td>
            </tr>
            <% } } %>
            </tbody>
        </table>
        </div>
    </div>
</div>
</body>
</html>
