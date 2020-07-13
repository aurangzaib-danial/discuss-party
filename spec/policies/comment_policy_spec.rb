require 'rails_helper'

RSpec.describe CommentPolicy, type: :policy do
  let(:user) { create(:user) }
  let(:topic) { create(:topic) }
  
  let(:comment) do
    topic.comments.create(content: 'This is a comment', user: user)
  end

  context 'comment creator' do
    subject { described_class.new(user, comment) }
    it {should permit_action(:destroy)}
  end

  context 'topic creator' do
    subject { described_class.new(topic.creator, comment) }
    it {should permit_action(:destroy)}
  end

end

