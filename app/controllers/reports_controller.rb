class ReportsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    topic = Topic.find(params[:topic_id])
    report = topic.reports.build

    authorize report, :create?

    report.user_id = current_user_id
    report.report_type = params[:report][:report_type]
    report.save
    redirect_to root_path, flash: { report_message: report_message }
  end
  private
  def report_message
    <<-TEXT
    Thanks for the report. 
    We will look into it and take appropriate action. 
    Meanwhile, this topic will not be shown in your feed.
    TEXT
  end
end
