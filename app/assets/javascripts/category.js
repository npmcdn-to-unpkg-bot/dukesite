$(function(){
  var cat_name = "#cat-name-1",
      cat_name_val =  $(cat_name).val(),
      cat_input = "<input type='text' class='form-control' placeholder='123'>";
  $(cat_name).click(function(){
    console.log("123");
    $(this).html(cat_input);
  });

  // Change visible status
  $(".category-list #cat-status").each(function(){
    $( this ).click(function(){
      var $this    = $( this ),
          visible  = $this.attr( "data-visible" ),
          edit_url = $this.attr( "data-edit" );
      if (visible == "false" ) {
        var visible = true;
      } else {
        var visible = false;
      };
      $.ajax({
        url: edit_url,
        method: "PUT",
        data: { category: 
                { visible: visible }
              },
        success: function(data) {
          var visible = data.cat_status;
          $this.text( function(){
            return visible ? "visible" : "hidden";
          });
          $this.attr("data-visible", visible.toString() );
          $this.toggleClass("btn-success");
          $this.toggleClass("btn-default");
        }
      });
      // end of ajax
    });
    // end of click 
  });
});
