<%-- 
    Document   : taux
    Created on : 22 avr. 2026, 08:45:28
    Author     : ME-PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="com.test.monprojetjsp.model.taux" %>

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
            <h2>💰 A propos de Taux</h2>
        </div>

        <div>
           <form action="<%=request.getContextPath()%>/tauxServlet" method="get">
                <input type="text" name="keyword" placeholder="idtaux ou montantant1 "> 
                <button type="submit">🔍</button>
            </form>
        </div>

        <div>
            <a href="tauxServlet?action=add">
                <button style="background:green;color:white;">➕ Ajouter un taux</button>
            </a>
        </div>

    </div>

<hr>
    <div class="card shadow-lg p-4">
        <h2>Taux d'echange</h2>
        <table class="table table-striped table-bordered">
            <tr>
                <th>Id</th>
                <th>Montant en euro</th>
                <th>Montant en Ariary</th>
            
            </tr>

            <%
                List<taux> liste = (List<taux>)request.getAttribute("liste");
                if(liste != null){
                for(taux t : liste){
            %>
            <tr>
                <td><%=t.getIdtaux()%></td>
                <td><%=t.getMontant1()%></td>
                <td><%=t.getMontant2()%></td>
                <td>
                    <a href="tauxServlet?action=edit&idtaux=<%=t.getIdtaux()%>">Modifier</a>
                    <a href="tauxServlet?action=delete&idtaux=<%=t.getIdtaux()%>"accesskey=""onclick="return confirm('Voulez-vous vraiment supprimer ce taux ?');"> Supprimer</a>
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
