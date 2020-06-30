require 'rails_helper'

RSpec.feature 'Searching for a topic', type: 'feature' do
  include_examples 'listing topics'

  let(:topics) {2.times.collect { create(:topic) }}

  def run_search
    topics
    visit search_path
    fill_in :big_search, with: 'The topic is'
    click_button :big_search_submit
  end

  alias_method :visit_collection, :run_search
  
  scenario 'using the navbar search' do
    topics = 2.times.collect {|n| create(:topic, title: "beautiful-#{n+1}")}
    visit root_path
    fill_in :navbar_search, with: 'beautiful'
    click_button 'Search'

    expect(page).to have_content('Found 2 topics')
    run_expectations_for_topics(topics)
  end

  scenario 'using the main search' do
    run_search
    run_expectations_for_topics(topics)
  end

end
