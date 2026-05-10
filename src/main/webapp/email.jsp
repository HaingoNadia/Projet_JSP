<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Notifications e-mail</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/app.css">
</head>
<body class="app-body">
<div class="container py-4">
    <div class="app-email-hero">
        <h1><i class="bi bi-envelope-paper me-2" aria-hidden="true"></i>Envoi d'e-mails</h1>
        <p>Les messages partent via votre serveur SMTP (<code>mail.properties</code> ou variables <code>SMTP_*</code>). Cette page est aussi accessible depuis le menu principal : <strong>E-mail & notifications</strong>.</p>
    </div>

    <%
        String msg = (String) session.getAttribute("msg");
        if (msg != null) {
            boolean err = msg.contains("Erreur");
    %>
    <div class="alert <%= err ? "alert-danger" : "alert-success" %> alert-dismissible fade show" role="alert">
        <%= msg %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <%
            session.removeAttribute("msg");
        }
    %>

    <div class="row g-4">
        <div class="col-lg-7">
            <div class="app-card p-4 h-100">
                <h2 class="h5 fw-bold mb-1">Composer un message</h2>
                <p class="app-subtitle mb-4">Destinataire, sujet et corps en texte brut.</p>

                <form action="<%= request.getContextPath() %>/emailServlet" method="post">
                    <div class="mb-3">
                        <label class="form-label">Destinataire</label>
                        <input type="email" name="to" class="form-control form-control-lg" placeholder="client@exemple.com" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Sujet</label>
                        <input type="text" name="sujet" class="form-control" placeholder="Objet du message" required>
                    </div>
                    <div class="mb-4">
                        <label class="form-label">Message</label>
                        <textarea name="corps" class="form-control" rows="7" placeholder="Corps du message…" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-app-primary btn-lg px-4">
                        <i class="bi bi-send-fill me-2" aria-hidden="true"></i>Envoyer
                    </button>
                </form>
            </div>
        </div>
        <div class="col-lg-5">
            <div class="app-card p-4 h-100 border-top border-4" style="border-color: #0d9488 !important;">
                <h2 class="h6 fw-bold text-uppercase text-muted mb-3">
                    <i class="bi bi-gear me-1" aria-hidden="true"></i>Configuration SMTP
                </h2>
                <p class="small text-muted mb-3">Fichier : <code>src/main/resources/mail.properties</code> (copiez depuis <code>mail.properties.example</code>).</p>
                <ol class="small text-muted ps-3 mb-0">
                    <li class="mb-2">Renseignez <code>smtp.host</code>, <code>smtp.port</code>, <code>smtp.user</code>, <code>smtp.password</code>, <code>smtp.from</code>.</li>
                    <li class="mb-2">Redémarrez le serveur après modification.</li>
                    <li>Les transferts internationaux déclenchent aussi des e-mails automatiques vers les clients.</li>
                </ol>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
