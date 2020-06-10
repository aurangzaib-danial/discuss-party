require 'rails_helper'

RSpec.feature 'User creates a topic', :type => :feature do
  before do
    3.times { create(:tag) }
    sign_in create(:user)
  end
  describe "User creates a new topic" do
    scenario 'succesfully creates with valid input' do
      visit new_topic_path
      topic = build(:topic)

      fill_in :topic_title, with: topic.title
      fill_in :topic_description, with: topic.description
      choose :topic_visibility_private
      check "topic_tag_ids_#{Tag.second.id}"
      check "topic_tag_ids_#{Tag.third.id}"

      click_button "Create Topic"

      expect(page).to have_text(topic.title)
      expect(page).to have_text(topic.description)
      expect(page).to have_text(Tag.second.name.capitalize)
      expect(page).to have_text(Tag.third.name.capitalize)
    end

    scenario 'sees errors on wrong input' do
      visit new_topic_path
      topic = build(:topic)
      click_button "Create Topic"
      expect(page).to have_text("Title is too short")
    end
  end
end
