
package dao;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.MessagingException;
import org.omg.CORBA.portable.ApplicationException;

import bean.EmailMessage;

/**
 *
 * @author Taylor Vincent
 */

public class EmailUtility {

    public static void sendMail(String host, String port, EmailMessage emailMsg, String rec) throws ApplicationException, MessagingException{
       
        // set SMTP server properties
        Properties props = new Properties();
        props.put("mail.smtp.host", host);  
        props.put("mail.smtp.port", port);
        props.put("mail.smtp.auth", "true"); 
        props.put("mail.smtp.starttls.enable", "true");
        
        final String from = "xxxxxxx";    // Authenticate the MessageTheBlake email
        final String email_pass = "xxxxxxxx";             
        final String fromName = "xxxxxx";
        
        Session session = Session.getDefaultInstance(props);
        
        // Send the mail
        Transport transport = session.getTransport();

        try{
            
            // Create a message
            Message msg = new MimeMessage(session);
            // Set From: header field of the header
            msg.setFrom(new InternetAddress(from, "MessageTheBlake"));  // Display website name rather than email address in mail
            // Set To: header field of the header
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(rec));
            // Setting the Subject and Content Type
            msg.setSubject("Forgot Password?");
           
            transport.connect(host,"xxxxxxx","xxxxxxxxx");
            transport.sendMessage(msg, msg.getAllRecipients());
            System.out.println("Email Sent!");
            
            // Set message MIME type
            switch (emailMsg.getMessageType()) {
            case EmailMessage.HTML_MSG:
               msg.setContent(emailMsg.getMessage(), "text/html");
               break;
            case EmailMessage.TEXT_MSG:
               msg.setContent(emailMsg.getMessage(), "text/plain");
               break;
            }
            //Transport.send(msg);
            
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            transport.close();
        }
     
    }
    
}
