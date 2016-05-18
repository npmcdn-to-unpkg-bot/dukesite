$(function(){
  // Image Preview
  function readURL(input){
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        $('#sna_form_img_preview').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    };
  }
  // Trigger Image Preview
  $("#social_network_account_image").change(function(){
    readURL(this);
  });
});
