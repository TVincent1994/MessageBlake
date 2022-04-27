
package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author Taylor Vincent
 */
public class ForgotUserPassword {
    
    public String FindPassword(String email){
        Connection conn;
        
        try{
            conn = DriverManager.getConnection("jdbc:mysql://instancemtb.cxbxcbrf5emw.us-east-2.rds.amazonaws.com:3306/messagetheblake", "messageRoot", "messageTheBRoot");
            PreparedStatement st = conn.prepareStatement("SELECT password FROM register WHERE email=?");
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            
            if(rs.next()){
                return rs.getString("password");
            }
            
        }catch(Exception e){
            e.printStackTrace();
        }
        return "No Password (Email May Not Exist)";
    }
    
}
