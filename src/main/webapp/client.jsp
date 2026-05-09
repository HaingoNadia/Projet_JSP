<%-- 
    Document   : index
    Created on : 12 avr. 2026, 12:14:34
    Author     : ME-PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="com.test.monprojetjsp.model.client" %>

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
            <h2><i class="bi bi-people"></i> Client</h2>
        </div>

        <div>
            <form action="<%=request.getContextPath()%>/clientServlet" method="get" style="display:inline;">
                <input type="text" name="keyword" placeholder="Rechercher client">
                <button type="submit">🔍</button>
            </form>
        </div>

        <div>
            <a href="<%=request.getContextPath()%>/clientServlet?action=add">
                <button style="background:green;color:white;">➕ Ajouter Client</button>
            </a>
        </div>

    </div>

<hr>        
<div class="card shadow-lg p-4">       
        <h2>Liste de client</h2>
        <table class="table table-striped table-bordered">            
            <tr>
                <th>Numtel</th>
                <th>Nom</th>
                <th>Sexe</th>
                <th>Pays</th>
                <th>Solde</th>
                <th>Gmail</th>
                <th>Action</th>
                <th>Pdf/Mois</th>
            </tr>

            <%
                List<client> liste = (List<client>)request.getAttribute("liste");
                if(liste != null){
                for(client c : liste){
            %>
            <tr>
                <td><%=c.getNumtel()%></td>
                <td><%=c.getNom()%></td>
                <td><%=c.getSexe()%></td>
                <td><%=c.getPays()%></td>
                <td><%=c.getSolde()%></td>
                <td><%=c.getMail()%></td>
                <td>
                    <a href="clientServlet?action=edit&numtel=<%=c.getNumtel()%>">Modifier</a>
                    <a href="clientServlet?action=delete&numtel=<%=c.getNumtel()%>" accesskey=""onclick="return confirm('Voulez-vous vraiment supprimer ce client ?');"> Supprimer</a>                
                </td>
                <td>
                      <form action="pdf" method="get">
                    <input type="hidden" name="numtel" value="<%=c.getNumtel()%>" >
                    <select name="mois">
                        <option value="1">Janvier</option>
                        <option value="2">Février</option>
                        <option value="3">Mars</option>
                        <option value="4">Avril</option>
                        <option value="5">Mai</option>
                        <option value="6">Juin</option>
                        <option value="7">Juillet</option>
                        <option value="8">Août</option>
                        <option value="9">Septembre</option>
                        <option value="10">Octobre</option>
                        <option value="11">Novembre</option>
                        <option value="12">Décembre</option>
                    </select>
                        <button type="submit">Télécharger PDF</button>
                    </form>
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
