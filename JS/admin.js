
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
