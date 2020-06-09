class TopicsController < ApplicationController
  before_action :authenticate_user!
  def new
    @topic = Topic.new
  end
end
