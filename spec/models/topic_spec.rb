require 'rails_helper'

RSpec.describe Topic, type: :model do
  it { should have_db_column(:title) }
  it { should have_db_column(:description) }
  it { should have_db_column(:visibility) }
  it { should belong_to(:user)}
  it { should have_many(:topic_tags).dependent(:delete_all) }
  it { should have_many(:tags).through(:topic_tags) }
  it { should have_many(:comments).dependent(:delete_all) }
  it { should have_many(:topic_votes).dependent(:delete_all) }

  it do 
    should define_enum_for(:visibility).
      with_values(public: 0, private: 1).
      with_prefix(:visibility)
  end

  describe 'validations' do
    it { should strip_attribute :title }
    it { should validate_length_of(:title).is_at_least(5).is_at_most(70)}
    it { should validate_length_of(:description).is_at_least(20)}
    
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

  describe '.by_created_at' do
    it 'takes in the order name and returns the right order' do
      topics = 2.times.collect { create(:topic) }
      expect(Topic.by_created_at(:desc)).to eq([topics.second, topics.first])
    end
  end

  describe '.search' do
    it 'returns topics when give a simple query' do
      topic_1 = create(:topic, title: 'this is a Topic full of awesomeness')
      topic_2 = create(:topic, title: 'this is another topic full of pakistan')

      expect(Topic.search('topic full of')).to include(topic_1, topic_2)
    end

    it 'returns an empty array if the query is empty string or nil' do
      expect(Topic.search(nil)).to eq([])
      expect(Topic.search('')).to eq([])
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
        expect(topic.liked?(user)).to be_truthy
      end

      it '#liked returns false if the user dislikes a topic' do
        topic.vote(user, :dislike)
        expect(topic.liked?(user)).to be_falsey
      end

      it '#liked returns false if the user has not liked' do
        expect(topic.liked?(user)).to be_falsey
      end
    end

    describe '#disliked' do
      it '#disliked returns true if the user dislikes a topic' do
        topic.vote(user, :dislike)
        expect(topic.disliked?(user)).to be_truthy
      end

      it '#disliked returns false if the user likes a topic' do
        topic.vote(user, :like)
        expect(topic.disliked?(user)).to be_falsey
      end

      it '#disliked returns false if the user has not disliked' do
        expect(topic.disliked?(user)).to be_falsey
      end
    end
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
  end
end



