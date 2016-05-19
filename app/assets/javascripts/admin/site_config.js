$(function(){

  // Image Preview
  function readURL(input){
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        $('#icon-form-img-preview').attr('src', e.target.result);
        $('#favorite-icon-form-img-preview').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    };
  }
  // Trigger Image Preview
  $("#icon_image").change(function(){
    readURL(this);
  });

  $("#favorite-icon_image").change(function(){
    readURL(this);
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
