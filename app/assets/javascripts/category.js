$(function(){
  // Change Cat name
  $(".category-list #cat-name").each(function(){
    var $this    = $( this );
    $this.click(function(){
      var cat_name = $this.text(), // Read category name
          edit_url = $this.attr( "data-edit" );
      // In Modal
      $("#editCatNamebody").attr("placeholder", cat_name);// Show category name in the form
      // To save the new Category
      $("#editCatNameConfirm").click(function(){
        var new_cat_name = $("#editCatNamebody").val(); // Read value from Category form
        $.ajax({
          url: edit_url,
          method: "PUT",
          data: { category:
                  { name: new_cat_name }
                },
          success: function(data) {
            // When the new name is saved
            var new_cat_name = data.cat_name;
            $this.text( new_cat_name ); // Show the new name on Category list
          }
        }); // end of ajax
      }); // end of click-confirm
    }); // end of click-show-modal
  });

  // Change visible status
  $(".category-list #cat-status").each(function(){
    var $this    = $( this );
    $this.click(function(){
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
          $this.toggleClass("btn-primary");
          $this.toggleClass("btn-default");
        }
      });
      // end of ajax
    });
    // end of click
  });
});
