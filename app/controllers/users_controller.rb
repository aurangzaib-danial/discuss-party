class UsersController < ApplicationController
  def profile
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end
