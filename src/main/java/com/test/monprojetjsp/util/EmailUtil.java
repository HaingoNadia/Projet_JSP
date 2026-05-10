package com.test.monprojetjsp.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 * Configuration SMTP (par ordre de priorité) :
 * <ol>
 *   <li>Variables d'environnement : {@code SMTP_HOST}, {@code SMTP_PORT}, {@code SMTP_USER},
 *       {@code SMTP_PASSWORD}, {@code SMTP_FROM}, (optionnel) {@code SMTP_STARTTLS}, {@code SMTP_AUTH}</li>
 *   <li>Fichier {@code src/main/resources/mail.properties} sur le classpath (copier depuis {@code mail.properties.example})</li>
 * </ol>
 */
public final class EmailUtil {

    private EmailUtil() {
    }

    public static void envoyerEmail(String toEmail, String sujet, String messageText) {
        Properties fileProps = loadClasspathMailProperties();
        String host = firstNonBlank(System.getenv("SMTP_HOST"), fileProps.getProperty("smtp.host"));
        String port = firstNonBlank(System.getenv("SMTP_PORT"), fileProps.getProperty("smtp.port", "587"));
        String user = firstNonBlank(System.getenv("SMTP_USER"), fileProps.getProperty("smtp.user"));
        String password = normalizeSecret(firstNonBlank(System.getenv("SMTP_PASSWORD"), fileProps.getProperty("smtp.password")));
        String from = firstNonBlank(System.getenv("SMTP_FROM"), fileProps.getProperty("smtp.from", user));

        String authStr = firstNonBlank(System.getenv("SMTP_AUTH"), fileProps.getProperty("smtp.auth", "true"));
        String startTlsStr = firstNonBlank(System.getenv("SMTP_STARTTLS"), fileProps.getProperty("smtp.starttls.enable", "true"));

        if (isBlank(host) || isBlank(user) || isBlank(password) || isBlank(from)) {
            System.err.println("[EmailUtil] Envoi ignoré : SMTP non configuré.");
            System.err.println("  → Copiez src/main/resources/mail.properties.example vers mail.properties et renseignez smtp.*");
            System.err.println("  → Ou exportez SMTP_HOST, SMTP_USER, SMTP_PASSWORD, SMTP_FROM (et optionnellement SMTP_PORT).");
            return;
        }

        Properties props = new Properties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);
        props.put("mail.smtp.auth", Boolean.parseBoolean(authStr) ? "true" : "false");
        props.put("mail.smtp.starttls.enable", Boolean.parseBoolean(startTlsStr) ? "true" : "false");

        final String u = user;
        final String p = password;

        Session session = Session.getInstance(props,
                new Authenticator() {
                    @Override
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(u, p);
                    }
                });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(sujet);
            message.setText(messageText);
            Transport.send(message);
            System.out.println("[EmailUtil] Message envoyé à " + toEmail);
        } catch (MessagingException e) {
            System.err.println("[EmailUtil] Erreur d'envoi vers " + toEmail);
            e.printStackTrace();
        }
    }

    private static Properties loadClasspathMailProperties() {
        Properties p = new Properties();
        try (InputStream in = EmailUtil.class.getClassLoader().getResourceAsStream("mail.properties")) {
            if (in != null) {
                p.load(in);
            }
        } catch (IOException e) {
            System.err.println("[EmailUtil] Lecture mail.properties : " + e.getMessage());
        }
        return p;
    }

    private static String firstNonBlank(String a, String b) {
        if (!isBlank(a)) {
            return a;
        }
        return b != null ? b : "";
    }

    private static boolean isBlank(String s) {
        return s == null || s.isBlank();
    }

    /** Accepts secrets pasted with surrounding quotes and optional spaces. */
    private static String normalizeSecret(String s) {
        if (s == null) {
            return "";
        }
        String value = s.trim();
        if ((value.startsWith("\"") && value.endsWith("\"")) || (value.startsWith("'") && value.endsWith("'"))) {
            value = value.substring(1, value.length() - 1).trim();
        }
        // Gmail app passwords are often displayed with spaces every 4 chars.
        return value.replace(" ", "");
    }
}
