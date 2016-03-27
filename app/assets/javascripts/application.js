//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .



// var duke_blue = "#013088";

$(function(){

  $('#subscribe-form').on('ajax:success', function(event, xhr) {
    $('#subscribe-form').hide();
    $('#subscribe-msg').html(xhr.response).removeClass('hide');
  }).on('ajax:error', function(event, xhr) {
    var response = xhr.responseJSON.response;
    $('#subscribe-msg').html(response).removeClass('hide');
  });

  $('#lookup-item-on-amazon-form').on('ajax:success', function(event, xhr) {
    $('#lookup-item-on-amazon-msg').html(xhr.response).removeClass('hide');
    var item = xhr.data;
    var asin = item.Asin;
    var title = item.Title;
    var product_page_url = item.DetailPageURL;
    var img_url = item.LargeImageURL;
    var desc = item.Description;

    $('#product_asin').val(asin);
    $('#product_title').val(title);
    $('#product_url').val(product_page_url);
    $('#product_image_url').val(img_url);
    $('#product_description').val(desc);
    $('#product-img-url').attr('src', img_url);

  }).on('ajax:error', function(event, xhr) {
    var response = xhr.responseJSON.response;
    $('#lookup-item-on-amazon-msg').html(response).removeClass('hide');
  });

});

