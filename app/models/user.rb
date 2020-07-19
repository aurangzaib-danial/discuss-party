class User < ApplicationRecord
  extend ClassMethods
  include InstanceMethods

  devise(:database_authenticatable, :registerable, :rememberable, :validatable,
    :recoverable, :confirmable)
  devise :omniauthable, omniauth_providers: %i(github google_oauth2 facebook twitter)

  has_many :topics, foreign_key: :creator_id, dependent: :delete_all, inverse_of: :creator
  has_many :comments, dependent: :delete_all
  has_many :topic_votes, dependent: :delete_all
  has_many :voted_topics, through: :topic_votes, source: :topic
  has_many :viewers, dependent: :delete_all
  has_many :shared_topics, through: :viewers, source: :topic
  has_many :oauth_identities, dependent: :delete_all
  has_many :reports, dependent: :delete_all
  has_many :reported_topics, through: :reports, source: :topic

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

  def active_for_authentication?
    super and self.active?
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
