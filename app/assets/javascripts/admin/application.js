//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require_directory .


// Image Preview
function readURL(input, preview){
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function (e) {
      preview.attr('src', e.target.result);
    }
    reader.readAsDataURL(input.files[0]);
  };
}

$(function(){
  // Masonry for Grids
  var $grid = $('.grid');
  $grid.imagesLoaded( function () {
    $('.grid').masonry({
      itemSelector: ".grid-item"
    });
  });
  
  // Flash Alert Fade out
  setTimeout(function() {
     $(".alert").delay(2000).slideUp(500, function(){
      $(this).alert('close');
    });
  }, 5000);
});
