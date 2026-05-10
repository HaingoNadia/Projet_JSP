<%-- 
    Document   : ajouterTaux
    Created on : 22 avr. 2026, 08:45:53
    Author     : ME-PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="com.test.monprojetjsp.model.taux" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Taux de change</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/app.css">
</head>

<body class="app-body">

<div class="container py-4">
    <div class="app-card p-4">

        <h2 class="app-page-title h4 text-center mb-2">Taux de change</h2>
        <p class="app-subtitle text-center mb-4">Ex. 1 € = 4800 Ar → montant1 = 1, montant2 = 4800</p>

        <%
            taux cl = (taux)request.getAttribute("taux");
        %>

        <form action="<%=request.getContextPath()%>/tauxServlet" method="post">

            <input type="hidden" name="action" value="<%= (cl != null) ? "update" : "insert" %>">

            <% if (cl != null) { %>
            <div class="mb-3">
                <label class="form-label">ID taux</label>
                <input type="text" class="form-control" name="idtaux"
                       value="<%= cl.getIdtaux() %>" readonly>
                <div class="form-text">Identifiant non modifiable.</div>
            </div>
            <% } %>

            <div class="mb-3">
                <label class="form-label">Montant en Euro (€)</label>
                <input type="number" class="form-control" name="montant1"
                       value="<%= (cl != null) ? cl.getMontant1() : "" %>"
                       min="1" step="1" required placeholder="Ex: 1">
            </div>

            <div class="mb-3">
                <label class="form-label">Montant en Ariary (Ar)</label>
                <input type="number" class="form-control" name="montant2"
                       value="<%= (cl != null) ? cl.getMontant2() : "" %>"
                       min="1" step="1" required placeholder="Ex: 4800">
            </div>

            <div class="d-flex gap-2 justify-content-center">
                <button type="submit" class="btn btn-app-primary px-4">
                    <%= (cl != null) ? "Modifier" : "Ajouter" %>
                </button>
                <a href="<%=request.getContextPath()%>/tauxServlet" class="btn btn-outline-secondary px-4">Retour</a>
            </div>

        </form>

    </div>
</div>

</body>
</html>