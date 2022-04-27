
package controller;

import bean.Image;
import dao.ImageDAO;
import dao.CommentManager;
import dao.CommentList;
import util.DBConnection;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
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

public class getImageServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
   
    public getImageServlet() {
        super();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        CommentManager commentManager = new CommentManager();
        HttpSession session = request.getSession();
        
        // get id of image
        int imgid = Integer.parseInt(request.getParameter("id"));
        String username = (String)session.getAttribute("usernameSession");
        String comment = request.getParameter("comment"); 
        
        String commentValidation = commentManager.addComment(username, comment, imgid);   
        
        if(commentValidation.equalsIgnoreCase("SUCCESS")){
            System.out.println("Comment inserted by " + username);
        }else{
            System.out.println("****COMMENT ERROR****");
        }
    }  
    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        CommentManager commentManager = new CommentManager();
        
        Connection con;
        ResultSet rs;
        
        response.setContentType("image/gif"); 
        PrintWriter out = response.getWriter();
        
        // recievces a request from the user with the specified image id
        int imageId = Integer.parseInt(request.getParameter("media"));
        ImageDAO dao = new ImageDAO();
        
        updateViews(imageId);
        
        try{
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://instancemtb.cbvlbcyf5pmu.us-west-2.rds.amazonaws.com:3306/messagetheblake", "messageRoot", "messageTheBRoot");
            Statement st = con.createStatement();
            //Query to get the number of rows in a table
            String numCount = "SELECT count(*) FROM comments WHERE C_itemID="+ imageId;
            //Executing the query
            rs = st.executeQuery(numCount);
            //Retrieving the result
            rs.next();
            int count = rs.getInt(1);
            // set the attribute to "count"
            request.setAttribute("commentNum", count);   
            
            // then calls the DAO to retrieve the image object
            Image image = dao.get(imageId);
            
            // which is then stored as a request attribute
            request.setAttribute("image", image);
            request.setAttribute("video", image.getVideo());
            request.setAttribute("views", image.getViews());
            
            CommentList commentList = commentManager.findSpecificImage(image); // set image number 
            
            request.getSession().setAttribute("commentList", commentList);    
            request.getSession().setAttribute("commentSize", commentList.size()); // set the comment list size name
            
            // the servlet fowards the processing to a destination JSP page.
            RequestDispatcher rd = request.getRequestDispatcher("containers/image.jsp"); 
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
    
    // update the number of view per page visit
    private int updateViews(int id){
        Connection con = DBConnection.createConnetion();
        try{
            String sql = "UPDATE photos SET views = views + 1 WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            int i = ps.executeUpdate();
            if(i!=0){
                return i;
            }
            con.close();
            ps.close();
        }catch(SQLException e){
            e.printStackTrace();
        }
        return 1;
    }
}
