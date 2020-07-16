class Manage::ManagementController < ApplicationController
  before_action :authenticate_user!
  
  def is_user_staff_memeber?
    unless current_user.staff?
      redirect_to root_path, alert: 'Only staff can access this page.'
    end
  end  
end
