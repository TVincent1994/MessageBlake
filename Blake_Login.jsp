<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.*" %> 
<%@page import="java.io.*" %>
<%           
    //To disable browser cache for JSP pages, create a Filter which is mapped on an url-pattern of *.jsp 
    // and does basically the following in the doFilter() method. Setting the headers to not save web pages.
    // Prevents after logging out from our website you could press the back button and view cached pages.
    HttpServletResponse httpResponse = (HttpServletResponse) response;
    httpResponse.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // supports HTTP 1.1
    httpResponse.setHeader("Pragma", "no-cache"); // supports HTTP 1.0
    httpResponse.setDateHeader("Expires", 0); // supports Proxies.            
 %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1.0"/>
        <link rel="stylesheet" type="text/css" href="css/Blake.css">      
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css">
        <title>Message The Blake</title>
    </head>
    <body> 
        <!-- If logged in, stay logged in until you end session (log off) -->
        <%
            String user = (String)session.getAttribute("BlakeSession");
            if(user!=null){
                response.sendRedirect("Blake_Index.jsp");
            }
        %>
        <div id="BlakeLogin">
            <h2>Blake Sign In</h2>
            <img src="blackbackground.jpg">
            
            <div class="ErrMessage"></div>
            
            <form class="BlakeContainer" method="post" action="AdminServlet">
                <input type="text" name="BlakeUsername" placeholder="Enter Username" id="BlakeUsername_ID"/>
                <input type="password" name="BlakePassword" placeholder="Enter Password" id="BlakePassword_ID"/>
                <input type="submit" name="BlakeLogin" value="BlakeLogin"/>    
            </form>
        </div>
    </body>
</html>