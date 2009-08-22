module ApplicationHelper
  def flash_div(*keys)
    return '' if keys.nil? or keys.empty?
  
    flash_info = keys.collect { |key| 
      content_tag(:div, 
        flash[key], :id => "flash_#{key}") if flash[key] 
    }.join
    
    flash_info
  end
end
