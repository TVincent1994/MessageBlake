
package bean;

import java.sql.Time;
import java.util.Date;

public class Reply {
    
    private final int commentId;
    private final String username;
    private final String reply;
    private final Date date;
    private final Time time;
    
    public Reply(int commentId, String user, String reply, Date date, Time time){
        this.commentId = commentId;
        this.username = user;
        this.reply = reply;
        this.date = date;
        this.time = time;
    }
    public int getCommentId(){
        return commentId;
    }
    public String getUser(){
        return username;
    }
    public String getReply(){
        return reply;
    }
    public Date getDate(){
        return date;
    }
    public Time getTime(){
        return time;
    }
    
}
