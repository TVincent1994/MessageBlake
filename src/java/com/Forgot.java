
package com;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ForgotUserPassword;
import dao.EmailUtility;
import bean.EmailMessage;
import javax.servlet.ServletContext;

/**
 *
 * @author Taylor Vincent
 */
public class Forgot extends HttpServlet {
    
    private String host;
    private String port;
    
    // load configuration for SMTP server upon initialization with "init()" to handle user's request in the "doPost()"
    public void init(){
        // reads SMTP server setting values from web.xml
        ServletContext context = getServletContext();
        host = context.getInitParameter("host");
        port = context.getInitParameter("port");
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher rs = request.getRequestDispatcher("forgotPwd.jsp");
        rs.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String email = request.getParameter("sentEmail");
        
        ForgotUserPassword find = new ForgotUserPassword();
        String pass = find.FindPassword(email);           // get password from db
        EmailMessage emailSetup = new EmailMessage();     //  email setup 
        emailSetup.setTo(email);                         // set to receiver email
        // Set the actual message
        emailSetup.setMessage("Hello! The password for your email '"+email+"' is: " + pass);   // took out reg.getPassword()
        System.out.println("PASSWORD: "+pass);
        try{  
            EmailUtility.sendMail(host, port, emailSetup, email);
        }catch(Exception e){
            System.out.println(e.getMessage());
            System.out.println("Password: "+pass);
        }
    }

}
