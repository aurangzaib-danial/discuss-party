class Topic < ApplicationRecord
  extend ClassMethods
  extend Voting::ClassMethods
  include InstanceMethods
  include Voting::InstanceMethods

  belongs_to :creator, class_name: 'User'
  has_many :topic_tags, dependent: :delete_all
  has_many :tags, -> { alphabetically }, through: :topic_tags
  has_many :comments, dependent: :delete_all
  has_many :topic_votes, dependent: :delete_all
  has_many :viewers, dependent: :delete_all
  has_many :private_viewers, through: :viewers, source: :user
  has_many :reports, dependent: :delete_all

  has_rich_text :description

  enum visibility: { public: 0, private: 1 }, _prefix: true

  strip_attributes only: :title

  before_save :switched_from_private_to_public?
  before_save :add_description_excerpt

  validates_length_of :title, in: 5..70
  validates_format_of(:title, with: /[a-zA-Z0-9]/, 
    message: 'must have at least a letter or a number')
  validates_presence_of :description
  
  slug_for :title

  scope :by_created_at, ->(order_type) { order(created_at: order_type) }
  scope :latest, -> { by_created_at(:desc) }
  scope :oldest, -> { by_created_at(:asc) }

end
