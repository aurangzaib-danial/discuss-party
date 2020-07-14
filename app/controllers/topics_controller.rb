class TopicsController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_topic, except: %i[new create]
  before_action :topic_is_private?, only: :sharing
  before_action :authorize_action, except: %i[new create]

  def new
    @topic = Topic.new
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
    @comments = @topic.comments_for_display(params[:page])
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.creator_id = current_user_id
    if @topic.save
      redirect_to topic_slug_path(@topic.id, @topic.slug)
    else
      render :new
    end
  end

  def vote
    @topic.vote(current_user_id, params[:vote])
    redirect_to request.referer
  end

  def sharing
    @viewer = Viewer.new
    @topic.viewers_with_users.load
  end

  def destroy
    @topic.delete
    redirect_to(user_slug_path(current_user.id, current_user.slug), 
      notice: 'Successfully deleted.')
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
