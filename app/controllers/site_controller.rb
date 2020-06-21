class SiteController < ApplicationController
  def home
    @topics = Topic.includes(:user, :tags)
  end

  def search
    @query = params[:q]
    @topics = Topic.search(@query)
  end
end
