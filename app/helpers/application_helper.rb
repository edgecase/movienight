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

  def gravatar_url(user, size=80)
    hash = Digest::MD5.hexdigest(user.email.downcase)
    "http://www.gravatar.com/avatar/#{hash}.jpg?d=mm&s=#{size}"
  end

  def current_user_is_host
    return unless user_signed_in?
    return unless night
    night.host == current_user
  end

  def movie_name(night)
    night.movie_title || "DUNNO YET"
  end
end
