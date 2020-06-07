class SiteController < ApplicationController
  def home
  @topics = Topic.all
  end
end
