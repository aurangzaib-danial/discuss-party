class ReportsController < ApplicationController
  before_action :authenticate_user!
  def create
    # TODO
    # report the topic and also pundit permissions
    raise params.inspect
  end
end
