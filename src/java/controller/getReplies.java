
package controller;

import dao.ReplyList;
import dao.ReplyManager;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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
public class getReplies extends HttpServlet {

    private static final long serialVersionUID = 1L;
   
    public getReplies() {
        super();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8"); 
        response.setCharacterEncoding("utf-8"); 
        response.setContentType("text/html;charset=UTF-8");
        
        ReplyManager replyManager = new ReplyManager();
        
        Connection con;
        ResultSet rs;
        
        // recievces a request from the user with the specified image id
        int commentID = Integer.parseInt(request.getParameter("Comment_ID"));
        
        try{
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("x,x,x,x");
            Statement st = con.createStatement();
            //Query to get the number of rows in a table
            String sql = "SELECT count(*) FROM replies WHERE R_itemID = " + commentID;
            
            //Executing the query
            rs = st.executeQuery(sql);
            //Retrieving the result
            rs.next();
            int count = rs.getInt(1);
            // set the attribute to "count"
            request.setAttribute("replyNum", count);
            
            ReplyList replyList = replyManager.findSpecificComment(commentID);  // set comment id number
            request.getSession().setAttribute("replyList", replyList);
            
            // the servlet fowards the processing to a destination JSP page.
            request.getRequestDispatcher("containers/comment.jsp").forward(request, response);
            
        }catch(SQLException ex){
            throw new ServletException(ex);
        }catch(ClassNotFoundException ex) {
            Logger.getLogger(getImageServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        ReplyManager replyManager = new ReplyManager();
        
        // get id of comment
        int commentId = Integer.parseInt(request.getParameter("Comment_ID"));
        String username = request.getParameter("User");
        String reply = request.getParameter("Reply"); 

        String replyValidation = replyManager.addReply(username, reply, commentId); 
        
        if(replyValidation.equalsIgnoreCase("SUCCESS")){
            System.out.println("Reply inserted by " + username);
        }else{
            System.out.println("****REPLY ERROR****");
        }
    }

   
}
