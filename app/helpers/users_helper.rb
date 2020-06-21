module UsersHelper
  def short_user_name(user)
    user.name.length <= 10 ? user.name : (user.name[0..9] + '...')
  end
end
