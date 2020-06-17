module UsersHelper
  def short_user_name(user)
    user.name[0..9] + '...'
  end
end
