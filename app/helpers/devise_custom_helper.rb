module DeviseCustomHelper
  def custom_devise_link(text, path)
    link_to text, path, class: 'btn btn-lg btn-primary btn-block'
  end

  def social_link(provider)
    site = provider
    site = site.gsub('_oauth2', '') if site == 'google_oauth2'

    url = send("user_#{provider}_omniauth_authorize_path")

    link_text = "Sign in with #{site.capitalize}"

    link_class = "btn btn-lg btn-block btn-social btn-#{site}"

    span_class = "fab fa-#{site}"

    link_to(url, class: link_class) do
      content_tag(:span, nil, class: span_class) << link_text
    end
  end
end
