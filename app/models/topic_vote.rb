class TopicVote < ApplicationRecord
  belongs_to :topic
  belongs_to :user
  validates_uniqueness_of :topic_id, scope: :user_id
  validates_presence_of :vote
  enum vote: { like: 0, dislike: 1}

  def self.topic_votes
    TopicVote.arel_table
  end
  
  
end
