class CommentsController < ApplicationController
  before_action :set_topic
  def create
    @comment = Comment.new(comment_params)
    @comment.topic = @topic
    @comment.user = current_user
    
    if @comment.save
      redirect_to topic_slug_path(@topic.slug, @topic.id)
    else
      render 'topics/show'
    end
  end

  private
  def set_topic
    @topic = Topic.find(params[:topic_id])
  end
  def comment_params
    params.require(:comment).permit(:content)
  end
end
