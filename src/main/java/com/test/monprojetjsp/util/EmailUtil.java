/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.test.monprojetjsp.util;

/**
 *
 * @author ME-PC
 */
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class EmailUtil {

    public static void envoyerEmail(String toEmail, String sujet, String messageText) {

        final String fromEmail = "ravelomananjarasoanadia@gmail.com"; // 👈 TON EMAIL
        final String password = "jhtwqgpbwoynqiaz"; // 👈 MOT DE PASSE APPLICATION

        Properties props = new Properties();

        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props,
            new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(fromEmail, password);
                }
            });

        try {
            Message message = new MimeMessage(session);

            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(
                Message.RecipientType.TO,
                InternetAddress.parse(toEmail)
            );

            message.setSubject(sujet);
            message.setText(messageText);

            Transport.send(message);

            System.out.println("✅ Email envoyé à " + toEmail);

        } catch (MessagingException e) {
            System.out.println("❌ Erreur envoi email");
            e.printStackTrace();
        }
    }
}
