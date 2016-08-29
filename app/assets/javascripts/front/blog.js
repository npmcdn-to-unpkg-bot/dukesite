$(function(){
  // Masonry for Grids
  var $grid = $('.grid');
  $grid.imagesLoaded( function () {
    $('.grid').masonry({
      itemSelector: ".grid-item"
    });
  });
});