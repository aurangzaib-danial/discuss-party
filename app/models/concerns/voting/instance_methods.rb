module Voting::InstanceMethods
  def self.included(base)
    base.attr_accessor :current_user_vote
    base.attr_accessor :vote_checked
  end

  def vote(current_user, vote_type)
    test_argument(current_user)
    
    if has_voted?(current_user)
      update_vote(vote_type)
    else
      topic_votes.create(by_user_or_its_id?(current_user).merge(vote: vote_type))
    end
  end

  def liked_by?(current_user)
    has_voted?(current_user) && current_user_vote.like? if current_user
  end

  def disliked_by?(current_user)
    has_voted?(current_user) && current_user_vote.dislike? if current_user
  end
  
  def likes
    @likes = try(:like_count) if @likes.nil?
    vote_count if @likes.nil?
    @likes
  end
  # like_count and dislike_count 
  # are set by temporary fields feteched through SQL
  def dislikes
    @dislikes = try(:dislike_count) if @dislikes.nil?
    vote_count if @dislikes.nil?
    @dislikes
  end

  private
  def update_vote(vote_type)
    if current_user_vote.vote == vote_type.to_s
      current_user_vote.delete
    else
      current_user_vote.update(vote: vote_type)
    end
  end

  def has_voted?(current_user)
    # vote checked is assigned when votes for multiple topics are checked for a user
    return current_user_vote if vote_checked
    
    topic_vote = topic_votes.find_by(by_user_or_its_id?(current_user))
    self.current_user_vote = topic_vote if topic_vote
  end

  def vote_count
    counts = topic_votes.pluck(
        self.class.count_likes,
        self.class.count_dislikes
      ).flatten
    
    result = (counts == [nil, nil] ? [0, 0] : counts)

    @likes, @dislikes = result
  end

  def by_user_or_its_id?(current_user)      
    current_user.class == User ? {user: current_user} : {user_id: current_user}
  end

  def test_argument(user)
    unless user.class.in?([User, Integer])
      raise(ActiveRecord::AssociationTypeMismatch, 
        "expected instance of #{User} or #{Integer} got instance of #{user.class}") 
    end
  end
end
