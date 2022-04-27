
package controller;

import bean.Image;
import dao.CommentList;
import dao.CommentManager;
import dao.ImageDAO;

import java.io.IOException;
import java.io.PrintWriter;
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
import javax.servlet.http.HttpSession;

/**
 *
 * @author Taylor Vincent
 */
public class getDetails extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
   
    public getDetails() {
        super();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Connection con;
        ResultSet rs;
        
        CommentManager commentManager = new CommentManager();
        
        int imageId = Integer.parseInt(request.getParameter("media"));
        ImageDAO dao = new ImageDAO();
        
        try{
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://instancemtb.cbvlbcyf5pmu.us-west-2.rds.amazonaws.com:3306/messagetheblake", "messageRoot", "messageTheBRoot");
            Statement st = con.createStatement();
            //Query to get the number of rows in a table
            String numCount = "SELECT count(*) FROM comments WHERE C_itemID="+ imageId;
            //Executing the query
            rs = st.executeQuery(numCount);
            rs.next();
            int count = rs.getInt(1);
            
            // set the attribute to "count"
            request.setAttribute("commentNum", count); 
            
            Image image = dao.get(imageId);
            request.setAttribute("image", image);
            
            CommentList commentList = commentManager.findSpecificImage(image);
            request.getSession().setAttribute("getComments", commentList);   
            
            RequestDispatcher rd = request.getRequestDispatcher("details.jsp"); 
            rd.forward(request, response);
            
            rs.close();
            st.close();
            con.close();
            
        }catch(SQLException ex){
            throw new ServletException(ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(getImageServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        PrintWriter out = response.getWriter();
        CommentManager commentManager = new CommentManager();
        
        
        String admin = (String)session.getAttribute("BlakeSession");
        String comment = request.getParameter("comment");
        int imageId = Integer.parseInt(request.getParameter("media"));
        
        String commentValidation = commentManager.addComment(admin, comment, imageId);   
        
        if(commentValidation.equalsIgnoreCase("SUCCESS")){
            System.out.println("Comment inserted by " + admin);
        }else{
            out.println("****COMMENT ERROR****");
        }
    }

}
