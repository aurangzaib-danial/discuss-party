require 'rails_helper'

RSpec.describe TopicPolicy, type: :policy do
  let(:topic) { create(:topic) }

  context 'topic creator' do
    subject { described_class.new(topic.creator, topic) }
    it { should permit_edit_and_update_actions}
    it { should permit_actions(%i[vote sharing])}
  end

  context 'another user' do
    subject { described_class.new(create(:user), topic) }
    it { should forbid_edit_and_update_actions}
    it { should forbid_actions(%i[vote sharing])}

    context 'private topic' do
      it { should forbid_action(:vote)}
    end
  end

end
