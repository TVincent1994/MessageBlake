
package bean;

public class searchConversation {
    private String username;
    
    public String getUsername(){
        return username;
    }
    public void setUsername(String user){
        this.username = user;
    }
    public searchConversation(String user){
        super();
        this.username = user;
    }
}
