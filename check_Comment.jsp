<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.*,java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<title>AJAX REQUEST IN JSP</title>
	<script type="text/javascript">
		function loadAjax(){
			var username= document.getElementById("username").value;
			var email= document.getElementById("email").value;
			var tel= document.getElementById("tel").value;
			var division= document.getElementById("division").value;
			
			
			var url="ajax.jsp?usernameE="+username +"&emailE="+email+"&division="+division+"&tel="+tel;

			if(window.XMLHttpRequest){
				
				request = new XMLHttpRequest();
				
			}else if(window.ActiveXObject){
				
				request = new ActiveXObject("Microsoft.XMLHTTP");
			}
			
			try{
				request.onreadystatechange=sendInfo;
				request.open("POST",url,true);
				request.send();
				
			}catch(e){
				alert("Unable to connect server");
			}
			
		}

		function sendInfo(){
			var p = document.getElementById("print");   // sends data to "print" div

			if(request.readyState ===1){
				var text = request.responseText;
				p.innerHTML="Please Wait.....";
				console.log("1");
			}

			if(request.readyState ===2){
				var text = request.responseText;
				console.log("2");
				
			}
			if(request.readyState ===3){
				var text = request.responseText;
				console.log("3");
				
			}
			if(request.readyState ===4){
				var text = request.responseText;			
				p.innerHTML=" Request Processed  "+text;
			}
		}
	</script>
</head>
<body>
	<h1>AJAX REQUEST IN JSP</h1>
	<form>
		<p><label>YOUR NAME</label>
		<input type="text" name="usernameE" id="username" required="required"></p>
		<p><label>YOUR EMAIL</label>
		<input type="email" name="emailE" id="email" required="required"></p>
		<p><label>YOUR PHONE</label>
		<input type="tel" name="tel" id="tel" required="required"></p>
		<p><label>YOUR DIVISION</label>
		<select name="division" required="required" id="division">
		<option value="">Select</option>
		<option value="East">East</option>
		<option value="West">West</option>
		<option value="North">North</option>
		<option value="South">South</option>
		</select></p>
		<button type="button" onclick="loadAjax()">REGISTER</button>
	</form>
	<p id="print"></p>
</body>
</html>








