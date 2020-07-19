module User::ClassMethods
  def find_or_create_from_auth_hash(auth_hash)
    info = auth_hash[:info]
    
    user = find_by_email(info[:email]) || create_with_job(info)

    create_user_oauth_identity(user, auth_hash[:provider], auth_hash[:uid])

    user
  end

  def create_user_oauth_identity(user, provider, uid)
    unless user.oauth_identities.exists?(provider: provider)
      user.oauth_identities.create(provider: provider, uid: uid)
    end
  end

  def create_with_job(info)
    user = self.new(email: info[:email], name: info[:name])
    user.password = Devise.friendly_token[0, 20]
    user.skip_confirmation!
    user.save
    UserAttachmentJob.perform_later(user, info[:image])
    user
  end

  def make_mod_by_email(email)
    (User.find_by_email(email) || User.new).tap do |user|
      if user.persisted?
        make_moderator(user)
      else
        add_mod_error(user, "Couldn't find user with that email")
      end
    end
  end

  def block_user_by_id(id, current_user)
    (User.find_by_id(id) || User.new).tap do |user|
      if user.persisted?
        block_user(user, current_user)
      else
        add_block_error(user, "Couldn't find user with that id")
      end
    end
  end

  private
  def add_mod_error(user, message)
    user.errors.add(:moderator, message)
  end

  def make_moderator(user)
    if user.admin?
      add_mod_error(user, "Can't make an admin a moderator")
    elsif user.moderator?
      add_mod_error(user, 'This user is already a moderator')
    else
      user.role = 'moderator'
    end
  end

  def block_user(user, current_user)
    if user.blocked?
      add_block_error(user, 'This user is already blocked')
    elsif user.admin?
      add_block_error(user, "Can't block an admin")
    elsif user.moderator? && current_user.moderator?
      add_block_error(user, "Can't block a moderator")
    else
      user.status = 'blocked'
    end
  end

  def add_block_error(user, message)
    user.errors.add(:block_error, message)
  end
end
