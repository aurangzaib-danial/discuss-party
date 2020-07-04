require 'rails_helper'

RSpec.feature 'sharing a private topic' do
  let(:topic) {create(:topic)}
  let(:user) {topic.creator}
  let(:third_user) {create(:user)}

  context 'topic creator' do
    before do
      sign_in topic.creator
    end
    scenario 'can share a topic with a user using their valid email' do

      visit topic_slug_path(topic.id, topic.slug)
      click_link 'Manage Sharing'

      fill_in :viewer_user_email, with: third_user.email
      click_button 'Share'

      expect(topic.private_viewers).to include(third_user)
      expect(page).to have_content('Succesfully shared.')
      expect(page).to have_content(third_user.email)
    end

    scenario 'cannot share a topic with invalid email' do
      visit topic_sharing_path(topic.id, topic.slug)
      fill_in :email, with: 'wrongemail@'
      click_button 'Share'
      expect(page).to have_content('Invalid email')
    end

    scenario 'displays error if a user is not found by the entered email' do
      visit topic_sharing_path(topic.id, topic.slug)
      fill_in :email, with: 'khan@hotmail.com '
      click_button 'Share'
      expect(page).to have_content('Coud not find a user with that email')
    end
  end
end
