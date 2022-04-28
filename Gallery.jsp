<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.*" %> 
<%@page import="java.io.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%> 
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
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1.0"/>
        <link rel="stylesheet" type="text/css" href="css/Style.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css">
        <title>Message The Blake</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="JS/open_close_forms.js"></script>    
        <script src="JS/signUpValidation.js"></script> 
        <script src="JS/loginValidation.js"></script>
        <script src="JS/emailExistCheck.js"></script>
        <script src="JS/open_messages.js"></script>
        <script src="JS/replies.js"></script>
        <script src="JS/messageValidation.js"></script>
    </head>
      <style type="text/css">
        #video{
            object-fit: fill;
        }

    </style>
    <body>
        <div id="SIGNUPOVERLAY" class="overlay">
            <span class="closebtn" onclick="closeSignUpForm()">&#215</span>
            <div class ="wrap">
                <h2>Sign Up Here</h2>
                <form name="signUpForm" method="post" action="RegistrationServlet" onsubmit="return signupvalidate()">
                    <span id="emailExistError"></span>
                    <input type="text" name="emailInput" placeholder="Enter Email" id="EMAIL_ID" onkeyup="checkExist()"/>  <!--While user is typing, "onkeyup" automatically updates text to the user instantly -->
                    <input type="text" name="usernameInput" placeholder="Enter Username"/>
                    <input type="password" name="passwordInput" placeholder="Enter Password"/>
                    <input type="password" name="repasswordInput" placeholder="Re-Enter Password"/>
                    <input type="submit" name="SignUp" value="Sign Up"/>
                </form>
            </div>
        </div>
        <div id="LOGINOVERLAY" class="overlay">
            <span class="closebtn" onclick="closeLoginForm()">&#215</span>
            <div class ="wrap">
                <h2>Login</h2>
                <form name="loginForm" method="post" action="LoginServlet" onsubmit="return loginvalidate()">
                    <input type="text" name="usernameInput" placeholder="Enter Username" id="username_ID"/>
                    <input type="password" name="passwordInput" placeholder="Enter Password" id="password_ID"/>
                    <a href="forgotPwd.jsp" class="forgotPwdBtn">Forgot Password</a>
                    <input type="submit" name="login" value="Login"/>    
                </form>
            </div>
        </div>
        <header>
            <!-- Click logo to navigate back to Home -->
            <a href="Home.jsp" class="active">
                <img src="logoMTB.png" class="logo">
            </a>
            
            <%
                    String username = (String) session.getAttribute("usernameSession"); // session name when user creates account  
                    if(username != null){
            %>
                <div class="welcomeUser">
                    <h1>Welcome, <span id="headerUsername"><%=username%></span></h1>
                </div>
            <%}%>
        </header>
        
        <!-- Implementation of Navigation Bar -->
        <jsp:include page="containers/navigation.jsp" />
            
        <!-- Container that implements the Message Modal -->
        <jsp:include page="containers/messageModal.jsp" />
                
        <!-- Container Photo Gallery -->
        <div class="gallery-Container" id="gallery-Container">  
            
            <!-- Container that implements the Message Modal -->
            <jsp:include page="containers/gallery.jsp" />
        
        </div>
      
    </body>
    <script src="JS/navigation.js"></script>
    <script src="JS/comments.js"></script>
    <script src="JS/Model_Images.js"></script>   <!-- must be put here because the images must come first -->
    <script src="JS/sendMessage.js"></script>
</html>

