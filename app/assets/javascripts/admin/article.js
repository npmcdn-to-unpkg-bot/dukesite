$(function(){
  // Change visible status
  $(".admin-article-thumbnail #article-status").each(function(){
    var $this    = $( this );
    $this.click(function updateAttr(){
      var visible  = $this.attr( "data-visible" ),
          editUrl = $this.attr( "data-edit" );
      visible == 'true' ? visible = false : visible = true ;
      $.ajax({
        url: editUrl,
        method: "PUT",
        data: { published: visible },
        success: function(data) {
                   var visible = data.article_status;
                   $this.text( function(){
                     return visible ? "Published" : "Unpublished";
                   });
                   $this.attr("data-visible", visible.toString() );
                   $this.toggleClass("btn-primary");
                   $this.toggleClass("btn-default");
                   $this.parents(".thumbnail").toggleClass("invisible_thumbnail");
                 }
      });// end of ajax
    });// end of click
  });
  // Trigger Image Preview
  $("#article_photo_attributes_image").change(function(){
    var $img_preview = $('#article-form-img-preview');
    readURL(this, $img_preview);
  });
});