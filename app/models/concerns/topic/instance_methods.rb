module Topic::InstanceMethods
  def owner?(user)
    creator_id == user.id
  end

  def viewers_with_users
    viewers.includes(:user)
  end

  def switched_from_private_to_public?
    return unless visibility_changed?
    value_before = visibility_change.first
    value_after = visibility_change.second
    viewers.delete_all if value_before == 'private'
  end

  def add_description_excerpt
    self.description_excerpt = description.to_plain_text.gsub(/\[.*\]/, '')[0..97]
    #remove image captains and limit the number of characters to 97
  end

  def comments_for_display(page_number)
    comments.page(page_number).
    per(15).
    latest.
    with_rich_text_content_and_embeds.
    with_users
  end

  def reading_time
    words_per_minute = 150
    text = description.to_plain_text
    minutes = (text.scan(/\w+/).length / words_per_minute).to_i
    minutes == 0 ? 1 : minutes
  end

  def public_and_not_owned_by?(user)
    visibility_public? and !owner?(user)
  end

  def reported_by?(user_id)
    reports.exists?(user: user_id)
  end
end
