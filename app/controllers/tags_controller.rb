class TagsController < ApplicationController
  before_action :set_tag, only: :show
  
  def show
    load_topics(@tag.topics)
  end

  private
  def set_tag
    @tag = Tag.friendly.find(params[:id])
  end
end
