require 'rails_helper'

RSpec.feature 'User creates a topic', :type => :feature do
  before do
    3.times { create(:tag) }
  end
  scenario "User creates a new topic" do
    sign_in create(:user)
    visit new_topic_path
    topic = build(:topic)

    fill_in :topic_title, with: topic.title
    fill_in :topic_description, with: topic.description
    check "topic_tag_ids_#{Tag.second.id}"
    check "topic_tag_ids_#{Tag.third.id}"

    click_button "Create Topic"

    expect(page).to have_text(topic.title)
    expect(page).to have_text(topic.description)
    expect(page).to have_text("tag1")
    expect(page).to have_text("tag2")

  end
end
