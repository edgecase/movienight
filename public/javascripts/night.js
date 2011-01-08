$(function() {

  $('#voting .movie a.vote_for_me').not('a.do_not_want, a.i_choose_you_pikachu').click(function(event) {
    var chosen = this;
    $.ajax({
      url: event.target.href,
      type: 'post',
      dataType: 'json',
      error: function(req) {
        // TODO: Use JS-driven flash message
      },
      success: function(response) {
        $('#voting').find('a.vote_for_me').addClass('do_not_want');
        $(chosen).addClass('i_choose_you_pikachu');
        $(chosen).siblings('span.vote_count').html('+'+response.count);
      }
    });
    return false;
  });

  $('#voting .movie a.do_not_want, #voting .movie a.i_choose_you_pikachu').click(function(event) {
    return false;
  });

});
