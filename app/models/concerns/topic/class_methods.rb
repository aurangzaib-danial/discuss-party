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

  def reported_topics
    joins(:reports).
    select(topics[Arel.star]).
    select(count_rude).
    select(count_spam).
    select(count_harassment).
    select(count_copyright).
    visibility_public.
    where(reports_count_are_greater_than_zero).
    group(:id).
    order(reports_count: :desc)
  end

  def reported_topics_count
    select(:id).distinct.joins(:reports).visibility_public.count
  end

  def self.extended(base)
    class << base
      private
      %i[rude harassment copyright spam].each do |type|
        define_method "count_#{type}" do
          case_for_reports(type)
        end
      end
    end
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

  def reports_count_are_greater_than_zero
    topics[:reports_count].gt(0)
  end

  def case_for_reports(type)
    Arel::Nodes::Case.new.
    when(reports[:report_type].eq(type)).then(1).
    else(0).
    sum.
    as("#{type}_count")
  end

  def reports
    Report.arel_table
  end
end
