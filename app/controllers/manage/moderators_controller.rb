class Manage::ModeratorsController < Manage::ManagementController
  before_action :user_is_admin?

  def index
    @moderators = User.moderator
  end

  def new
    @moderator = User.new
  end

  def create
    @moderator = User.make_mod_by_email(params[:email])
    if @moderator.valid_moderator?
      @moderator.save
      redirect_to manage_moderators_path, notice: 'Successfully created moderator.'
    else
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.moderator?
      @user.normal_user!
      message = {notice: 'Successfully removed moderator.'}
    else
      message = {alert: 'Provided ID was not of a moderator.'}
    end
    redirect_to manage_moderators_path, message
  end

  private
  def user_is_admin?
    unless current_user.admin?
      redirect_to root_path, alert: 'Only admins are allowed to manage moderators.'
    end
  end
end
