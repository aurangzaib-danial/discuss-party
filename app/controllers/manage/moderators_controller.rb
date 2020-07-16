class Manage::ModeratorsController < Manage::ManagementController
  def index
    @moderators = User.moderator
  end

  def new
    @moderator = User.new(role: 'moderator')
  end
end
