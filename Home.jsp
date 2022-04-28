<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.*" %> 
<%@page import="java.io.*" %>
<%           
    //To disable browser cache for JSP pages, create a Filter which is mapped on an url-pattern of *.jsp 
    // and does basically the following in the doFilter() method. Setting the headers to not save web pages.
    // Prevents after logging out from our website you could press the back button and view cached pages.
    HttpServletResponse httpResponse = (HttpServletResponse) response;
    httpResponse.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // supports HTTP 1.1
    httpResponse.setHeader("Pragma", "no-cache"); // supports HTTP 1.0
    httpResponse.setDateHeader("Expires", 0); // supports Proxies.   
    
    String username = (String) session.getAttribute("usernameSession"); // session name when user creates account
 %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1.0"/>
        <link rel="stylesheet" type="text/css" href="css/Style.css">
        <link rel="stylesheet" type="text/css" href="css/all.min.css">
        <link rel="stylesheet" type="text/css" href="css/fontawesome.min.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css">
        <title>Message The Blake</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="JS/open_close_forms.js"></script>
        <script src="JS/signUpValidation.js"></script> 
        <script src="JS/loginValidation.js"></script>
        <script src="JS/emailExistCheck.js"></script>
        <script src="JS/userExistCheck.js"></script>
        <script src="JS/open_messages.js"></script>
        <script src="JS/messageValidation.js"></script>
    </head>
    <body>        
        <div id="SIGNUPOVERLAY" class="overlay">
            <span class="closebtn" onclick="closeSignUpForm()">&#215</span>
            <div class ="wrap">
                <h2>Sign Up Here</h2>
                <form name="signUpForm" method="post" action="RegistrationServlet" onsubmit="return signupvalidate()">
                    <span id="emailExistError"></span>
                    <input type="text" name="emailInput" placeholder="Enter Email" id="EMAIL_ID" onkeyup="checkExist()" required="required"/>  <!--While user is typing, "onkeyup" automatically updates text to the user instantly -->
                    <input type="tel" name="phoneInput" placeholder="Enter Phone Number" pattern="[0-9]{3}-[0-9]{3}-[0-9]{4}" required="required"/>
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
                    <span id="userExistError"></span>
                    <input type="text" name="usernameInput" placeholder="Enter Username" id="username_ID" onClick="checkUserExist()"/>
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
                    // used for displaying username if logged in
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
        
        <div id="sectionsID">
         
            <section class="sec0"> 
                <!-- Home Page Image -->    
                <div class="selfie">
                    <img src="selfie.JPG" class="self">
                </div> 
            </section>
            
            <section class="sec1"> 
                <img src="blackbackground.jpg" class="bg"> 
            </section>
            
            <section class="sec2">
                <h2>Welcome To <u>Message The Blake</u></h2>
                <p>Welcome to the journey of my captured experiences that I'm grateful and open to share to the world. 
                    The goal is to share what I hope most don't get to see but at the same time finding creative ways of taking a snap or video 
                    that would make the media unique in its own way. Hopefully worth your time to scan through each one. Some are interesting, beautiful, funny and 
                    some are just experimenting. MessageTheBlake is a photo/video gallery that users are welcomed to comment with the access of signing up 
                    an account or just skimming through with no need to create one. 
                    Users must be logged in to message me privately and I'll respond to messages whenever I have the time. 
                    Thank you for taking the time to visit and hope you'll come back to check up upcoming uploads every Sunday. 
                    God bless.</p>
            </section>   
            
            <div id="sendMessageWrapper">
            <form id="sendMessageForm" method="post" class="bottomCommentSection">
                <table border="0" width="35%" align="center" id="sendMsgTo">
                    <caption><h2 style="color:green; margin: 5px;">Send A Message</h2></caption>
                    <tr>
                        <td>
                            <div class="sendMessageError"></div>
                            <div id="messageID">
                                <textarea class="message" id="message_id" placeholder="Message me here..." ></textarea>
                                <input style="display:none" name="user_Name" id="user_Name" value="<%=username%>" required/>
                            </div>
                        </td>    
                    </tr>
                    <tr>
                        <td colspan="4" align="center">
                            <div id="SendButtonID">
                                <button id="SendButton">Send</button>
                            </div>
                        </td>
                    </tr>
                </table>
            </form>
            </div>
             
            <!-- Confirmation message is first hidden until user submits message to trigger message to be revealed -->
            <div id="replaceSumbitForm" style="display:none;">
                <div class="backgroundSentSuccess">
                    <p class="sentSuccessTxt">Thank you for submitting your message! Check the message inbox for conversation :)</p>    
                </div>
            </div>
                            
        </div>         
        <script src="JS/navigation.js"></script>
        <script src="JS/sendMessage.js"></script>
    </body>
</html>
