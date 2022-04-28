<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.*,java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try{
        String email=request.getParameter("emailInput");
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost/messagetheblake", "root", "MessageTheB1994");
        Statement st=con.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM register WHERE email='" + email + "'");
        if(rs.next()){
%>     
            <!-- If email exists, show red text -->
            <font color=red>Email already exists<input type="hidden" id="emailAlert" name="actual" value="taken"></font>
        <%}else{%>
            <!-- If email doesn't exist, show green text -->
            <font color=green><input type="hidden" id="emailAlert" name="actual" value="available">Email available</font>      
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

