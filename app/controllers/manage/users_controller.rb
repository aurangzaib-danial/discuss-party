class Manage::UsersController < Manage::ManagementController
  before_action :is_user_staff_memeber?

  def index
    @blocked_users = User.blocked.order(:id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.block_user_by_id(params[:id], current_user)
    if @user.blockable?
      @user.save
      redirect_to manage_users_path, notice: 'Successfully blocked user.'
    else
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    flash_type = 'alert'

    if !@user.blocked?
      message = "User is not blocked"
    elsif @user.admin?
      message = "Can't perform this action on an admin"
    elsif @user.moderator? && current_user.moderator?
      message = "You cannot unblock a moderator"
    else
      @user.active!
      flash_type = 'notice'
      message = "Successfully unblocked."
    end

    redirect_to manage_users_path, "#{flash_type}": message
  end
end

# policy scope for users
# do not let blocked users sign in
