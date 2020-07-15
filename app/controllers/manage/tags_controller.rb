class Manage::TagsController < Manage::ManagementController
  before_action :set_tag, only: %i[edit destroy update]
  def index
    @tags = Tag.alphabetically
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to manage_tags_path, notice: 'Successfully created.'
    else
      render :new
    end
  end

  def update
    if @tag.update(tag_params)
      redirect_to manage_tags_path, notice: 'Successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @tag.destroy
    redirect_to manage_tags_path, notice: 'Successfully deleted.'
  end

  private
  def tag_params
    params.require(:tag).permit(:name)
  end

  def set_tag
    @tag = Tag.friendly.find(params[:id])
  end
end
