<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Connexion — TapTap Send</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/app.css">
</head>
<body>
<div class="app-login-wrap">
    <div class="app-login-card">
        <div class="text-center mb-4">
            <div class="fw-bold text-teal mb-1" style="color:#0d9488;font-size:1.25rem;">TapTap Send</div>
            <p class="text-muted small mb-0">Connexion opérateur</p>
        </div>

        <form action="<%= request.getContextPath() %>/loginServlet" method="post">
            <div class="mb-3">
                <label class="form-label">E-mail</label>
                <input type="email" name="mail" class="form-control" placeholder="vous@exemple.com" required autocomplete="username">
            </div>
            <div class="mb-4">
                <label class="form-label">Mot de passe</label>
                <input type="password" name="password" class="form-control" required autocomplete="current-password">
            </div>
            <button type="submit" class="btn btn-app-primary w-100 py-2">Se connecter</button>
        </form>

        <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger mt-3 mb-0 small">
            <%= request.getAttribute("error") %>
        </div>
        <% } %>
    </div>
</div>
</body>
</html>
