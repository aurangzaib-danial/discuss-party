class TopicsController < ApplicationController
  before_action :authenticate_user!, only: :new
  before_action :set_topic, only: :show

  def new
    @topic = Topic.new
    @tags = Tag.all
  end

  def show
  end

  private
  def set_topic
    @topic = Topic.find(params[:id])
  end
end
