class Topic < ApplicationRecord
  belongs_to :user
  has_many :topic_tags, dependent: :delete_all
  has_many :tags, through: :topic_tags
  has_many :comments, dependent: :delete_all
  has_many :topic_votes, dependent: :delete_all

  enum visibility: { public: 0, private: 1 }, _prefix: true

  strip_attributes only: :title

  validates_length_of :title, in: 5..70

  validates_length_of :description, minimum: 20
  validate :has_at_least_one_tag
  slug_for :title

  scope :by_created_at, ->(order_type) { order(created_at: order_type) }
  scope :latest, -> { by_created_at(:desc) }
  scope :oldest, -> { by_created_at(:asc) }

  class << self
    def search(query)
      query.present? ? where(case_insensitive_clause(query)) : []
    end

    def popular
      # joins(<<-SQL).
      #   LEFT JOIN topic_votes
      #   ON topics.id = topic_votes.topic_id
      #   AND topic_votes.vote = 0
      # SQL
      # group(:id).
      # order(topic_votes[:vote].count.desc)

      left_joins_topic_votes_by_likes.
      group(:id).
      order(topic_votes[:vote].count.desc)
    end

    def includes_vote_count
      left_joins(:topic_votes).
      select(topics[Arel.star]).
      select(count_likes).
      select(count_dislikes).
      group(:id)
    end

    def count_likes
      count_with_case(:like)
    end

    def count_dislikes
      count_with_case(:dislike)
    end

    private
    def case_insensitive_clause(query)
      arel_table[:title].lower.matches("%#{query.downcase}%")
    end

    def topic_votes
      TopicVote.arel_table
    end

    def topics
      arel_table
    end

    def left_joins_topic_votes_by_likes
      topic_and_votes = topics.join(topic_votes, Arel::Nodes::OuterJoin).
             on(
                topics[:id].eq(topic_votes[:topic_id]).
                and(topic_votes[:vote].eq(:like))
              ).
             join_sources
      joins(topic_and_votes)
    end

    def count_with_case(type)
      Arel::Nodes::Case.new.
      when(topic_votes[:vote].eq(type)).then(1).
      else(0).
      sum.
      as("#{type}_count")
    end
  end

  def has_at_least_one_tag
    if topic_tags.size < 1
      errors.add(:tags, 'must be at least one.')
    end
  end

  def comments_by_updated_at
    comments.order(updated_at: :desc)
  end

  def vote(current_user, vote_type)
    raise ActiveRecord::AssociationTypeMismatch, "expected instance of #{User} got instance of #{current_user.class}" unless current_user.class == User
    
    if has_voted?(current_user)
      update_vote(vote_type)
    else
      topic_votes.create(user: current_user, vote: vote_type)
    end
  end

  def liked?(current_user)
    has_voted?(current_user) && @current_user_vote.like? if current_user
  end

  def disliked?(current_user)
    has_voted?(current_user) && @current_user_vote.dislike? if current_user
  end
  
  def likes
    @likes = try(:like_count)
    vote_count if @likes.nil?
    @likes
  end
  # like_count and dislike_count 
  # are set by temporary fields feteched through SQL
  def dislikes
    @dislikes = try(:dislike_count)
    vote_count if @dislikes.nil?
    @dislikes
  end

  def vote_count
    counts = topic_votes.pluck(
        self.class.count_likes,
        self.class.count_dislikes
      ).flatten
    
    result = (counts == [nil, nil] ? [0, 0] : counts)

    @likes, @dislikes = result
  end

  private
  def update_vote(vote_type)
    if @current_user_vote.vote == vote_type.to_s
      @current_user_vote.delete
    else
      @current_user_vote.update(vote: vote_type)
    end
  end

  def has_voted?(current_user)
    topic_vote = topic_votes.find_by(user: current_user)
    @current_user_vote = topic_vote if topic_vote
  end

end
