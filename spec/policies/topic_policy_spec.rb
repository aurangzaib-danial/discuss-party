require 'rails_helper'

RSpec.describe TopicPolicy, type: :policy do
  let(:topic) { create(:topic) }
  let(:common_actions) { %i[show vote comment] }

  context 'topic creator' do
    subject { described_class.new(topic.creator, topic) }
    it { should permit_edit_and_update_actions }
    it { should permit_actions common_actions.push(:sharing) }
    context 'private topic' do
      before {topic.update(visibility: :private)}
      it { should permit_actions common_actions.push(:sharing) }
    end
  end

  context 'another user' do
    subject { described_class.new(create(:user), topic) }
    
    it { should forbid_edit_and_update_actions }
    it { should forbid_action(:sharing) }
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

# show, vote

# public
# every user can show
# every user can vote
# every user can comment

# private
# creator can do everything
# only private_viewers can view
# only private_viewers can comment
# only private_viewers can vote
