class Manage::TopicsController < Manage::ManagementController
  before_action :is_user_staff_memeber?
  
  def index
    @reported_topics = Topic.reported_topics
  end
end
