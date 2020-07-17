module Topic::ClassMethods
  def search(query)
    where(case_insensitive_clause(query))
  end

  private
  def case_insensitive_clause(query)
    topics[:title].matches("%#{query}%")
  end

  def topic_votes
    TopicVote.arel_table
  end

  def topics
    arel_table
  end
end
