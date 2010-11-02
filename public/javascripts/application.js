$(function() {
  $('[rel=date]').datepicker({dateFormat: 'yy-mm-dd'});

  $('a[rel=external]').click(function() {
    var newWindow = window.open($(this).attr('href'), '_blank');
    if(newWindow) { if(newWindow.focus) { newWindow.focus(); return false; } }
    newWindow = null;
  });
});

