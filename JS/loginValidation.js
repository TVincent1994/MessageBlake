
function loginvalidate(){
    var username = document.forms["loginForm"]["usernameInput"].value;
    var password = document.forms["loginForm"]["passwordInput"].value;
    
    if(username==="" && password===""){
        alert("Please fill in all fields.");
        return false;
    }
    if(username===null || username===""){
        alert("Username can't be left blank.");
        return false;
    }
    if(password===null || password===""){
        alert("Password can't be left blank.");
        return false;
    }    
    return true;
}







