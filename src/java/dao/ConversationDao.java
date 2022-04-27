
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.sql.Connection;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import util.DBConnection;

import bean.Message;
import bean.searchConversation;
import java.time.LocalTime;

public class ConversationDao {
    
    public boolean conversation(String username1, String username2){
        try{
            Connection con = DBConnection.createConnetion();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM conversation WHERE username1='"+username1+"' AND username2='"+username2+"'");
            while(rs.first()){
                int id = getConversationId(username1, username2);
                long now = System.currentTimeMillis();
                Time time = new Time(now);
                LocalTime localTm = time.toLocalTime();
                int i = st.executeUpdate("UPDATE conversation SET convo_time='"+localTm+"' WHERE convo_id='"+id+"'");
                return true;
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return false;
    }
    
    // get all conversations from all users
    public List<searchConversation> conversationList(String username1, String username2){
        List<searchConversation> users = new ArrayList<>();
        try{
            Connection con = DBConnection.createConnetion();
            Statement st = con.createStatement();
            String sql = "SELECT * FROM conversation WHERE username1='"+username1+"' OR username2='"+username1+"' ORDER BY convo_date, convo_time DESC";
            ResultSet rs = st.executeQuery(sql);
            while(rs.next()){
                String user1 = rs.getString("username1");
                String user2 = rs.getString("username2");
                if(user1.equals(username1)){
                    users.add(new searchConversation(user2)); // MAY NEED TO GO BACK TO THESE IF STATEMENTS
                }else{
                    users.add(new searchConversation(user1));
                }
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return users;
    }
    
    // get the list of messages user1 and user2 
    public List<Message> getAllConversations(String username1, String username2){
        ArrayList<Message> conversation = new ArrayList<>();
        ResultSet rs = null;
        Statement st = null;
        try{
            Connection con = DBConnection.createConnetion();
            st = con.createStatement();
            String sql = "SELECT * FROM messages WHERE (sender_name='"+username1+"' AND receiver_name='"+username2+"') OR (sender_name='"+username2+"' AND receiver_name='"+username1+"') ORDER BY m_date DESC, m_time DESC";
            rs = st.executeQuery(sql);
            while(rs.next()){
                // add the user and messages into "conversation" List
                // changed the rs.getString for first and second parameter from "username1" and "username2"
                conversation.add(new Message(rs.getString("sender_name"), rs.getString("receiver_name"), rs.getString("messages_text"), rs.getDate("m_date"), rs.getTime("m_time"), rs.getInt("message_status"))); 
            }
            st.close();
            rs.close();
            con.close();       // closes the connections from increasing in mysql db by the setInterval js function 
        }catch(Exception e){
            e.printStackTrace();
        }
        
        return conversation;
    }
    
    // send message
    public String sendMessage(String sender, String receiver, String message, int status){
        try{
            Connection con = DBConnection.createConnetion();
            String sql = "INSERT INTO messages(sender_name, receiver_name, messages_text, m_date, m_time, message_status) VALUES(?,?,?,CURRENT_DATE,CURRENT_TIME, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, sender);
            ps.setString(2, receiver);
            ps.setString(3, message);
            ps.setInt(4, status);
            int i = ps.executeUpdate();
            
            con.close();   // close connection to stop leakage of open connection
            
        }catch(SQLException e){
            e.printStackTrace();
        }catch(Exception ex){
            ex.printStackTrace();
        }
        return null;
    }
    
    // add new conversation to the db
    public void addConversation(String username1, String username2){
        try{
            Connection con = DBConnection.createConnetion();
            String sql = "INSERT INTO conversation(username1, username2, convo_time) VALUES(?,?, CURRENT_TIME)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username1);
            ps.setString(2, username2);
            int i = ps.executeUpdate();
            
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    // get the id of conversation
    public int getConversationId(String username1, String username2){
        try{
            Connection con = DBConnection.createConnetion();
            Statement st = con.createStatement();
            String sql = "SELECT convo_id FROM conversation WHERE (username1 = '"+username1+"' AND username2 = '"+username2+"') OR (username1 = '"+username2+"' AND username2 = '"+username1+"')";
            ResultSet rs = st.executeQuery(sql);
            while(rs.first()){        // move cursor to the first row
                int id = rs.getInt("convo_id");
                return id;
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return 0;
    }
    
    // delete conversation from list
    public void deleteConversation(String username1, String username2){
        try{
            Connection con = DBConnection.createConnetion();
            Statement st = con.createStatement();
            int id = getConversationId(username1, username2);
            int i = st.executeUpdate("DELETE FROM conversation WHERE convo_id='"+id+"'");
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
}