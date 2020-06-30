require 'rails_helper'

RSpec.feature 'Visiting the home view', type: 'feature' do
  include_examples 'listing topics'
  
  let(:topics) {2.times.collect { create(:topic) }}

  def visit_collection
    topics
    visit root_path
  end

  scenario 'shows no content message if no topic is available' do
    visit root_path
    message = 'No topic available, be the first to create one.'
    expect(page).to have_content(message)
  end

end
