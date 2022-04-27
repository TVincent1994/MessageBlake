
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
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class adminSendReply extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        ReplyManager replyManager = new ReplyManager();
        
        Connection con;
        ResultSet rs;
        
        // recievces a request from the user with the specified image id
        int commentID = Integer.parseInt(request.getParameter("CommentID"));
        
        try{
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost/messagetheblake", "root", "MessageTheB1994");
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
            RequestDispatcher rd = request.getRequestDispatcher("details.jsp"); 
            rd.forward(request, response);
            
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
        
        String username = request.getParameter("a_user");
        String reply = request.getParameter("reply"); 
        int Id = Integer.parseInt(request.getParameter("commentID"));
        
        String replyValidation = replyManager.addReply(username, reply, Id); 
        
        if(replyValidation.equalsIgnoreCase("SUCCESS")){
            System.out.println("Reply inserted by " + username);
        }else{
            System.out.println("****REPLY ERROR****");
        }
    }
}
