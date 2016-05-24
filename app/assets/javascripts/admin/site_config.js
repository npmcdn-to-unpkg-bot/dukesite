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
});
