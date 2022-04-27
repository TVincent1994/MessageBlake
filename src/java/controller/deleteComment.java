
package controller;

import dao.CommentManager;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Taylor Vincent
 */
public class deleteComment extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int commentID = Integer.parseInt(request.getParameter("commID"));
        int imageId = Integer.parseInt(request.getParameter("media"));
        
        CommentManager commentManager = new CommentManager();
        commentManager.deleteComment(commentID);
        response.sendRedirect("getDetails?media="+imageId);   // return back to page after delete comment
    }
}
