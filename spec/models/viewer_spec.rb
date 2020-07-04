require 'rails_helper'

RSpec.describe Viewer, type: :model do
  it { should belong_to(:topic) }
  it { should belong_to(:user) }
  it { should have_db_index([:topic_id, :user_id]).unique }

  describe 'customized validations and creating viewer between a private topic and an user' do
    let(:fake_topic) {build_stubbed(:topic)}
    subject {Viewer.new(topic: fake_topic)}
    
    it 'email format' do
      subject.user_email = ''
      subject.valid?
      expect(subject.errors[:user_email].first).to eq('Invalid Email')
      
      subject.user_email = 'khan@'
      subject.valid?
      expect(subject.errors[:user_email].first).to eq('Invalid Email')
    end

    it 'error when user is not found using their email' do
      subject.user_email = 'khan@hotmail.com'
      subject.valid?
      expect(subject.errors[:user_email].first).to eq('Email not found')
    end

    it 'reports no error when user is found with provided email' do
      user = create(:user)
      subject.user_email = user.email
      subject.valid?
      expect(subject.errors[:user_email].any?).to be_falsey
    end

    it 'checks if topic is already shared with the provided email' do
      user = create(:user)
      topic = create(:topic)
      create(:viewer, topic: topic, user: user)
      
      viewer = topic.viewers.build(user_email: user.email)
      viewer.valid?
      expect(viewer.errors[:user_email].first).to eq('Already shared with this user')
    end

    it 'succesfully shares a private topic with a user' do
      user = create(:user)
      topic = create(:topic)
      
      viewer = topic.viewers.build(user_email: user.email)
      viewer.valid?
      expect(viewer.errors.any?).to be_falsey
      expect(viewer.user).to eq(user)
    end
  end
end
