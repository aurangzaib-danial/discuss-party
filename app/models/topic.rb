class Topic < ApplicationRecord
  belongs_to :user
  has_many :topic_tags
  has_many :tags, through: :topic_tags
  enum status: { public: 0, private: 1 }, _prefix: true
end
