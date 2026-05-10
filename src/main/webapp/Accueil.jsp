<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>TapTap Send — Tableau de bord</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/app.css">
</head>
<body class="app-body" style="margin:0;">

<aside class="app-sidebar">
    <div class="app-sidebar-header">
        <i class="bi bi-send-fill app-sidebar-logo" aria-hidden="true"></i>
        TapTap Send
    </div>
    <nav>
        <a href="<%= request.getContextPath() %>/dashboard.jsp" target="frame">
            <i class="bi bi-house-door" aria-hidden="true"></i>
            <span>Accueil</span>
        </a>
        <a href="<%= request.getContextPath() %>/clientServlet" target="frame">
            <i class="bi bi-people" aria-hidden="true"></i>
            <span>Clients</span>
        </a>
        <a href="<%= request.getContextPath() %>/envoyerServlet" target="frame">
            <i class="bi bi-arrow-left-right" aria-hidden="true"></i>
            <span>Transferts</span>
        </a>
        <a href="<%= request.getContextPath() %>/tauxServlet" target="frame">
            <i class="bi bi-currency-exchange" aria-hidden="true"></i>
            <span>Taux de change</span>
        </a>
        <a href="<%= request.getContextPath() %>/fraisEnvoiServlet" target="frame">
            <i class="bi bi-percent" aria-hidden="true"></i>
            <span>Frais d'envoi</span>
        </a>
        <a href="<%= request.getContextPath() %>/recetteServlet" target="frame">
            <i class="bi bi-graph-up" aria-hidden="true"></i>
            <span>Recette opérateur</span>
        </a>
        <a class="app-nav-email" href="<%= request.getContextPath() %>/emailServlet" target="frame" title="Envoyer des e-mails (SMTP)">
            <i class="bi bi-envelope-paper" aria-hidden="true"></i>
            <span>E-mail & notifications</span>
        </a>
    </nav>
    <div class="app-sidebar-footer">
        Gestion transfert international
    </div>
</aside>

<div class="app-main">
    <div class="app-topbar">
        <span class="app-topbar-title">Espace opérateur</span>
        <span class="app-topbar-hint text-muted small d-none d-md-inline">Menu à gauche · section e-mail : <strong>E-mail & notifications</strong></span>
    </div>
    <iframe name="frame" title="Contenu" src="<%= request.getContextPath() %>/dashboard.jsp"></iframe>
</div>

</body>
</html>
