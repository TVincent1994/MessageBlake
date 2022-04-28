<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.*" %> 
<%@page import="java.io.*" %>
<%@page import="java.util.*"%>
<%@page import="org.apache.commons.fileupload.DiskFileUpload"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        <link rel="stylesheet" type="text/css" href="css/Blake.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css">
        <script src="JS/uploadedModalImages.js"></script>
        <title>Message The Blake</title>
    </head>
    <body>   
        <!-- If user is not logged in, go back to login page -->
        <!-- Prevent user from seeing page if not logged in -->
        <%
            String user = (String)session.getAttribute("BlakeSession");
            if(user==null){
                response.sendRedirect("Blake_Login.jsp");
            }
        %>
        <div id="Blake_Upload">
            <h2><a href="Blake_Index.jsp">Welcome Blake</a></h2>
            <img src="blackbackground.jpg">
            <div class="uploadContainer">
                <!-- "multipart/form-data" is used to upload files to the server. -->
                <form action="UploadServlet"  class="uploader" method="post" enctype="multipart/form-data">   
                    <table class="uploadTable" align="center">
                        <tr>
                            <td align="center" colspan="2">Upload Image Details</td>
                        </tr>
                        <tr>
                            <td>Name of Photo</td>
                            <td><input type="text" name="filename" autocomplete="off" required></td>
                        </tr>
                        <tr>
                            <td>Upload ThumbNail For Image/Video</td>
                            <td><input type="file" class="fileButton" name="file" required></td>
                        </tr>
                        <tr>
                            <td>Upload Video (Optional)</td>
                            <td><input type="file" class="video" name="videoFile" required></td>
                        </tr>
                        <tr>
                            <td>Submit</td>
                            <td><input type="submit" value="Submit Photo"></td>
                        </tr>
                    </table>
                </form>
            </div>
            
            <sql:setDataSource var="myDB" driver="com.mysql.jdbc.Driver" url="xxxxxxxxxxxx" user="xxxx" password="xxxxxxxx" />
            
            <div class="gallery">
                <table id="photoTable" border="3px">
                    <tr>
                       
                        <sql:query dataSource="${myDB}" var="result" 
                             sql="SELECT * FROM photos ORDER BY img_date DESC, img_time DESC"/>
                        
                        <!-- Create a new row after 8th image -->
                        <c:forEach var="img" items="${result.rows}" varStatus="colCnt">
                            <fmt:formatDate value="${img.img_date}" var="imgDate" type="date" dateStyle="medium"/>
                            <fmt:formatDate value="${img.img_time}" var="imgTime" type="time" timeStyle="short"/>
                            
                            <c:if test="${not colCnt.first and colCnt.index%8==0}">
                                </tr><tr>
                            </c:if>
                                    
                            <td>
                                <img src="uploads/${img.fileName}" onclick="myFunc(this)" class="uploadedImage">                            
                                <div class="photoContent">
                                    ${img.title}<br>
                                </div>
                                <div class="pcDate">
                                    ${imgDate}&nbsp;&nbsp;${imgTime}
                                </div>
                                 
                                <sql:setDataSource var="myDB" driver="com.mysql.jdbc.Driver" url="xxxxxxxxxxxxx" user="xxxxxxxx" password="xxxxxxxxxx" />
            
                                <c:set var="Username" value="<%=user%>"/>
                                <c:set var="alert" value="${img.id}"/>
                                
                                <a href="getDetails?media=${img.id}" class="details" id="img-${img.id}" >Details&nbsp;</a>
            
                                <!-- Get messages -->
                                <sql:query dataSource="${myDB}" var="getAlert">
                                    SELECT COUNT(C_id) AS count FROM comments WHERE C_itemID = ? AND C_alert = 0;
                                    <sql:param value="${alert}" />
                                </sql:query>
                                <c:forEach var="c_Unread" items="${getAlert.rows}">
                                    <c:set var="Alert" value="${c_Unread.count}"/>
                                </c:forEach>
                                
                                <c:choose>
                                    <c:when test="${Alert == 0}">   
                                        <span id="commentAlert" style="padding: 0;"></span> 
                                    </c:when>
                                    <c:otherwise>
                                        <span id="commentAlert">${Alert}</span>
                                    </c:otherwise>
                                </c:choose>
                                        
                            </td>
                        </c:forEach>
                        
                    </tr>
                </table>
            </div>
            
            <div id="Uploaded_Pic_Modal" class="uploaded_pic_modal">
                <span class="close" onclick="uploadedPic.style.display ='none'">&times;</span>
                <img class="modal-imgContent" id="imgContent">
                <div id="imgCaption"></div>
                <!-- Displaying photo content/likes/comments from users -->
            </div>
        
        </div>
                        
        <script src="JS/commentAlert.js"></script>
        <script src="JS/comments.js"></script>               
        <script src="JS/uploadedModalImages.js"></script>
    </body>
</html>
