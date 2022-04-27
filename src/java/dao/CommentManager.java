
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Date;

import bean.Image;
import bean.Comment;
import java.io.IOException;
import util.DBConnection;
/**
 *
 * @author Taylor Vincent
 */

public class CommentManager {

    public CommentList findAll(){
        return null;
    }
    
    @SuppressWarnings("finally")     
    public CommentList findSpecificImage(Image image){     // get the id of the selected image and all comments associated with
        
        int id = image.getId();                  // get the id of the image
        CommentList list = new CommentList();    // "CommentList" is an arrayList to add comment objects
        
        try{
            String sql = "SELECT * FROM comments WHERE C_itemID = " + id + " ORDER BY C_id DESC";
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://instancemtb.cbvlbcyf5pmu.us-west-2.rds.amazonaws.com:3306/messagetheblake", "messageRoot", "messageTheBRoot");
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()){
                int commentId = rs.getInt("C_id");
                String user = rs.getString("username");
                String text = rs.getString("C_text");
                Date date = rs.getDate("C_date");
                Time time = rs.getTime("C_time");
                int imageID = rs.getInt("C_itemID");
                
                Comment comment = new Comment(commentId, user, text, date, time, imageID);
                list.add(comment);  // add the comment object to the arrayList
                
            }
            
            ps.close();
            con.close();
        }catch(SQLException e){
            e.printStackTrace();
        }finally{
            return list;
        }
    }

    @SuppressWarnings("finally")
    public String addComment(String username, String comment, int imgid){
        try{
            Connection con = DBConnection.createConnetion();
            String sql = "INSERT INTO comments(username, C_text, C_date, C_itemID, C_time) VALUES(?,?,CURRENT_DATE,?,CURRENT_TIME)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, comment);
            ps.setInt(3, imgid);
            
            int i = ps.executeUpdate();
            if(i>0){
                return "SUCCESS";
            }
            
            ps.close();
            con.close();
        }catch(SQLException e){
            e.printStackTrace();
        }
        return "Oops.. Something happened..!";
    }
    
    @SuppressWarnings("finally")
    public int deleteComment(int id){
        int commentId = id;
            
        try{
            Connection con = DBConnection.createConnetion();
            String sql = "DELETE FROM comments WHERE C_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, commentId);
            
            int i = ps.executeUpdate();
            
            con.close();
            ps.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return commentId;
    }

    @SuppressWarnings("finally")
    public int getCommentId(int id) throws SQLException, IOException{
        String sql = "SELECT * FROM comments WHERE C_id = ?";
        ResultSet rs = null;
        try(Connection con = DBConnection.createConnetion()){
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            
            rs = ps.executeQuery();
            
            
        }catch(SQLException ex){
            ex.printStackTrace();
            throw ex;
        }
        return id;
    }

}
