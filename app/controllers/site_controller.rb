class SiteController < ApplicationController
  def home
    @topics = Topic.includes(:user, :tags)
    if params[:view] == 'oldest'
      @topics = @topics.oldest
    else
      @topics = @topics.latest
    end
  end

  def search
    @query = params[:q]
    @topics = Topic.search(@query)
  end
end
