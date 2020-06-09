class Tag < ApplicationRecord
  has_many :topic_tags
  has_many :topics, through: :topic_tags
end
