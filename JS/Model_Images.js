
// Get the modal
var modal = document.getElementById("Modal");
// Get the image and insert it inside the modal
var modalImg = document.getElementById("img01");
           
function viewImage(el){
    var imgSrc = el.src;
    modal.style.display = "block";
    modalImg.src = imgSrc;            // gets the source of the image
}; 

// When the user clicks anywhere besides image, close the modal
window.onclick = function(event){
    if(event.target === modal){
        modal.style.display = "none";
    }
};
