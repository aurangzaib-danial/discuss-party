module User::InstanceMethods
  def downcase_name
    name.downcase!
  end

  def private_topics
    topics.visibility_private
  end

  def guest?
    !persisted?
  end
  
  def test_attachment?
    @test_attachment == false ? false : true
  end

  def delete_display_picture
    display_picture.purge_later
  end

  def valid_moderator?
    !errors[:moderator].any?
  end

  def blockable?
    !errors[:block_error].any?
  end

  def staff?
    moderator? || admin?
  end

  def name_titlecase
    name.titlecase
  end
end
