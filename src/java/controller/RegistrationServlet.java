package controller;

import bean.Register;
import dao.RegisterDao;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name="RegistrationServlet", urlPatterns={"/RegistrationServlet"})
public class RegistrationServlet extends HttpServlet {
    
    public RegistrationServlet(){  
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");  
        PrintWriter out = response.getWriter();
        
        HttpSession session = request.getSession();  
        
        // Copy all the input parameters in to local variables
        String email = request.getParameter("emailInput");
        String username = request.getParameter("usernameInput");
        String password = request.getParameter("passwordInput");
       
        Register r = new Register();
        
        r.setUsername(username);
        r.setEmail(email);
        r.setPassword(password);
        
        RegisterDao rd = new RegisterDao();
        
        // Insert user data into the database
        String userRegistered = rd.registerUser(r);
        
        if(userRegistered.equalsIgnoreCase("SUCCESS")){ 
            // When a session object is created, then a server creates a cookie with JSESSIONID key and value which identifies a session.
            session = request.getSession(); 
            session.setAttribute("usernameSession", username);
            session.setAttribute("emailSession", email);
               
            response.sendRedirect("Home.jsp");
            
        }else{
            // Else user validation is incorrect
            out.println("<div class=\"WelcomeUserErr\">Incorrect Registration</div>");
            RequestDispatcher rs = request.getRequestDispatcher("Home.jsp");
            rs.include(request, response);
        }
    }
}
