<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.*,java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String user = request.getParameter("usernameInput");

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(x,x,x,x);
    Statement st=con.createStatement();
    ResultSet rs = st.executeQuery("SELECT * FROM register WHERE username='" + user + "'");  
    if(rs.next()){    
        out.print("");
    }else {
        out.println("<font color = red>");
        out.println("Username Doesn't Exist");
        out.println("</font>");
    }

rs.close();
st.close();
con.close();

%>
