<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.*" %> 
<%@page import="java.io.*" %>


<%
    String username = (String) session.getAttribute("usernameSession"); // session name when user creates account
%>

<div id="MESSAGESOVERLAY" class="overlay" >
    <span class="closebtn" onclick="closeMessagesForm()">&#215</span>
    <div id="messagesWrapper">
        <h2>Your Conversation</h2>
        <div id="chatbox">
            <!-- container for chatbox -->
            <jsp:include page="chatbox.jsp" />
        </div>
        <span id="messageError"></span>
        <form name="message" id="messageForm" class="messageForm" action="UserSendMessage" method="post">  
            <textarea name="usermsg" class="usermsg" id="usermsg" placeholder="Message me here..." ></textarea>
            <input style="display:none" name="hiddenUser" id="hiddenUser" value="<%=username%>" required/>
            <input type="button" id="submitmsg" value="Send" onclick="submitMessage()"/>
        </form>
    </div>
</div>