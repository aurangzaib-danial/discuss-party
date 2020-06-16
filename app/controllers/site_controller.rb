class SiteController < ApplicationController
  def home
    @topics = Topic.by_created_at(:desc).includes(:user, :tags)
  end
end
