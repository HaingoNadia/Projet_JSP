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

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">

    <div class="card shadow">
        
        <%
            client cl = (client)request.getAttribute("client");
        %>

        <div class="card-header bg-primary text-white text-center">
            <h4><%= (cl != null) ? "Modifier Client" : "Ajouter Client" %></h4>
        </div>

        <div class="card-body"> 
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
                    <label class="form-label">Numéro</label>
                    <input type="text" name="numtel" class="form-control"
                           value="<%= (cl != null) ? cl.getNumtel() : "" %>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Nom</label>
                    <input type="text" name="nom" class="form-control"
                           value="<%= (cl != null) ? cl.getNom() : "" %>" required>
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
                           value="<%= (cl != null) ? cl.getPays() : "" %>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Solde</label>
                    <input type="number" name="solde" class="form-control"
                           value="<%= (cl != null) ? cl.getSolde() : "" %>">
                </div>

                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <input type="email" name="mail" class="form-control"
                           value="<%= (cl != null) ? cl.getMail() : "" %>" required>
                </div>

                <div class="d-flex justify-content-between">
                    <a href="clientServlet" class="btn btn-secondary">Retour</a>
                    <button type="submit" class="btn btn-success">
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
