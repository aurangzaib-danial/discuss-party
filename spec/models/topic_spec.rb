require 'rails_helper'

RSpec.describe Topic, type: :model do
  it { should have_db_column(:title) }
  it { should have_db_column(:description) }
  it { should have_db_column(:visibility) }
  it { should belong_to(:creator).class_name('User')}
  it { should have_many(:topic_tags).dependent(:delete_all) }
  it { should have_many(:tags).through(:topic_tags) }
  it { should have_many(:comments).dependent(:delete_all) }
  it { should have_many(:topic_votes).dependent(:delete_all) }
  it { should have_many(:viewers).dependent(:delete_all) }
  it { should have_many(:private_viewers).through(:viewers).source(:user) }

  it do 
    should define_enum_for(:visibility).
      with_values(public: 0, private: 1).
      with_prefix(:visibility)
  end

  describe 'validations' do
    it { should strip_attribute :title }
    it { should validate_length_of(:title).is_at_least(5).is_at_most(70)}
    it 'title must have atleast a letter or a number' do
      should_not allow_value('$$$$$$$$').for(:title).with_message('must have atleast a letter or a number')
      should allow_value('$$$$$$$$$a').for(:title)
      should allow_value('$$$$$$$$$1').for(:title)
    end
    it { should validate_presence_of(:description)}
    
    it 'should have at least one tag associated with it' do
      topic = build(:topic)
      topic.topic_tags = []
      expect(topic).not_to be_valid
    end
  end

  describe '#slug' do
    it 'should return the slugified version of topic' do
      topic = build(:topic)
      topic.title = "This is good. So$is this."
      expect(topic.slug).to eq('this-is-good-so-is-this')
    end
  end

  describe '.search' do
    it 'returns topics when given a query' do
      topic_1 = create(:topic, title: 'this is a Topic full of awesomeness')
      topic_2 = create(:topic, title: 'this is another topic full of pakistan')

      expect(Topic.search('topic full of')).to include(topic_1, topic_2)
    end
  end

  describe '#vote' do
    let(:user) { create(:user) }
    let(:topic) { create(:topic) }

    context 'vote(:like)' do
      it 'creates a like for the topic' do
        topic.vote(user, :like)
        topic_vote = TopicVote.find_by(user: user, topic: topic)
        expect(topic_vote).to be_like
      end

      it 'liking again a topic that is already liked removes vote' do
        TopicVote.create(user: user, topic: topic, vote: :like)
        topic.vote(user, :like)
        topic_vote = TopicVote.find_by(user: user, topic: topic)
        expect(topic_vote).to be_nil
      end

      it 'if vote is dislike previously then its updated to like' do
        TopicVote.create(user: user, topic: topic, vote: :dislike)
        topic.vote(user, :like)
        topic_vote = TopicVote.find_by(user: user, topic: topic)
        expect(topic_vote).to be_like
      end
    end

    context 'vote(:dislike)' do
      it 'creates a dislike for the topic' do
        topic.vote(user, :dislike)
        topic_vote = TopicVote.find_by(user: user, topic: topic)
        expect(topic_vote).to be_dislike
      end

      it 'disliking again a topic that is already liked removes vote' do
        TopicVote.create(user: user, topic: topic, vote: :dislike)
        topic.vote(user, :dislike)
        topic_vote = TopicVote.find_by(user: user, topic: topic)
        expect(topic_vote).to be_nil
      end

      it 'if vote is like previously then its updated to dislike' do
        TopicVote.create(user: user, topic: topic, vote: :like)
        topic.vote(user, :dislike)
        topic_vote = TopicVote.find_by(user: user, topic: topic)
        expect(topic_vote).to be_dislike
      end
    end

    context 'vote errors' do
      it 'raises error if the user argument is of wrong class' do
        expect{topic.vote('User', :like)}.to raise_error(ActiveRecord::AssociationTypeMismatch)
      end
    end
  end

  describe '#liked and #disliked' do
    let(:user) { create(:user) }
    let(:topic) { create(:topic)}

    describe '#liked' do
      it '#liked returns true if the user likes a topic' do
        topic.vote(user, :like)
        expect(topic.liked_by?(user)).to be_truthy
      end

      it '#liked returns false if the user dislikes a topic' do
        topic.vote(user, :dislike)
        expect(topic.liked_by?(user)).to be_falsey
      end

      it '#liked returns false if the user has not liked' do
        expect(topic.liked_by?(user)).to be_falsey
      end
    end

    describe '#disliked' do
      it '#disliked returns true if the user dislikes a topic' do
        topic.vote(user, :dislike)
        expect(topic.disliked_by?(user)).to be_truthy
      end

      it '#disliked returns false if the user likes a topic' do
        topic.vote(user, :like)
        expect(topic.disliked_by?(user)).to be_falsey
      end

      it '#disliked returns false if the user has not disliked' do
        expect(topic.disliked_by?(user)).to be_falsey
      end
    end
  end

  it '.includes_vote_count returns all the topics with their vote counts' do
    user_1 = create(:user)
    user_2 = create(:user)
    3.times do |index|
      topic = create(:topic)
      topic.vote(topic.creator, :like)
      topic.vote(user_1, :dislike)
      topic.vote(user_2, :dislike) if index == 1
      topic.vote(user_2, :like) if index == 2
    end

    last_topic = create(:topic)

    topics = Topic.includes_vote_count
    expect(topics.first.likes).to eq(1)
    expect(topics.second.dislikes).to eq(2)
    expect(topics.third.likes).to eq(2)
    expect(topics.last).to eq(last_topic)
  end

  describe 'vote count' do
    let(:topic) { create(:topic) }
    it '#likes' do
      5.times do
        topic.vote(create(:user), :like)
      end
      expect(topic.likes).to eq(5)
    end

    it '#dislikes' do
      3.times do
        topic.vote(create(:user), :dislike)
      end
      expect(topic.dislikes).to eq(3)
    end

    it '#likes and #dislikes return 0 if no vote' do
      expect(topic.likes).to eq(0)
      expect(topic.dislikes).to eq(0)
    end
  end

  describe 'Class Scopes' do
    it '.latest returns latest topics' do
      topic_1 = create(:topic, created_at: 2.day.ago)
      topic_2 = create(:topic, created_at: 1.day.ago)

      expect(Topic.latest).to eq([topic_2, topic_1])
    end

    it '.oldest returns oldest topics' do
      topic_1 = create(:topic, created_at: 1.day.ago)
      topic_2 = create(:topic, created_at: 2.day.ago)

      expect(Topic.oldest).to eq([topic_2, topic_1])
    end

    it '.popular returns topics by popularity' do
      topics = 3.times.collect { create(:topic) }
      topics.each.with_index(1) do |topic, index|
        topic.vote(topic.creator, :like) if index == 2 || index == 3
        topic.vote(create(:user), :like) if index == 2
      end
      expect(Topic.popular).to eq([topics.second, topics.third, topics.first])
    end
  end

  it 'changing private to public topic removes all viewers' do
    topic = create(:topic, visibility: :private)
    user_1 = create(:user)
    user_2 = create(:user)
    topic.viewers.create(user: user_1)
    topic.viewers.create(user: user_2)

    topic.update(visibility: :public)
    expect(topic.private_viewers).to be_empty
  end

end



