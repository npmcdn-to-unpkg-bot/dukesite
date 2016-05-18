$(function(){
  // Image Preview
  function readURL(input){
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        $('#cat_form_img_preview').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    };
  }
  // Trigger Image Preview
  $("#category_image").change(function(){
    readURL(this);
  });

  // Change Visible Status
  $('.admin-category-thumbnail').on('click', "#cat-status", function(){
    var $this    = $( this ),
        visible  = $this.attr( "data-visible" ),
        edit_url = $this.attr( "data-edit" );
    visible == 'true' ? visible = false : visible = true ;
    $.ajax({
      url: edit_url,
      method: "PUT",
      data: { visible: visible },
      success: function(data) {
        var visible = data.cat_status;
        $this.text( function(){
          return visible ? "visible" : "hidden";
        });
        $this.attr("data-visible", visible.toString() );
        $this.toggleClass("btn-primary");
        $this.toggleClass("btn-default");
        $this.parents(".thumbnail").toggleClass("invisible_thumbnail");
      }
    });// end of ajax
  });
});
