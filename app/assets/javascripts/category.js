$(function(){
  var cat_name = "#cat-name-1";
  var cat_name_val =  $(cat_name).val();
  var cat_input = "<input type='text' class='form-control' placeholder='123'>"
  $(cat_name).click(function(){
    console.log("123");
    $(this).html(cat_input);
  });

  // Change visible status
  $("#cat-status").click(function(){
    var visible = $( this ).data( "visible" );
    var edit_url = $( this ).data( "edit" );
    $.ajax({
      url: edit_url,
      method: "PUT",
      data: { category: 
              { visible: !visible }
            }
    })
    .success( function(data) {
      var cat_status = data.cat_status;
      $("#cat-status").text( function(){
        return cat_status ? "visible" : "hidden";
      });
      $("#cat-status").attr("data-visible", cat_status.toString() );
      $("#cat-status").toggleClass("btn-success");
      $("#cat-status").toggleClass("btn-default");
    });

  });
});
