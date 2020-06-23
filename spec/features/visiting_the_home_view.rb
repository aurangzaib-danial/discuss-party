require 'rails_helper'

RSpec.feature 'Visiting the home view', type: 'feature' do

  scenario 'shows no content message if no topic is available' do
    visit root_path
    message = 'No topic available, be the first to create one.'
    expect(page).to have_content(message)
  end

  scenario 'lists all the available topics' do
    topics = 2.times.collect { create(:topic) }
    visit root_path 
    run_expectations_for_topics(topics)
  end

end
