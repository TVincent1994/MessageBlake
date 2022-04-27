
package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Time;
import java.util.Date;
import java.sql.SQLException;

import util.DBConnection;

public class Comment {
    // took out the final keywords 
    private int commentId;
    private int imgid;
    private String username;
    private String comment;
    private Date date;
    private Time time;
    
    
    public void setId(int commentId){
        this.commentId = commentId;
    }
    public int getId(){
        return commentId;
    }
    public void setImgId(int imgid){
        this.imgid = imgid;
    }
    public int getImageId(){
        return imgid;
    }
    public void setUsername(String username){
        this.username = username;
    }
    public String getUsername(){
        return username;
    }
    public void setComment(String comment){
        this.comment = comment;
    }
    public String getComment(){
        return comment;
    }
    public void setDate(Date date){
        this.date = date;
    }
    public Date getDate(){
        return date;
    }
    public void setTime(Time time){
        this.time = time;
    }
    public Time getTime(){
        return time;
    }

    public Comment(int commentId, String user, String comment, Date date, Time time, int imgid){
        this.commentId = commentId;
        this.username = user;
        this.comment = comment;
        this.date = date;
        this.time = time;
        this.imgid = imgid;
    }
    
    // function to get the comment id
    public int getCommentId(int id) throws SQLException {
        this.commentId = id;
        String sql = "SELECT * FROM comments WHERE C_id = ?";
        Connection con = DBConnection.createConnetion();
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        return id;
    }
}
