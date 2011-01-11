$(function() {

  $('a[rel=facebox]').facebox();

  $('#voting .movie a.choose_this_movie').click(function(event) {
    var chosen = this;
    $.ajax({
      url: event.target.href,
      type: 'post',
      data: {'_method': 'put', 'night[movie_id]': $(this).attr('data-movie-id')},
      dataType: 'json',
      error: function(req) {
        // TODO: Use JS-driven flash message
      },
      success: function(response) {
        $('#voting').hide();
        $('#main_content h1 span.movie').removeClass('undecided');
        $('#main_content h1 span.movie span:first').html(response.night.movie.title);

        $('#chosenMovie').tmpl(response.night.movie).appendTo('#chosen');
      }
    });
    return false;
  });

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

  $('#sidebar a.add_friend').click(function(event) {
    var friend = this;
    $.ajax({
      url: event.target.href,
      type: 'post',
      data: {friend_id: $(this).attr('data-friend-id')},
      dataType: 'json',
      error: function(req) {
        // TODO: Use JS-driven flash message
      },
      success: function(response) {
        // TODO: Use JS-driven flash message
        $(friend).hide();
      }
    });
    return false;
  });

  $('#friend_list .friend a.invite').live('click', function() {
    var $emails       = $('#facebox ' + $(this).attr('href'));
    var  emailAddress = $(this).attr('data-friend-email');
    var previousValue = $emails.val();

    $emails.val(emailAddress + ',' + previousValue);
    $(this).parent().hide();
    return false;
  });

});

$(function() {
  var $friendsList = $('#friend_list');
  $.ajax({
    url: $friendsList.attr('href'),
    type: 'post',
    data: {},
    dataType: 'json',
    success: function(response) {
      $('#friendInfo').tmpl(response).appendTo($friendsList);
      $friendsList.show();
    }
  });
});
