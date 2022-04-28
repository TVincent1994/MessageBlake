<%@page import="dao.ReplyList"%>
<%@page import="dao.ReplyManager"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.Base64"%>
<%@page import="java.sql.*" %> 
<%@page import="java.io.*" %>
<%@page import="java.util.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>

<%
    // get comment id to submit and display the first reply to a comment with no relies.
    int commentID = Integer.parseInt(request.getParameter("commentID"));
%>

<sql:setDataSource var="myDB" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost/messagetheblake" user="root" password="MessageTheB1994" />

<sql:query dataSource="${myDB}" var="reply">
    SELECT * FROM replies WHERE R_ItemID = ? ORDER BY R_date DESC, R_time DESC
    <sql:param value="<%=commentID%>" />
</sql:query>

<c:forEach var="row" items="${reply.rows}">                                                             
    <fmt:formatDate value="${row.R_date}" var="RDate" type="date" dateStyle="medium"/>
    <fmt:formatDate value="${row.R_time}" var="RTime" type="time" timeStyle="short"/>
                                                        
    <div class="reply_box">
        <div class="reply-content">
            <p><c:out value="${row.username}"/></p>
            <p><c:out value="${row.R_text}"/></p>
            <p>${RDate}&nbsp;&nbsp;&nbsp;${RTime}</p>
        </div>
    </div>
</c:forEach>

