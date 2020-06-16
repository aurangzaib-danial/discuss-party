class SiteController < ApplicationController
  def home
    @topics = Topic.by_created_at(:desc).includes(:user, :tags)
  end

  def search
    @query = params[:q]
    @topics = Topic.search(@query)
  end
end
