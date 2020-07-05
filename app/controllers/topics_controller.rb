class TopicsController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_topic, except: %i[new create]
  before_action :topic_is_private?, only: :sharing
  before_action :authorize_action, except: %i[new create]

  def new
    @topic = Topic.new
  end

  def edit
  end

  def update
    if @topic.update(topic_params)
      redirect_to(topic_slug_path(@topic.id, @topic.slug), 
        notice: 'Updated successfully.')
    else
      render :edit
    end
  end

  def show
    @comment = Comment.new if user_signed_in?
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.creator = current_user
    if @topic.save
      redirect_to topic_slug_path(@topic.id, @topic.slug)
    else
      render :new
    end
  end

  def vote
    @topic.vote(current_user, params[:vote])
    redirect_to request.referer
  end

  def sharing
    @viewer = Viewer.new
    @topic.viewers_with_users.load
  end

  private
  def set_topic
    @topic = Topic.find(params[:id])
  end
  def topic_params
    params.require(:topic).permit(:title, :description, :visibility, tag_ids: [])
  end
  def authorize_action
    authorize @topic
  end
end
