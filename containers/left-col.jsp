<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="bean.Register"%>
<%@page import="java.util.*"%>

<div id="left-col-container">
    <div class="userChatTitle">
        <p class="userChat_Title" align="center">Users to Chat</p>
    </div>

    <%
        // Displays the users that are available for the Admin (Blake) to chat with
        ArrayList userList = (ArrayList)request.getAttribute("userList");
        // List that listens for online users
        List<String> online = (List<String>)getServletContext().getAttribute("onlineUsers");
      
        for(int userCnt=0; userCnt<userList.size(); userCnt++){
            Register reg = (Register)userList.get(userCnt);
    %>
            <a href="AdminSendMessage?userChatMessages=<%=reg.getUsername()%>">
                <div class="userContactBtn" onclick="getMsgs()" name="<%=reg.getUsername()%>">
                    <p class="userDisplay"><%=reg.getUsername()%></p>
                    <!-- IF USERS WERE TO ADD PROFILE PIC, NOT SURE YET!!!! <img src="accenture-logo.gif" class="user_image" style="float:left; margin-right:5px; width:50px; height:50px;"/> -->
                    <!-- When user link is clicked, show conversation in right column. -->
                        
                    <%
                        String user = reg.getUsername();
                        // if a user is in the online list, display online
                        if(online.contains(user)){
                        %>
                            <!-- Need to align the "online" text to where its placed in one spot. No matter how large the username characters are (moves the online text right) -->                
                            <p class="onlineStatus">Online</p>     
                        <%
                        }
                    %>
                </div>
            </a>
    <%
         }       
    %> 
<!-- end of left-col-column -->
</div> 
