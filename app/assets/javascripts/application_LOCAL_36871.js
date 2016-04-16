//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .

$(function(){
  $('#subscribe-form').on('ajax:success', function(e, data) {
    $('#subscribe-form').hide();
    $('#subscribe-msg').html("You've subscirbed Newsletter from Duke for Girls.").removeClass('hide');
  }).on('ajax:error', function() {
    $('#subscribe-msg').html("Please enter email address.").removeClass('hide');
  });
});
