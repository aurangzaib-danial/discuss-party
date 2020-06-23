require 'rails_helper'

RSpec.feature 'Visiting the home view', type: 'feature' do

  scenario 'shows no content message if no topic is available' do
    visit root_path
    message = 'No topic available, be the first to create one.'
    expect(page).to have_content(message)
  end

  scenario 'lists available topics' do
    topics = 2.times.collect { create(:topic) }
    visit root_path 
    run_expectations_for_topics(topics)
  end

  scenario 'lists latest topics by default' do
    topics = 2.times.collect { create(:topic) }
    visit root_path
    topic_titles = page.all('h5.card-title').map { |result| result.text }
    expect(topic_titles).to eq([topics.second.title, topics.first.title])
  end


end
