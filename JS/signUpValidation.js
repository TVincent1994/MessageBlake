
function signupvalidate(){  
    
    var email = document.forms["signUpForm"]["emailInput"].value;
    var emailExist = document.getElementById('emailAlert').value;
    var username = document.forms["signUpForm"]["usernameInput"].value;
    var password = document.forms["signUpForm"]["passwordInput"].value;
    var repeatPassword = document.forms["signUpForm"]["repasswordInput"].value;
      
    var emailFormat = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    
    if(email === "" && username ==="" && password ==="" && repeatPassword === ""){  // if all fields are empty.
        alert("Please fill in all fields");
        return false;
    }
    if(!(email.match(emailFormat))){
        alert("You have entered an invalid email format.");
        return false;
    }
    if(email===null || email===""){   // If email input is empty
        alert("Email can't be left blank.");
        return false;
    }else if (username===null || username===""){
        alert("Username can't be left blank.");
        return false;
    }else if(password===null || password===""){
        alert("Password can't be left blank.");
        return false;
    }else if(password.length<6){
        alert("Password must be at least 6 characters long.");
        return false;
    }else if(repeatPassword===null || repeatPassword===""){
        alert("Re-Enter Password can't be left blank.");
        return false;
    }else if(password !== repeatPassword){
        alert("Passwords must match.");
        return false;
    }else if(emailExist === "taken"){
        alert("Email already exist.");
        return false;
    }
    return true;      // return true if all fields follow the principles above.
}
