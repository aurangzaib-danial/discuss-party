module ApplicationHelper
  def nav_li(text, path, url_options = {})
    content_tag :li, class: 'nav-item' do
      link_to text, path, {class: 'nav-link'}.merge(url_options)
    end
  end
end
