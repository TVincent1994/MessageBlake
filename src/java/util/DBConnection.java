
package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    
    public static Connection createConnetion(){
        Connection con = null;
        String url = "jdbc:mysql://instancemtb.cbvlbcyf5pmu.us-west-2.rds.amazonaws.com:3306/messagetheblake"; //mysql url followed by database name
        String username = "messageRoot";      // mysql username
        String password = "messageTheBRoot";   // mysql password
        
        try{
            try{
                Class.forName("com.mysql.jdbc.Driver"); // loading mysql driver
            }catch(ClassNotFoundException e){
                e.printStackTrace();
            }
            
            con = DriverManager.getConnection(url, username, password); // attempts to connect to mysql database
            System.out.println("Printing connection object" + con);
        }catch(Exception e){
           e.printStackTrace();
        }
        return con;    
    }
}
