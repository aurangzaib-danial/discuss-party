class Topic < ApplicationRecord
  belongs_to :user
  has_many :topic_tags
  has_many :tags, through: :topic_tags
  enum visibility: { public: 0, private: 1 }, _prefix: true
  strip_attributes only: :title
  validates_length_of :title, in: 5..70
  validates_format_of :title, without: /[^a-zA-Z\d\s]/
  validates_length_of :description, minimum: 20
end
