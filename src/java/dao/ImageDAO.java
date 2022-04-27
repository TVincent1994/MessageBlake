
package dao;

import bean.Image;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.sql.Time;

public class ImageDAO {
    String databaseURL = "jdbc:mysql://instancemtb.cbvlbcyf5pmu.us-west-2.rds.amazonaws.com:3306/messagetheblake";
    String user = "messageRoot";
    String password = "messageTheBRoot";
    
    public Image get(int id) throws SQLException, IOException {
        Image image = null;
        String sql = "SELECT * FROM photos WHERE id = ? ";
        
        try(Connection conn = DriverManager.getConnection(databaseURL, user, password)){
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            if(rs.next()){
                image = new Image();
                int ID = rs.getInt("id");
                String title = rs.getString("title");
                String commCount = rs.getString("comments_count");
                Date date = rs.getDate("img_date");
                Time time = rs.getTime("img_time");
                String img = rs.getString("fileName");
                String vid = rs.getString("video");
                int views = rs.getInt("views");
                
                // get methods finds a row int the "photo" table that's associated with the specified id.
                // If the row is found, a new "image" object is created and populated
                image.setId(ID);
                image.setTitle(title);
                image.setDate(date);
                image.setTime(time);
                image.setImage(img);
                image.setVideo(vid);
                image.setViews(views);
            }
            // added closes
            ps.close();
            conn.close();
        }catch(Exception ex){
            ex.printStackTrace();
            throw ex;
        }
        return image;
    }
}
