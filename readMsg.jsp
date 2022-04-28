<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.*,java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String username = (String) session.getAttribute("usernameSession");
    String status = request.getParameter("status");
    
    if(status.equals("1")){     // if messages equal 1, then messages are updated as read
        Connection con;
        try{
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(x,x,x,x);
            Statement st = con.createStatement();
            // update the message status so the user has read them. (1 = read, 0 = unread)
            String sql = "UPDATE messages SET message_status='"+status+"' WHERE sender_name='Blake' AND receiver_name='"+username+"' OR receiver_name='Blake' AND sender_name='"+username+"'";
            st.executeUpdate(sql);
            st.close();
            con.close();
        }catch (Exception e){
            e.printStackTrace();
        }
    }else{ 
        // else messages are 0, meaning keep returning the number notifying user they have unread messages still
        try{
            Connection con;
            ResultSet rs;
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(x,x,x,x);
            Statement st = con.createStatement();
            // update the message status so the user has read them. (1 = read, 0 = unread)
            rs = st.executeQuery("SELECT COUNT(*) FROM messages WHERE receiver_name='"+username+"' AND sender_name='Blake' AND message_status=0");
            if(rs.next()){
                // display the total number of unread messages 
                %>
                    <%=rs.getString("COUNT(*)")%>
                <%
            }else{
                out.println("");
            }
            rs.close();
            st.close();
            con.close();
        }catch (Exception e){
            System.out.println(e);  
        }
    }
%>
