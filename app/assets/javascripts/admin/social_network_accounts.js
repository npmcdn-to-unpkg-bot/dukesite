$(function(){
  // Trigger Image Preview
  $("#social_network_account_photo_attributes_image").change(function(){
    var $img_preview = $('#sna_form_img_preview');
    readURL(this, $img_preview);
  });
});
