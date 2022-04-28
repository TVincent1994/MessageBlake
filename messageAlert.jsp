<%@page import="java.util.LinkedList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.*" %> 
<%@page import="java.io.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>

<%
    String alert = request.getParameter("alert");  // get the status of comment
    String imgID = request.getParameter("img");  // get image id for comments
    
    if(alert.equals("1")){  // if messages equal 1, then messages are updated as read
        Connection con;
        try{
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(x,x,x,x);
            Statement st = con.createStatement();
            // update the alert status so the user has read them. (1 = read, 0 = unread)
            String sql = "UPDATE comments SET C_alert='"+alert+"' WHERE C_itemID='"+imgID+"'";
            st.executeUpdate(sql);
            st.close();
            con.close();
        }catch(Exception e){
            e.printStackTrace();
        }
    }else{
        // else comment alert is 0, meaning keep returning the number notifying user they have unread comments still
        Connection con;
        ResultSet rs;
        try{
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(x,x,x,x);
            Statement st = con.createStatement();
            // update the alert status so the user has read them. (1 = read, 0 = unread)
            String sql = "SELECT COUNT(*) FROM comments WHERE C_alert = 0 AND C_itemID='"+imgID+"'";
            rs = st.executeQuery(sql);
            System.out.println(sql);
            if(rs.next()){
                // outputs 0 
                System.out.println(rs.getString("COUNT(*)"));
                %>
                    <%=rs.getString("COUNT(*)")%>
                <%
            }else{
                out.println("");
            }
            rs.close();
            st.close();
            con.close();
        }catch(Exception e){
            e.printStackTrace();
        }
    }
%>


