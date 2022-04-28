
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="bean.Register"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

    <div id="adminMessageContainer">
        <c:forEach items="${sessionScope.conversationOfUsers}" var="msg">
            <fmt:formatDate value="${msg.date}" var="Date" type="date" dateStyle="medium"/>
            <fmt:formatDate value="${msg.time}" var="Time" type="time" timeStyle="short"/>
            
            <div class="users-message">
                <div class="message-content">
                    <a class="msgName" href="#">${msg.sender}</a>
                    <p class="msgTxt">${msg.message}</p>
                    <p class="msgTime">${Time}</p>
                    <p class="msgDate">${Date}</p>
                </div>
            </div>	
        </c:forEach>
        
    <!-- end of messages container -->
    </div>
    
<!-- end of right-col-container -->   
