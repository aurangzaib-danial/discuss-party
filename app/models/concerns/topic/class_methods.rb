module Topic::ClassMethods
  def search(query)
    where(case_insensitive_clause(query))
  end

  def for_list_view(order_type:, current_user:, visibility:, page_number:)
    topics = includes_vote_count.
    where(visibility: visibility).
    page(page_number).
    add_order(order_type).
    includes(:tags, creator: {display_picture_attachment: :blob})

    topics = filter_reported(topics, current_user) if current_user

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

  def filter_reported(topics, current_user)
    topics.where.not(id: current_user.reported_topic_ids)
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
