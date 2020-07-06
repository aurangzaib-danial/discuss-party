class SiteController < ApplicationController
  def home
    load_topics
  end

  def search
    @query = params[:q]
    if @query.present?
      load_topics(Topic.search(@query))
    else
      @topics, @topics_scope = [], []
    end
  end
end
