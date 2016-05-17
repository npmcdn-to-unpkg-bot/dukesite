$(function(){
  $('#new_keyword').on('ajax:success', function(event, xhr) {
    var url = xhr.url,
        new_keyword = "<p>\
                        <span class='label label-default'>"
                          + xhr.new_keyword + " " +
                          "<span class='glyphicon glyphicon-remove' \
                                 aria-hidden='true' \
                                 id='remove_keyword' \
                                 data-url=" + url + ">"
                          "</span>\
                         </span>\
                      </p>";
    $("#seo-list").after(new_keyword);
  }).on('ajax:error', function(event, xhr) {
    var response = xhr.responseJSON.response;
    $('#seo-msg').html(response).toggleClass('hide');
    setTimeout(function(){
      $('#seo-msg').toggleClass('hide');
    }, 3000);
  });
  $('#seo-list #remove-keyword').each(function(){
    $(this).click(function(){
      var url = $(this).data('url');
      $.ajax({
        context: this,
        url: url,
        type: "DELETE",
        success: function(){
          $(this).parents('p').toggleClass('hide');
        },
        error: function(e, xhr){
          var response = xhr.responseJSON.response;
          $('#seo-msg').html(response).toggleClass('hide');
        }
      });
    });
  });
});
