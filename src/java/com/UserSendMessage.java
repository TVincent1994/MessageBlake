
package com;

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
public class UserSendMessage extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8"); 
        response.setCharacterEncoding("utf-8"); 
        response.setContentType("text/html;charset=UTF-8");
        
        String user = request.getParameter("user");
        
        ConversationDao convo = new ConversationDao();
        List<Message> li = convo.getAllConversations(user, "Blake");
        
        request.getSession().setAttribute("conversationOfUsers", li); 
        
        response.setContentType("application/json");
        response.setHeader("Cache-control", "no-cache, no-store");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "-1");
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "POST");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");
        response.setHeader("Access-Control-Max-Age", "86400"); 
        request.getRequestDispatcher("containers/chatbox.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String user = (String)session.getAttribute("usernameSession");
        // String receiver = (String)session.getAttribute("BlakeSession");   <-- some reason this has to be logged in for send message to work? 
        String message = request.getParameter("messageText");
        
        ConversationDao convo = new ConversationDao();
        convo.sendMessage(user, "Blake", message, 0);   // set status to 0 (zero) because its unread to admin
        
        List<Message> li = convo.getAllConversations(user, "Blake");
        
        session.setAttribute("conversationOfUsers", li);
        
        response.setContentType("text/html");
        response.setHeader("Cache-control", "no-cache, no-store");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "-1");
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "POST");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");
        response.setHeader("Access-Control-Max-Age", "86400");
        request.getRequestDispatcher("containers/chatbox.jsp").forward(request, response);
    }
}