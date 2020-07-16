class Manage::UsersController < Manage::ManagementController
  def index
    @blocked_users = User.blocked
  end
end
