
package controller;

import java.io.IOException;
import java.util.Date;
import java.util.Properties;
import javax.mail.AuthenticationFailedException;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.servlet.http.HttpSession;
/**
 *
 * @author Taylor Vincent
 */
public class EmailSendServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        HttpSession sess = request.getSession(true);
        
        String from = (String)sess.getAttribute("usernameSession");
        String subject = request.getParameter("userSubject");
        String message = request.getParameter("userMessage");
        
        try{
            Properties props = new Properties();
            props.setProperty("mail.host", "email-smtp.us-west-2.amazonaws.com");
            props.setProperty("mail.smtp.port", "587");
            props.setProperty("mail.smtp.auth", "true");
            props.setProperty("mail.smtp.starttls.enable", "true");
            
            // Recipient's e-mail id.
            
            String pass = "Blake1994";
            String gmail = "tvincent1322@gmail.com";
            
            // Create a new session with an authenticator.
            // javax.mail.Session class provides "getInstance()" method to get the object of session by returning a new session.
            Authenticator auth = new SMTPAuthenticator(gmail, pass);
            
            Session session = Session.getInstance(props, auth);
           
            // creates a new e-mail message
            MimeMessage msg = new MimeMessage(session);
            msg.setText(message);
            String TextMessage = "<b>Username:</b> " + from + "<br><br><b>Message:</b> " + message;
            msg.setSubject(subject);
            msg.setFrom(new InternetAddress(from));
            msg.addRecipient(Message.RecipientType.TO, new InternetAddress(gmail));
            msg.setSentDate(new Date());
            msg.setContent(TextMessage, "text/html");
            // send the message
            Transport.send(msg);
            System.out.println("Message successfully sent...");
        }catch(AuthenticationFailedException ex){
            request.setAttribute("ErrorMessage", "Authentication Failed");           
            response.sendRedirect("error.jsp");
       }catch (AddressException ex) {
            request.setAttribute("ErrorMessage", "Wrong email address");
            response.sendRedirect("error.jsp");
        } catch (MessagingException ex) {
            request.setAttribute("ErrorMessage", ex.getMessage());
            response.sendRedirect("error.jsp");
        }
            response.sendRedirect("success.jsp");   
    }

    // authenticate to sign in gmail mail
    private class SMTPAuthenticator extends Authenticator{
        private final PasswordAuthentication authentication;
        public SMTPAuthenticator(String login, String password){
            authentication = new PasswordAuthentication(login, password);
        }
        
        @Override
        protected PasswordAuthentication getPasswordAuthentication() {
            return authentication;
        }   
    }
}
