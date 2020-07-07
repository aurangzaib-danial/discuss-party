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
    @topics_scope = scope.where(visibility: visibility)
    page_out_of_range?
    @topics = scope.for_list_view(
      order_type: params[:view], 
      current_user: current_user, 
      visibility: visibility, 
      page_number: params[:page]
    )
  end

  def page_out_of_range?
    params[:page] = 1 if @topics_scope.page(params[:page]).out_of_range?
  end

  def topic_is_private?
    unless @topic.visibility_private?
      redirect_to topic_slug_path(@topic.id, @topic.slug)
    end
  end

  def current_user_id
    session['warden.user.user.key'].try(:flatten).try(:first)
  end
 
end
