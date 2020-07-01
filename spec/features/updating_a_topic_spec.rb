require 'rails_helper'

RSpec.feature 'Updating a topic', type: :feature do
  let(:topic) { create(:topic) }
  before do
    sign_in topic.creator
  end
  scenario 'with valid input updates the topic' do
    data = { title: 'Update topic', description: Faker::Lorem.paragraph}
    visit topic_slug_path(topic.id, topic.slug)
    click_link :edit

    fill_in :topic_title, with: data[:title]
    choose :topic_visibility_private
    uncheck "topic_tag_ids_1"

    click_button "Update Topic"

    expect(page).to have_content(data[:title])
    expect(page).to have_content(data[:description])
    expect(page.find('main')).to have_content('private')

    expect(page).not_to have_content('tag1')
  end

  scenario 'displays error on wrong input' do
    visit edit_topic_path(topic.id, topic.slug)

    fill_in :topic_title, with: ''

    click_button "Update Topic"

    expect(page).to have_content("Title is too short")
  end
end
