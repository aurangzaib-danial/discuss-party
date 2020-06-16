class Topic < ApplicationRecord
  belongs_to :user
  has_many :topic_tags
  has_many :tags, through: :topic_tags
  has_many :comments

  enum visibility: { public: 0, private: 1 }, _prefix: true

  strip_attributes only: :title

  validates_length_of :title, in: 5..70
  validates_length_of :description, minimum: 20
  validate :has_at_least_one_tag

  scope :by_created_at, ->(type = 'asc') { order(created_at: type) }

  def self.search(query)
    where('title ILIKE ?', "%#{query}%")
  end

  def has_at_least_one_tag
    if topic_tags.size < 1
      errors.add(:tags, 'must be at least one.')
    end
  end

  def slug
    title.parameterize
  end

  def comments_by_updated_at
    comments.order(updated_at: :desc)
  end
end
