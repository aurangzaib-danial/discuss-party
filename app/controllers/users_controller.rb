class UsersController < ApplicationController
  before_action :set_user
  def profile
    load_topics(@user)
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end
