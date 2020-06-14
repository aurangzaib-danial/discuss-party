class SiteController < ApplicationController
  def home
    @topics = Topic.includes(:user, :tags)
  end
end
