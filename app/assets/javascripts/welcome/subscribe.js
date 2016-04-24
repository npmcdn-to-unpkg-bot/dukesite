$(function(){
  // subscribe-form
  $('#subscribe-form').on('ajax:success', function(event, xhr) {
    $('#subscribe-form').hide();
    $('#subscribe-msg').html(xhr.response).removeClass('hide');
  }).on('ajax:error', function(event, xhr) {
    var response = xhr.responseJSON.response;
    $('#subscribe-msg').html(response).removeClass('hide');
  });
});
