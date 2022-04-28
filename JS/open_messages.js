
$(document).ready(function(){

    // open chatbox and clear notification number
    $(document).on('click', '.chatBoxButton', function(){
        $('.notification').html("");           // clear notification number    
        document.getElementById("MESSAGESOVERLAY").style.display = "block";
        openMessagesForm(1);     // add "1" to function so the unread messaages are read from 0 to 1
    });

    // open chatbox message and set unread messages to read
    function openMessagesForm(status = 0){
        $.ajax({
            type: 'GET',
            url: 'readMsg.jsp',
            data: {
                status : status
            },
            success: function(data){
                // if messages greater than 0, display the notification number 
                if(data > 0){
                    $(".notification").html(data);  
                }else{
                    // else 0, no notification showing 
                    $('.notification').html("");  
                }
            }
        });
    }
    
    // set to 5 seconds for messages to receive
    setInterval(function(){ 
        openMessagesForm(); 
    }, 5000);  

});

function closeMessagesForm(){
    document.getElementById("MESSAGESOVERLAY").style.display = "none";
}