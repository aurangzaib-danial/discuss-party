class TopicVote < ApplicationRecord
  belongs_to :topic
  belongs_to :user
  validates_presence_of :vote
  enum vote: { like: 0, dislike: 1}
end
