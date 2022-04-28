<%-- 
    Document   : forgotPwd
    Created on : Jul 5, 2021, 2:40:13 PM
    Author     : Taylor Vincent
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1.0"/>
        <link rel="stylesheet" type="text/css" href="css/Style.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="JS/forgot.js"></script>
        <title>Message The Blake</title>
    </head>
    <body>
        <div class="forgotTitle">
            <h1>Forget Password?</h1>
        </div>
        <br>
        <div class="forgotDesc">
            <h2>Enter your email address and you'll get your password back.</h2>
        </div>
        
        <span id="forgotError"></span>
        
        <form action="Forgot" method="post" name="sendForgottenEmail">
            <input type="text" id="f_email" name="f_email" placeholder="Enter Email"><br>
            <input type="button" id="forgotSubmit" value="Send" onclick="sendEmail();"/>
        </form>
        <br><br>
        <a href="Home.jsp" class="goBackHome">Go Back To Site</a>
    </body>
</html>
