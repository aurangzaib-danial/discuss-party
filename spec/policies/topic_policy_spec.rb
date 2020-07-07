require 'rails_helper'

RSpec.describe TopicPolicy, type: :policy do
  let(:topic) { create(:topic) }
  let(:common_actions) { %i[show vote comment] }
  let(:destructive_actions) { %i[sharing destroy edit update] }
  let(:creator_actions) { destructive_actions + common_actions }


  context 'topic creator' do
    subject { described_class.new(topic.creator, topic) }
    it { should permit_actions creator_actions }
    context 'private topic' do
      before {topic.update(visibility: :private)}
      it { should permit_actions creator_actions }
    end
  end

  context 'another user' do
    subject { described_class.new(create(:user), topic) }
    
    it { should forbid_actions(destructive_actions) }
    it { should permit_actions(common_actions) }
  end

  context 'private topic' do   

    context 'simple user' do
      subject do 
        topic.update(visibility: :private)
        described_class.new(create(:user), topic)
      end

      it { should forbid_actions(common_actions)}
    end

    context 'user with whom topic is shared' do
      subject do
        private_user = create(:user)
        topic = create(:topic, visibility: :private)
        topic.viewers.create(user: private_user)
        
        described_class.new(private_user, topic)
      end

      it { should permit_actions(common_actions)}
    end
  end

end
