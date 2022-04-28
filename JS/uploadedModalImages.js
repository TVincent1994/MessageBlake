// Get the modal
var uploadedPic = document.getElementById("Uploaded_Pic_Modal");
var modalImg = document.getElementById("imgContent");
var captionText = document.getElementById("imgCaption");    // The title of the image
           
function myFunc(el){
    var imgSrc = el.src;
    var altText = el.alt;
    uploadedPic.style.display = "block";
    modalImg.src = imgSrc;
    captionText.innerHTML = altText;
} 

// Click anywhere on page to exit
window.onclick = function(event){
    if(event.target === uploadedPic){
        uploadedPic.style.display = "none";
    }
};

