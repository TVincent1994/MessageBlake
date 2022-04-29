
package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;

import util.DBConnection;
import bean.Login;

/**
 *
 * @author Taylor Vincent
 */
public class AdminDao {
    
    public String authentication(Login login){
        
        String username = login.getUserName();
        String password = login.getPassword();
        
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet resultset = null;
        
        String usernameDB = "";
        String passwordDB = "";
        
        try{
            con = DBConnection.createConnetion(); // establish connection
            ps = con.prepareStatement("SELECT * FROM xxxxxxx WHERE admin_username=? AND admin_pass=?");
            ps.setString(1, username);
            ps.setString(2, password);
            resultset = ps.executeQuery();
        
            while(resultset.next()){   
                //fetch the values present in database
                usernameDB = resultset.getString("admin_username");
                passwordDB = resultset.getString("admin_pass");
                
                if(username.equals(usernameDB) && password.equals(passwordDB)){
                    // Blake logins successful
                    return "SUCCESS";
                }else{
                    // If the entered fields don't match, credentials like username doesn't exist in database
                    return "FAILED";
                }
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return "Invalid Credentials";
    }
    
}
