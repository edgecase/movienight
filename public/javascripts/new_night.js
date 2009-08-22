$(function() {
  $('input[name=location_source]').change(function() {
    var target = $('input:checked[name=location_source]').attr('rel');
    $('.location_source').hide();
    $(target).show();
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
