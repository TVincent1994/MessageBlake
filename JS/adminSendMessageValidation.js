
var xmlhttp;

$(document).ready(function(){
   
    // send to user
    $("#submitAdminMsg").click(function(event){
        // get message and user to send to 
        var text = $("#adminTxtAreaId").val();
        var user = $("#receiver_Name").val();
        var status = 0;
        
        if(text.trim() === "" || text.trim() === null || text.trim() === "null"){      
            event.preventDefault(); // the default action that belongs to the event will not occur
            $(".adminSendMessageErr").text("Cant send empty message to user..."); 
        // If admin sends message to no user when in messages page, trigger this if/esle statement    
        }else if(user===null || user==="null" || user===""){
            event.preventDefault(); // the default action that belongs to the event will not occur
            $(".adminSendMessageErr").text("You must choose a user to send message..."); 
            return false;
        }else{
            $.ajax({
                type: "POST",
                url: "AdminSendMessage",
                data:{
                    message: text,
                    user: user,
                    status: status
                },
                success: function(data){
                    
                    // clears the previous text field value after submitting the form without refreshing the entire page
                    var msgForm = document.getElementsByName("adminMsgForm")[0];
                    msgForm.reset();
                    
                    // Load data from the server and place the returned HTML into the matched elements
                    $("#adminMessageContainer").load("containers/right-col.jsp"); 
                    
                }
            });
        }   
    });

});

// every 5 seconds refresh div to get message
function getMsgs(){
    var url = window.location.href;
    xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange=function(){
        if (xmlhttp.readyState===4 && (xmlhttp.status===200||xmlhttp.status===500)) {
            $("#adminMessageContainer").load("containers/right-col.jsp"); 
        }
    };
    xmlhttp.open("GET", url, true);
    xmlhttp.send();
}

setInterval(getMsgs, 5000);
