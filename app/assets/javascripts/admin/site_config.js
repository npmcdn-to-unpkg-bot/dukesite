$(function(){

  // Image Preview
  function readIconURL(input){
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        $('#icon-form-img-preview').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    };
  }

  function readFavIconURL(input){
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        $('#favorite-icon-form-img-preview').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    };
  }
  // Trigger Image Preview
  $("#icon-image").change(function(){
    readIconURL(this);
  });

  $("#favorite-icon-image").change(function(){
    readFavIconURL(this);
  });

  // Add Keywords
  $('#new_keyword').on('ajax:success', function(event, xhr) {
    $("#seo-list").load(location.href + " #seo-list");
  }).on('ajax:error', function(event, xhr) {
    var response = xhr.responseJSON.response;
    $('#seo-msg').html(response).toggleClass('hide');
    setTimeout(function(){
      $('#seo-msg').toggleClass('hide');
    }, 3000);
  });
  // Remove Keywords
  $('body').on('click', '#remove-keyword', function(){
    var url = $(this).data('url');
    $.ajax({
      context: this,
      url: url,
      type: "DELETE",
      success: function(){
        $(this).parents('p').toggleClass('hide');
      },
      error: function(e, xhr){
        var response = xhr.responseJSON.response;
        $('#seo-msg').html(response).toggleClass('hide');
      }
    });
  });
});
