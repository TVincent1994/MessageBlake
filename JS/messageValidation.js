
var request; 

// submit a comment
function submitMessage(){ 
    var msg = document.forms["message"]["usermsg"].value; 
    // send this msg to url. the parameter name "messageText" is that same as the servlets getParameter name 
    // and will send both whater submit/send button is clicked
    var url = "http://localhost:8080/MessageTheBlake/UserSendMessage?messageText="+msg;   
         
    if(msg === "" || msg === "null" || msg === null){
        document.getElementById("messageError").innerHTML = "Can't send an empty message!";  // display error message
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
                var messageForm = document.getElementsByName("message")[0];
                messageForm.reset();
                // sends message and displays within container
                var val = request.responseText;  
                document.getElementById('userMessageContainer').innerHTML = val;  
            }
        };//end of function  
            request.open("POST",url,true);  // maybe thats why its returning the elements
            request.send();  
        }catch(e){
            alert("Unable to connect to server");
        }  
    }
}
