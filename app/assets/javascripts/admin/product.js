$(function(){
  // lookup-item-on-amazon
  $('#lookup-item-on-amazon-form').on('ajax:success', function(event, xhr) {
    $('#lookup-item-on-amazon-msg').html(xhr.response).removeClass('hide');
    var returned_items = xhr.data,
        returned_items_num = returned_items.length;

    $.each(returned_items, function(index, value){
      var item       = value,
          asin       = item.asin,
          title = item.title,
          product_page_url = item.detail_page_url,
          img_url = item.image_url_large,
          desc = item.description,
          id = 'item-' + asin;
      // Thumbmail for each item
      $col = $('<div></div>').addClass("col-xs-12 col-sm-3 col-md-2").attr('id', id);
      $thumbnail = $('<div></div>').addClass("thumbnail").appendTo($col);
      $img = $('<img />', { src: img_url}).appendTo($thumbnail);
      $item_info = $('<p></p>').text(title);
      $caption = $('<div></div>').addClass("caption").append($item_info).appendTo($thumbnail);
      $('#returned_items').append($col);

      // Click thumbnail & Show in form
      $('#' + id).click(function(){
        var $form = $('#new_product');
        $('#product_asin').val(asin);
        $('#product_title').val(title);
        $('#product_url').val(product_page_url);
        $('#product_image_url').val(img_url);
        $('#product_description').val(desc);
        $('#product-img-url').attr('src', img_url);
        // $(this).parent().children().remove();

        // Scroll to the form
        $('html,body').animate({
          scrollTop: $form.offset().top}, 'show');
      });

    });
  }).on('ajax:error', function(event, xhr, status) {
    var response = xhr.responseJSON.response;
    $('#lookup-item-on-amazon-msg').html(response).removeClass('hide');
  }).on('click', function(){
    $('#returned_items').children().remove();
  }).on('keypress', function(){
    $('#returned_items').children().remove();
  });

  // Change visible status
  $(".admin-product-thumbnail #product-status").each(function(){
    var $this    = $( this );
    $this.click(function updateAttr(){
      var visible  = $this.attr( "data-visible" ),
          editUrl = $this.attr( "data-edit" );
      visible == 'true' ? visible = false : visible = true ;
      $.ajax({
        url: editUrl,
        method: "PUT",
        data: { product: 
                { published: visible }
              },
        success: function(data) {
                   var visible = data.product_status;
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

  $(".admin-product-thumbnail").each(function(){
    var $this    = $( this );
    $this.hover(
      function(){
        $this.find('.caption').toggleClass('hide');
      })
  });
});

