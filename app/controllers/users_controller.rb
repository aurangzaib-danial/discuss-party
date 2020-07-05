class UsersController < ApplicationController
  before_action :authenticate_user!, except: :profile
  before_action :set_user, only: :profile
  
  def profile
    load_topics(@user.topics)
  end

  def private
    load_topics(current_user.topics, :private)
  end

  def shared_with_me
    load_topics(current_user.shared_topics, :private)
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end
