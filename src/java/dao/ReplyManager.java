
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Date;

import bean.Reply;
import util.DBConnection;

/**
 *
 * @author Taylor Vincent
 */
public class ReplyManager {
    
    public ReplyList findAll(){
        return null;
    }
    
    @SuppressWarnings("finally")
    public ReplyList findSpecificComment(int commentID){
        
        int id = commentID;
        ReplyList list = new ReplyList();    // "ReplyList" is an array list to add replies of objects to comments
        
        try{
            String sql = "SELECT * FROM replies WHERE R_ItemID = "+id+" ORDER BY R_date DESC, R_time DESC";
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://instancemtb.cbvlbcyf5pmu.us-west-2.rds.amazonaws.com:3306/messagetheblake", "messageRoot", "messageTheBRoot");
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                String user = rs.getString("username");
                String text = rs.getString("R_text");
                Date date = rs.getDate("R_date");
                Time time = rs.getTime("R_time");
                int commentId = rs.getInt("R_ItemID");
                
                Reply reply = new Reply(commentId, user, text, date, time);
                list.add(reply);    // add the replies to the arrayList
            }
            ps.close();
            con.close();
            rs.close();
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            return list;
        }
    }
    
    @SuppressWarnings("finally")
    public String addReply(String username, String reply, int commentId){
        try{
            Connection con = DBConnection.createConnetion();
            String sql = "INSERT INTO replies(username, R_text, R_date, R_ItemID, R_time) VALUES(?,?,CURRENT_DATE,?,CURRENT_TIME)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, reply);
            ps.setInt(3, commentId);
            int i = ps.executeUpdate();
            
            if(i!=0){
                return "SUCCESS";
            }
            ps.close();
            con.close();
        }catch(SQLException e){
            e.printStackTrace();
        }
        return "Oops.. Something happened..!";
    }
    
}
