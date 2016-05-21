$(function(){
  // Trigger Image Preview
  $("#icon-image").change(function(){
    var $img_preview = $('#icon-form-img-preview');
    readURL(this, $img_preview);
  });

  $("#favorite-icon-image").change(function(){
    var $img_preview = $('#favorite-icon-form-img-preview');
    readURL(this, $img_preview);
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
