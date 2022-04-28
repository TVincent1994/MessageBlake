
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


<li>
    <a class="chatBoxButton" href="#">
        <i class="far fa-envelope"></i>
        
            <sql:setDataSource var="myDB" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost/messagetheblake" user="root" password="MessageTheB1994" />
            
            <c:set var="Username" value="${username}"/> 
            
            <!-- Get messages -->
            <sql:query dataSource="${myDB}" var="getMsg">
                SELECT COUNT(message_id) AS count FROM messages WHERE receiver_name= ? AND sender_name='Blake' AND message_status=0;
                <sql:param value="${Username}" />
            </sql:query>
            <c:forEach var="mCnt" items="${getMsg.rows}">
                <c:set var="MsgCnt" value="${mCnt.count}"/>
            </c:forEach>
             
            <c:choose>
                <c:when test="${MsgCnt == 0}">   
                    <span class="notification"></span> 
                </c:when>
                <c:otherwise>
                    <span class="notification">${MsgCnt}</span>
                </c:otherwise>
            </c:choose>
                    
    </a>
</li>

