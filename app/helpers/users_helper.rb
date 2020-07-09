module UsersHelper

  def short_user_name(user)
    name = truncate user.name, length: 30
    content_tag :span, name, class: 'short_name'
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

  def small_thumbnail(user)
    make_thumbnail(user, width: 50, height: 50)
  end

  private
  def make_thumbnail(user, width:, height:)
    image_tag asset_path('sunny.jpeg'), class: 'rounded_thumbnail', width: width, height: height
  end
end
