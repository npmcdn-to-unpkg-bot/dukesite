//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .



// var duke_blue = "#013088";

$(function(){
  // subscribe-form
  $('#subscribe-form').on('ajax:success', function(event, xhr) {
    $('#subscribe-form').hide();
    $('#subscribe-msg').html(xhr.response).removeClass('hide');
  }).on('ajax:error', function(event, xhr) {
    var response = xhr.responseJSON.response;
    $('#subscribe-msg').html(response).removeClass('hide');
  });

  // lookup-item-on-amazon
  $('#lookup-item-on-amazon-form').on('ajax:success', function(event, xhr) {
    $('#lookup-item-on-amazon-msg').html(xhr.response).removeClass('hide');
    var returned_items_num = xhr.data.length;
    var item = xhr.data;
    var asin = item.asin;
    var title = item.title;
    var product_page_url = item.detail_page_url;
    var img_url = item.large_image_url;
    var desc = item.description;
    if(returned_items_num > 1) { // show multiple returned items in boxes
      console.log(item);
    } else { // show the only returned item in the form
      $('#product_asin').val(asin);
      $('#product_title').val(title);
      $('#product_url').val(product_page_url);
      $('#product_image_url').val(img_url);
      $('#product_description').val(desc);
      $('#product-img-url').attr('src', img_url);
    };
  }).on('ajax:error', function(event, xhr, status) {
    var response = xhr.responseJSON.response;
    $('#lookup-item-on-amazon-msg').html(response).removeClass('hide');
  });

});
