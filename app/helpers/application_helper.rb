module ApplicationHelper
  def nav_li(text, path, url_options = {})
    content_tag :li, class: 'nav-item' do
      link_to text, path, {class: 'nav-link'}.merge(url_options)
    end
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
end
