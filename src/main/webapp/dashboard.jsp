<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Accueil</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/app.css">
</head>
<body class="app-frame app-body">
<%
    String cp = request.getContextPath();
%>
<div class="p-4">
    <h1 class="app-page-title">Bienvenue</h1>
    <p class="app-subtitle mb-4">Gestion des transferts internationaux (type TapTap Send). Utilisez le menu latéral ou les raccourcis ci-dessous.</p>

    <h2 class="h6 text-uppercase text-muted fw-bold mb-3">Accès rapide</h2>
    <div class="row g-3 mb-4">
        <div class="col-sm-6 col-xl-4">
            <a href="<%= cp %>/clientServlet" target="frame" class="app-quick-card app-card p-4">
                <i class="bi bi-people fs-3 d-block mb-2" style="color:#0d9488;" aria-hidden="true"></i>
                <span class="fw-bold d-block">Clients</span>
                <span class="small text-muted">Liste, recherche, modifier (tous les champs), PDF</span>
            </a>
        </div>
        <div class="col-sm-6 col-xl-4">
            <a href="<%= cp %>/envoyerServlet" target="frame" class="app-quick-card app-card p-4">
                <i class="bi bi-arrow-left-right fs-3 d-block mb-2" style="color:#2563eb;" aria-hidden="true"></i>
                <span class="fw-bold d-block">Transferts</span>
                <span class="small text-muted">Création et modification (montant, date, raison…)</span>
            </a>
        </div>
        <div class="col-sm-6 col-xl-4">
            <a href="<%= cp %>/emailServlet" target="frame" class="app-quick-card app-card p-4 border border-2" style="border-color: rgba(13,148,136,0.35) !important;">
                <i class="bi bi-envelope-paper fs-3 d-block mb-2" style="color:#0f766e;" aria-hidden="true"></i>
                <span class="fw-bold d-block">E-mail & notifications</span>
                <span class="small text-muted">Envoyer un e-mail manuel (SMTP)</span>
            </a>
        </div>
    </div>

    <div class="row g-3">
        <div class="col-md-4">
            <div class="app-card p-4 h-100 border-start border-4" style="border-color: #0d9488 !important;">
                <h3 class="h6 fw-bold text-muted text-uppercase">Clients</h3>
                <p class="mb-0 small text-muted">CRUD, recherche, relevés PDF mensuels.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="app-card p-4 h-100 border-start border-4 border-primary">
                <h3 class="h6 fw-bold text-muted text-uppercase">Transferts</h3>
                <p class="mb-0 small text-muted">International, taux, frais, e-mails automatiques.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="app-card p-4 h-100 border-start border-4 border-warning">
                <h3 class="h6 fw-bold text-muted text-uppercase">Recette</h3>
                <p class="mb-0 small text-muted">Total des frais perçus par l'opérateur.</p>
            </div>
        </div>
    </div>
</div>
</body>
</html>
