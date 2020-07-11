class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  before_action :auth_login

  def github
  end

  def google_oauth2
  end

  def facebook
  end

  def twitter
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

  def auth_login
    if auth_hash
      @user = User.find_or_create_from_auth_hash(auth_hash)
      sign_in_and_redirect(@user)
    end
  end

end
