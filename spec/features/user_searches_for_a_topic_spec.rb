require 'rails_helper'

RSpec.feature 'User searches for a topic', type: 'feature' do
  scenario 'using the navbar search' do
    topic_1 = create(:topic, title: 'A beautiful topic')
    topic_2 = create(:topic, title: 'The land was so much beautiful')

    visit root_path
    fill_in :navbar_search, with: 'beautiful'
    click_button 'Search'

    expect(page).body.to have_content('Found 2 topics')
    expect(page.body).to have_content(topic_1.title)
    expect(page.body).to have_content(topic_2.title)
  end
end
