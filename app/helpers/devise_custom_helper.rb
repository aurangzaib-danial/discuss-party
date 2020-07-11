module DeviseCustomHelper
  def custom_devise_link(text, path)
    link_to text, path, class: 'btn btn-lg btn-primary btn-block'
  end
end
