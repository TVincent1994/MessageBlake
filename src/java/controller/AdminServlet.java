
package controller;

import bean.Login;
import dao.AdminDao;

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
public class AdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    public AdminServlet(){
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");  
        PrintWriter out = response.getWriter();
        
        String username = request.getParameter("BlakeUsername");
        String password = request.getParameter("BlakePassword");
        
        Login login = new Login();
        login.setUsername(username);
        login.setPassword(password); 
        
        AdminDao admin = new AdminDao();
        
        String userValidate = admin.authentication(login);  // Calling authentication function  
               
        if(userValidate.equalsIgnoreCase("BLAKE_SUCCESS")){
            HttpSession session = request.getSession(); 
            session.setAttribute("BlakeSession", request.getParameter("BlakeUsername"));   // Set/create a session attribute for the existing user with their name(username).
            // With setAttribute() you can define a "key" and value pair so that you can get it in future using getAttribute("key").
            response.sendRedirect("Blake_Index.jsp");
        }else{
            out.println("<b><div class=\"ErrMessage\">Incorrect Username or Password</div>");
            RequestDispatcher rs = request.getRequestDispatcher("Blake_Login.jsp");
            rs.include(request, response);
        }
        out.close();
    }

}
