
package com;

import dao.CommentManager;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class sendComment extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        PrintWriter out = response.getWriter();
        CommentManager commentManager = new CommentManager();
        
        int id = Integer.parseInt(request.getParameter("media"));
        String comment = request.getParameter("sendComm"); 
        String admin = (String)session.getAttribute("BlakeSession");
        
        String commentValidation = commentManager.addComment(admin, comment, id); 
        
        if(commentValidation.equalsIgnoreCase("SUCCESS")){
            System.out.println("Comment inserted by " + admin);
        }else{
            System.out.println("****Comment ERROR****");
        }
    }

    

}
