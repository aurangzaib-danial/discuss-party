module ApplicationHelper
  def nav_li(text, path, url_options = {})
    content_tag :li, class: "nav-item #{current_class?(path)}" do
      link_to path, {class: 'nav-link'}.merge(url_options) do
        link_content = text + ' '
        link_content += content_tag(:span, '(current)', class: 'sr-only') if current_class?(path)
        link_content.html_safe
      end
    end
  end

  def current_class?(test_path)
    'active' if request.path == test_path
  end

  def alert_class(class_name)
    case class_name
    when 'alert'
      class_name = 'danger'
    when 'notice'
      class_name = 'success'
    end
    
    "alert alert-#{class_name} flash-alert"
  end

  def no_content_message(message, path = nil)
    result = content_tag :p, message, class: 'lead'
    result = link_to result, path, class: 'text-info' if path
    result
  end

end
