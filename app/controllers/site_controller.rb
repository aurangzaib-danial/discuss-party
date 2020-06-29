class SiteController < ApplicationController
  def home
    load_topics
  end

  def search
    @query = params[:q]
    @topics = Topic.search(@query)
  end
end
