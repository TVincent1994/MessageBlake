


<div id="new-message" class="overlay">
    <span class="closebtn" onclick="document.getElementById('new-message').style.display='none'">&#215</span>
    <p class="message-header">New Message</p>
    <p class="message-body"></p>
        <form align="center" name="userExistForm" method="post" style="padding-top:0" action="AdminSendMessage" onsubmit="">
            <div id="DisplayUserMessage"></div>
            <input type="text" name="userInList" list="listOfUsers" onkeyup="check_user_in_db(this.value);" class="message-input" placeholder="username"><br><br>
               
                
            <!-- drop down list to show the available users -->
            <datalist id="listOfUsers"></datalist>
                    
            <textarea id="textarea-input" class="textarea-input" name="messageText" placeholder="Write your message here.."></textarea>
            <input type="submit" value="Send" id="SendUserMessage" class="sendButtonUserMessage" style="width:80px; margin-top: 0"/>
        </form>
            
    <p class="message-footer">Click to send Button, Click X to Exit</p>
</div>