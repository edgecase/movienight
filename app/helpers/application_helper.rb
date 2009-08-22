module ApplicationHelper
  def flash_div(*keys)
    return '' if keys.nil? or keys.empty?
  
    flash_info = keys.collect { |key| 
      content_tag(:div, 
        flash[key], :id => "flash_#{key}") if flash[key] 
    }.join
    
    flash_info
  end

  def body_classes
    classes = "#{params[:controller]} #{params[:action]}"
    classes << ' login_or_signup' if ((params[:controller] == 'sessions' && params[:action] == 'new') || (params[:controller] == 'users' && params[:action] == 'new'))
    classes
  end
end
