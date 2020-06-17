require 'rails_helper'

RSpec.feature 'User searches for a topic', type: 'feature' do
  def expect_statements_for_found
    expect(page.body).to have_content(@topic_1.title)
    expect(page.body).to have_content(@topic_2.title)
    expect(page.body).to have_content('Found 2 topics')
  end

  before do
    @topic_1 = create(:topic, title: 'A beautiful topic')
    @topic_2 = create(:topic, title: 'The land was so much beautiful')
  end
  
  scenario 'using the navbar search' do

    visit root_path
    fill_in :navbar_search, with: 'beautiful'
    click_button 'Search'

    expect_statements_for_found
  end

  scenario 'using the main search' do

    visit search_path
    fill_in :big_search, with: 'beautiful'
    click_button :big_search_submit

    expect_statements_for_found
  end

end
