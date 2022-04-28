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

<sql:setDataSource var="myDB" driver="com.mysql.jdbc.Driver" url="xxxxxxxxxx" user="xxxxxxxxx" password="xxxxxxxx" />

<div id="location">                                
    <c:forEach items="${commentList}" var="comment">
        <fmt:formatDate value="${comment.date}" var="Date" type="date" dateStyle="medium"/>
        <fmt:formatDate value="${comment.time}" var="Time" type="time" timeStyle="short"/>
                                                                       
        <div class="comment_box">
            <div class="comment-content">
                                            
                <c:set var="commentID" value="${comment.id}"/> 
                                            
                <p class="comment-User">${comment.username}</p>
                <p>${comment.comment}</p>
                <p class="comment-Date">${Date}&nbsp;&nbsp;&nbsp;${Time}</p>
            
                <!-- Click to reveal the list of replies -->
                <a href="javascript:void(0)" class="replyBtn" id="replyID" name="${commentID}" value="${commentID}" onclick="reply(this)">REPLY</a>
                 
                <!-- Replies -->
                <sql:query dataSource="${myDB}" var="replies">
                    SELECT * FROM replies WHERE R_ItemID = ? ORDER BY R_date DESC, R_time DESC
                    <sql:param value="${commentID}" />
                </sql:query>

                <!-- Test if comment has/no replies -->
                <c:choose>
                    <c:when test="${not empty replies.rows}">
                        <!-- Get Count of Replies -->
                        <sql:query dataSource="${myDB}" var="replyCnt">
                            SELECT COUNT(R_id) AS count FROM replies WHERE R_ItemID = ?;
                        <sql:param value="${commentID}" />
                        </sql:query>
                        <c:forEach var="rCnt" items="${replyCnt.rows}">
                            <c:set var="ReplyNum" value="${rCnt.count}"/>
                        </c:forEach> 
                         
                        <!-- This a tag is the number of the replies hidden but when clicked drops down the replies -->
                        <div id="repliesNumTag">
                            <a class="link-reply" id="repliesBtnID" name="${commentID}"><span id="tog_text">Replies</span>(<span id="replyNum${commentID}">${ReplyNum}</span>)</a>    
                        </div>
                            
                        <!-- Reveal the list of replies -->
                        <div class="replies" id="C-${commentID}">
                                                    
                            <c:forEach var="row" items="${replies.rows}">                                                             
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
                    
                        </div>
                                                    
                    </c:when>
                    <c:otherwise>
                        
                        <!-- Add if no replies exists to comment -->
                        <div id="repliesNumTag${commentID}"></div>
                        <div id="C-${commentID}"></div>
                        
                    </c:otherwise>
                </c:choose>
                
            </div>
        </div>   
    </c:forEach>
    
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
    function reply(caller){
        commentID = $(caller).attr('name');        // get the comment id number when "REPLY" button clicked
        $(".replyForm").insertAfter($(caller));
        $(".replyForm").show();
        // add hidden element to form with comment id so when submitting reply, the coment id is sent too
        $("#getComment_Id").html("<input style=\"display:none\" id=\"comment_ID\" value="+commentID+">");
    }
</script>
