<%-- 
    Document   : ajouterEnvoyer
    Created on : 21 avr. 2026, 20:22:08
    Author     : ME-PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="com.test.monprojetjsp.model.envoyer" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Transfert d'argent</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">

    <div class="card shadow-lg p-4">
        <h2 class="text-center text-primary mb-4">💸 Transfert d'argent</h2>

        <%
            envoyer cl = (envoyer)request.getAttribute("envoyer");
        %>

        <form action="<%=request.getContextPath()%>/envoyerServlet" method="post">

            <input type="hidden" name="action" value="<%= (cl != null) ? "update" : "insert" %>">

            <div class="mb-3">
                <label class="form-label">ID Transaction</label>
                <input type="text" class="form-control" name="idEnv"
                       value="<%= (cl != null) ? cl.getIdEnv() : "" %>">
            </div>

            <div class="mb-3">
                <label class="form-label">Numéro Envoyeur</label>
                <input type="text" class="form-control" name="numEnvoyeur"
                       value="<%= (cl != null) ? cl.getNumEnvoyeur() : "" %>">
            </div>

            <div class="mb-3">
                <label class="form-label">Numéro Récepteur</label>
                <input type="text" class="form-control" name="numRecepteur"
                       value="<%= (cl != null) ? cl.getNumRecepteur() : "" %>">
            </div>

            <div class="mb-3">
                <label class="form-label">Montant</label>
                <input type="number" class="form-control" name="montant"
                       value="<%= (cl != null) ? cl.getMontant() : "" %>">
            </div>

            <div class="mb-3">
                <label class="form-label">Date</label>
                <%
                    String dateValue = "";
                    if(cl != null && cl.getDate() != null){
                        dateValue = cl.getDate().toString().replace(" ", "T");
                    }
                %>
                <input type="datetime-local" class="form-control" name="date"
                       value="<%= dateValue %>">
            </div>

            <div class="mb-3">
                <label class="form-label">Raison</label>
                <input type="text" class="form-control" name="raison"
                       value="<%= (cl != null) ? cl.getRaison() : "" %>">
            </div>

            <div class="text-center">
                <button type="submit" class="btn btn-success px-4">
                    <%= (cl != null) ? "Modifier" : "Transférer" %>
                </button>

                <a href="envoyerServlet" class="btn btn-secondary px-4">Retour</a>
            </div>

        </form>
    </div>

</div>

</body>
</html>