//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .



var duke_blue = "#013088";

$(document).ready(function(){
  $('.nav-contact li')
    .mouseover(function(){
      $(this).css('background-color', duke_blue);
      $("a", this).css('color', 'whiteSmoke');

    })
    .mouseout(function(){
      $(this).css('background-color', "");
      $("a", this).css('color', '');
    });
});
