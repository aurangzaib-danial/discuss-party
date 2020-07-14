class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic, only: :create
  before_action :set_comment, only: :destroy

  def create
    authorize @topic, :comment?
    @comment = Comment.new(comment_params)
    @comment.topic = @topic
    @comment.user_id = current_user_id
    @comment.save
    redirect_to topic_slug_path(@topic.id, @topic.slug)
  end

  def destroy
    authorize @comment
    @comment.destroy
    redirect_to topic_slug_path(@comment.topic.id, @comment.topic.slug), notice: 'Successfully deleted.'
  end

  private
  def set_topic
    @topic = Topic.find(params[:topic_id])
  end
  def set_comment
    @comment = Comment.find(params[:id])
  end
  def comment_params
    params.require(:comment).permit(:content)
  end
end
