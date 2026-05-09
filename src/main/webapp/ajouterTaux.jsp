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

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow-lg p-4">

        <h2 class="text-center text-info mb-4">💱 Taux de change</h2>

        <%
            taux cl = (taux)request.getAttribute("taux");
        %>

        <form action="<%=request.getContextPath()%>/tauxServlet" method="post">

            <input type="hidden" name="action" value="<%= (cl != null) ? "update" : "insert" %>">

            <div class="mb-3">
                <label class="form-label">ID Taux</label>
                <input type="text" class="form-control" name="idtaux"
                       value="<%= (cl != null) ? cl.getIdtaux() : "" %>">
            </div>

            <div class="mb-3">
                <label class="form-label">Montant en Euro (€)</label>
                <input type="number" class="form-control" name="montant1"
                       value="<%= (cl != null) ? cl.getMontant1() : "" %>">
            </div>

            <div class="mb-3">
                <label class="form-label">Montant en Ariary (Ar)</label>
                <input type="number" class="form-control" name="montant2"
                       value="<%= (cl != null) ? cl.getMontant2() : "" %>">
            </div>

            <div class="text-center">
                <button type="submit" class="btn btn-info px-4">
                    <%= (cl != null) ? "Modifier" : "Ajouter" %>
                </button>

                <a href="tauxServlet" class="btn btn-secondary px-4">Retour</a>
            </div>

        </form>

    </div>
</div>

</body>
</html>