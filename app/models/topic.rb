class Topic < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :topic_tags, dependent: :delete_all
  has_many :tags, through: :topic_tags
  has_many :comments, dependent: :delete_all
  has_many :topic_votes, dependent: :delete_all
  has_many :viewers, dependent: :delete_all
  has_many :private_viewers, through: :viewers, source: :user

  has_rich_text :description

  enum visibility: { public: 0, private: 1 }, _prefix: true

  strip_attributes only: :title

  before_save :switched_from_private_to_public?
  before_save :add_description_excerpt

  validates_length_of :title, in: 5..70
  validates_format_of(:title, with: /[a-zA-Z0-9]/, 
    message: 'must have atleast a letter or a number')
  validates_presence_of :description
  validate :has_at_least_one_tag
  
  slug_for :title

  scope :by_created_at, ->(order_type) { order(created_at: order_type) }
  scope :latest, -> { by_created_at(:desc) }
  scope :oldest, -> { by_created_at(:asc) }

  extend Voting::ClassMethods
  include Voting::InstanceMethods

  class << self
    def search(query)
      where(case_insensitive_clause(query))
    end

    private
    def case_insensitive_clause(query)
      topics[:title].matches("%#{query}%")
    end

    def topic_votes
      TopicVote.arel_table
    end

    def topics
      arel_table
    end
  end

  def has_at_least_one_tag
    if topic_tags.size < 1
      errors.add(:tags, 'must be at least one.')
    end
  end

  def comments_by_updated_at
    comments.order(updated_at: :desc)
  end

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

end
