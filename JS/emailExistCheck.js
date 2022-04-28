
// Checks if an email exists in the database using ajax. Displays the notification
function checkExist(){
    
    var xmlhttp = new XMLHttpRequest();
    var email = document.signUpForm.emailInput.value;
    var url = "checkEmailExist.jsp?emailInput=" + email;

    if (window.XMLHttpRequest){
        xmlhttp=new XMLHttpRequest();
    }else{
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    xmlhttp.onreadystatechange=function(){
        if (xmlhttp.readyState===4){
            document.getElementById("emailExistError").innerHTML=xmlhttp.responseText;
        }
    };
    xmlhttp.open("GET",url,true);
    xmlhttp.send();
}

