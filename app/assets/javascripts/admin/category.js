$(function(){
  // Change Cat name
  $(".admin-category-thumbnail #cat-name").each(function(){
    var $this    = $( this );
    $this.click(function readURL(input){
      var cat_name = $this.data('title'),
          cat_img_name = $this.data('img-name'),
          cat_img_url  = $this.data('img'),
          edit_url = $this.data( 'edit' );
          cat_img = $this.parents(".admin-category-thumbnail").find('img'),
      // Show category name and img in Modal
      $("#editCatNameInput").val(cat_name);
      $("#cat_img_preview").attr('src', cat_img_url);
      
      if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
          $('#cat_img_preview').attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
      }
      $("#editCatName #category_image").change(function(){
          readURL(this);
      });

      $("#editCatNameConfirm").click(function(){ // To save the new Category
        var category = new FormData(),
            new_cat_name = $("#editCatNameInput").val(), // cat name value
            new_cat_img  = $("#editCatName #category_image").val(); // cat img
        category.append('category[name]', new_cat_name);
        category.append('category[image]', new_cat_img);
        $.ajax({
          url: edit_url,
          method: "PUT",
          data: category,
          cache: false,
          contentType: false,
          processData: false,
          success: function(data) {
            // When the new name is saved
            var new_cat_name = data.cat_name,
                new_cat_img_url = data.cat_img_url;
            $this.text( new_cat_name ); // Show the new name on Category list
            cat_img.attr('src', new_cat_img_url);
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
      });
      // end of ajax
    });
    // end of click 
  });
});
