class Manage::TagsController < Manage::ManagementController
  
  def index
    @tags = Tag.all
  end
end
