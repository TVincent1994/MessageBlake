
// Checks if an email exists in the database using ajax. Displays the notification
function check_user_in_db(value){ 
    
    xmlHttp = GetXmlHttpObject();
    var url = "checkInDB.jsp";
    url = url + "?userInList=" + value;
    xmlHttp.onreadystatechange = stateChanged; 
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);
}
        
function stateChanged(){ 
    if(xmlHttp.readyState===4 || xmlHttp.readyState==="complete"){ 
        var showdata = xmlHttp.responseText; 
        document.getElementById("DisplayUserMessage").innerHTML = showdata;
                
        // COME BACK TO THIS TO DISABLE BUTTON
        if(showdata==="User Doesn't Exists"){
            $("#SendUserMessage").prop("disabled",true);
        }else{
            document.getElementById("#SendUserMessage").disabled = false;
        }
    } 
}
        
// code for version of the browser the user is using
function GetXmlHttpObject(){
    var xmlHttp=null;
    try{
        xmlHttp=new XMLHttpRequest();
    }catch (e) {
        try {
            xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
        }catch (e){
            xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
    }
    return xmlHttp;
}
        
        
        
        

