<%
    String username = (String) session.getAttribute("usernameSession");
%>
<div class='replyForm' id="replyForm" style="display:none">
    <textarea class='replyText' name='new-reply' id='newReply' required='required'></textarea>
    <input style="display:none" name="user_reply" id="user_reply" value="<%=username%>" required/>
    <div id="getComment_Id"></div>
    <div><span id="replyErrMsg"></span></div>
    <div class="replyButtons">
        <button class='closeReplyBtn' onclick="$('.replyForm').hide();">CLOSE</button>
        <button class='submitReply' id='addReply'>SEND</button>   
    </div>
</div>
