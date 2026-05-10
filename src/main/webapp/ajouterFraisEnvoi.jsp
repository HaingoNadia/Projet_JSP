<%-- 
    Document   : ajouterFraisEnvoi
    Created on : 19 avr. 2026, 13:38:39
    Author     : ME-PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="com.test.monprojetjsp.model.fraisEnvoi" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Frais d'envoi</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/app.css">
</head>

<body class="app-body">

<div class="container py-4">
    <div class="app-card p-4">

        <h2 class="app-page-title h4 text-center mb-4">Frais d'envoi (tranches)</h2>

        <%
            fraisEnvoi cl = (fraisEnvoi)request.getAttribute("fraisEnvoi");
        %>

        <form action="<%=request.getContextPath()%>/fraisEnvoiServlet" method="post">

            <input type="hidden" name="action" value="<%= (cl != null) ? "update" : "insert" %>">

            <% if (cl != null) { %>
            <div class="mb-3">
                <label class="form-label">ID frais</label>
                <input type="text" class="form-control" name="idfrais"
                       value="<%= cl.getIdfrais() %>" readonly>
                <div class="form-text">Identifiant non modifiable.</div>
            </div>
            <% } %>

            <div class="mb-3">
                <label class="form-label">Montant minimum</label>
                <input type="number" class="form-control" name="montant1"
                       value="<%= (cl != null) ? cl.getMontant1() : "" %>"
                       min="0" step="1" required placeholder="Ex: 0">
            </div>

            <div class="mb-3">
                <label class="form-label">Montant maximum</label>
                <input type="number" class="form-control" name="montant2"
                       value="<%= (cl != null) ? cl.getMontant2() : "" %>"
                       min="1" step="1" required placeholder="Ex: 100000">
            </div>

            <div class="mb-3">
                <label class="form-label">Frais</label>
                <input type="number" class="form-control" name="frais"
                       value="<%= (cl != null) ? cl.getFrais() : "" %>"
                       min="0" step="0.01" required placeholder="Ex: 1500">
            </div>

            <div class="d-flex gap-2 justify-content-center">
                <button type="submit" class="btn btn-app-primary px-4">
                    <%= (cl != null) ? "Modifier" : "Ajouter" %>
                </button>
                <a href="<%=request.getContextPath()%>/fraisEnvoiServlet" class="btn btn-outline-secondary px-4">Retour</a>
            </div>

        </form>

    </div>
</div>

</body>
</html>