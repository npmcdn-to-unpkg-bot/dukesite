$(function(){
  // Change Cat name
  $(".admin-category-thumbnail #cat-name").each(function(){
    var $this    = $( this );
    $this.click(function(){
      var 
          cat_img = $this.parents(".admin-category-thumbnail").find('img'),
          cat_img_url = cat_img.attr('src'),
          cat_name = $this.text(), // Read category name
          edit_url = $this.attr( "data-edit" );

      // In Modal
      $("#editCatNameInput").attr("placeholder", cat_name);// Show category name
      $("#editCatImgUrlInput").attr("placeholder", cat_img_url);
      // To save the new Category
      $("#editCatNameConfirm").click(function(){

        var new_cat_name = $("#editCatNameInput").val(),
            new_cat_img_url  = $("#editCatImgUrlInput").val(); // Read value from Category form
        if (new_cat_name == "") {
          new_cat_name = cat_name;
        }
        if (new_cat_img_url == "") {
          new_cat_img_url = cat_img_url;
        }
        $.ajax({
          url: edit_url,
          method: "PUT",
          data: { category: 
                  { name: new_cat_name,
                    img_url: new_cat_img_url }
                },
          success: function(data) {
            // When the new name is saved
            var new_cat_name = data.cat_name,
                new_cat_img_url = data.cat_img_url;
            $this.text( new_cat_name ); // Show the new name on Category list
          }
        }); // end of ajax
      }); // end of click-confirm
    }); // end of click-show-modal
  });

  // Change visible status
  $(".admin-category-thumbnail #cat-status").each(function(){
    var $this    = $( this );
    $this.click(function(){
      var visible  = $this.attr( "data-visible" ),
          edit_url = $this.attr( "data-edit" );
      visible == 'true' ? visible = false : visible = true ;
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
          $this.parents(".thumbnail").toggleClass("invisible_thumbnail");
        }
      });
      // end of ajax
    });
    // end of click 
  });
});
