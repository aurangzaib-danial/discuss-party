class TopicsController < ApplicationController
  before_action :authenticate_user!, only: :new
  before_action :set_topic, only: :show

  def new
    @topic = Topic.new
  end

  def show
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user = current_user
    if @topic.save
      redirect_to @topic
    else
      render :new
    end
  end

  private
  def set_topic
    @topic = Topic.find(params[:id])
  end
  def topic_params
    params.require(:topic).permit(:title, :description, :visibility, tag_ids: [])
  end
end
