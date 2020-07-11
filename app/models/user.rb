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
      auth_info = auth_hash[:info]
      user = find_or_create_by(email: auth_info[:email]) do |user|
        user.name = auth_info[:name]
        user.password = Devise.friendly_token[0, 20]
        attach_image_from_provider(user, image_url: auth_info[:image])
      end

      create_user_oauth_identity(user, auth_hash[:provider], auth_hash[:uid])
      user
    end

    def attach_image_from_provider(user, image_url:)
      user.display_picture.attach(
        AttachmentFromInternet.for_active_storage(image_url)
      )
    end

    def create_user_oauth_identity(user, provider, uid)
      unless user.oauth_identities.exists?(provider: provider)
        user.oauth_identities.create(provider: provider, uid: uid)
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

end
