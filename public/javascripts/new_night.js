$(function() {
  $('input[name=location_source]').change(function() {
//    $('#saved_or_new_location').hide();
    var target = $('input:checked[name=location_source]').attr('rel');
    $('.location_source').hide();
    $(target).show();
  });

  $('input[name=location_source]').click(function() {
    $(this).change();
  });

  $('a#add_new_location').click(function(){
    $('#new_location').show();
    $('#saved_locations').hide();
    return false;
  });

  $('a#cancel_new_location').always().click(function(event) {
    $('#new_location.location_source').hide();
    $('#saved_locations').show();
    return false;
  });

  $('a.edit_location').always().click(function(event) {
    $('#edit_location').css('height', $('#saved_locations').css('height')).show();
    $("#saved_locations.location_source").hide();
    $(this).siblings("input[type='radio']").attr('checked', 'checked');
    $.get($(this).attr('href'), {}, function(data, textStatus) {
      $('#edit_location').html(data);
    }, 'html');
    return false;
  });

  $('a#cancel_edit_location').always().click(function(event) {
    $('#edit_location.location_source').html('').hide();
    $("#saved_locations.location_source").show();
    return false;
  });

  $('#new_location input').keydown(function(e) {
    if(e.keyCode == 13) {
      $("#add_location").click();
      return false;
    }
  });

  $(".saved_location input[type='radio']").always().click(function(){
    var $html = $(this).parents(".saved_location").find(".location_details").html();
    $("#saved_location_details").html($html).show();
  });

  $('#edit_location input').always().keydown(function(e) {
    if(e.keyCode == 13) {
      $("a#update_location").click();
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
  

  $('#add_location').click(function() {
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
        $('#saved_location_list').html(response);
        $('#saved_locations').show();
        $("#new_location input[type!='hidden']").val('');
      }
    });
    return false;
  });

  $('a#update_location').always().click(function(event) {
    var data = $('#edit_location input').serialize();
    $.ajax({
      url: event.target.href,
      data: data + "&_method=put",
      type: 'post',
      dataType: 'html',
      error: function(req) {
        $("#edit_location_errors").html(req.responseText);
      },
      success: function(response) {
        $('#use_saved_location').attr('checked', 'checked');
        $('.location_source').hide();
        $('#saved_location_list').html(response);
        $('#saved_locations').show();
      },
      complete: function() {
        $('input.check_me').each(function(){
          $(self).attr('checked', 'checked').removeClass('check_me');
          $(self).click();
        });
      }
    });
    return false;
  });

  $('a.delete_location').always().click(function(event) {
    var data = $('#saved_location_details form.delete_location input').serialize();
    $.ajax({
      url: event.target.href,
      data: data,
      type: 'post',
      dataType: 'html',
      error: function(req) {
        $("#edit_location_errors").html(req.responseText);
      },
      success: function(response) {
        $('.location_source').hide();
        $('#saved_location_list').html(response);
        $('#saved_locations').show();
        $('#saved_location_details').hide();
      },
      complete: function() {
        $('input.check_me').each(function(){
          $(self).attr('checked', 'checked').removeClass('check_me');
          $(self).click();
        });
      }
    });
    return false;
  });

  $(".field label a#add_movie").click(function(){
    $('.half#voting_options .field.movie:first').each(function() {
      $(this).clone(true).insertAfter(this).show();
    });
    return false;
  });

  $("input[name='vote']").click(function() {
    $('.field#vote_or_dictate').hide();
    $('.field#movie_header').show();
    if (this.value == 'yes') {
      $('.half#voting_options').show();
      $('.field#movie_header a').show();
    } else {
      $('.half#dictate_movie').show();
      $('.field#movie_header a').hide();
    }
  });

  $("a#nah_lets_vote, a#im_gonna_dictate").click(function(){
    $('.half#voting_options').toggle();
    $('.half#dictate_movie').toggle();
    $('.field#movie_header a').toggle();
    return false;
  });

});
