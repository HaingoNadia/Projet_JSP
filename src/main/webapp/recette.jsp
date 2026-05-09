<%-- 
    Document   : recette
    Created on : 8 mai 2026, 02:38:30
    Author     : ME-PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.test.monprojetjsp.model.fraisEnvoi"%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>Recette</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body class="bg-light">

<div class="container mt-5">

    <!-- RECETTE -->
    <div class="card shadow-lg p-4 mb-4 bg-success text-white">

        <h2>💰 Recette Totale Opérateur</h2>

        <h3 class="display-4">
            Total de frais :<%= request.getAttribute("recette") %> £
        </h3>

    </div>

    <!-- TAUX -->
    <div class="card shadow-lg p-4">

        <h3 class="text-primary mb-4">
            Liste de la recette
        </h3>

        <table class="table table-bordered table-hover">

            <tr class="table-dark">
                <th>Id</th>
                <th>Montant1 (£)</th>
                <th>Montant2 (£)</th>
                <th>Frais</th>
            </tr>

            <%
                List<fraisEnvoi> liste =
                    (List<fraisEnvoi>)request.getAttribute("liste");

                if(liste != null){

                    for(fraisEnvoi f: liste){
            %>

            <tr>

                <td><%=f.getIdfrais()%></td>
                <td><%=f.getMontant1()%></td>
                <td><%=f.getMontant2()%></td>
                <td><%=f.getFrais()%></td>

            </tr>

            <%
                    }
                }
            %>

        </table>

    </div>

</div>

</body>
</html>