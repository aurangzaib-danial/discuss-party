module UsersHelper
  def short_user_name(user)
    truncate user.name, length: 10
  end

  def user_no_topic_message(guest, current)
    if current == guest
      message = 'You have not created a public topic yet.'
      path = new_topic_path
    else
      message = "#{guest.name.titlecase} has not created a public topic yet."
      path = root_path
    end

    no_content_message(message, path)
  end
end
