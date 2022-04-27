
package controller;

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
public class getReply extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Connection con;
        ResultSet rs;
        
        request.setCharacterEncoding("UTF-8"); 
        response.setCharacterEncoding("utf-8"); 
        response.setContentType("text/html;charset=UTF-8");
        
        int commentID = Integer.parseInt(request.getParameter("commentID"));
        
        try{
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://instancemtb.cbvlbcyf5pmu.us-west-2.rds.amazonaws.com:3306/messagetheblake\", \"messageRoot\", \"messageTheBRoot");
            Statement st = con.createStatement();
            //Query to get the number of rows in a table
            String sql = "SELECT * FROM replies WHERE R_ItemID = "+commentID;
            //Executing the query
            rs = st.executeQuery(sql);
            //Retrieving the result
            while(rs.next()){
                rs.getString("username");
            }
            
            // the servlet fowards the processing to a destination JSP page.
            request.getRequestDispatcher("containers/comment.jsp").forward(request, response);
            
        }catch(SQLException ex){
            throw new ServletException(ex);
        }catch(ClassNotFoundException ex) {
            Logger.getLogger(getImageServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
