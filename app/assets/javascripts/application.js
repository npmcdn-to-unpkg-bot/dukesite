//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .



var duke_blue = "#013088";

$(function(){
  var changBgColor = function(button) {
    $(button)
    .mouseover(function(){
      $(this).css('background-color', duke_blue);
      $("a", this).css('color', 'whiteSmoke');

    })
    .mouseout(function(){
      $(this).css('background-color', "");
      $("a", this).css('color', '');
    });
  };

  changBgColor('.nav-contact li');
  changBgColor('.nav-bar li');  

  // $(nav_button)
  //   .mouseover(function(){
  //     $(this).css('background-color', duke_blue);
  //     $("a", this).css('color', 'whiteSmoke');

  //   })
  //   .mouseout(function(){
  //     $(this).css('background-color', "");
  //     $("a", this).css('color', '');
  //   });


});
