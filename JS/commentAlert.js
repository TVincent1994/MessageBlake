

$(document).ready(function(){
    
    // click "Details" for selected image and clear notification number
    $(document).on('click', '.details', function(){
        var img = this.id;                     // get id number of specific imgae display
        var i = img.replace('img-','');        // extract imgage text from numbers
        $('.commentAlert').html("");     // clear notification number   
        commentAlert(1, i);               // mark notification as opened (read).
    });
    
    function commentAlert(alert = 0, i){
        $.ajax({
            type: 'GET',
            url: 'messageAlert.jsp',
            data:{
                alert : alert,
                img : i
            },
            success: function(data){
                if(data > 0){
                    // if messages greater than 0, display the notification number 
                    $("#commentAlert").html(data);  // element as "id" to display unique number for specific image of unread comments
                }else{
                    // else 0, no notification showing
                    $("#commentAlert").html("");    // element as "id" to display unique number for specific image of unread comments
                }
            }
        });
    }
    
});

