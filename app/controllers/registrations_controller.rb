class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name display_picture])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name display_picture])
  end
  
  def update_resource(resource, params)
    if (params[:password].blank? && 
        params[:password_confirmation].blank? &&
        params[:current_password].blank?)
      params.delete(:current_password)
      resource.update_without_password(params)
    else
      resource.update_with_password(params)
    end
  end
end
