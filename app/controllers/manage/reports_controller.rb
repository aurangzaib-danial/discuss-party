class Manage::ReportsController < ApplicationController
  def index
    @reported_topics = Report.reported_topics
  end
end
