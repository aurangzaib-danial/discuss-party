class TagsController < ApplicationController
  before_action :set_tag, only: :show
  def show
  end

  private
  def set_tag
    @tag = Tag.find_by_slug(params[:slug])
    if @tag.nil?
      raise ActiveRecord::RecordNotFound, 'Cant do it'
    end
  end
end
