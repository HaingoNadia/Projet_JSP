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

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow-lg p-4">

        <h2 class="text-center text-warning mb-4">💰 Gestion des frais</h2>

        <%
            fraisEnvoi cl = (fraisEnvoi)request.getAttribute("fraisEnvoi");
        %>

        <form action="<%=request.getContextPath()%>/fraisEnvoiServlet" method="post">

            <input type="hidden" name="action" value="<%= (cl != null) ? "update" : "insert" %>">

            <div class="mb-3">
                <label class="form-label">ID Frais</label>
                <input type="text" class="form-control" name="idfrais"
                       value="<%= (cl != null) ? cl.getIdfrais() : "" %>">
            </div>

            <div class="mb-3">
                <label class="form-label">Montant minimum</label>
                <input type="number" class="form-control" name="montant1"
                       value="<%= (cl != null) ? cl.getMontant1() : "" %>">
            </div>

            <div class="mb-3">
                <label class="form-label">Montant maximum</label>
                <input type="number" class="form-control" name="montant2"
                       value="<%= (cl != null) ? cl.getMontant2() : "" %>">
            </div>

            <div class="mb-3">
                <label class="form-label">Frais</label>
                <input type="number" class="form-control" name="frais"
                       value="<%= (cl != null) ? cl.getFrais() : "" %>">
            </div>

            <div class="text-center">
                <button type="submit" class="btn btn-warning px-4">
                    <%= (cl != null) ? "Modifier" : "Ajouter" %>
                </button>

                <a href="fraisEnvoiServlet" class="btn btn-secondary px-4">Retour</a>
            </div>

        </form>

    </div>
</div>

</body>
</html>