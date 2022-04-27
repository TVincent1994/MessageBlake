
package com;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.annotation.WebListener;

/* ServletContextListener: 
     Role -- Monitor the creation and destruction of the servletContext object, since we are going to listen 
     to the servletContext object, we must know when it is created and when it is destroyed (ie the life cycle of servletContext)
     life cycle -- Creating: Web Application When you run successfully on your server, the server creates a servletContext for each web app.
 * HttpSessionAttributeListener: 
     When the user logs in, the user information will be saved in the session domain, and we 
     will save the information in the session domain in the application domain
 * HttpSessionListener: When the user logs out, remove the current user information in the application domain
*/
@WebListener
public class usersOnline implements HttpSessionListener, HttpSessionAttributeListener, ServletContextListener {
   
    private ServletContext application = null;      // Application domain object
    
    @Override
    public void contextInitialized(ServletContextEvent sce){
        // Initialize an application object
        this.application=sce.getServletContext();
        // Set a list property to save the online user
        this.application.setAttribute("onlineUsers", new ArrayList<String>());
        System.out.println("Monitor the creation of Application objects...");
    }
    
     // ServletContext is called when the method is destroyed
    public void contextDestroyed(ServletContextEvent sce) { 
    }

    
    public void sessionCreated(HttpSessionEvent http){   
    }
    
    @Override
    public void sessionDestroyed(HttpSessionEvent event) {   
        List<String> online = (List<String>)this.application.getAttribute("onlineUsers");
        // Gets the current online user list
        String user = (String)event.getSession().getAttribute("usernameSession");
        // Remove this user from the list
        online.remove(user);
        // Re-add the deleted list to DaoApplication
        this.application.setAttribute("onlineUsers", online);
    }

    // User logged in, add a user information to the collection
    @Override
    public void attributeAdded(HttpSessionBindingEvent event){
        //Get the current online user list
        String attributeName = event.getName();
        Object attributeValue = event.getValue();
        List<String> online = (List<String>)this.application.getAttribute("onlineUsers");
        if("username".equals(event.getName())){
            // add the current username to the list
            online.add((String)event.getValue());
        }
        this.application.setAttribute("onlineUsers", online);
        System.out.println("Attribute added : " + attributeName + " : " + attributeValue);     
    }

    // User logged out, reduce one user information to the collection
    @Override
    public void attributeRemoved(HttpSessionBindingEvent event){ 
    }
    
    public void attributeReplaced(HttpSessionBindingEvent event){   
    }
    
}
