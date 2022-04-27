package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import bean.Register;
import util.DBConnection;
/**
 *
 * @author Taylor Vincent
 */
public class RegisterDao {

    public String registerUser(Register rb){
        
        String email = rb.getEmail();
        String username = rb.getUsername();
        String password = rb.getPassword();
        
        Connection con = null;
        PreparedStatement ps = null;
        
        try{
            con = DBConnection.createConnetion();
            String query = "INSERT INTO register(username, password, email) VALUES(?,?,?)";
            ps = con.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3,  email);
            
            int i = ps.executeUpdate();
            
            if(i!=0){
                return "SUCCESS";
            }       
        }catch(SQLException e){
            e.printStackTrace();
        }    
        return "Oops.. Something's wrong..!";
    }
}

