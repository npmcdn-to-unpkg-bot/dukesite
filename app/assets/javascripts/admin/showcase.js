$(function(){
  // Trigger Image Preview
  $("#showcase_photo_attributes_image").change(function(){
    var $img_preview = $('#showcase_form_img_preview');
    readURL(this, $img_preview);
  });
  // Change visible status
  $(".admin-showcase-thumbnail").on('click', "#showcase-status", function(){
    var $this    = $( this ),
        visible  = $this.attr( "data-visible" ),
        editUrl  = $this.attr( "data-edit" );
    visible == 'true' ? visible = false : visible = true ;
    $.ajax({
      url: editUrl,
      method: "PUT",
      data: { visible: visible },
      success: function(data) {
        var visible = data.showcase_status;
        $this.text( function(){
         return visible ? "Visible" : "Hidden";
        });
        $this.attr("data-visible", visible.toString() );
        $this.toggleClass("btn-primary");
        $this.toggleClass("btn-default");
        $this.parents(".thumbnail").toggleClass("invisible_thumbnail");
        }
    });// end of ajax
  });
});
