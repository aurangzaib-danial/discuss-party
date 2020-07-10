class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :load_attachment, only: %i[edit update]

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name display_picture])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name display_picture])
  end
  
  def update_resource(resource, params)
    test_display_picture?(resource, params)
    if (params[:password].blank? && 
        params[:password_confirmation].blank? &&
        params[:current_password].blank?)
      params.delete(:current_password)
      resource.update_without_password(params)
    else
      resource.update_with_password(params)
    end
  end

  def test_display_picture?(resource, params)
    if params[:display_picture].blank?
      resource.test_attachment = false
    end
  end

  def load_attachment
    @attachment = ActiveStorage::Attachment.find_by(record_id: current_user_id)
  end
end
