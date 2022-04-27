
package bean;

import java.util.ArrayList;
import bean.Register;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 *
 * @author Taylor Vincent
 */
public class RegisteredUsers {
    
    public ArrayList<Register> getUsers(){
        
        ArrayList<Register> userList = new ArrayList<Register>();
        
        Connection con = null;
        Statement statement = null;
        
        try{
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(
                    "jdbc:mysql://instancemtb.cbvlbcyf5pmu.us-west-2.rds.amazonaws.com:3306/messagetheblake", "messageRoot", "messageTheBRoot");
            statement = con.createStatement();
            ResultSet rs = statement.executeQuery("SELECT uid, username, email FROM register");
            while(rs.next()){
                Register reg = new Register();
                
                reg.setUid(rs.getInt("uid"));
                reg.setUsername(rs.getString(2));
                reg.setEmail(rs.getString(3));
                
                userList.add(reg);
            }
            // close the connection 
            con.close();
            
            
        }catch(Exception e){
            System.out.println(e);
        }
        
        return userList;
    }
    
}
