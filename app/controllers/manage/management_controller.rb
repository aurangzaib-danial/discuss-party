class Manage::ManagementController < ApplicationController
  before_action :authenticate_user!

  def moderators
    @moderators = User.moderator
  end
end
