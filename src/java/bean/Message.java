
package bean;

import javax.servlet.http.*;
import java.sql.Time;
import java.util.Date;

public class Message implements HttpSessionBindingListener {
    //private int id;
    private String sender;
    private String receiver;
    private String message;
    private Time time;
    private Date date;
    private int status;
    
    public String getSender(){
        return sender;
    }
    public void setSender(String sender){
        this.sender = sender;
    }
    public String getReciever(){
        return receiver;
    }
    public void setReciever(String receiver){
        this.receiver = receiver;
    }
    public String getMessage(){
        return message;
    }
    public void setMessage(String message){
        this.message = message;
    }
    public Time getTime(){
        return time;
    }
    public void setTime(Time time){
        this.time = time;
    }
    public Date getDate(){
        return date;
    }
    public void setDate(Date date){
        this.date = date;
    }
    public int getStatus(){
        return status;
    }
    public void setStatus(int status){
        this.status = status;
    }
    public Message(String sender, String receiver, String message, Date date, Time time, int status){
        this.sender = sender;
        this.receiver = receiver;
        this.message = message;
        this.date = date;
        this.time = time;
        this.status = status;
    }
    public void messageAdded(HttpSessionBindingEvent event){
        // added this attribute to a session
        String name = event.getName();
        Object value = event.getValue();
        System.out.println("Attribute added: "+name+ ": " + value);
    }

    @Override
    public void valueBound(HttpSessionBindingEvent event) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void valueUnbound(HttpSessionBindingEvent event) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    
    
}