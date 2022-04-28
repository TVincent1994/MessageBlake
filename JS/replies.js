
// global variables for logic below 
var commentID = 0;
var replyCnt = 0; 

$(document).ready(function(){
    
    $(".replies").hide();        // div tag for child comments expanded from original comments
     
    $("a#repliesBtnID").click(function(){         // a tag for opening/expanding the replies that are hidden
        var section = $(this).attr("name");
        var togTxt = $("#tog_text").text();     // "Replies" the html <span> text
        $("#C-" + section).toggle();
    });
    
    $("#addReply").click(function(){          // check if reply text field is empty
        var replyBox = $("#newReply");
        var user = $("#user_reply").val();        // get the user's name
        var replyCheck = replyBox.val();   
        var time = new Date();
        var date = new Date();
        
        var commentId = document.getElementById('comment_ID').value;      // get comment id for replies
        replyCnt = $("#C-"+commentId).find(".reply_box").length;  // get the reply length or size number from comment id div 
       
        if(replyCheck === '' || replyCheck === null){
            replyBox.addClass("form-text-error");
            $("#replyErrMsg").text("Can't leave text blank...");    // show error message
            return false;
        }else if(user === '' || user === "null" || user === null){
            replyBox.addClass("form-text-error");
            $("#replyErrMsg").text("You must be logged in to reply...");    // show error message
            return false;
        }else{
            $("#replyErrMsg").hide();       // hide the error message if textfield empty at first
            $.ajax({
                url: "getReplies",
                type: "POST",
                data: {
                    User: user,
                    Reply: $('#newReply').val(),
                    Comment_ID: commentId
                },
                success: function(data){
                    
                    // get rid of textfield red error after submit
                    replyBox.removeClass("form-text-error");
                    
                    // clears the previous text field value after submitting the form without refreshing the entire page
                    document.getElementById("newReply").value='';

                    // refresh the page if no replies exist. This will then add the reply the user sent
                    if(!$("#replyNum"+commentID).length){
                        getReply();    // call function to display the first reply for comment
                    }else{
                        
                        // Add reply if replies already exists without having to refresh the page
                        $("#C-"+commentId).prepend("<div class=\"reply_box\">" +
                            "<div class=\"reply-content\">" +
                            "<p>" + user + "</p>" +
                            "<p>" + replyCheck + "</p>" +
                            "<p>"+date.toLocaleString("default", {month:"short", day:"2-digit"})+", "+date.toLocaleString("default", {year:"numeric"})+"&nbsp;&nbsp;&nbsp;"+time.toLocaleString('en-US', { hour: 'numeric', minute: 'numeric', hour12: true })+"</p>" +
                            "</div>" +
                            "</div>");
                    }
                   
                    replyCnt++;    // increase the reply count everytime a new reply is inserted
                    $("#replyNum"+commentId).text(replyCnt); // change the number of reply rows
                    
                }
            });
            $("#replyErrMsg").text("");    // clear the error message from the user if true
            return true;
        }
    }); 
    
    $("#sendReply").click(function(){
        var replyBox = $("#a_newReply");  // text box
        var reply = replyBox.val();       // value of reply
        var user = $("#a_reply").val();
        var commentId = document.getElementById('comment_ID').value;  // get comment id
        var time = new Date();
        var date = new Date();
        
        replyCnt = $("#C-"+commentId).find(".reply_box").length;  // get the reply length or size number from comment id div 
        
        if(reply==='' || reply===null || reply==="null"){
            replyBox.addClass("form-text-error");
            $("#a_replyErrMsg").text("Can't leave text blank..."); 
            return false;
        }else{
            $("#a_replyErrMsg").hide();
            $.ajax({
                url: "adminSendReply",
                type: "post",
                data:{
                    a_user : user,
                    reply : reply,
                    commentID : commentId
                },
                success: function(data){
                    
                    // get rid of textfield red error after submit
                    replyBox.removeClass("form-text-error");
                    
                    // clears the previous text field value after submitting the form without refreshing the entire page
                    document.getElementById("a_newReply").value='';
                    
                    replyCnt++;    // increase the reply count everytime a new reply is inserted
                    $("#replyNum"+commentId).text(replyCnt); // change the number of reply rows
                    
                    // refresh the page if no replies exist. This will then add the reply the user sent
                    if(!$("#replyNum"+commentID).length){
                        setInterval('location.reload()', 1000);    // reload the page after submitting reply
                    }else{
                        // Add reply if replies already exists without having to refresh the page
                        $("#C-"+commentId).prepend("<div class=\"reply_box\">" +
                            "<div class=\"reply-content\">" +
                            "<p class=\"reply-user\">" + user + "</p>" +
                            "<p class=\"reply-txt\">" + reply + "</p>" +
                            "<p class=\"reply-date\">"+date.toLocaleString("default", {month:"short", day:"2-digit"})+", "+date.toLocaleString("default", {year:"numeric"})+"&nbsp;&nbsp;&nbsp;"+time.toLocaleString('en-US', { hour: 'numeric', minute: 'numeric', hour12: true })+"</p>" +
                            "</div>" +
                            "</div>");
                    }
                },
                error: function(data){
                    alert("ERROR: "+data);
                }
            });
            $("#a_replyErrMsg").text("");    // clear the error message from the user if true
            return true;
        }
    });
 
});

function reply(caller){
    commentID = $(caller).attr('name');        // get the comment id number when "REPLY" button clicked
    $(".replyForm").insertAfter($(caller));
    $(".replyForm").show();
    // add hidden element to form with comment id so when submitting reply, the coment id is sent too
    $("#getComment_Id").html("<input style=\"display:none\" id=\"comment_ID\" value="+commentID+">");
}

// Get and display comment after user submits 
function getReply(){
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange=function(){
        if (xmlhttp.readyState===4 && (xmlhttp.status===200||xmlhttp.status===500)) {
            
            // add the number of replies when the comment doesn't have a number of replies.
            $("#repliesNumTag"+commentID).append("<a class=\"link-reply\" id=\"repliesBtnID\" name="+commentID+">" +
            "<span id=\"tog_text\">Replies</span>(<span id=\"replyNum"+commentID+"\">1</span>)</a>");
            
            $("#C-"+commentID).load("getReply.jsp?commentID="+commentID);
            
        }
    };
    xmlhttp.open("GET", "getReplies?Comment_ID="+commentID, true);
    xmlhttp.send();
}
