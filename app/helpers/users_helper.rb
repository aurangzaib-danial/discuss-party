module UsersHelper

  def short_user_name(user)
    name = truncate user.name, length: 30
    content_tag :span, name, class: 'short_name'
  end

  def back_path_for_user(user)
    unless user.name.present?
      user.name = user.name_change.first
      user_slug_path(user.id, user.name)
    else
      user_slug_path(user.id, user.name)
    end
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

  def user_link(user, klass = 'user-link')
    link_to user_slug_path(user.id, user.slug), class: "#{klass} text-capitalize", &Proc.new
  end

  def user_thumbnail_and_name(user)
    user_link(user) do
      (small_thumbnail(user) + user.name).html_safe
    end
  end

  private
  def make_thumbnail(user, width:, height:)
    return '' unless user.display_picture.attached?
    
    attachment = @attachment || user.display_picture 

    image_tag attachment.variant(resize_to_limit: [width, height]), class: 'rounded-thumbnail'
  end
end
