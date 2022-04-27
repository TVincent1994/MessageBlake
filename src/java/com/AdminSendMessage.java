
package com;

import bean.RegisteredUsers;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ConversationDao;
import bean.Message;
import java.util.List;

/**
 *
 * @author Taylor Vincent
 */
public class AdminSendMessage extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String receiver = request.getParameter("userChatMessages");    // the users who receieve the message 
        String sender = "Blake";
        
        request.setAttribute("userList", new RegisteredUsers().getUsers());
        
        ConversationDao convo = new ConversationDao();
        List<Message> li = convo.getAllConversations(sender, receiver);
        
        request.getSession().setAttribute("conversationOfUsers", li); 
        
        response.setContentType("application/json");
        response.setHeader("Cache-control", "no-cache, no-store");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "-1");
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "POST");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");
        response.setHeader("Access-Control-Max-Age", "86400"); 
       
        request.getRequestDispatcher("Blake_Messages.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession sess = request.getSession();
        
        String sender = (String)sess.getAttribute("BlakeSession");
        String receiver = request.getParameter("user");
        String message = request.getParameter("message");
        int status = Integer.parseInt(request.getParameter("status"));
        
        ConversationDao convo = new ConversationDao();
        convo.sendMessage(sender, receiver, message, status);
        
        List<Message> li = convo.getAllConversations(sender, receiver);
        sess.setAttribute("conversationOfUsers", li);
            
        response.setContentType("text/html");
        response.setHeader("Cache-control", "no-cache, no-store");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "-1");
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "POST");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");
        response.setHeader("Access-Control-Max-Age", "86400");        
    }

}
