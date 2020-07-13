module ApplicationHelper

  def heading(text)
    content_for :heading, text
  end

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
    path ? link_to(message, path) : message
  end

  def sort_link(sort_type)
    link_to sort_type, sort_link_path(sort_type),
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

  def sort_link_path(sort_type)
    request.path << query_parameter(sort_type)
  end

  def created_at_in_words(object)
    distance_of_time_in_words_to_now(object.created_at) + ' ago'
  end

  private
  def query_parameter(sort_type)
    if sort_type == :latest
      search_param ? "?#{search_param}" : ''
    else
      query = "?"
      query << "#{search_param}&" if search_param
      query << "view=#{sort_type}"
    end
  end

  def explicits_not_present?(explicits)
    params[:view].nil? || !params[:view].in?(explicits)
  end

  def search_param
    "q=#{params[:q]}" if request.path == '/search' && params[:q].present?
  end

  def field_class(object, attribute)
    "form-control #{ 'is-invalid' if object.errors[attribute].any? }"
  end

end
