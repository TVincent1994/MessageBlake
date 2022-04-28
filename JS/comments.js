
// global variable
var imgid = $("#imgID").val();
var commID;

$(document).ready(function(){
    
    var user = $("#user_Name").val();
    
    // open/hide form to send comment
    $("a#openSendComment").click(function(){
        var unhide = $("#sendCommentForm");
        $(unhide).toggle();
    });
    
    // Actions that happen when the user clicks the submit comment button
    $("#addCommentButton").click(function(){ 
        var comment = $("#comment").val();
        var rowCount = $(".comment_box").length;     // get the comment length or size number
        
        if(comment === null || comment === ""){
            $("#errorText").text("Can't leave comment text blank..."); 
            return false;
        }else if(user === null || user === "null" || user === ""){    // "null" string works when user session or user is logged out 
            $("#errorText").text("You must be logged in to comment..."); 
            return false;
        }else{
            // Else if user is logged in and leaves no comment field empty
            rowCount++;     // increase the comment count everytime a new comment is inserted
            $.ajax({
                type: "POST",  
                data: {
                    user: user,
                    comment: comment,
                    id: imgid
                },
                url: "getImageServlet",
                success: function(data){
                    
                    // clears the previous text field value after submitting the form without refreshing the entire page
                    var cmtForm = document.getElementsByName("commentForm")[0];
                    cmtForm.reset();
                    
                    // call function to return comment
                    getComment();
                    
                    // increase the number of comment rows
                    $("#commentNum").html(rowCount); 
                }
            });
            $("#errorText").text("");    // clear the error message from the user if true
            return true;
        }
    });
 
});

// function for admin to submits comments
function submitComment(){
    var comment = document.forms["sendCommentForm"]["sendComment"].value; 
    var id = document.forms["sendCommentForm"]["commIngId"].value;
    
    var url = "http://localhost:8080/MessageTheBlake/getDetails?comment="+comment+"&media="+id;  
    
    if(comment === "" || comment === "null" || comment === null){
        document.getElementById("sendCommentErr").innerHTML = "Can't leave comment text blank...";  // display error message
        return false;
    }else{
        if(window.XMLHttpRequest){            // for IE7+, Firefox, Chrome, Opera, Safari
            request = new XMLHttpRequest();    
        }else if(window.ActiveXObject){           // for IE6, IE5
            request = new ActiveXObject("Microsoft.XMLHTTP");  
        }try{  
            request.onreadystatechange = function(){  
            if(request.readyState===4){  
                
                setInterval('location.reload()', 1000);
                
                // clears the previous text field value after submitting the form without refreshing the entire page
                var commentForm = document.getElementsByName("sendCommentForm")[0];
                commentForm.reset();
            }
        };//end of function  
            request.open("POST",url,true);  // maybe thats why its returning the elements
            request.send();  
        }catch(e){
            alert("Unable to connect to server");
        }  
    }
}

// Get and display comment after user submits 
function getComment(){
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange=function(){
        if (xmlhttp.readyState===4 && (xmlhttp.status===200||xmlhttp.status===500)) {
            
            // get comment text 
            var comment = xmlhttp.responseText;
            document.getElementById("comments_list").innerHTML = comment;
            
            // after submit, hide the replies and make it accessible whenever clicked.
            $(".replies").hide();        // div tag for child comments expanded from original comments
            $("a#repliesBtnID").click(function(){         // a tag for opening/expanding the replies that are hidden
                var section = $(this).attr("name");
                var togTxt = $("#tog_text").text();     // "Replies" the html <span> text
                $("#C-" + section).toggle();
            });
            
            
        }
    };
    xmlhttp.open("GET", "getComments?media="+imgid, true);
    xmlhttp.send();
}

// open/close delete comment window
function openDeleteWindow(caller){
    document.getElementById("popup-overlay").style.display = "block";
    
    var commentID = $(caller).attr('name');        // get the comment id number when "REPLY" button clicked
    commID = commentID.replace('C-','');          // assign and get the comment Id number to global var
}
function closeDeleteWindow(){
    document.getElementById("popup-overlay").style.display = "none";
}

// when clicked, this function deletes selected comment 
function deleteComment(img_id){
    var imgNum = $(img_id).attr('name');        // get the comment id number when "REPLY" button clicked
    var id = imgNum.replace('img-','');
    
    $.ajax({
        url: "deleteComment",
        type: "GET",
        data:{
            commID : commID,
            media : id
        },
        success: function(data){
            // refresh page.
            setInterval('location.reload()', 1000);
            // delete window disappears.
            document.getElementById("popup-overlay").style.display = "none";
        }
    });
}


