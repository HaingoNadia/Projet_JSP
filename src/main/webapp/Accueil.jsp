<%-- 
    Document   : Accueille
    Created on : 29 avr. 2026, 15:40:26
    Author     : ME-PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            margin: 0;
            overflow: hidden;
        }

        .sidebar {
            width: 250px;
            height: 100vh;
            background: #2c3e50;
            color: white;
            position: fixed;
        }

        .sidebar a {
            color: white;
            display: block;
            padding: 15px;
            text-decoration: none;
        }

        .sidebar a:hover {
            background: #1abc9c;
        }

        .content {
            margin-left: 250px;
            height: 100vh;
        }

        iframe {
            width: 100%;
            height: 100%;
            border: none;
        }

        .title {
            padding: 30px;
            height : 100px;
            background: #1abc9c;
            font-weight: bold;
        }
    </style>
</head>

<body>
    <!-- %
        if(session.getAttribute("user") == null){
            response.sendRedirect("login.jsp");
        }
    % -->

    <!--a href="logoutServlet" style="color:red;">🚪 Logout</a>
<!-- MENU -->
<div class="sidebar">
    <div class="title">💰 Gestion Transfert Argent</div>

    <a href="clientServlet" target="frame">
        <i class="bi bi-people"></i> Clients
    </a>

    <a href="envoyerServlet" target="frame">
        <i class="bi bi-arrow-left-right"></i> Transferts
    </a>

    <a href="tauxServlet" target="frame">
        <i class="bi bi-currency-exchange"></i> Taux
    </a>

    <a href="fraisEnvoiServlet" target="frame">
        <i class="bi bi-cash-stack"></i> Frais
    </a>
    
    <a href="recetteServlet" target="frame"> <i class="bi bi-cash-stack"></i>Recette de l'operateur
</a>
</div>

<!-- CONTENU -->
<div class="content">
    <iframe name="frame" src="dashboard.jsp"></iframe>
</div>

</body>
</html>