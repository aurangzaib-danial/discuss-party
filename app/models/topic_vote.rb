class TopicVote < ApplicationRecord
  belongs_to :topic
  belongs_to :user

  enum vote: { like: 0, dislike: 1}
end
