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
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1.0"/>
        <link rel="stylesheet" type="text/css" href="css/Style.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css">
        <script src="JS/replies.js"></script> 
        <title>Message The Blake</title>
    </head>
    <body>
        <%
            String username = (String) session.getAttribute("usernameSession");
            if(username == null){
                // Display if user is not logged in... just a heads up for users
                %>
                    <div class="userLogError">
                        <h3>You must be logged in to comment</h3>
                    </div>
                <%
            }
                //String comment = request.getParameter("comment");  
                int id =  Integer.parseInt(request.getParameter("media"));
        %>
        <div id="ImagePage">
            <div class="Image_Content">
                <div class="goBackTxt">
                    <a href="Gallery.jsp"><h2>Go Back To Gallery</h2></a>
                </div>
                
                <c:set var = "content" value ="${image.image}"/>
                <c:set var = "Video" value ="${video}"/>
                
                <!-- Display media -->
                <c:choose>
                    <c:when test="${fn:containsIgnoreCase(Video, '.mov')|| fn:containsIgnoreCase(Video, '.mp4')|| fn:containsIgnoreCase(Video, '.wmv')|| fn:containsIgnoreCase(Video, '.avi')}">
                        <div class="image">
                            <a href="#">
                                <video controls controlsList="nodownload" src="uploads/${Video}" alt="${image.title}" class="viewVideo"></video>
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="image">
                            <a href="#">
                                <img src="uploads/${content}" onclick="viewImage(this)" alt="${image.title}" class="viewImage" />
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
                
                <div class="commentContainer">
                    <fmt:formatDate value="${image.date}" var="imgDate" type="date" dateStyle="medium"/>
                    <div class="uploadViewsContainer">
                        <div class="viewsIcon">
                            <i class="fas fa-eye" id="viewI"></i>
                        </div>
                        <div id="uploadViewsNum">
                            <c:out value="${views}"/>
                        </div>
                        <div class="uploadDate">
                            <c:out value="${imgDate}"/>
                        </div>
                    </div>
                        
                    <div id="captionContainer">
                        <c:out value="${image.title}"/>
                    </div>
                    <div id="comments">
                        
                        <!-- Get The total number of comments that exist -->
                        <h2 style="color: green; margin:5px;"><span id="commentNum">${commentNum}</span> Comments</h2>

                        <!-- Warning Messages  -->
                        <div id="comments_warning1" style="display:none">Don`t forget to fill both fields (Name and Comment)</div>
                        <div id="comments_warning2" style="display:none">You can't post more than one comment per 10 minutes (spam protection)</div>
                    
                        <span style="color:red" id="errorText">${COMMENTERRORS[0]}</span>  <!-- Show error messages if user not logged in and comment field left blank -->
                        <span style="color:red" id="errorText">${COMMENTERRORS[1]}</span>
                        
                        <form class="comments_field" id="commentForm" name="commentForm" method="post" >  <!-- add "action='AddComment'"  -->
                            <table>
                                <tbody>
                                    <tr>
                                        <td class="field">
                                            <textarea name="comment" id="comment" required></textarea>
                                            <input style="display:none" name="user_Name" id="user_Name" value="<%=username%>" required/>
                                            <input style="display:none" type="number" name="imgID" id="imgID" value="<%=id%>" required/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="field">
                                            <input type="button" value="Add Comment" name="new_comment" id="addCommentButton"/>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>
                                        
                        <div id="comments_list">
                            <!-- container for comments -->
                            <jsp:include page="comment.jsp" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Hidden Reply Form -->
        <jsp:include page="replyForm.jsp" />
            
        <!-- Hidden Photo Modal -->
        <div id="Modal" class="modal">
            <span class="close" onclick="modal.style.display ='none'">&times;</span>
            <img class="modal-content" id="img01">    
        </div> 

        <script src="JS/comments.js"></script>
        <script src="JS/Model_Images.js"></script>   <!-- must be put here because the images must come first -->
        
    </body>
</html>
