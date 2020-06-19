class TopicVote < ApplicationRecord
  belongs_to :topic
  belongs_to :user
  validates_uniqueness_of :topic_id, scope: :user_id
  enum vote: { like: 0, dislike: 1}
end
