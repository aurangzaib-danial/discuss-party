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
      expect(page).to have_content('Successfully shared.')
      expect(page).to have_content(third_user.name)
   end

    scenario 'cannot share a topic with invalid email' do
      visit sharing_topic_path(topic.id, topic.slug)
      fill_in :viewer_user_email, with: 'wrongemail@'
      click_button 'Share'
      expect(page).to have_content('Invalid email')
    end

    scenario 'displays error if a user is not found by the entered email' do
      visit sharing_topic_path(topic.id, topic.slug)
      fill_in :viewer_user_email, with: 'khan@hotmail.com'
      click_button 'Share'
      expect(page).to have_content('Coud not find a user with that email')
    end

    scenario 'displays error when topic is already shared with the provided email' do
      create(:viewer, topic: topic, user: third_user)
      visit sharing_topic_path(topic.id, topic.slug)
      fill_in :viewer_user_email, with: third_user.email
      click_button 'Share'
      expect(page).to have_content('Already shared with this user')
    end

    scenario 'displays error if user tries to share topic with himself' do
      visit sharing_topic_path(topic.id, topic.slug)
      fill_in :viewer_user_email, with: topic.creator.email
      click_button 'Share'
      expect(page).to have_content('You cannot share with yourself')
    end

    scenario 'can delete a private viewer from a topic' do
      viewer = create(:viewer, topic: topic, user: third_user)
      visit sharing_topic_path(topic.id, topic.slug)

      click_button "viewer_#{viewer.id}"

      expect(page).to_not have_content(third_user.name)
      expect(page).to have_content('Successfully removed access.')
    end
  end
end
