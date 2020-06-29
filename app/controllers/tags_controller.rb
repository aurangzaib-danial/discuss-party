class TagsController < ApplicationController
  before_action :set_tag, only: :show
  
  def show
    @topics = @tag.topics.for_list_view

    if params[:view] == 'oldest'
      @topics = @topics.oldest
    elsif params[:view] == 'popular'
      @topics = @topics.popular
    else
      @topics = @topics.latest
    end

    Topic.find_votes_for(@topics, current_user)
  end

  private
  def set_tag
    @tag = Tag.find_by_slug(params[:slug])
  end
end
