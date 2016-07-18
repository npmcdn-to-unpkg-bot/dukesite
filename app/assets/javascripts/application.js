//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .

$(function(){
  // Masonry for Grids
  var $grid = $('.grid');
  $grid.imagesLoaded( function () {
    $('.grid').masonry({
      itemSelector: ".grid-item"
    });
  });
});
  