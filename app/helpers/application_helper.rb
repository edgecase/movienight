module ApplicationHelper
  def flash_div(*keys)
    return '' if keys.nil? or keys.empty?

    flash_info = keys.collect { |key|
      content_tag(:div,
        flash[key], :id => "flash_message", :class => key) if flash[key]
    }.join.html_safe

    flash_info
  end

  def body_classes
    classes = "#{params[:controller]} #{params[:action]}"
    if (classes.scan('devise').any?)
      classes << ' login'
    end
    classes
  end

  def poster_url(movie, size)
    movie.poster_url(size) || ''
  end

  def movie_name(night)
    night.movie_title || "DUNNO YET"
  end
end
