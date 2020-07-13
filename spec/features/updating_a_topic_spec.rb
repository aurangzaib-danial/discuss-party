require 'rails_helper'

RSpec.feature 'Updating a topic', type: :feature do
  let(:topic) { create(:topic) }
  before do
    sign_in topic.creator
  end
  scenario 'with valid input updates the topic' do
    data = { title: 'Update topic', description: Faker::Lorem.paragraph}
    visit topic_slug_path(topic.id, topic.slug)
    tag = topic.tags.first
    click_link 'Edit'
    fill_in 'topic[title]', with: data[:title]
    page.find("#topic_description_trix_input_topic_#{topic.id}", visible: false).set(data[:description])
    choose :topic_visibility_private
    uncheck tag.name

    click_button "Update Topic"

    expect(page).to have_content('Updated successfully.')
    expect(page).to have_content(data[:title])
    expect(page).to have_content(data[:description])
    expect(page.find('main')).to have_content('Private')

    expect(page.find('main')).not_to have_content(tag.name)
  end

  scenario 'displays error on wrong input' do
    visit edit_topic_path(topic.id, topic.slug)

    fill_in :topic_title, with: ''

    click_button "Update Topic"

    expect(page).to have_content("Title is too short")
  end
end
