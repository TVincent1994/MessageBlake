
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.text.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
    </head>
    <body>
        <h1>Users Online</h1>
        
        <h3>Online User List</h3><hr>    
        <%
            List<String> online = (List<String>)getServletContext().getAttribute("onlineUsers");
        %>
        <li><%=online.size()%></li>
        <%
            Iterator<String> IT = online.iterator();
            while(IT.hasNext()){
                %>
                <li><%=IT.next()%></li>
                <%
            }
        %>
    </body>
</html>
