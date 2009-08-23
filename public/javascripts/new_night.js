$(function() {
  $('input[name=location_source]').change(function() {
    var target = $('input:checked[name=location_source]').attr('rel');
    $('.location_source').hide();
    $(target).show();
  });

  $('#new_location input').keydown(function(e) {
    if(e.keyCode == 13) {
      $("#add_address").click();
      return false;
    }
  });

  $('.movie input').blur(function() {
    var title_input = $(this)
    var results = title_input.nextAll('span.results');
    // TODO: Make this populate via some ajax response
    if (title_input.val()) {
      var search_link = $(this).nextAll('a.search');
      $.get(search_link.attr('href'), { movie_title: title_input.val() }, function(html) {
        results.html(html);
      });
    } else
      results.html('');
  });
  

  $('#add_address').click(function() {
    var data = $('#new_location input').serialize();

    $.ajax({
      url: '/locations',
      data: data,
      type: 'post',
      dataType: 'html',
      error: function(req) {
        $("#location_errors").html(req.responseText);
      },
      success: function(response) {
        $('#use_saved_location').attr('checked', 'checked');
        $('.location_source').hide();
        $('#saved_locations').html(response).show();
      }
    });

  });

});
