
package controller;

import bean.Login;
import dao.LoginDao;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Taylor Vincent
 */
public class LoginServlet extends HttpServlet {
    // The "serialVersionUID" is a universal version identifier for a Serializable class.
    // Deserialization uses this number to ensure that a loaded class corresponds exactly to a serialized object. If no match is found, then an InvalidClassException is thrown.
    private static final long serialVersionUID = 1L;
    public LoginServlet(){
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
    

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException { 
        
        response.setContentType("text/html");  
        PrintWriter out = response.getWriter();
        
        String username = request.getParameter("usernameInput");
        String password = request.getParameter("passwordInput");
        
        Login login = new Login();
        
        login.setUsername(username);
        login.setPassword(password); 
        
        LoginDao loginDao = new LoginDao();
        
        String userValidate = loginDao.authentication(login);  // Calling authentication function  
        
        if(userValidate.equalsIgnoreCase("SUCCESS")){
            // When a session object is created, then a server creates a cookie with JSESSIONID key and value which identifies a session.
            // "get.Session()" creates a cookie if one doesn't exist.
            HttpSession session = request.getSession(); // creates a new cookie object for you automatically and sets the cookie as part of the response. 
            // the "false" for "getSession()" doesn't create a new session but uses a pre-existing session.
            session.setAttribute("usernameSession", request.getParameter("usernameInput"));   // Set/create a session attribute for the existing user with their name(username).
            // With setAttribute() you can define a "key" and value pair so that you can get it in future using getAttribute("key").
            
            // Add attribute to the session to trigger the "AttributeAdded" method in httpsessionListener
            request.getSession().setAttribute("username", username);
            response.sendRedirect("Home.jsp");
        
        }else{
            // Else user validation is incorrect
            out.println("<div class=\"WelcomeUserErr\">Incorrect Username or Password</div>");
            RequestDispatcher rs = request.getRequestDispatcher("Home.jsp");
            rs.include(request, response);
        }
        out.close();
    }
}
