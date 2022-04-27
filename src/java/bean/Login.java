
package bean;

public class Login {
    private String username;
    private String password;
    private int uid;
    
    public int getUid(){
        return uid;
    }
    public void setUid(int uid){
        this.uid = uid;
    }
    public String getUserName(){
        return username;
    }
    public void setUsername(String username){
        this.username = username;
    }
    public String getPassword(){
        return password;
    }
    public void setPassword(String password){
        this.password = password;
    }
}
