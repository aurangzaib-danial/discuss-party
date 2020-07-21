class Manage::TopicsController < Manage::ManagementController
  before_action :is_user_staff_memeber?

  def index
    @reported_topics = Topic.reported_topics
  end

  def destroy
    topic = Topic.find(params[:id])

    if topic.creator.admin?
      message = {alert: "You cannot delete an admin's topic"}
    elsif topic.reported?
      topic.destroy
      message = {notice: 'Successfully deleted.'}
    else
      message = {alert: 'The topic has not been reported even once.'}
    end
    redirect_to manage_reports_path, message
  end
end
