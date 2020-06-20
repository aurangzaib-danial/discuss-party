class TopicsController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_topic, only: [:show, :vote]

  def new
    @topic = Topic.new
  end

  def show
    @comment = Comment.new if user_signed_in?
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user = current_user
    if @topic.save
      redirect_to topic_slug_path(@topic.id, @topic.slug)
    else
      render :new
    end
  end

  def vote
    @topic.vote(current_user, params[:vote])
    redirect_to topic_slug_path(@topic.id, @topic.slug)
  end

  private
  def set_topic
    @topic = Topic.find(params[:id])
  end
  def topic_params
    params.require(:topic).permit(:title, :description, :visibility, tag_ids: [])
  end
end
