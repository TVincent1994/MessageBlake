

var request; 

// submit a comment
function sendEmail(){ 
    var email = document.forms["sendForgottenEmail"]["f_email"].value; 
    // send this msg to url. the parameter name "messageText" is that same as the servlets getParameter name 
    // and will send both whater submit/send button is clicked
    var url = "http://localhost:8080/MessageTheBlake/Forgot?sentEmail="+email;   
         
    if(email === "" || email === "null" || email === null){
        document.getElementById("forgotError").innerHTML = "Can't send an empty email...";  // display error message
        return false;
    }else{
        if(window.XMLHttpRequest){            // for IE7+, Firefox, Chrome, Opera, Safari
            request = new XMLHttpRequest();    
        }else if(window.ActiveXObject){           // for IE6, IE5
            request = new ActiveXObject("Microsoft.XMLHTTP");  
        }try{  
            request.onreadystatechange = function(){  
            if(request.readyState===4){  
                // clears the previous text field value after submitting the form without refreshing the entire page
                var messageForm = document.getElementsByName("sendForgottenEmail")[0];
                messageForm.reset();
                // display sucessful mail sent message
                document.getElementById("forgotError").style.color="green";
                document.getElementById("forgotError").innerHTML = "Password Successfully sent!"; 
                document.getElementById("f_email").style.display = "none";
                document.getElementById("forgotSubmit").style.display = "none";
                return true;
            }
        };//end of function  
            request.open("POST",url,true);  // maybe thats why its returning the elements
            request.send();  
        }catch(e){
            alert("Unable to connect to server");
        }  
    }
}