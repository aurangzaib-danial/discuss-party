module Voting::ClassMethods
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
