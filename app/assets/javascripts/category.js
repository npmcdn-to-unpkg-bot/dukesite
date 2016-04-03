$(function(){
  var cat_name = "#cat-name-1",
      cat_name_val =  $(cat_name).val(),
      cat_input = "<input type='text' class='form-control' placeholder='123'>";
  $(cat_name).click(function(){
    console.log("123");
    $(this).html(cat_input);
  });

  // Change visible status
  $("#cat-status").click(function(){
    var visible = $( this ).attr( "data-visible" ),
        edit_url = $( this ).attr( "data-edit" );
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
            }
    })
    .success( function(data) {
      var visible = data.cat_status;
      $("#cat-status").text( function(){
        return visible ? "visible" : "hidden";
      });
      $("#cat-status").attr("data-visible", visible.toString() );
      $("#cat-status").toggleClass("btn-success");
      $("#cat-status").toggleClass("btn-default");
    });
  });
});
