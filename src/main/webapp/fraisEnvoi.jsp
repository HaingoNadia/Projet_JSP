<%-- 
    Document   : fraisEnvoi
    Created on : 19 avr. 2026, 13:28:11
    Author     : ME-PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="com.test.monprojetjsp.model.fraisEnvoi" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <title>JSP Page</title>
    </head>
    <body>
        
         <%
            String msg = (String) session.getAttribute("msg");
            if(msg != null){
        %>

        <div id="messageBox" style="
            position: fixed;
            top: 600px;
            right: 20px;
            background-color: #28a745;
            color: white;
            padding: 15px 25px;
            border-radius: 5px;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.2);
            z-index: 999;
        ">
            <%= msg %>
        </div>

        <script>
            setTimeout(function(){
                document.getElementById("messageBox").style.display = "none";
            }, 3000); // disparaît après 3 secondes
        </script>

        <%
                session.removeAttribute("msg");
            }
        %>
        
    <div style="background:#2c3e50;color:white;padding:15px;display:flex;justify-content:space-between;align-items:center;">

        <div>
            <h2>💰 Frais de Transfert</h2>
        </div>

        <div>
            <form action="<%=request.getContextPath()%>/fraisEnvoiServlet" method="get">
            <input type="text" name="keyword" placeholder="montant1 ou montant2 ">
                <button type="submit">🔍</button>
            </form>
        </div>

        <div>
            <a href="fraisEnvoiServlet?action=add">
                <button style="background:green;color:white;">➕ Ajouter Frais</button>
            </a>
        </div>

    </div>

<hr>
<div class="card shadow-lg p-4">
        <h2> Frais d'envoi</h2>
        <table class="table table-striped table-bordered">
            <tr>
                <th>Id</th>
                <th>Montant1 (£)</th>
                <th>Montant2 (£)</th>
                <th>Frais</th>
                <th>Action</th>
            </tr>

            <%
                List<fraisEnvoi> liste = (List<fraisEnvoi>)request.getAttribute("liste");
                if(liste != null){
                for(fraisEnvoi f : liste){
            %>
            <tr>
                <td><%=f.getIdfrais()%></td>
                <td><%=f.getMontant1()%></td>
                <td><%=f.getMontant2()%></td>
                <td><%=f.getFrais()%></td>
                <td>
                    <a href="fraisEnvoiServlet?action=edit&idfrais=<%=f.getIdfrais()%>">Modifier</a>
                    <a href="fraisEnvoiServlet?action=delete&idfrais=<%=f.getIdfrais()%>"accesskey=""onclick="return confirm('Voulez-vous vraiment supprimer ce frais ?');"> Supprimer</a>
                </td>
            </tr>
            <%
                    }
                }
            %>
        </table>
    </div>
    </body>
</html>
