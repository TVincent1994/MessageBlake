
package bean;

import java.sql.Time;
import java.util.Date;

public class Image {
    
    private String image;
    private String video;
    private String title;
    private Date date;
    private Time time;
    private int id;
    private int views;
    
    public String getImage(){
        return image;
    }
    public void setImage(String image){
        this.image = image;
    }
    public String getVideo(){
        return video;
    }
    public void setVideo(String video){
        this.video = video;
    }
    public String getTitle(){
        return title;
    }
    public void setTitle(String title){
        this.title = title;
    }
    public Date getDate(){
        return date;
    }
    public void setDate(Date date){
        this.date = date;
    }
    public Time getTime(){
        return time;
    }
    public void setTime(Time time){
        this.time = time;
    }
    public int getId(){
        return id;
    }
    public void setId(int id){
        this.id = id;
    }
    public int getViews(){
        return views;
    }
    public void setViews(int views){
        this.views = views;
    }
}
