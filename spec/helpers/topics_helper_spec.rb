require 'rails_helper'

RSpec.describe TopicsHelper, type: :helper do
  let(:topic) { create(:topic) }

  it '#short description returns only 20 characters of description and adds three periods at the end' do
    topic.description = "Some quick example text to build on the card title and make up the bulk of the card's content."
    expect(helper.short_description(topic)[-3..-1]).to eq("...")
    expect(helper.short_description(topic).length).to be >= 23 # 3 chars of dots
  end

  it '#topic_user_name and marks the string html_safe' do
    topic.user.name = 'sunny'
    expect(helper.topic_user_name(topic)).to include(topic.user.name)
    expect(helper.topic_user_name(topic)).to be_html_safe
  end

  it '#topic_information returns topic user\'s name and tag names and marks the string html_safe' do
    topic.created_at = 1.day.ago
    topic.updated_at = 1.day.ago
    topic.user.name = 'sunny'

    expect(helper.topic_information(topic)).to include(topic.user.name)
    expect(helper.topic_information(topic)).to include(topic.tags.first.name)
    expect(helper.topic_information(topic)).to include('1 day ago')

    expect(helper.topic_information(topic)).to be_html_safe
  end

  it '#topic_created_at_in_words' do
    topic = build(:topic, created_at: 1.day.ago, updated_at: 1.day.ago)

    expect(topic_created_at_in_words(topic)).to eq('1 day ago')
  end

  describe 'vote_button accepts topic, vote_type' do
    it 'like and marked' do
        topic.vote(topic.user, :like)
        result = helper.vote_button(topic, topic.user, :like)
        expect(result).to include('like')
        expect(result).to include('thumb-marked')
    end

    it 'dislike but not marked' do
        result = helper.vote_button(topic, topic.user, :dislike)
        expect(result).to include('dislike')
        expect(result).not_to include('thumb-marked')
    end

    describe 'vote_icon' do
      it ':like, false' do
        expect(helper.vote_icon(:like, false)).to include('far fa-thumbs-up')
      end

      it ':like, true' do
        expect(helper.vote_icon(:like, true)).to include('fas fa-thumbs-up')
      end

      it ':dislike, true' do
        expect(helper.vote_icon(:dislike, true)).to include('fa-rotate-180')
      end
    end
  end
end
