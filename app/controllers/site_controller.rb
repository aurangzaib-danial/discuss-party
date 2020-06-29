class SiteController < ApplicationController
  def home
    load_topics
  end

  def search
    @query = params[:q]
    load_topics(Topic.search(@query))
  end
end
