require 'rails_helper'

RSpec.describe TopicsHelper, type: :helper do
  let(:topic) { create(:topic) }

  describe 'private_topic?' do
    it 'returns private' do
      expect(helper.private_topic?(Topic.new(visibility: :private))).to include('Private')
    end
    
    it 'returns nil for a public topic' do
      expect(helper.private_topic?(Topic.new(visibility: :public))).to be_nil
    end
  end

  describe 'vote_button accepts topic, vote_type' do
    it 'like and marked' do
        topic.vote(topic.creator, :like)
        result = helper.vote_button(topic, topic.creator, :like)
        expect(result).to include('like')
        expect(result).to include('thumb-marked')
    end

    it 'dislike but not marked' do
        result = helper.vote_button(topic, topic.creator, :dislike)
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
