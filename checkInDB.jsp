<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.*,java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try{
        String userExist = request.getParameter("userInList").toString();
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost/messagetheblake", "root", "MessageTheB1994");
        Statement st=con.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM register WHERE username='" + userExist + "'");
        if(rs.next()){
%>     
            <!-- If user exist, show green text -->
            <b><font style="color: green">User Exists</font></b>
        <%}else{%>
            <!-- If user doesn't exist, show red text -->
            <b><font style="color: red">User Doesn't Exists</font></b>  
            
        <%}%>
        <%              
        rs.close();
        st.close();
        con.close();
        %>
    <%    
    }catch (Exception e){
        System.out.println(e);  
    }%>