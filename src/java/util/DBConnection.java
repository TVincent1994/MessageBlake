
package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    
    public static Connection createConnetion(){
        Connection con = null;
        String url = "x,x,x,x"; //mysql url followed by database name
        String username = "xxxxxxx";      // mysql username
        String password = "xxxxxxxx";   // mysql password
        
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
