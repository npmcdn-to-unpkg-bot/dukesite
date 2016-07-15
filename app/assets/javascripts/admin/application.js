//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery-fileupload/basic-plus
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .


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
});
