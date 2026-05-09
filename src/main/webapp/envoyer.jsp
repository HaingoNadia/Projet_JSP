<%-- 
    Document   : envoyer
    Created on : 21 avr. 2026, 20:21:26
    Author     : ME-PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="com.test.monprojetjsp.model.envoyer" %>

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
                }, 3000); 
        </script>

        <%
            session.removeAttribute("msg");
            }
        %>
        
         <div style="background:#2c3e50;color:white;padding:15px;display:flex;justify-content:space-between;align-items:center;">

        <div>
            <h2>🔄 Transfert</h2>
        </div>

        <div>
            <form action="<%=request.getContextPath()%>/envoyerServlet" method="get">
                <input type="date" name="keyword" placeholder="date">
                <button type="submit">🔍</button>
            </form>
        </div>

        <div>
             <a href="envoyerServlet?action=add">
                <button style="background:green;color:white;">Envoyer</button>
            </a>
        </div>

    </div>  
    <hr>
    <div class="card shadow-lg p-4">
        <h1>Historique de transaction</h1>
        <table class="table table-striped table-bordered">
            <tr>
                <th>Id</th>
                <th>NumEnvoyeur</th>
                <th>NumRecepteur</th>
                <th>Montant</th>
                <th>Date</th>
                <th>Raison</th>
            </tr>

            <%
                List<envoyer> liste = (List<envoyer>)request.getAttribute("liste");
                if(liste != null){
                for(envoyer env : liste){
            %>
            <tr>
                <td><%=env.getIdEnv()%></td>
                <td><%=env.getNumEnvoyeur()%></td>
                <td><%=env.getNumRecepteur()%></td>
                <td><%=env.getMontant()%></td>
                <td><%=env.getDate()%></td>
                <td><%=env.getRaison()%></td>
                <td>
                    <a href="envoyerServlet?action=edit&idEnv=<%=env.getIdEnv()%>">Modifier</a>
                    <a href="envoyerServlet?action=delete&idEnv=<%=env.getIdEnv()%>"accesskey=""onclick="return confirm('Voulez-vous vraiment supprimer cet historique ?');"> Supprimer</a>
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

