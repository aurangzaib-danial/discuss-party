class ViewersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic

  def create
    viewer = @topic.viewers.build(viewer_params)
    if viewer.save
      redirect_to topic_sharing_path(@topic), alert: 'Successfully shared.'
    else
      render 'topics/sharing'
    end
  end

  private
  def set_topic
    @topic = Topic.find(params[:topic_id])
  end

  def viewer_params
    params.require(:viewer).permit(:user_email)
  end
end
