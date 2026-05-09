<%-- 
    Document   : login
    Created on : 29 avr. 2026, 18:45:56
    Author     : ME-PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">
    <div class="col-md-4 mx-auto">

        <div class="card p-4 shadow">
            <h3 class="text-center">🔐 Connexion</h3>

            <form action="loginServlet" method="post">

                <input type="email" name="mail" class="form-control mb-3" placeholder="Email" required>

                <input type="password" name="password" class="form-control mb-3" placeholder="Mot de passe" required>

                <button class="btn btn-primary w-100">Se connecter</button>
            </form>

            <% if(request.getAttribute("error") != null){ %>
                <div class="alert alert-danger mt-3">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

        </div>
    </div>
</div>

</body>
</html>
