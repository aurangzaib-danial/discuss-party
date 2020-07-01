require 'rails_helper'

RSpec.describe TopicPolicy, type: :policy do
  let(:topic) { create(:topic) }

  context 'topic creator' do
    subject { described_class.new(topic.creator, topic) }
    it { should permit_edit_and_update_actions}
  end

  context 'another user' do
    subject { described_class.new(create(:user), topic) }
    it { should forbid_edit_and_update_actions}
  end

end
