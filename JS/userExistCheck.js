

function checkUserExist(){
    
    var xmlhttp = new XMLHttpRequest();
    var k = document.getElementById("username_ID").value;
    var url ="checkUserExist.jsp?usernameInput=" + k;

    if (window.XMLHttpRequest){
        xmlhttp=new XMLHttpRequest();
    }else{
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
        xmlhttp.onreadystatechange=function(){
            if (xmlhttp.readyState===4){
            //document.getElementById("err").style.color="red";
            document.getElementById("userExistError").innerHTML = xmlhttp.responseText;
        }
    };
    xmlhttp.open("GET",url,true);
    xmlhttp.send();
}
