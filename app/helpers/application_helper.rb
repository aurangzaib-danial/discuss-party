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

  def sort_link(sort_type)
    link_to sort_type, root_path(query_parameter(sort_type)),
      class: "nav-item nav-link text-capitalize #{current_sort_class?(sort_type)}" 
  end

  def current_sort_class?(sort_type)
    explicits = %w(popular oldest)
    
    if params[:view].in?(explicits) && params[:view] == sort_type.to_s
      'active'
    elsif explicits_not_present?(explicits) && sort_type == :latest
      'active'
    end
  end

  private
  def query_parameter(sort_type)
    {view: sort_type} unless sort_type == :latest
  end

  def explicits_not_present?(explicits)
    params[:view].nil? || !params[:view].in?(explicits)
  end

end
