class Topic < ApplicationRecord
  belongs_to :user
  has_many :topic_tags
  has_many :tags, through: :topic_tags
end
