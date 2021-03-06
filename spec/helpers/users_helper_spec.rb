require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  describe 'user_no_topic_message' do
    let(:current_user) {create(:user)}
    let(:guest) {create(:user)}
    let(:third_person) {create(:user)}

    it 'returns message for current user if they are visiting their own profile' do
      expect(helper.user_no_topic_message(current_user, current_user)).to include('You have not created a public topic yet.')
    end

    it 'returns message for user when they are visiting some one else\'s profile' do
      third_person.name = 'Aurangzaib Khan'
      expect(helper.user_no_topic_message(third_person, current_user)).to include("#{third_person.name.titlecase} has not created a public topic yet.")
    end
  end
end
