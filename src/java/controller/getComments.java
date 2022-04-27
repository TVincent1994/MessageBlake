
package controller;

import bean.Image;
import dao.CommentList;
import dao.CommentManager;
import dao.ImageDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Taylor Vincent
 */
public class getComments extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8"); 
        response.setCharacterEncoding("utf-8"); 
        response.setContentType("text/html;charset=UTF-8");
        
        int imageId = Integer.parseInt(request.getParameter("media"));
        CommentManager commentManager = new CommentManager();
        ImageDAO dao = new ImageDAO();
        
        try {
            Image image = dao.get(imageId);
            CommentList commentList = commentManager.findSpecificImage(image); // set image number 
            request.getSession().setAttribute("commentList", commentList); 
            request.getRequestDispatcher("containers/comment.jsp").forward(request, response);
            
        } catch (SQLException ex) {
            Logger.getLogger(getComments.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }
}
