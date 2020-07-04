class ApplicationController < ActionController::Base
  include Pundit
  
  rescue_from Pundit::NotAuthorizedError do
    redirect_to(root_path,
      alert: 'You are not authorized to access this page.')
  end
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  private
  def load_topics(scope = Topic, visibility = :public)
    @topics = scope.for_list_view(params[:view], current_user, visibility)
  end

  def topic_is_private?
    if @topic.visibility_private?
      redirect_to topic_slug_path(@topic.id, @topic.slug)
    end
  end
 
end
