class Manage::ModeratorsController < Manage::ManagementController
  def index
    @moderators = User.moderator
  end

  def new
    @moderator = User.new(role: 'moderator')
  end

  def create
    @moderator = User.make_mod_by_email(params[:email])
    if @moderator.valid_moderator?
      @moderator.save
      redirect_to manage_moderators_path, notice: 'Successfully created moderator.'
    else
      render :new
    end
  end
end
