class SiteController < ApplicationController
  def home
    @topics = Topic.latest.includes(:user, :tags)
  end

  def search
    @query = params[:q]
    @topics = Topic.search(@query)
  end
end
