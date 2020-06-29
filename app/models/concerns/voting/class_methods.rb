module Voting::ClassMethods
  def for_list_view(order_type, current_user)
    topics = includes_vote_count.
    add_order(order_type).
    includes(:user, :tags)
    
    find_votes_for(topics, current_user)
  end

  def add_order(order_type)
    case order_type
    when 'oldest'
      oldest
    when 'popular'
      popular
    else
      latest
    end
  end

  def find_votes_for(topics, current_user)
    # this method exists for solving the problem of N+1 queries
    # when we can to check if a user has voted on topics or not.
    topics.load
    return topics if current_user.nil?
    votes = current_user.topic_votes.where(topic: topics.ids)
    assign_votes(topics, votes)
  end

  def assign_votes(topics, votes)
    topics.each do |topic|
      topic.vote_checked = true
      find_and_assign_vote(topic, votes) if votes.present?
    end
  end

  def find_and_assign_vote(topic, votes)
    vote = votes.detect {|vote| vote.topic_id == topic.id }
    topic.current_user_vote = vote
  end

  def popular
    includes_vote_count.order('like_count DESC')
  end

  def includes_vote_count
    left_joins(:topic_votes).
    select(topics[Arel.star]).
    select(count_likes).
    select(count_dislikes).
    group(:id)
  end

  def count_likes
    count_with_case_statements(:like)
  end

  def count_dislikes
    count_with_case_statements(:dislike)
  end

  def count_with_case_statements(type)
    Arel::Nodes::Case.new.
    when(topic_votes[:vote].eq(type)).then(1).
    else(0).
    sum.
    as("#{type}_count")
  end

  def self.extended(base)
    base.private_class_method :count_with_case_statements
  end
end
