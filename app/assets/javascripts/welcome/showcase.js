$(function(){
  // Change visible status
  $(".admin-showcase-thumbnail #showcase-status").each(function(){
    var $this    = $( this );
    $this.click(function updateAttr(){
      var visible  = $this.attr( "data-visible" ),
          editUrl = $this.attr( "data-edit" );
      visible == 'true' ? visible = false : visible = true ;
      $.ajax({
        url: editUrl,
        method: "PUT",
        data: { showcase: 
                { visible: visible }
              },
        success: function(data) {
                   var visible = data.showcase_status;
                   $this.text( function(){
                     return visible ? "Visible" : "Hidden";
                   });
                   $this.attr("data-visible", visible.toString() );
                   $this.toggleClass("btn-primary");
                   $this.toggleClass("btn-default");
                 }
      });// end of ajax
    });// end of click
  });
});
