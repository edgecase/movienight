$(function() {
  $('input[name=location_source]').change(function() {
    var target = $('input:checked[name=location_source]').attr('rel');
    $('.location_source').hide();
    $(target).show();
  });
});
