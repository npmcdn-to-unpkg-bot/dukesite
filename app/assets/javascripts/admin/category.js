$(function(){
  // Trigger Image Preview
  $("#category_photo_attributes_image").change(function(){
    var $img_preview = $('#cat-form-img-preview');
    readURL(this, $img_preview);
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
