class TagsController < ApplicationController
  before_action :set_tag, only: :show
  
  def show
    load_topics(@tag)
  end

  private
  def set_tag
    @tag = Tag.find_by_slug(params[:slug])
  end
end
