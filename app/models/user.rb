class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :recoverable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: %i(github google_oauth2 facebook twitter)

  has_many :topics, foreign_key: :creator_id, dependent: :delete_all, inverse_of: :creator
  has_many :comments, dependent: :delete_all
  has_many :topic_votes, dependent: :delete_all
  has_many :voted_topics, through: :topic_votes, source: :topic
  has_many :viewers, dependent: :delete_all
  has_many :shared_topics, through: :viewers, source: :topic
  has_many :oauth_identities, dependent: :delete_all

  has_one_attached :display_picture

  enum role: { normal_user: 0, admin: 1, moderator: 2 }
  enum status: { active: 0, blocked: 1 }

  slug_for :name

  validates_presence_of :name
  validates_format_of :name, :with => /\A[^0-9`!@#\$%\^&*+_=]+\z/
  validates_length_of :name, maximum: 50
  validates(:display_picture, 
    content_type: [:png, :jpg, :jpeg], 
    size: { less_than: 10.megabytes , message: 'must be less than 10 mb' },
    if: :test_attachment?
  )
  
  strip_attributes only: :name, collapse_spaces: true

  before_save :downcase_name
  before_destroy :delete_display_picture

  attr_writer :test_attachment

  class << self
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

    def add_block_error(user, message)
      user.errors.add(:block_error, message)
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
  end

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

end
