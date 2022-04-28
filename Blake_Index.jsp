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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <title>Message The Blake</title>
    </head>
    <body>   
        <!-- If user is not logged in, go back to login page -->
        <!-- Prevent user from seeing page if not logged in -->
        <%
            String user = (String)session.getAttribute("BlakeSession");
            if(user==null){
                response.sendRedirect("Blake_Login.jsp");
            }
        %>
        <div id="BlakeLogin">
            <h2>Welcome Blake</h2>
            <img src="blackbackground.jpg">
            <div class="List_Index">
                <nav>
                    <a href="AdminLogoutServlet">Log Out</a>
                    <a href="/MessageTheBlake/ListUsersServlet">Users</a>
                    <a href="/MessageTheBlake/AdminSendMessage">Messages</a>
                    <a href="/MessageTheBlake/UploadServlet">Upload</a>
                </nav>
            </div>
        </div>
    </body>
</html>