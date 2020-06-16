require 'rails_helper'

RSpec.describe Topic, type: :model do
  it { should have_db_column(:title) }
  it { should have_db_column(:description) }
  it { should have_db_column(:visibility) }
  it { should belong_to(:user)}
  it { should have_many(:topic_tags) }
  it { should have_many(:tags).through(:topic_tags) }
  it { should have_many(:comments) }
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
  end
end
