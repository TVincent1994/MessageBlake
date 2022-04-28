
var username = $("#hiddenUser").val();   // global varable within the script to get username from message modal

$(document).ready(function(){   
    
    var user = $("#user_Name").val();   
    // when user clicks "send" btn on bottom page of "Home" page without interruptions, send data to database
    $("#SendButton").click(function(event){
        var message = $("#message_id").val();   
        // if user isn't logged in, display error
        if(user.trim()==="" || user==="null" || user===null){
            event.preventDefault();           // the default action that belongs to the event will not occur
            $(".sendMessageError").text("You must be logged in to comment!"); 
        // if user leaves message empty, display error
        }else if(message.trim() === "" || message.trim() === null){
            event.preventDefault();
            $(".sendMessageError").text("Can't send an empty message!"); 
        }else{
            $.ajax({
                type: "POST",
                data:{
                    messageText: $("#message_id").val()
                },
                url: "UserSendMessage",
                success: function(data){
                    // eventually want the "message sent" message to go away after a couple seconds 
                    $("#sendMessageWrapper").hide();    // Hide the form and replace it with "message sent" successful message for 10 seconds
                    $("#replaceSumbitForm").show();
                },
                error: function(){
                    alert("Error");
                }
            });
            return false;
        }
    });
    
    // when the user clicks on the email icon "(messages)" inbox, get and display the messages to the jsp chatbox page from server
    $(".chatBoxButton").click(function(){
        $.ajax({
           type: "GET",
           url: "UserSendMessage",
           data: {
               user : user
           },
           success: function(data){
               // Load data from the server and place the returned HTML into the matched elements
               $("#chatbox").load("containers/chatbox.jsp");
           }
        });
    });  
});

// after user submits the message from the "Home" page, replace the form with the Message confirmation 
function replaceForm(){
    document.getElementById("sendMessageWrapper").innerHTML = document.getElementById("replaceSumbitForm").innerHTML;
}

// every 5 seconds refresh div to get message
function getMsg(){
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange=function(){
        if (xmlhttp.readyState===4 && (xmlhttp.status===200||xmlhttp.status===500)) {
            var msg = xmlhttp.responseText;
            document.getElementById("chatbox").innerHTML = msg;
        }
    };
    xmlhttp.open("GET", "UserSendMessage?user="+username, true);
    xmlhttp.send();
}

setInterval(getMsg, 3000);


