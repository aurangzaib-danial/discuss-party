class Manage::TopicsController < Manage::ManagementController
  def index
    @reported_topics = Topic.reported_topics
  end
end
