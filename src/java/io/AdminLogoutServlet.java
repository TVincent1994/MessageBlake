
package io;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Taylor Vincent
 */
public class AdminLogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        if(session!=null){  
            // This method removes the whole session from the web server so we cannot access attributes from it anymore.
            session.invalidate();
            System.out.println("Logged out");
            response.sendRedirect("Blake_Login.jsp");
        }
    }
}
