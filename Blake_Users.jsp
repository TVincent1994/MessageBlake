<%@page import="bean.Register"%>
<%@page import="java.util.ArrayList"%>
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
        <!-- If user is not logged in, go back to login page -->
        <%
            ArrayList userList = (ArrayList)request.getAttribute("userList");
            
            String user = (String)session.getAttribute("BlakeSession");
            if(user==null){
                response.sendRedirect("Blake_Login.jsp");
            }
        %>
        <div id="BlakeUsers">
            <h2><a href="Blake_Index.jsp">Welcome Blake</a></h2>
            <img src="blackbackground.jpg">
            <div id="ListRegistered_Index">
                <div id="numOfRegisterdUsers">
                    <p><%=userList.size()%> Registered Users</p>
                </div>
                <table class="table_setup">
                    <thead>
                        <!-- Header names -->
                        <tr>
                            <th>Username</th>
                            <th>Email</th>
                        </tr>
                    </thead>
                <!-- List of registered usernames with emails -->    
                <% for(int recordCnt=0; recordCnt < userList.size(); recordCnt++){ %>
                    <tr>
                        <% Register reg = (Register)userList.get(recordCnt);%>
                        <td>
                            <small class="display_users">
                                <%= reg.getUsername()%>
                            </small>
                        </td>
                        <td>
                            <small class="display_userEmail">
                                <%= reg.getEmail()%>
                            </small>
                        </td>
                    </tr>
                    <%} %>
                </table>
                <!-- List the names of users and delete option -->
            </div>
        </div>
    </body>
</html>
