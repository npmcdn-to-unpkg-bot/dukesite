$(function(){
  // Image Preview
  function readURL(input){
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        $('#quote-form-img-preview').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    };
  }
  // Trigger Image Preview
  $("#quote_photo_attributes_image").change(function(){
    readURL(this);
  });
  // Change visible status
  $(".admin-quote-thumbnail #quote-status").each(function(){
    var $this    = $( this );
    $this.click(function updateAttr(){
      var visible  = $this.attr( "data-visible" ),
          editUrl = $this.attr( "data-edit" );
      visible == 'true' ? visible = false : visible = true ;
      $.ajax({
        url: editUrl,
        method: "PUT",
        data: { visible: visible },
        success: function(data) {
                   var visible = data.quote_status;
                   $this.text( function(){
                     return visible ? "Visible" : "Hidden";
                   });
                   $this.attr("data-visible", visible.toString() );
                   $this.toggleClass("btn-primary");
                   $this.toggleClass("btn-default");
                   $this.parents(".thumbnail").toggleClass("invisible_thumbnail");
                 }
      });// end of ajax
    });// end of click
  });
});
