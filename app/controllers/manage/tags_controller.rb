class Manage::TagsController < Manage::ManagementController
  before_action :set_tag, only: %i[edit destroy update]
  before_action :authorize_action, only: %i[edit destroy update]

  def index
    @tags = Tag.alphabetically
    authorize @tags
  end

  def new
    @tag = Tag.new
    authorize @tag
  end

  def create
    @tag = Tag.new(tag_params)
    authorize @tag
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
    params.require(:tag).permit(:name, :text_color, :background_color)
  end

  def set_tag
    @tag = Tag.friendly.find(params[:id])
  end

  def authorize_action
    authorize @tag
  end
end
