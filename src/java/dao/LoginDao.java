
package dao;

import bean.Login;
import util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class LoginDao {
    
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
            ps = con.prepareStatement("SELECT * FROM register WHERE username=? AND password=?");
            ps.setString(1, username);
            ps.setString(2, password);
            resultset = ps.executeQuery();
        
            while(resultset.next()){   
                //fetch the values present in database
                usernameDB = resultset.getString("username");
                passwordDB = resultset.getString("password");
                
                if(username.equals(usernameDB) && password.equals(passwordDB)){
                    //If the user entered values and are already present in database, which means user has already registered, return "SUCCESS" message.
                    return "SUCCESS";
                }else{
                    // If the entered fields don't match, credentials like username doesn't exist in database
                    return "failed";
                }
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return "Invalid user credentials";
    }
    
}
