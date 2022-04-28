<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.*" %> 
<%@page import="java.io.*" %>

<%
    try{
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("xxxxxxxxx", "xxxxxxxx", "xxxxxxxxxxx");
        PreparedStatement ps = con.prepareStatement("Select * FROM photos ORDER BY img_date DESC, img_time DESC");
        ResultSet rs = ps.executeQuery();

        while(rs.next()){  
            String file = rs.getString("fileName");   // thumbNail
            %>
                <figure class="gallery_item">
                    <a href="getImageServlet?media=<%=rs.getInt(1)%>" class="gallery_img_B">
                        <img class="gallery_img" id="gallery_Image" src="uploads/<%=file%>">
                    </a>
                </figure>
            <%
        }
            con.close();
            rs.close();
    }catch(Exception e){
        System.out.println(e);
    }
%>
