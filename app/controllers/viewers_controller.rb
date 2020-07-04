class ViewersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic

  def create
    authorize @topic, :sharing?
    @viewer = @topic.viewers.build(viewer_params)
    if @viewer.save
      redirect_to sharing_topic_path(@topic.id, @topic.slug), notice: 'Successfully shared.'
    else
      render 'topics/sharing'
    end
  end

  def destroy
    authorize @topic, :sharing?
    viewer = @topic.viewers.find(params[:id])
    viewer.delete

    redirect_to sharing_topic_path(@topic.id, @topic.slug), notice: 'Successfully removed access.'
  end

  private
  def set_topic
    @topic = Topic.find(params[:topic_id])
  end

  def viewer_params
    params.require(:viewer).permit(:user_email)
  end
end
