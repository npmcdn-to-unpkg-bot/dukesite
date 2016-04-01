//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .
//= require category


// var duke_blue = "#013088";

$(function(){
  // var changBgColor = function(button) {
  //   $(button).hover(function(){
  //     $(this).toggleClass('hover');
  //   }, function() {
  //     $(this).toggleClass('hover');
  //   });
  // };
  // changBgColor('.navbar-collapse #nav-link');

  $('#subscribe-form').on('ajax:success', function(e, data) {
    $('#subscribe-form').hide();
    $('#subscribe-msg').html("You've subscirbed Newsletter from Duke for Girls.").removeClass('hide');
  }).on('ajax:error', function() {
    $('#subscribe-msg').html("Please enter email address.").removeClass('hide');
  });

});
