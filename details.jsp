<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.Base64"%>
<%@page import="java.sql.*" %> 
<%@page import="java.io.*" %>
<%@page import="java.util.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%           
    //To disable browser cache for JSP pages, create a Filter which is mapped on an url-pattern of *.jsp 
    // and does basically the following in the doFilter() method. Setting the headers to not save web pages.
    // Prevents after logging out from our website you could press the back button and view cached pages.
    HttpServletResponse httpResponse = (HttpServletResponse) response;
    httpResponse.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // supports HTTP 1.1
    httpResponse.setHeader("Pragma", "no-cache"); // supports HTTP 1.0
    httpResponse.setDateHeader("Expires", 0); // supports Proxies.
            
 %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width,initial-scale=1.0"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/Blake.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css">
        <script src="JS/replies.js"></script>
        <title>Message The Blake</title>
    </head>
    <body>
        <%
            String user = (String)session.getAttribute("BlakeSession");
            if(user==null){
                response.sendRedirect("Blake_Login.jsp");
            }
            int id =  Integer.parseInt(request.getParameter("media"));
        %>
        
        <div class="detailsTitleCnter">
            <h1 class="detailsTitle">${image.title} - Details</h1>
        </div>
        <div class="goBackGallery">
            <a href="Blake_Upload.jsp">Go Back</a>
        </div>
        
        <!-- Get The total number of comments that exist -->
        <h2 style="color: green; margin:5px; text-align: center;"><span id="commentNum">${commentNum}</span> Comments</h2>
        
        <div class="openCommentWrapper">
            <a id="openSendComment" name="openSendComment">Send Comment</a>
        </div> 
        
        <div id="sendCommentWrapper">
            
            <form action="getDetails" method="post" id="sendCommentForm" name="sendCommentForm" style="display:none">
                <div class="errComment">
                    <span id="sendCommentErr"></span>
                </div>
                <div id="commentTxtField">
                    <textarea id="sendComment" name="sendComment" placeholder="Send Comment..."></textarea>
                    <input style="display:none" name="a_user" id="a_user" value="<%=user%>" required/>
                    <input style="display:none" name="commIngId" id="commIngId" value="<%=id%>" required/>
                    <div id="SendButtonWrapper">
                        <input type="button" id="SendButton" name="SendButton" value="Send" onclick="submitComment()"/>
                    </div>
                </div>
            </form>
        </div>
        
        <div class="commentContainer">
            <!-- container for comments -->
            <jsp:include page="containers/a_comment.jsp" />
        </div>
            
        <!-- Hidden Reply Form -->
        <div class='replyForm' id="replyForm" style="display:none">
            <textarea class='replyText' name='new-reply' id='a_newReply' required='required'></textarea>
            <input style="display:none" name="user_reply" id="a_reply" value="<%=user%>" required/>
            <div id="getComment_Id"></div>
            <div><span id="a_replyErrMsg"></span></div>
            <div class="replyButtons">
                <button class='closeReplyBtn' onclick="$('.replyForm').hide();">CLOSE</button>
                <button class='submitReply' id='sendReply'>SEND</button>   
            </div>
        </div>
         
        <!-- Hidden Delete Comment Window -->  
        <div id="popup-overlay">
            <div id="deleteCommWindow" >
                <div class="deleteTitle">
                    <h2>Are you sure?</h2>
                </div>
                <div class="deleteWindowControls">
                    <button class="deleteCommBtn" name="img-${image.id}" onclick="deleteComment(this)">Delete</button>
                    <button class="closeCommBtn" onclick="closeDeleteWindow()">Close</button>
                </div>
            </div>
        </div>
        
        <script src="JS/comments.js"></script>
    </body>
</html>
